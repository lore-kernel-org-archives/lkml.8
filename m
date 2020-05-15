Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68C22074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589550543;
	bh=HFbyjxC4aSz/WBBxS/2xZgacqhZC2KmQgAjkHuWCFrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=18sHZ+PfqdpnjP8af3KSN8q8TKLVXTZsxATEsvOk3lOhn+tZSbmOBS7fSoJbAsSVG
	 txAVc6MzQA04vTe1RhTIqIHVoEQ9LpGpVkksY99CwNpL2wCve+dgn+XOvXy2EeQ7F5
	 rQhWTSZ/EyGjPWAcu7IurMN0ibxw93oFHzv2aPCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEONtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEONtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:49:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C258206D4;
        Fri, 15 May 2020 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589550541;
        bh=HFbyjxC4aSz/WBBxS/2xZgacqhZC2KmQgAjkHuWCFrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=00Cvbmn3DhDyA5RGAF9XzorUyjuSIZWm4CXlkZKSgld116pjWFtF9lEYaVixaogvI
         7pbuBIdmtOgP7uS3I3KPObiUQyQD+6iZD/YGNwmuNmoZVHEZAnreKXGWJ+MSBSWApo
         UKMvRZ96g0IZeK99jNNPe/LTJJifN+B5RyXsOsSE=
Date:   Fri, 15 May 2020 15:48:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matej Dujava <mdujava@kocurkovo.cz>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] staging: vt6655: vt6656: change order of makefile
 variable definitions
Message-ID: <20200515134859.GA2112248@kroah.com>
References: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
 <1589397351-24655-3-git-send-email-mdujava@kocurkovo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589397351-24655-3-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:15:51PM +0200, Matej Dujava wrote:
> This patch will add indentation to multiline variable and put
> obj-$(CONFIG_X) at the beginning of the file. This order of variables is
> used in other drives, so this will make vt665x Makefiles fit into the
> pattern.
> 
> Indentation is fixed in vt6655/Makefile.
> 
> Order of variable declaration is changed in vt6656/Makefile.
> 
> Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
> ---
> v1: Initial patch
> v2: This patch was split from original bigger patch
> v3: Added more info about what and why it's removed
> 
>  drivers/staging/vt6655/Makefile | 24 ++++++++++++------------
>  drivers/staging/vt6656/Makefile |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/Makefile b/drivers/staging/vt6655/Makefile
> index e70357ec0af8..eda08a1516ab 100644
> --- a/drivers/staging/vt6655/Makefile
> +++ b/drivers/staging/vt6655/Makefile
> @@ -1,15 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -vt6655_stage-y +=	device_main.o \
> -	card.o \
> -	channel.o \
> -	mac.o \
> -	baseband.o \
> -	rxtx.o \
> -	dpc.o \
> -	power.o \
> -	srom.o \
> -	key.o \
> -	rf.o
> -
>  obj-$(CONFIG_VT6655) +=	vt6655_stage.o
> +
> +vt6655_stage-y +=	device_main.o \
> +			card.o \
> +			channel.o \
> +			mac.o \
> +			baseband.o \
> +			rxtx.o \
> +			dpc.o \
> +			power.o \
> +			srom.o \
> +			key.o \
> +			rf.o
> diff --git a/drivers/staging/vt6656/Makefile b/drivers/staging/vt6656/Makefile
> index f696a9d7a143..aac323d6a684 100644
> --- a/drivers/staging/vt6656/Makefile
> +++ b/drivers/staging/vt6656/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +obj-$(CONFIG_VT6656) +=	vt6656_stage.o
> +
>  vt6656_stage-y +=	main_usb.o \
>  			card.o  \
>  			mac.o   \
> @@ -11,5 +13,3 @@ vt6656_stage-y +=	main_usb.o \
>  			rf.o \
>  			usbpipe.o \
>  			channel.o
> -
> -obj-$(CONFIG_VT6656) +=	vt6656_stage.o

I still fail to understand the need for this patch at all.  It doesn't
clean anything up, nor change anything.  There is no rule that this has
to be in one order or the other, and in fact, I like the order that the
files currently have :)

thanks,

greg k-h
