Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5A720692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbgDMRcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:32:08 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50539 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732808AbgDMRcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:32:07 -0400
Received: from [192.168.1.6] (x4d0d8c93.dyn.telefonica.de [77.13.140.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D4604206442E6;
        Mon, 13 Apr 2020 19:32:03 +0200 (CEST)
Subject: Re: [regression 5.7-rc1] System does not power off, just halts
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Prike Liang <Prike.Liang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        regressions@leemhuis.info, stable@vger.kernel.org,
        Mengbing Wang <Mengbing.Wang@amd.com>,
        Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <f4eaf0ca-6cd6-c224-9205-bf64ca533ff5@molgen.mpg.de>
Message-ID: <dcc4851e-0ab5-683a-2cf2-687d64a3c9da@molgen.mpg.de>
Date:   Mon, 13 Apr 2020 19:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f4eaf0ca-6cd6-c224-9205-bf64ca533ff5@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Prike, dear Alex, dear Linux folks,


Am 13.04.20 um 10:44 schrieb Paul Menzel:

> A regression between causes a system with the AMD board MSI B350M MORTAR 
> (MS-7A37) with an AMD Ryzen 3 2200G not to power off any more but just 
> to halt.
> 
> The regression is introduced in 9ebe5422ad6c..b032227c6293. I am in the 
> process to bisect this, but maybe somebody already has an idea.

I found the Easter egg:

> commit 487eca11a321ef33bcf4ca5adb3c0c4954db1b58
> Author: Prike Liang <Prike.Liang@amd.com>
> Date:   Tue Apr 7 20:21:26 2020 +0800
> 
>     drm/amdgpu: fix gfx hang during suspend with video playback (v2)
>     
>     The system will be hang up during S3 suspend because of SMU is pending
>     for GC not respose the register CP_HQD_ACTIVE access request.This issue
>     root cause of accessing the GC register under enter GFX CGGPG and can
>     be fixed by disable GFX CGPG before perform suspend.
>     
>     v2: Use disable the GFX CGPG instead of RLC safe mode guard.
>     
>     Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>     Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
>     Reviewed-by: Huang Rui <ray.huang@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Cc: stable@vger.kernel.org

It reverts cleanly on top of 5.7-rc1, and this fixes the issue.

Greg, please do not apply this to the stable series. The commit message 
doesn’t even reference a issue/bug report, and doesn’t give a detailed 
problem description. What system is it?

Dave, Alex, how to proceed? Revert? I created issue 1094 [1].


Kind regards,

Paul


[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1094
