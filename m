Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2372075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgFRO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:56:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:8231 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbgFRO42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:56:28 -0400
IronPort-SDR: H7iTJm2UcQg/t2n495Xzfs4x238RRREgFnE/zfxuYbHjaHQJD7xvAVzruwjPBPjMrTDLQcMUWU
 s3QnhZcQo6RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="204090969"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="204090969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:56:27 -0700
IronPort-SDR: NEx0GOaMn7OvG1Et1Z3rmhL2o3vxYosQnEPvgEEQoBzIU1av8cbFXZ6IsBIpSxA+94iSjx64Dh
 kvfC5ZH29okg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="477268207"
Received: from richard2-mobl.amr.corp.intel.com (HELO [10.254.109.110]) ([10.254.109.110])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 07:56:25 -0700
Subject: Re: [PATCH] ANDROID: sound: usb: Add vendor's hooking interface
To:     JaeHun Jung <jh0801.jung@samsung.com>, tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <CGME20200617022554epcas2p214a49f03a15e504d8faa28148e06e796@epcas2p2.samsung.com>
 <1592360304-29621-1-git-send-email-jh0801.jung@samsung.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d37660f8-3bb6-5f3a-8ac1-c0d6d5a08468@linux.intel.com>
Date:   Thu, 18 Jun 2020 07:27:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592360304-29621-1-git-send-email-jh0801.jung@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/20 9:18 PM, JaeHun Jung wrote:
> In mobile, a co-processor is used when using USB audio
> to improve power consumption.
> hooking is required for sync-up when operating
> the co-processor. So register call-back function.
> The main operation of the call-back function is as follows:
> - Initialize the co-processor by transmitting data
>    when initializing.
> - Change the co-processor setting value through
>    the interface function.
> - Configure sampling rate
> - pcm open/close

Thank you for this patch. With the removal of the 3.5mm jack on a number 
of platforms, and improvements to reduce power consumption on a variety 
of hosts there's indeed a need to enhance sound/usb in the kernel.

> 
> Bug: 156315379
> 
> Change-Id: I32e1dd408e64aaef68ee06c480c4b4d4c95546dc
> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>

You probably want to remove bug references and Change-Id if they are not 
publicly visible

> @@ -891,6 +897,15 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>   	struct usb_interface *iface;
>   	int ret;
>   
> +	if (usb_audio_ops && usb_audio_ops->vendor_set_pcmbuf) {
> +		ret = usb_audio_ops->vendor_set_pcmbuf(subs->dev);
> +
> +		if (ret < 0) {
> +			dev_err(&subs->dev->dev, "pcm buf transfer failed\n");
> +			return ret;
> +		}
> +	}
> +
>   	if (! subs->cur_audiofmt) {
>   		dev_err(&subs->dev->dev, "no format is specified!\n");
>   		return -ENXIO;
> @@ -924,6 +939,15 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>   		if (ret < 0)
>   			goto unlock;
>   
> +		if (usb_audio_ops && usb_audio_ops->vendor_set_rate) {
> +			subs->need_setup_ep = false;
> +			usb_audio_ops->vendor_set_rate(
> +					subs->cur_audiofmt->iface,
> +					subs->cur_rate,
> +					subs->cur_audiofmt->altsetting);
> +			goto unlock;
> +		}
> +
>   		ret = configure_endpoint(subs);
>   		if (ret < 0)
>   			goto unlock;
> @@ -1333,6 +1357,9 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>   	struct snd_usb_substream *subs = &as->substream[direction];
>   	int ret;
>   
> +	if (usb_audio_ops && usb_audio_ops->vendor_pcm_con)
> +		usb_audio_ops->vendor_pcm_con(true, direction);
> +
>   	subs->interface = -1;
>   	subs->altset_idx = 0;
>   	runtime->hw = snd_usb_hardware;
> @@ -1361,12 +1388,18 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
>   	struct snd_usb_substream *subs = &as->substream[direction];
>   	int ret;
>   
> +	if (usb_audio_ops && usb_audio_ops->vendor_pcm_con)
> +		usb_audio_ops->vendor_pcm_con(false, direction);
> +

can you elaborate on the PCM streaming parts? if you allocate a buffer 
for the co-processor to deal with PCM data, will you end-up copying data 
from the existing ring buffers allocated with vmalloc() into your 
coprocessor?

I was instead thinking of having a different 'mode' where the PCM 
buffers are not allocated by sound/usb, but instead allocated by the 
driver taking care of the low-power USB path, so that apps can directly 
write into ring buffers that are handled by the coprocessor/offload unit.

Thanks
-Pierre
