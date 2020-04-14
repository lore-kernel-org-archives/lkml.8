Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5EBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C122076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586902733;
	bh=JTEHaA8L3ttVTL7silMjzu76CqWt/4Z5j2JWJn0TfT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yeqJljHIZKuEOV1gibgGlY6vo6RMTSV+ZqcmXyLxPrChB5I5ecOM0vR+tbyqbHP0D
	 IIxsaNrknvAheWMe9dr/4bQ2a5p2L4m0qphB83nwvZt4lyGoLWeTpv86HKz21X1g7G
	 NWhXNf/BmNxgeeBd2u0bVXz0RxlTCvm7NdJIkcPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgDNWSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728100AbgDNWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:18:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72129C061A0C;
        Tue, 14 Apr 2020 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=B58qBEM0F93IEa1FE/sOHbOVrJ5N3H5UuNHGMFnTNEY=; b=PnOMmQBCVUeuZe49ng9V1LX6qZ
        5scCVyueSv4y8TcEtozZM9VIlWkaLMG8qjVLreBCKpdKcHomGML01QCfKv57R5D9Mb9ikzKNJ2qMm
        f4kPPYN4r8UflRTwTrMd2qOj0hUQyLsJGiKRsN0zS1AUycYIhvWL6LNSiHLzZfqdevSajCgWWgJWv
        IFjKBLWMDdiMqkoRPK/oCLT91XYSBOSZnLyOfLdBlvp6d63XFTS5xshgKEjYAsKgQUOJ5GzufangJ
        IqE6fgDT6I2fNSb3HJVgptaWu+f1xRZ4HWM+Ym9jVLxFZilCDrNkvEZB30m8Ixlvgg22GwUcjyx0i
        hcF5otLg==;
Received: from [95.90.212.216] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOTtH-0000Ml-VG; Tue, 14 Apr 2020 22:18:48 +0000
Date:   Wed, 15 Apr 2020 00:18:42 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH] media: Kconfig: Don't expose the Request API option
Message-ID: <20200415001842.7773610b@coco.lan>
In-Reply-To: <20200414220624.5396-1-ezequiel@collabora.com>
References: <20200414130210.18970-1-ezequiel@collabora.com>
        <20200414220624.5396-1-ezequiel@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 14 Apr 2020 19:06:24 -0300
Ezequiel Garcia <ezequiel@collabora.com> escreveu:

> The Request API isn't meant to be chosen by users,
> but instead should be selected by drivers that want
> to support it.
> 
> Hantro and Cedrus are already selecting the right options,
> so only the test drivers need to be fixed.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/mc/Kconfig                   | 6 ++++--
>  drivers/media/test_drivers/Kconfig         | 2 ++
>  drivers/media/test_drivers/vicodec/Kconfig | 2 ++
>  drivers/media/test_drivers/vivid/Kconfig   | 2 ++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/mc/Kconfig b/drivers/media/mc/Kconfig
> index 002a918c4c75..7c9628f37196 100644
> --- a/drivers/media/mc/Kconfig
> +++ b/drivers/media/mc/Kconfig
> @@ -2,7 +2,6 @@
>  
>  #
>  # Media controller
> -#	Selectable only for webcam/grabbers, as other drivers don't use it
>  #
>  
>  config MEDIA_CONTROLLER_DVB
> @@ -14,7 +13,7 @@ config MEDIA_CONTROLLER_DVB
>  	  This is currently experimental.
>  
>  config MEDIA_CONTROLLER_REQUEST_API
> -	bool "Enable Media controller Request API (EXPERIMENTAL)"
> +	bool
>  	depends on MEDIA_CONTROLLER && STAGING_MEDIA
>  	help
>  	  DO NOT ENABLE THIS OPTION UNLESS YOU KNOW WHAT YOU'RE DOING.

Hmm... I guess you can also remove the help here, as it won't be
shown anymore with make menuconfig.

Thanks,
Mauro
