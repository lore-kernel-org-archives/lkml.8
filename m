Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76843C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F339206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ+S2fDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFVMSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgFVMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:18:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDFC061794;
        Mon, 22 Jun 2020 05:18:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ga4so4216818ejb.11;
        Mon, 22 Jun 2020 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=docflIDI4amLCKHeLBAb6CqbsH4oE72ch38fsudpF+I=;
        b=IJ+S2fDFp7GG1ynDNN0Y4anCN49jKSFMM3o4BtWVib61kP2b4PAcqcYHPyHMquqt31
         C1ThsgPzyOLKxSSnjmDLG1bFkZqSiSEXTqcz0LZREOkaGwN9EUcm6PQhbWzN9rN6E4OR
         vegTRIDmATxE7ggM3TrxndNIENg7x2IxagZGHq7S7KTgY9E1kPaxT4/ciTCPCQkFWLPt
         1Li99vnBc5xZSDafA/tkaJNijKGeah6H0ldSdQo23gjIonSn2Ve0XkSutlmXe/3c0/5a
         nu5MVmtVQZHvsKBtqCJw3wViduCOmL6tnNOFadTrxlqpPSy7UFgKd9zNTnaZsD3sUlNb
         S14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=docflIDI4amLCKHeLBAb6CqbsH4oE72ch38fsudpF+I=;
        b=G/swLib8rkSJBWqfeH2dGgBVdS7ntMQrlIfBAHoxQc1ACZRP+gA+YTdTEorZbaRpmb
         DmtQ2WQ4f9DDxAzTqDnhfreVdYiT4UkX0r/1ScHimKczzWqRCt35G1qQhPgCXbRokuwi
         UfL38Gd9oYg1Ts8Ge8U30daUGrGRq5LZzEZwN15wNfJor9TY8H2GatC1XBtVKyRKo94X
         yryIAIACNk5JCIhMbMmElmbUq9K0cMDjKbXLPKD52dwTXlX/y/qArxOs8wOupgmxs3kH
         Gj2vXSVqgy8+SWFof6lNVuN3YnSza0E77RYcZN+Yt1sJVxYgPn1Xx0hDXrep68jky1Tl
         sMzA==
X-Gm-Message-State: AOAM5314YkycBFwUiw+GlwVdwebEb6bNvAdpLIFq9XEiU9GbS9nbnKwU
        WhnRrPCjZ/XiP8LMuoiwnNo=
X-Google-Smtp-Source: ABdhPJxcnXn3SwizrRcX6gkvmZ5KKeWEOb3yZYZ1x023/kXSF/cDxIFGr1v3RLSqqpGX1y4XRYpqXw==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr15008947ejr.20.1592828292916;
        Mon, 22 Jun 2020 05:18:12 -0700 (PDT)
Received: from BV030612LT ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id a1sm5562180ejk.125.2020.06.22.05.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 05:18:12 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:18:09 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 00/11] Add CMU/RMU/DMA support for Actions Semi S500 SoCs
Message-ID: <20200622121809.GA23301@BV030612LT>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
 <159281361144.62212.15284914532690869405@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159281361144.62212.15284914532690869405@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:13:31AM -0700, Stephen Boyd wrote:
> Quoting Cristian Ciocaltea (2020-06-17 09:48:00)
> > This patch series improves the existing implementation of the Clock
> > Management Unit for the Actions Semi S500 SoC, by adding support for
> > some missing clocks, like DMAC and GPIO.
> > 
> > Additionally, it enables the UART nodes in the common owl-s500 DTS to
> > use the clock provided by the CMU. That means the S500 based SBCs can
> > now get rid of their (fake) UART fixed clock and, as a matter of fact,
> > this has been already done here for RoseapplePi, the new board which
> > is going to be supported (hopefully) via the following patchset:
> > https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> > 
> > Eventually, the patchset adds support for the Actions Semi S500 SoC's
> > DMA controller and Reset Management Unit. Please note the already
> > existing Actions Semi Owl SoCs DMA driver seems to be fully compatible
> > with S500, even though this is not explicitly mentioned in the source
> > code. For the moment, I have just enabled the DMA controller node in
> > owl-s500 DTS using the "actions,s900-dma" compatible string.
> > 
> > In the upcoming patch series I will provide a pinctrl driver and enable
> > access to MMC and I2C.
> > 
> 
> Can you please untangle this from the DTS changes? The clk driver
> changes will go through the clk tree and the DTS changes will go through
> arm-soc. Please send them as separate patch series to the respective
> maintainers.

Hi Stephen,

Thank you for reviewing!
I will submit v2 having the DTS related changes removed from this patch
series.

Regards,
Cristi

