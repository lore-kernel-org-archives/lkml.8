Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2043CC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08A2215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2PgJT5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCYPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:05:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgCYPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=RgL3fFDWUfi6OWcUf2aZFRQF2RBFjztz840WQI7cRrw=; b=D2PgJT5GWvwimZ+nxt3NjqP52H
        bRaS81pr7TBINEDhA4/hLqobFxqEDzpWYG60fV6Yr7KhtRO6qj8ckxyMwCDty73iVrNP1q62AfLWC
        3Gff5dD2OpwhkVzEa7TJxcAH+Hf582moq+ixiGz+LkK/Cq7e4+y++Q2SAOS3aKOfO8q2G0KUhs5Ip
        n5Hk1sqLu6uO9TnmUwNPbh5VIb25yasBxLx/UqmogiScdnj5HZscdZuuV+4r1QmTcLYFQpsn6hLe4
        WXaUuqRLStaqecTD/z7QCDaSZ/0BCBBOmAb4UHJ0uTQldldWGfBSYXmZ/wPnt2ey2Pea+59llj9RI
        qGlMjP/w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH7ak-0003GQ-TB; Wed, 25 Mar 2020 15:05:14 +0000
Subject: Re: [PATCH v5 4/6] pinctrl: mediatek: add pinctrl support for MT6779
 SoC
To:     Hanks Chen <hanks.chen@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Andy Teng <andy.teng@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, Mars Cheng <mars.cheng@mediatek.com>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
 <1585128694-13881-5-git-send-email-hanks.chen@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e91e09ca-d896-3712-f8fa-8811a2be6b5e@infradead.org>
Date:   Wed, 25 Mar 2020 08:05:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585128694-13881-5-git-send-email-hanks.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 2:31 AM, Hanks Chen wrote:
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 701f9af..f628d01 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -86,6 +86,13 @@ config PINCTRL_MT6765
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  
> +config PINCTRL_MT6779
> +	bool "Mediatek MT6779 pin control"
> +	depends on OF
> +	depends on ARM64 || COMPILE_TEST
> +	default ARM64 && ARCH_MEDIATEK
> +	select PINCTRL_MTK_PARIS

Hi,
Please add some useful help text.

> +
>  config PINCTRL_MT6797
>  	bool "Mediatek MT6797 pin control"
>  	depends on OF

thanks.
-- 
~Randy

