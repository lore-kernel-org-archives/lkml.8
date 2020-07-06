Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D9120708
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9Wq9RrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGFQNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgGFQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:13:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75319C061755;
        Mon,  6 Jul 2020 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=09RoxU92YpiyFpZjGA58GlY5VvI+xGq1TPjqAx/m+PA=; b=h9Wq9RrXAVog2t9KjanKEF/6JQ
        UYC9ZjGxcBBW2cT32mHa0U50bCWLIuS+tbVqK1O64zY2AKOMdczgjQxbDj4gDV0CIi1EqeMrFvmEx
        fb3hyUuWqjqSsQ3aSai9NsVbMweQnRBPEsCm08It7Qu+7zRWDyNpTQxYBajH1AChsDq8bzC9Ci1pF
        N2eR+c9k7gNxWNjDewVLrAKXNQr6SkFvY3fbFC0+myqMPZMAxdBc0utoYRcSfHQTEZStRQgH7NOEi
        6K9uozqOpTEPIw/Y6/qp4SOOLSAqFtygJo7Cl+XYCX/vSQxVT60o0TWs2Z5uRHIL3ZmcCPdodcrBV
        hjhH+sLA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsTk7-0007XD-V2; Mon, 06 Jul 2020 16:13:20 +0000
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6779 driver
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
 <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dd03ec1e-e511-4c13-4e12-a9f8ec407326@infradead.org>
Date:   Mon, 6 Jul 2020 09:13:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 2:28 AM, Neal Liu wrote:
> diff --git a/drivers/soc/mediatek/devapc/Kconfig b/drivers/soc/mediatek/devapc/Kconfig
> new file mode 100644
> index 0000000..b0f7d0e
> --- /dev/null
> +++ b/drivers/soc/mediatek/devapc/Kconfig
> @@ -0,0 +1,17 @@
> +config MTK_DEVAPC
> +	tristate "Mediatek Device APC Support"
> +	help
> +	  Device APC is a HW IP controlling internal device security.

preferably:               s/HW/hardware/

> +	  MediaTek bus frabric provides TrustZone security support and data

	               fabric

> +	  protection to prevent slaves from being accessed by unexpected
> +	  bus masters.
> +	  Device APC prevents malicious access to internal devices.
> +
> +config DEVAPC_MT6779
> +	tristate "Mediatek MT6779 Device APC driver"
> +	select MTK_DEVAPC
> +	help
> +	  Say yes here to enable support Mediatek MT6779 Device APC driver.

	                         support for Mediatek

> +	  This driver mainly used to handle the violation with 1 DEVAPC AO/PDs.

	  This driver is mainly used                           ^^^^^^^^^^^^^^^^

	                      What is that meaningless string of chars? ^^^^^^^


> +	  The violation information are logged for further analysis or

	                            is

> +	  countermeasures.

thanks.
-- 
~Randy

