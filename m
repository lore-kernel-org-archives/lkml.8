Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9DFC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CD2206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGXHpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:45:22 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52005 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgGXHpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:45:21 -0400
Received: from [192.168.0.2] (ip5f5af51b.dynamic.kabel-deutschland.de [95.90.245.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 95C4C2002EE2B;
        Fri, 24 Jul 2020 09:45:18 +0200 (CEST)
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
To:     Kees Cook <keescook@chromium.org>,
        Mazin Rezk <mnrzk@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sunpeng.li@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        1i5t5.duncan@cox.net, mphantomx@yahoo.com.br,
        regressions@leemhuis.info, anthony.ruhier@gmail.com
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
Date:   Fri, 24 Jul 2020 09:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007231524.A24720C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kees,


Am 24.07.20 um 00:32 schrieb Kees Cook:
> On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
>> When amdgpu_dm_atomic_commit_tail is running in the workqueue,
>> drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_tail is
>> running, causing a race condition where state (and then dm_state) is
>> sometimes freed while amdgpu_dm_atomic_commit_tail is running. This bug has
>> occurred since 5.7-rc1 and is well documented among polaris11 users [1].
>>
>> Prior to 5.7, this was not a noticeable issue since the freelist pointer
>> was stored at the beginning of dm_state (base), which was unused. After
>> changing the freelist pointer to be stored in the middle of the struct, the
>> freelist pointer overwrote the context, causing dc_state to become garbage
>> data and made the call to dm_enable_per_frame_crtc_master_sync dereference
>> a freelist pointer.
>>
>> This patch fixes the aforementioned issue by calling drm_atomic_state_get
>> in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called and
>> drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.
>>
>> According to my testing on 5.8.0-rc6, this should fix bug 207383 on
>> Bugzilla [1].
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=207383
> 
> Nice work tracking this down!
> 
>> Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of object")
> 
> I do, however, object to this Fixes tag. :) The flaw appears to have
> been with amdgpu_dm's reference tracking of "state" in the nonblocking
> case. (How this reference counting is supposed to work correctly, though,
> I'm not sure.) If I look at where the drm helper was split from being
> the default callback, it looks like this was what introduced the bug:
> 
> da5c47f682ab ("drm/amd/display: Remove acrtc->stream")
> 
> ? 3202fa62f certainly exposed it much more quickly, but there was a race
> even without 3202fa62f where something could have realloced the memory
> and written over it.

I understand the Fixes tag mainly a help when backporting commits.

As Linux 5.8-rc7 is going to be released this Sunday, I wonder, if 
commit 3202fa62f ("slub: relocate freelist pointer to middle of object") 
should be reverted for now to fix the regression for the users according 
to Linux’ no regression policy. Once the AMDGPU/DRM driver issue is 
fixed, it can be reapplied. I know it’s not optimal, but as some testing 
is going to be involved for the fix, I’d argue it’s the best option for 
the users.


Kind regards,

Paul
