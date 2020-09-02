Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B03C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCD4207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599026869;
	bh=K9hPv0moh+VVqHvEFvjmnIkS0cdhPRY28MtLaDip6uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kyj76yC0XUQ6eBDDlAdGWfzFBanNURd5NaVRvfVPXuCpArzsHeJtNlaHUUFREJAr6
	 9eqdLgC/VcVS3u6Gn72zpc7Owg6mxAMHXw5TZ5lzwwz5H3fttwIHIF9nyScTNLQUTr
	 l532ODoPer1G1BS8OfvZCnoqFgeMFVctzHE4bJXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBGHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:07:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3AC20758;
        Wed,  2 Sep 2020 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599026867;
        bh=K9hPv0moh+VVqHvEFvjmnIkS0cdhPRY28MtLaDip6uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjaV7xCJi8O5HE5ELXkiQTJkKzIjnCuUuT6nVjDKP+Xtrudat9G9ENEyWDZRK7gQI
         siMyVEgcSler8y2AtSZkR7o9Y3LffwJv6Toac2EQUD7lGvlUc+/XGrHfPNK4bm7ICp
         xmelw100vL6tp2bxu26Ji31eQreaqXC4hfuqSTcE=
Date:   Wed, 2 Sep 2020 08:07:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Message-ID: <20200902060744.GA142357@kroah.com>
References: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 01:21:43PM -0700, Matthias Kaehlcke wrote:
> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index da39bddb0604..2bd02388ca62 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
>  
>  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
>  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
> +obj-$(CONFIG_USB_HUB_PWR)		+= usb_hub_pwr.o usb_hub_psupply.o

Why is this 2 files?  Why can't it just be one?

And isn't this much the same thing as many of the other "misc" hub
controller drivers we have?

And to make it easier to review, can you split out the device tree
descriptions so that the DT maintainers can review that?

thanks,

greg k-h
