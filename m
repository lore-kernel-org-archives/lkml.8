Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18652072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594639491;
	bh=2ihvV64TmJUeECvFxw3ZTKel8EzPxIPDdARcWIR7/Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWdOwV3T7IGl91fmx/zp4V7xt6CRYSONORJJlhvYn43gJC2QzRdB6RzsEUa1hGbZf
	 RSmnPIlxobF79QDfmQKSdZZqBtKy/BcInLB/EsqKeUo2uTRih0lDyAiFECvvCo6ESq
	 +Wdiu8ZPpanpim4Snz8WKYhvRorflaLRqyzoBoxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgGMLYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgGMLYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:24:50 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03421206F0;
        Mon, 13 Jul 2020 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594639489;
        bh=2ihvV64TmJUeECvFxw3ZTKel8EzPxIPDdARcWIR7/Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fe+q4zLT5dkZGcDoyt9Fo1bSr4SrOo6+Jru+U1b+8rRHrVRBKK2GqFiBynA4vpBqU
         nC8/pjLXbdwVjj5JAsJIPvgY4YsidZnnfIQ8XY9L0K9eOCiC11gBRdJyQa8atRFOny
         IVu00pxGoCwueYoc0sisi011TsGVrF+RmO0Cq1fw=
Date:   Mon, 13 Jul 2020 16:54:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        chenyu56@huawei.com, wangbinghui@hisilicon.com, kishon@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB IP DRIVER FOR HISILICON KIRIN: Replace HTTP links
 with HTTPS ones
Message-ID: <20200713112445.GJ34333@vkoul-mobl>
References: <20200709210933.27359-1-grandmaster@al2klimov.de>
 <20200710070613.GA1176018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710070613.GA1176018@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-07-20, 09:06, Greg KH wrote:
> On Thu, Jul 09, 2020 at 11:09:33PM +0200, Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> > 
> > Deterministic algorithm:
> > For each file:
> >   If not .svg:
> >     For each line:
> >       If doesn't contain `\bxmlns\b`:
> >         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> >             If both the HTTP and HTTPS versions
> >             return 200 OK and serve the same content:
> >               Replace HTTP with HTTPS.
> > 
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > ---
> >  Continuing my work started at 93431e0607e5.
> >  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> >  (Actually letting a shell for loop submit all this stuff for me.)
> > 
> >  If there are any URLs to be removed completely or at least not HTTPSified:
> >  Just clearly say so and I'll *undo my change*.
> >  See also: https://lkml.org/lkml/2020/6/27/64
> > 
> >  If there are any valid, but yet not changed URLs:
> >  See: https://lkml.org/lkml/2020/6/26/837
> > 
> >  If you apply the patch, please let me know.
> 
> Again, please fix your subject line.

Is there any rationale for these patches? They replace documentation
link of vendors, am not sure if that is super helpful to kernel devs and
does it really protect :)

-- 
~Vinod
