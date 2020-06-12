Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6389620835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591956106;
	bh=IBzrqa8288WHt0Vr+2XSR3sZwtmgNbA3oFvFtV3/1MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NpbsFOSDFHWJheiSdwqvsYrPB9PS+/uxBQvsS1o2/uU9eNCwcD9Lx/O1HOaUKogIJ
	 /rIkj9GZHHxYWa+Ubziu4WHGDzsAG4y41s/CRHEniJHU6nP+/q0glI4JQDjqpgSbpm
	 gbbIHJfw8ZDjaegXcD12ycvVKG6D0h8+Fq1bCsoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFLKBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgFLKBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:01:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE6A207D8;
        Fri, 12 Jun 2020 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591956101;
        bh=IBzrqa8288WHt0Vr+2XSR3sZwtmgNbA3oFvFtV3/1MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2vPFMorhf1SoQns9I/vVtVFeBl5WXxk3cGLGvcK//oMZ6nuV87wkamGEdT9lVhuA
         5/Oh1w5iuhlsKrHP4iiWxu7+icB1Rf0xEcwk16Ht5CJX6iPxFHhhdRK7+eyyxemqAL
         jwWFREBmJhoD2QZdkNWo5iPAze0FaCHpdXyg46S8=
Date:   Fri, 12 Jun 2020 12:01:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Bernard Zhao <bernard@vivo.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/msm: Improve exception handling in
 msm_gpu_crashstate_capture()
Message-ID: <20200612100132.GB3157576@kroah.com>
References: <56a615b6-9881-ff01-fa0f-8ea070fc03e7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56a615b6-9881-ff01-fa0f-8ea070fc03e7@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:36:09AM +0200, Markus Elfring wrote:
> > Function msm_gpu_crashstate_capture maybe called for several
> > times, and then the state->bos is a potential memleak. Also
> > the state->pos maybe alloc failed, but now without any handle.
> > This change is to fix some potential memleak and add error
> > handle when alloc failed.
> 
> I suggest to improve the provided information.
> How do you think about a wording variant like the following?
> 
>    The function “msm_gpu_crashstate_capture” can be called multiple times.
>    The members “comm”, “cmd” and “bos” of the data structure “msm_gpu_state”
>    are reassigned with pointers according to dynamic memory allocations
>    if the preprocessor symbol “CONFIG_DEV_COREDUMP” was defined.
>    But the function “kfree” was not called for them before.
> 
>    Thus add missing actions.
>    * Release previous objects.
>    * Use further null pointer checks.
>    * Complete the corresponding exception handling.
> 
> 
> Would you like to add the tag “Fixes” to the commit message?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b791d1bdf9212d944d749a5c7ff6febdba241771#n183
> 
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
