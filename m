Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB743C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC34207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593610631;
	bh=5tE183U8HFGTx/+i+OpSh5OTZevNZV/V9TLpzYw5pNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=riOyrKcf5P0gko1jPWJvAkBQ2boLnll+55bewa34cacep9FBiQhTVTL9QwU1OYgjJ
	 Ub5YwXxp/FuEHWl1N4gycPIlHeE95REc3+6nEmaVClAMVSVBEGVGYjf/Vhx2K2F6rD
	 ryqQN7P4eqWoQ18a3i6+QIqKBOmZk22xs8nl6V+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgGANhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgGANhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:37:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC4B2206BE;
        Wed,  1 Jul 2020 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593610629;
        bh=5tE183U8HFGTx/+i+OpSh5OTZevNZV/V9TLpzYw5pNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekY7/q4M/OQJAUogvbtk46eVfBh6fcvVNLe+hB3hDOIwzt/yQhwN4fOHMQvssxpk1
         ZSrnoVf1wlxRs87yKDS7Nc6+guH/ikDHGBOEDHnObFaOHuXKl/V5zq2ZwkVn8WdIwf
         Kgv4Wa0A6RRuq05bALEenfzGgWnRnEeZSpxTWNNI=
Date:   Wed, 1 Jul 2020 15:36:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        devel@driverdev.osuosl.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 6/6] staging: greybus: audio: Enable GB codec, audio
 module compilation.
Message-ID: <20200701133655.GA2373798@kroah.com>
References: <cover.1592537217.git.vaibhav.sr@gmail.com>
 <e9aaa09c6688aa5ed8bddf51f5cd402bb8cf39b3.1592537217.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9aaa09c6688aa5ed8bddf51f5cd402bb8cf39b3.1592537217.git.vaibhav.sr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:50:26PM +0530, Vaibhav Agarwal wrote:
> Currently you can't enable the Gey Bus Audio Codec because there is no
> entry for it in the Kconfig file. Originally the config name was going
> to be AUDIO_MSM8994 but that's not correct because other types of
> hardware are supported now. I have chosen the name AUDIO_APB_CODEC
> instead.  Also I had to update the dependencies for GREYBUS_AUDIO to
> make the compile work.
> 
> Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/staging/greybus/Kconfig  | 14 +++++++++++++-
>  drivers/staging/greybus/Makefile |  4 ++--
>  2 files changed, 15 insertions(+), 3 deletions(-)

Can you fix the build issues found by the bot and resend?

thanks,

greg k-h
