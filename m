Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E05C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54B220758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQC1Kdrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgHTMUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbgHTMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:20:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE81C061386;
        Thu, 20 Aug 2020 05:20:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so1804218ljg.13;
        Thu, 20 Aug 2020 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xbINavy4gHcRxNs/5kLcdkVc1FcO3WPizBP6INYtSP4=;
        b=lQC1KdrnOgLXAQYFuDiKTg6pUavfIoWf4LVotFU7Sl5ZiSXQekFnzcRa1vIBa4v3F/
         Z9IZ+bJwXgvcJ326ID2k31ggk4Bsv9YP7jNCcE2oQqBD8vhQukItqJ8CjAhW+6MpVLoX
         NZBMAkHDR8oyNgTErvVCPv97DDZUs0SOdLRQ5zLUPofrD58w2NXkmncu2jQJAAzBLYLb
         eK1ezZV+9HZkQMds+lAc++HmmlJmfQUfII/36KGzz32excIS/af+ee38lF8dJXmOFESS
         2/rx0qKof883/H3epULNfQgBPumc3PReyXB8wGx1NmVAbOKErkplS5xv4eLHeN3DbkYB
         jaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xbINavy4gHcRxNs/5kLcdkVc1FcO3WPizBP6INYtSP4=;
        b=olOWRyRdyt/XCFOD1GHyuZOibhqEsieCEk0+rk1ctb8vaZfPvIF9pQUBQrGT1DUAAC
         Cf1JVDVonBe3dih+oGG7rGJzG9t4mUW6W61hzEcbK7vtYTS3n8zrcyl71+c5F7y/nBAD
         J0CwQDox6PjK5kRLvajbXJbwkYO/c5XkxRumXJOOHoc1hZgwQTQ/Es6m4tcpJ1G3kAJx
         P4lO6Rzu5s+F6GEUbj1nGKZ/kgDk64FlZn+jXHivras45Vq9uDXXbv+ARIVnlsDtyuXN
         6A3InNEXhv7G1gFRtvg2LZf0DIkMiqzZcm0Hhl5YvG0gAFuqRpPlSnm2E05i26rDnolm
         uJGw==
X-Gm-Message-State: AOAM533ZGwYjXPEOHn6BgD9s+M0Ite15s8ihasCik/RX7d9x2snsyrtV
        ay8fSoia5PKBoSd0MPdnRir8OpXLVTU=
X-Google-Smtp-Source: ABdhPJymjxP8701lahasTauyhK7MW73ikzbXwms7TfQBLJzKvydCc/2wRunfMm73vMbg0HvMPkkCXQ==
X-Received: by 2002:a2e:85d3:: with SMTP id h19mr1604426ljj.363.1597926024210;
        Thu, 20 Aug 2020 05:20:24 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id l10sm418503ljc.65.2020.08.20.05.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:20:23 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200819042308.19043-1-f.fainelli@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <d4a3b850-7b19-bad7-383b-dfbc0f7c896c@gmail.com>
Date:   Thu, 20 Aug 2020 14:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819042308.19043-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.2020 06:23, Florian Fainelli wrote:
> The pin controller resources start at 0xc0 from the CRU base which is at
> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
> are currently off by 0x100. The resource size of the CRU is also
> incorrect and should end at 0x248 bytes from 0x100 which is the start
> address. Finally, the compatibility strings defined for the
> pin-controller node should reflect the SoC being used.

I can confirm 0x1800c1c0 is the correct absolute offset.


> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 2d9b4dd05830..bf49943f504a 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -402,14 +402,14 @@ dmu@1800c000 {
>   
>   		cru@100 {
>   			compatible = "simple-bus";
> -			reg = <0x100 0x1a4>;
> +			reg = <0x100 0x248>;
>   			ranges;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   
> -			pin-controller@1c0 {
> -				compatible = "brcm,bcm4708-pinmux";
> -				reg = <0x1c0 0x24>;
> +			pinctrl: pin-controller@c0 {
> +				compatible = "brcm,bcm53012-pinmux";
> +				reg = <0xc0 0x24>;
>   				reg-names = "cru_gpio_control";
>   
>   				spi-pins {
> 

That whole binding has a bit messy story.

Initially it used to be binding like:
	compatible = "brcm,bcm4708-pinmux";
	reg = <0x1800c1c0 0x24>;
	reg-names = "cru_gpio_control";
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c12fb1774deaa9c9408b19db8d43d3612f6e47a0
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f9f82b3ffb8bfe01988c890e3a24328e9e1c1df

Later example binding was rewritten to include dmu and cru (simplified
below):
	dmu@1800c000 {
		compatible = "simple-bus";
		ranges = <0 0x1800c000 0x1000>;

		cru@100 {
			compatible = "simple-bus";
			reg = <0x100 0x1a4>;
			ranges;

			pin-controller@1c0 {
				compatible = "brcm,bcm4708-pinmux";
				reg = <0x1c0 0x24>;
				reg-names = "cru_gpio_control";
			};
		};
	};
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93d39737b29eaf1974bf850ccdc903b2418c800b
I don't understand or remember why pin-controller reg was relative to
dmu instead of cru. Some DT offset calculation magic?

Finally I updated binding to use "offset", see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2ae80900f239484069569380e1fc4340fd6e0089
and then updated driver to follow:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a49d784d5a8272d0f63c448fe8dc69e589db006e
but I never updated DTS file accordingly.

To OpenWrt I pushed relevant kernel patch in the commit:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=a28f6ab27f9ae1a08c6945013cdb796b12ce150d
(called [PATCH] ARM: dts: BCM5301X: Update Northstar pinctrl binding)
but I never sent it upstream.

Florian: your change doesn't match docs or existing Linux driver:
1. Driver seems to ignore "reg"
2. Driver requires "offset"
3. Property "cru_gpio_control" is leftover (undocumented and unused)

I think we need to take a step back and cleanup Northstar bindings. Few
months ago I sent e-mail:
Subject: Proper DT bindings for Broadcom's DMU node
Message-ID: <7da2db8f-66d0-24ec-d3eb-84247b383a06@gmail.com>

I didn't get any reply from Rob who previously pointed out that
compatible = "syscon", "simple-mfd";
is not a valid compatibility.

I suggest we hold on on DTS update for a moment and switch back to my
question from March on designing proper bindings.
