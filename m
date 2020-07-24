Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9093EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64342206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:20:04 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52807 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgGXVUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:20:03 -0400
Received: from [192.168.0.7] (ip5f5af26d.dynamic.kabel-deutschland.de [95.90.242.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4C4162002EE2A;
        Fri, 24 Jul 2020 23:20:00 +0200 (CEST)
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
To:     Kees Cook <keescook@chromium.org>
Cc:     Mazin Rezk <mnrzk@protonmail.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sunpeng.li@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        1i5t5.duncan@cox.net, mphantomx@yahoo.com.br,
        regressions@leemhuis.info, anthony.ruhier@gmail.com
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
 <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
 <202007241016.922B094AAA@keescook>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3c92db94-3b62-a70b-8ace-f5e34e8f268f@molgen.mpg.de>
Date:   Fri, 24 Jul 2020 23:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007241016.922B094AAA@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kees,


Am 24.07.20 um 19:33 schrieb Kees Cook:
> On Fri, Jul 24, 2020 at 09:45:18AM +0200, Paul Menzel wrote:
>> Am 24.07.20 um 00:32 schrieb Kees Cook:
>>> On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
>> As Linux 5.8-rc7 is going to be released this Sunday, I wonder, if commit
>> 3202fa62f ("slub: relocate freelist pointer to middle of object") should be
>> reverted for now to fix the regression for the users according to Linux’ no
>> regression policy. Once the AMDGPU/DRM driver issue is fixed, it can be
>> reapplied. I know it’s not optimal, but as some testing is going to be
>> involved for the fix, I’d argue it’s the best option for the users.
> 
> Well, the SLUB defense was already released in v5.7, so I'm not sure it
> really helps for amdgpu_dm users seeing it there too.

In my opinion, it would help, as the stable release could pick up the 
revert, ones it’s in Linus’ master branch.

> There was a fix to disable the async path for this driver that worked
> around the bug too, yes? That seems like a safer and more focused
> change that doesn't revert the SLUB defense for all users, and would
> actually provide a complete, I think, workaround whereas reverting
> the SLUB change means the race still exists. For example, it would be
> hit with slab poisoning, etc.

I do not know. If there is such a fix, that would be great. But if you 
do not know, how should a normal user? ;-)


Kind regards,

Paul


Kind regards,

Paul
