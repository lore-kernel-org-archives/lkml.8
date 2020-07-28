Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B7206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgG1JWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:22:16 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:46281 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbgG1JWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:22:15 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4ADE82002EE3C;
        Tue, 28 Jul 2020 11:22:12 +0200 (CEST)
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
To:     Mazin Rezk <mnrzk@protonmail.com>, Duncan <1i5t5.duncan@cox.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sunpeng.li@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        mphantomx@yahoo.com.br, regressions@leemhuis.info,
        anthony.ruhier@gmail.com
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
 <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
 <202007241016.922B094AAA@keescook>
 <3c92db94-3b62-a70b-8ace-f5e34e8f268f@molgen.mpg.de>
 <_vGVoFJcOuoIAvGYtkyemUvqEFeZ-AdO4Jk8wsyVv3MwO-6NEVtULxnZzuBJNeHNkCsQ5Kxn5TPQ_VJ6qyj9wXXXX8v-hc3HptnCAu0UYsk=@protonmail.com>
 <20200724215914.6297cc7e@ws>
 <c7mHa5xU_kh7K9KM5P1UJoCY00b3Oxj3s_y3vr0LGQzUPtWlhv5JjjhT4CnnbDhuTZhCuHT2uMbjdDCZ-JLmHVlS7B_k-wj1OTmZpMD7cg4=@protonmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <0b0fbe35-75cf-ec90-7c3d-bdcedbe217b7@molgen.mpg.de>
Date:   Tue, 28 Jul 2020 11:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c7mHa5xU_kh7K9KM5P1UJoCY00b3Oxj3s_y3vr0LGQzUPtWlhv5JjjhT4CnnbDhuTZhCuHT2uMbjdDCZ-JLmHVlS7B_k-wj1OTmZpMD7cg4=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Am 25.07.20 um 07:20 schrieb Mazin Rezk:
> On Saturday, July 25, 2020 12:59 AM, Duncan wrote:
> 
>> On Sat, 25 Jul 2020 03:03:52 +0000 Mazin Rezk wrote:
>>
>>>> Am 24.07.20 um 19:33 schrieb Kees Cook:
>>>>
>>>>> There was a fix to disable the async path for this driver that
>>>>> worked around the bug too, yes? That seems like a safer and more
>>>>> focused change that doesn't revert the SLUB defense for all
>>>>> users, and would actually provide a complete, I think, workaround
>>>
>>> That said, I haven't seen the async disabling patch. If you could
>>> link to it, I'd be glad to test it out and perhaps we can use that
>>> instead.
>>
>> I'm confused. Not to put words in Kees' mouth; /I/ am confused (which
>> admittedly could well be just because I make no claims to be a
>> coder and am simply reading the bug and thread, but I'd appreciate some
>> "unconfusing" anyway).
>>
>> My interpretation of the "async disabling" reference was that it was to
>> comment #30 on the bug:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=207383#c30
>>
>> ... which (if I'm not confused on this point too) appears to be yours.
>> There it was stated...
>>
>> I've also found that this bug exclusively occurs when commit_work is on
>> the workqueue. After forcing drm_atomic_helper_commit to run all of the
>> commits without adding to the workqueue and running the OS, the issue
>> seems to have disappeared.
>> <<<<
>>
>> Would not forcing all commits to run directly, without placing them on
>> the workqueue, be "async disabling"? That's what I /thought/ he was
>> referencing.
> 
> Oh, I thought he was referring to a different patch. Kees, could I get
> your confirmation on this?
> 
> The change I made actually affected all of the DRM code, although this could
> easily be changed to be specific to amdgpu. (By forcing blocking on
> amdgpu_dm's non-blocking commit code)
> 
> That said, I'd still need to test further because I only did test it for a
> couple of hours then. Although it should work in theory.
> 
>> OTOH your base/context swap idea sounds like a possibly "less
>> disturbance" workaround, if it works, and given the point in the
>> commit cycle... (But if it's out Sunday it's likely too late to test
>> and get it in now anyway; if it's another week, tho...)
> 
> The base/context swap idea should make the use-after-free behave how it
> did in 5.6. Since the bug doesn't cause an issue in 5.6, it's less of a
> "less disturbance" workaround and more of a "no disturbance" workaround.

Sorry for bothering, but is there now a solution, besides reverting the 
commits, to avoid freezes/crashes *without* performance regressions?


Kind regards,

Paul
