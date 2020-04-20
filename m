Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22659C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF6C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="hE3jjcIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgDTUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:42:14 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 13:42:13 PDT
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
        s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=ZKaz9g+0dN4EMZTssIuTURp7XdyfTbM9NKhYQlFDI6Q=; b=hE3jjcIicpBLRbfMdYwOm7k70P
        O5XW9hDIULhuBkjgZqgmGtvWgiB2l2dl/LygBV9Y2pixjriADPQEQMOsukOQjl2llEGEn3s33b9hA
        L1tr4wdWUQQpQ/WZnBvi2bhGzwdSwYSPjtrGnFOuQlLon4ZP/pxUlkLv2NfWbYKx70iI=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home)
        by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <puleglot@puleglot.ru>)
        id 1jQczO-0006SG-8n; Mon, 20 Apr 2020 23:25:58 +0300
Message-ID: <1c4b8a362761421eba0ded60bb4f0e11b7e42f3b.camel@tsoy.me>
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for Focusrite Scarlett 2i2
From:   Alexander Tsoy <alexander@tsoy.me>
To:     Gregor Pintar <grpintar@gmail.com>, tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Apr 2020 23:25:56 +0300
In-Reply-To: <20200420201937.12634-1-grpintar@gmail.com>
References: <20200420201937.12634-1-grpintar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

В Пн, 20/04/2020 в 22:19 +0200, Gregor Pintar пишет:
> Force it to use asynchronous playback.

Can we use snd_usb_audioformat_attributes_quirk() for such fixes? See
the quirk for Griffin iMic as an example.

> 
> Same quirk has already been added for Focusrite Scarlett Solo (2nd
> gen)
> with a commit 46f5710f0b88 ("ALSA: usb-audio: Add quirk for Focusrite
> Scarlett Solo").
> 
> This also seems to prevent regular clicks when playing at 44100Hz
> on Scarlett 2i2 (2nd gen). I did not notice any side effects.
> 
> Signed-off-by: Gregor Pintar <grpintar@gmail.com>
> ---
>  sound/usb/quirks-table.h | 84
> ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index e009d584e..bc936bf79 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -2840,6 +2840,90 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>  		}
>  	}
>  },
> +{
> +	/*
> +	 * Focusrite Scarlett 2i2 2nd generation
> +	 * Reports that playback should use Synch: Synchronous
> +	 * while still providing a feedback endpoint. Synchronous
> causes
> +	 * snapping on some sample rates.
> +	 * Force it to use Synch: Asynchronous.
> +	 */
> +	USB_DEVICE(0x1235, 0x8202),
> +	.driver_info = (unsigned long) &(const struct
> snd_usb_audio_quirk) {
> +		.ifnum = QUIRK_ANY_INTERFACE,
> +		.type = QUIRK_COMPOSITE,
> +		.data = (const struct snd_usb_audio_quirk[]) {
> +			{
> +				.ifnum = 1,
> +				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
> +				.data = &(const struct audioformat) {
> +					.formats =
> SNDRV_PCM_FMTBIT_S32_LE,
> +					.channels = 2,
> +					.iface = 1,
> +					.altsetting = 1,
> +					.altset_idx = 1,
> +					.attributes = 0,
> +					.endpoint = 0x01,
> +					.ep_attr =
> USB_ENDPOINT_XFER_ISOC |
> +						USB_ENDPOINT_SYNC_ASYNC
> ,
> +					.protocol = UAC_VERSION_2,
> +					.rates = SNDRV_PCM_RATE_44100 |
> +						SNDRV_PCM_RATE_48000 |
> +						SNDRV_PCM_RATE_88200 |
> +						SNDRV_PCM_RATE_96000 |
> +						SNDRV_PCM_RATE_176400 |
> +						SNDRV_PCM_RATE_192000,
> +					.rate_min = 44100,
> +					.rate_max = 192000,
> +					.nr_rates = 6,
> +					.rate_table = (unsigned int[])
> {
> +						44100, 48000, 88200,
> +						96000, 176400, 192000
> +					},
> +					.clock = 41
> +				}
> +			},
> +			{
> +				.ifnum = 2,
> +				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
> +				.data = &(const struct audioformat) {
> +					.formats =
> SNDRV_PCM_FMTBIT_S32_LE,
> +					.channels = 2,
> +					.iface = 2,
> +					.altsetting = 1,
> +					.altset_idx = 1,
> +					.attributes = 0,
> +					.endpoint = 0x82,
> +					.ep_attr =
> USB_ENDPOINT_XFER_ISOC |
> +						USB_ENDPOINT_SYNC_ASYNC
> |
> +						USB_ENDPOINT_USAGE_IMPL
> ICIT_FB,
> +					.protocol = UAC_VERSION_2,
> +					.rates = SNDRV_PCM_RATE_44100 |
> +						SNDRV_PCM_RATE_48000 |
> +						SNDRV_PCM_RATE_88200 |
> +						SNDRV_PCM_RATE_96000 |
> +						SNDRV_PCM_RATE_176400 |
> +						SNDRV_PCM_RATE_192000,
> +					.rate_min = 44100,
> +					.rate_max = 192000,
> +					.nr_rates = 6,
> +					.rate_table = (unsigned int[])
> {
> +						44100, 48000, 88200,
> +						96000, 176400, 192000
> +					},
> +					.clock = 41
> +				}
> +			},
> +			{
> +				.ifnum = 3,
> +				.type = QUIRK_IGNORE_INTERFACE
> +			},
> +			{
> +				.ifnum = -1
> +			}
> +		}
> +	}
> +},
>  
>  /* Access Music devices */
>  {

