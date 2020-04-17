Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB9C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2079620776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgDQT6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:58:18 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:37994 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730573AbgDQT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:58:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D4035180A7344;
        Fri, 17 Apr 2020 19:58:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl79_4831856ceed2e
X-Filterd-Recvd-Size: 3676
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 19:58:15 +0000 (UTC)
Message-ID: <51793346cd065247886af6d54c32691e94c9b843.camel@perches.com>
Subject: Re: checkpatch.pl: WARNING: else is not generally useful after a
 break or return
From:   Joe Perches <joe@perches.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Apr 2020 12:56:03 -0700
In-Reply-To: <064ada88-9fa3-6f6d-967c-00d4e2d325ae@amd.com>
References: <064ada88-9fa3-6f6d-967c-00d4e2d325ae@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 15:20 -0400, Luben Tuikov wrote:
> Hi,
> 
> I'm getting what seems to be a false positive in this case:
> 
> :32: WARNING: else is not generally useful after a break or return
> #32: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:55:
> +		return 0;
> +	} else {
> 
> for the following code, at the bottom of a function:
> 
> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> 		amdgpu_device_gpu_recover(ring->adev, job);
> 		return 0;
> 	} else {
> 		drm_sched_suspend_timeout(&ring->sched);
> 		return 1;
> 	}
> }
> 
> Which seems to be coming from commit:
> 
> commit 032a4c0f9a77ce565355c6e191553e853ba66f09
> Author: Joe Perches <joe@perches.com>
> Date:   Wed Aug 6 16:10:29 2014 -0700
> 
>     checkpatch: warn on unnecessary else after return or break
>     
>     Using an else following a break or return can unnecessarily indent code
>     blocks.
>     
>     ie:
>             for (i = 0; i < 100; i++) {
>                     int foo = bar();
>                     if (foo < 1)
>                             break;
>                     else
>                             usleep(1);
>             }
>     
>     is generally better written as:
>     
>             for (i = 0; i < 100; i++) {
>                     int foo = bar();
>                     if (foo < 1)
>                             break;
>                     usleep(1);
>             }
>     
>     Warn when a bare else statement is preceded by a break or return
>     indented 1 tab more than the else.
>     
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> While I agree with what the commit is trying to do,
> it doesn't seem to apply to the if-else statement which I quoted
> above. That is, the "else" is not "bare"--to use the lingo of
> the commit.
> 
> I suggest that no warning is issued when the "else" is a compound
> statement, as shown in my example at the top of this email.
> 
> It is only natural to write:
> 
> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> 		amdgpu_device_gpu_recover(ring->adev, job);
> 		return 0;
> 	} else {
> 		drm_sched_suspend_timeout(&ring->sched);
> 		return 1;
> 	}
> }
> 
> instead of,
> 
> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> 		amdgpu_device_gpu_recover(ring->adev, job);
> 		return 0;
> 	}
> 	drm_sched_suspend_timeout(&ring->sched);
> 	return 1;
> }

This is continuing an email thread sent privately to Andy and me.

I disagree and do not believe this should be implemented in
checkpatch as an accepted typical coding style.

btw:

Even in your example, amdgpu_device_gpu_recover has a return
value, can fail, and likely should not just return 0.



