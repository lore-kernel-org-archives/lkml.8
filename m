Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C61CC11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08453208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OGlPGfGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgBTTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:31:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBTTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:31:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so5902204wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DYNEng+7zD6OFMtDudcYE3wzE2+5a/X4a0VlHsXEIpM=;
        b=OGlPGfGUSkgbEdmuMrVZ8vkKL75x5aaCabHCqh9VsD/lXRWghC/0VsZQQ14UVDhb9b
         nhQd2LWug7n9sjnJYZNBIXWEareEVbQpp+SFlXuslZtAx/UyfCvhMaMySFquuxJJz78u
         08iQcycCqNbQ/mDE4bfjDst4GaK0gFNINjk9J3FAs2c8xbdIAM1HdFTzhiDAuVEaGArX
         2YOeZn69T2YPAFkvRjOEZf+wpto+6H2Gj19FMRRCBACSSHD7e2MlEB3aCVMqf2L7MUbo
         5RzsioMu/RWUL02KFTR6MhtC55FAwmQIS9LIXb586m5O79RXO6L4pvvL9Vbz1SN+YC9y
         hWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DYNEng+7zD6OFMtDudcYE3wzE2+5a/X4a0VlHsXEIpM=;
        b=CxHqtQ4M0aVMlejbYStD2gyD/pj05XYmR/wgRKiOSpqzW79A8dmdVHtWXjufiprwp8
         oiQyRT3VunQey7lLa5CQmI4fDeBim614+mRdEGob0ZzG2z9R+JMtCrA3NC+vIK7/GNlA
         CDy3ITEZDdDfzp9vu7kqmYI79i4+IteqKMfOVQy2jqabQNZNGQWdbgXwN3naMR5enJPj
         taoqWPhDWdMcIlu4Bq+QXIUDYcUmrYmDI5W3I3Xjc62rXJ8HWU/L6oJx7Kd7epHUcBKh
         uoyvOOFGmb7aWPY2YcmAy5lQddvlGtw9tDZh3o3fFH2de/t1L6ENTZ5BKnMWn+wPd+c1
         5+NA==
X-Gm-Message-State: APjAAAX6iHmLYr366N8bOuUoWAtGKNQ9ucuH9W1BmjMJQn1St8+m1tAl
        jX+mrlGcA1ZKepaS5KF07IRElg==
X-Google-Smtp-Source: APXvYqyfBUkzQRvzomJyxmKwUibj1mCUwFcnnPjIXyXQXzSw/m4kvvVCRcxQZCJQ6hJ/ya6U+cn+MQ==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr17579533wru.143.1582227087004;
        Thu, 20 Feb 2020 11:31:27 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e35:2ec0:82b0:3115:825f:fd46:f0e9])
        by smtp.gmail.com with ESMTPSA id w8sm433876wmm.0.2020.02.20.11.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 11:31:26 -0800 (PST)
Subject: Re: [PATCH v2] arm64: dts: meson-gxbb-vega-s95: fix bluetooth node
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1582220642-14133-1-git-send-email-christianshewitt@gmail.com>
Cc:     Oleg Ivanov <balbes-150@yandex.ru>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <c9d7d7a0-4dc0-8698-ed82-6c0b10990374@baylibre.com>
Date:   Thu, 20 Feb 2020 20:31:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1582220642-14133-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/02/2020 à 18:44, Christian Hewitt a écrit :
> This was missed from the previous fix.
> 
> Fixes: b07a11dbdfeb ("arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support")
> 
> Suggested-by: Oleg Ivanov <balbes-150@yandex.ru>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index 5eab3df..45cb836 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -245,6 +245,9 @@
>  	bluetooth {
>  		compatible = "brcm,bcm43438-bt";
>  		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
> +		max-speed = <2000000>;
> +		clocks = <&wifi32k>;
> +		clock-names = "lpo";
>  	};
>  };
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
