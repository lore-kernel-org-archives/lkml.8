Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC05CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892E4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LgduLYE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636888AbgDOPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636868AbgDOPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:25:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDDC061A0C;
        Wed, 15 Apr 2020 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=daO92Tw6mjzwnZTWWONfVVOWvOshJIiguRIHq2MkEXQ=; b=LgduLYE1WQCRvj65hfnqVRbukl
        d1nSnLh+yFv+To4VmD2YoCLw8NB5ksC0uTTLLIau0Aft2pIpliUcXbBJUuCuEd8n4sYXLUDby0qX3
        8YFnLRbJZiw+UyCPUXyqHhlUbdS9dh1Vd45uIsNJcCnb2Bfy94ra3rS5TqWcRx6Mz+5mrfJn5uwBk
        /RTxUaeM6gNL1fIp42j755QfgL3k49KEavXKfhz5ANp4u051hjnSjjdHHDV3FYWdi3J34HC30JQmo
        RBq0L/n+iM7TtcjM9pQ6TSOsHKmCWyfEXYART8LncTYxX6wrnYQw4/IR3/m4uPLF/Dgnp1haHFIF+
        gl3hmvjQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOjuw-0006aD-Ab; Wed, 15 Apr 2020 15:25:35 +0000
Subject: Re: [PATCH 2/2] soc: mediatek: Add mtk-mmdvfs driver
To:     Anthony Huang <anthony.huang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <1586949506-22990-1-git-send-email-anthony.huang@mediatek.com>
 <1586949506-22990-3-git-send-email-anthony.huang@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1296cbb7-c470-4169-8499-89f723308f85@infradead.org>
Date:   Wed, 15 Apr 2020 08:25:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586949506-22990-3-git-send-email-anthony.huang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--


On 4/15/20 4:18 AM, Anthony Huang wrote:
> Mediatek MMDVFS driver is used to set clk for Mediatek multimedia
> hardwares. The MMDVFS registers a regulator callback and multimedia

  hardware.

> hardwares set voltage by regulator API and then this callback will be

  hardware

> triggered. The MMDVFS will get current opp level from opp table according
> to the voltage, and then the MMDVFS sets all the clock MUXs to the clock
> sources according to the opp level.
> 
> On some platforms, both clock MUX and frequency hopping need to be used
> together. The MMDVFS supports these two clock setting methods and the
> execution sequence of them can be configured in DTS.
> 
> Signed-off-by: Anthony Huang <anthony.huang@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig      |    9 ++
>  drivers/soc/mediatek/Makefile     |    1 +
>  drivers/soc/mediatek/mtk-mmdvfs.c |  312 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 322 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-mmdvfs.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 2114b56..e92762b 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -44,4 +44,13 @@ config MTK_SCPSYS
>  	  Say yes here to add support for the MediaTek SCPSYS power domain
>  	  driver.
>  
> +config MTK_MMDVFS
> +	tristate "MediaTek MMDVFS Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Say yes here to add support for the MediaTek Multimedia DVFS (MMDVFS)
> +	  driver. The MMDVFS is used to set clk for Mediatek multimedia hardwares

	                                                                hardware,

> +	  , such as display, camera, mdp and video codec. Say no if your device

	  ^drop that comma.

> +	  does not need to do DVFS for Multimedia hardwares.

	                                          hardware.

> +
>  endmenu


thanks.
-- 
~Randy

