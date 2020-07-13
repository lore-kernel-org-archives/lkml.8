Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8420791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594624433;
	bh=xVWnbn71e12nKs+8LFqQsBzd/nrmtlDTH93hB63ta+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nPYfUvobcOwOpWLR0MPURMnKl0pB8wapOAE11MKV/L2E2E7HcWd+ueHTFVKdvkUpm
	 Cl0eo84jeNIKWTOHHPIajswqUWCdEfT6jvdsmjaAJ8ucHMdmhcqiTxFlSw3+nqoMn9
	 O0xU3+r1PinxzmAbQrziHVgnNgIW17ki6M84i3/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGMHNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgGMHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:13:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C8E2075D;
        Mon, 13 Jul 2020 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594624431;
        bh=xVWnbn71e12nKs+8LFqQsBzd/nrmtlDTH93hB63ta+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEWllgk2YOFua+n5t2l0ZTpeLJeDHwykd8NCjsWiqbGdZDMgogX1wPZX3cxgQrb0a
         9/X/h/anUDl1EpgaD2aRJFCf9CxHwVHnLFLtiUYy8c+KbIzT1SgU67VREkRhyVQkC+
         E+bdTOXj7Cage1IrxywG4XED0mO1FoPphrTp5r3o=
Date:   Mon, 13 Jul 2020 15:13:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add Bruno Thomsen as reviewer of
 Kamstrup DTS
Message-ID: <20200713071342.GK12113@dragon>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-3-bruno.thomsen@gmail.com>
 <20200713025559.GZ21277@dragon>
 <da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 10:22:50PM -0700, Joe Perches wrote:
> Right now, a little less than half of the .dts* files
> have an author or other email address in them.
> 
> $ git ls-files arch/arm/boot/dts/*.dts* | wc -l
> 2105
> 
> $ git grep -P --name-only '<\S+@\S+>' arch/arm/boot/dts/*.dts* | wc -l
> 997
> 
> Some have multiple email addresses:
> 
> $ git grep -P '<\S+@\S+>' arch/arm/boot/dts/*.dts* | wc -l
> 1240
> 
> (and there are a few false positives in that regex)
> 
> I suppose that get_maintainer could handle .dts* files
> the same way .yaml files are handled so any email address
> in the file is added to patches that touch the file.
> 
> This is the commit that added the .yaml file handling:
> 
> commit 0c78c013762142bfe8fce34e7e968f83f0a4b891
> Author: Joe Perches <joe@perches.com>
> Date:   Thu Jun 4 16:50:01 2020 -0700
> 
>     get_maintainer: add email addresses from .yaml files
>     
>     .yaml files can contain maintainer/author addresses and it seems unlikely
>     or unnecessary that individual MAINTAINER file section entries for each
>     .yaml file will be created.
>     
>     So add the email addresses found in .yaml files to the default
>     get_maintainer output.
>     
>     The email addresses are marked with "(in file)" when using the "--roles"
>     or "--rolestats" options.
> 
> So something like:

Yeah, that's helpful.

> ---
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 484d2fbf5921..4c3c69d7bed0 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -436,7 +436,7 @@ sub maintainers_in_file {
>  
>      return if ($file =~ m@\bMAINTAINERS$@);
>  
> -    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
> +    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {

It should cover .dts file too?

Shawn

>  	open(my $f, '<', $file)
>  	    or die "$P: Can't open $file: $!\n";
>  	my $text = do { local($/) ; <$f> };
> 
> 
