Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746D8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1762078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="toQb+N8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgHSQAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHSQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:00:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1BEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=BK1LndwIv+/Uu7uRarU+mX6SC3KhRNJ1Vg8sH2sbGHk=; b=toQb+N8vp+OjE8TAeKwP7GG5zV
        ui93QbQKKW7PzjU0caOz3Mo31HnHZGwS7wIp9x/ZDzzKuPcGj1O/IaHqGM6kZ3OGDxXk/GhmRM4b8
        ZeQ8X9wqJxMAfs6KZJnI9gumGKZODyrh+OoHbNhb+ZsTip0fUX9VqxqGgCFdN0/Ow1OVKOrmucIZ7
        oy74l5794ncrpiHC+664m2KwUJlAm2bV7tToS9Y9Y5khv5Q/C7akYc3lsOzuflsKw3PfYV7+mvnQw
        qlEMWyGik0wx2GPbrioAnwGJaoe+VCX3d62V8C743LmU9yGDWDYSrwHtfYZDNVXTK3SyS/fjN56m/
        kcjleghQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8QVO-0001e6-04; Wed, 19 Aug 2020 16:00:02 +0000
Subject: Re: [PATCH v4 3/4] phy: mediatek: Move mtk_hdmi_phy driver into
 drivers/phy/mediatek folder
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>
References: <20200819154421.7013-1-chunkuang.hu@kernel.org>
 <20200819154421.7013-4-chunkuang.hu@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <919b4b36-8deb-dfbe-81fe-c12f8da65dac@infradead.org>
Date:   Wed, 19 Aug 2020 08:59:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819154421.7013-4-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 8:44 AM, Chun-Kuang Hu wrote:
> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> index dee757c957f2..10f0ec2d5b54 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -35,3 +35,10 @@ config PHY_MTK_XSPHY
>  	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
>  	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
>  	  multiple USB2.0, USB3.1 GEN2 ports.
> +
> +config PHY_MTK_HDMI
> +    tristate "MediaTek HDMI-PHY Driver"
> +    depends on ARCH_MEDIATEK && OF
> +    select GENERIC_PHY
> +    help
> +          Enable this to support HDMI-PHY

Fix indentation above.

thanks.
-- 
~Randy

