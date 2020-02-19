Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821CC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8AF24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582143558;
	bh=BMqfNAqnRNhsX0S28jKzbbqRGrFmcgyFHV69yPDrYEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0SIP3iciFwOSiLuICUda8HlJ2554pCvYT/dUy8DtZgkkFP1TFlYMFdlnRDktEp2zb
	 MA/Qth6RFpwEU7qsHDZ0xf0hEEWkHKiuHmVmWdrmqnOIUZktdaWEB9e12r4S8Wsq4l
	 raDK86m9AYTksH0WX/szJIy74cL3A/WoCfZmCoCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBSUTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSUTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:19:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B33B24654;
        Wed, 19 Feb 2020 20:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582143556;
        bh=BMqfNAqnRNhsX0S28jKzbbqRGrFmcgyFHV69yPDrYEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRtbjXZ8Mde4Hy9lBcGW6R/EQrCVPybzx/AtGRwcTkhkv5laP25wPQKXxxwV1Cg+S
         yjejy+XDrUgNWBiBORk6oD9t64KlnmFe5OwOsPlxIVajPCExoZilujW9pESEso0GUr
         /y/4/IY9PY5rW2aup4tbdCgdRqPcec7EmCYg9ov0=
Date:   Wed, 19 Feb 2020 21:19:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: match parenthesis alignment
Message-ID: <20200219201913.GA2882443@kroah.com>
References: <20200219195651.GA485@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219195651.GA485@kaaira-HP-Pavilion-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 01:26:51AM +0530, Kaaira Gupta wrote:
> Fix checkpatch.pl warning of alignment should match open parenthesis in
> audio_codec.c
> 
> Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> ---
>  drivers/staging/greybus/audio_codec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 08746c85dea6..d62f91f4e9a2 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -70,7 +70,7 @@ static int gbaudio_module_enable_tx(struct gbaudio_codec_info *codec,
>  		i2s_port = 0;	/* fixed for now */
>  		cportid = data->connection->hd_cport_id;
>  		ret = gb_audio_apbridgea_register_cport(data->connection,
> -						i2s_port, cportid,
> +							i2s_port, cportid,
>  						AUDIO_APBRIDGEA_DIRECTION_TX);

You can't do it for one line, and not all of the lines.

And if you do it for all lines, then you push past the line-length.

So you are back to what we currently have, which is the best we can do,
sorry.

greg k-h
