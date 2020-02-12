Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB43C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96272073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i7D2bxT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBLFLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:11:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgBLFLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OTFD/SNJffQD3DOz5VRTovqxb+aXKeZm5TMlIiwyLbY=; b=i7D2bxT62GMcsQBA/OG+IFzNG6
        lmiouuAQCXjnQ5VxYf05qkah31TKIuACoAxAW/5IFUiktzYFxUYyxLUwOa5cDZQaEZLyZ4anQLGOA
        6J2hKd+ITQCBXqX3V7JmOEaILq2ppan2KDM3uBu1yRtWB1n6Vyl9lWTuUPaoW8IoHfPYotYNcOszQ
        oF4zMTRyLmKiVzrlXh4SPmFZuxY0nzcKrrsJr2cQ5aEBf9ag8H74ZyJwekTQn1J2syYa5aWHk5Lmq
        9UmNgg0EF5Hv3xwppCVqhUZjBcXSW/WcBBUEnbKhPaqYR0rx537FQfxsrDeO/gD8sFJFKg15P6ZlS
        bVAWmY6A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1kJ5-0007Y5-TA; Wed, 12 Feb 2020 05:11:27 +0000
Subject: Re: [PATCH 0/3] Add new module driver for new ASRC
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2ab5cc65-026a-10fd-1216-b0d83baf37a6@infradead.org>
Date:   Tue, 11 Feb 2020 21:11:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1581475981.git.shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 8:30 PM, Shengjiu Wang wrote:
> Add new module driver for new ASRC in i.MX815/865
> 
> Shengjiu Wang (3):
>   ASoC: fsl_asrc: Move common definition to fsl_asrc_common
>   ASoC: dt-bindings: fsl_easrc: Add document for EASRC
>   ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers
> 
>  .../devicetree/bindings/sound/fsl,easrc.txt   |   57 +
>  sound/soc/fsl/fsl_asrc.h                      |   11 +-
>  sound/soc/fsl/fsl_asrc_common.h               |   22 +
>  sound/soc/fsl/fsl_easrc.c                     | 2265 +++++++++++++++++
>  sound/soc/fsl/fsl_easrc.h                     |  668 +++++
>  sound/soc/fsl/fsl_easrc_dma.c                 |  440 ++++
>  6 files changed, 3453 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
>  create mode 100644 sound/soc/fsl/fsl_asrc_common.h
>  create mode 100644 sound/soc/fsl/fsl_easrc.c
>  create mode 100644 sound/soc/fsl/fsl_easrc.h
>  create mode 100644 sound/soc/fsl/fsl_easrc_dma.c
> 

Hi,

Is this patch series missing Kconfig, Makefile, and possibly
MAINTAINERS patches?

thanks.
-- 
~Randy

