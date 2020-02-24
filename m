Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5685BC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5762072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ugYQv4c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBXLtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:49:53 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47118 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgBXLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:49:53 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12C21E89;
        Mon, 24 Feb 2020 12:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582544991;
        bh=VVerRb6P9n4J0byG4RDsnhoDAwB4cAvUJUyugM/0Jkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugYQv4c39w/BkPop3ddbphnw7qyYCMDbqcgPLKuDgjGcZC5LoOJius+czrFIHnrb+
         u816peG8yGigqAo9ygdzkTC9q7i8yW3GmL2ZSQlkPVa5pSTcbXErFNcBc5VMpcR6Cd
         Zk0y5c8XWW8nPgbWZw6H0KcjPP3rblcv841JCdU8=
Date:   Mon, 24 Feb 2020 13:49:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] staging: greybus: match parenthesis
 alignment
Message-ID: <20200224114929.GB4827@pendragon.ideasonboard.com>
References: <20200219195651.GA485@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219195651.GA485@kaaira-HP-Pavilion-Notebook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaaira,

Thank you for the patch.

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

I'm curious to know why you think the line you changed deserves a
modification, while the next one doesn't :-)

>  		if (ret) {
>  			dev_err_ratelimited(module->dev,
> @@ -160,7 +160,7 @@ static int gbaudio_module_disable_tx(struct gbaudio_module_info *module, int id)
>  		i2s_port = 0;	/* fixed for now */
>  		cportid = data->connection->hd_cport_id;
>  		ret = gb_audio_apbridgea_unregister_cport(data->connection,
> -						i2s_port, cportid,
> +							  i2s_port, cportid,
>  						AUDIO_APBRIDGEA_DIRECTION_TX);
>  		if (ret) {
>  			dev_err_ratelimited(module->dev,
> @@ -205,7 +205,7 @@ static int gbaudio_module_enable_rx(struct gbaudio_codec_info *codec,
>  		i2s_port = 0;	/* fixed for now */
>  		cportid = data->connection->hd_cport_id;
>  		ret = gb_audio_apbridgea_register_cport(data->connection,
> -						i2s_port, cportid,
> +							i2s_port, cportid,
>  						AUDIO_APBRIDGEA_DIRECTION_RX);
>  		if (ret) {
>  			dev_err_ratelimited(module->dev,
> @@ -295,7 +295,7 @@ static int gbaudio_module_disable_rx(struct gbaudio_module_info *module, int id)
>  		i2s_port = 0;	/* fixed for now */
>  		cportid = data->connection->hd_cport_id;
>  		ret = gb_audio_apbridgea_unregister_cport(data->connection,
> -						i2s_port, cportid,
> +							  i2s_port, cportid,
>  						AUDIO_APBRIDGEA_DIRECTION_RX);
>  		if (ret) {
>  			dev_err_ratelimited(module->dev,

-- 
Regards,

Laurent Pinchart
