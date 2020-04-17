Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA69C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A08207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgDQReW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:34:22 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:49374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbgDQReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:34:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0D2F2184AA7F1;
        Fri, 17 Apr 2020 17:34:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rain55_7d2aa5877710a
X-Filterd-Recvd-Size: 2056
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 17:34:20 +0000 (UTC)
Message-ID: <1a47c5c428968a0e1d0ac5b92ce7ebdd4014fd38.camel@perches.com>
Subject: Re: checkpatch.pl warning for "return" with value
From:   Joe Perches <joe@perches.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Apr 2020 10:32:07 -0700
In-Reply-To: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
References: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 13:20 -0400, Luben Tuikov wrote:
> Hi guys,
> 
> I get this warning:
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
> It seems like a false positive--I mean, if the else branch was
> taken, we'd return a different result.

There is an existing checkpatch exception for single line
if/else returns
like:

	if (foo)
		return bar;
	else
		return baz;

because that's a pretty common code style.

But I personally don't think that your example fits the
same style.

I think when unexpected condition should be separated from
the expected condition which should typically be the last
block of a function like:


	if (<atypical_condition>) {
		...;
		return <atypical_result>;
	}

	...;
	return <typical_result>;
}

If you want to code it, and it works, go ahead, but I
won't attempt it because I think it's not appropriate.

cheers, Joe

