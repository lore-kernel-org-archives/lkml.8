Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77452C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493842078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vh8X+msp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHZTA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHZTAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:00:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86CC061574;
        Wed, 26 Aug 2020 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JTeiHpI9co8/sk3zm+dbWTU5RH8x8HjRlmbdmUsEWAA=; b=vh8X+msp/Vupas3v7jeX+S7Px9
        13YwPPFGaulusQHlWXot74+cIamxFiSmgBkVDynnN9eUJ1KqDz568hVwY4lGG0aQXbGJk80T7fyGn
        Be3o2tN+yw2Ls1zLNSBINNMHhXkr/6/lIuIpzoBxQwa75CsHRtj3WcSmhWLLQmosxoQSAzcZAIgud
        KpN7FOHfFrdwxQ7rlq5ZXftd3UVCor+VZLAmreVxJehHWlQm8WzGrjBlf3EqrpmhYUPGPVCUuaHpu
        dwyn4Qie2tm+UGPXu8RfioxupN9HsyZE8zyuiVEWWfZOSUvMy3JOpgtAKgIlPIML5va8BSom1GFS+
        AvBT8paA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kB0fD-0008WJ-28; Wed, 26 Aug 2020 19:00:51 +0000
Subject: Re: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
To:     Manish Narani <manish.narani@xilinx.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b7054ec-1b20-0bbc-3cf2-53a32f6fb52d@infradead.org>
Date:   Wed, 26 Aug 2020 12:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 11:44 AM, Manish Narani wrote:
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 7a2304565a73..416063ee9d05 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -139,4 +139,12 @@ config USB_DWC3_QCOM
>  	  for peripheral mode support.
>  	  Say 'Y' or 'M' if you have one such device.
>  
> +config USB_DWC3_XILINX
> +       tristate "Xilinx Platforms"
> +       depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
> +       default USB_DWC3
> +       help
> +         Support Xilinx SoCs with DesignWare Core USB3 IP.
> +	 Say 'Y' or 'M' if you have one such device.
> +
>  endif

Indent help text (2 lines) with one tab + 2 spaces, please,
according to Documentation/process/coding-style.rst.

thanks.

-- 
~Randy

