Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C2C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F022220873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581564366;
	bh=F73RG8CacFW4ufAQv04PMvYtdV5CimSEtBHF9fc93qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NsWw0vPmkly5mTdpHVpnnAtDAPFOIqJqBtBr7clOOnDO/D3ku9b6jqle+RC/+qIMZ
	 IMdDbfhc9WTbp5c+txbmHqywnoxq+v+adNm8yAeqYFn5gGf9x78w2qrxEp3vnX9Laa
	 HLLi7KNB9olinrDhrmfLGdJAK8Ll7YQP90oHDAZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgBMD0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgBMD0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:26:04 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF4521739;
        Thu, 13 Feb 2020 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581564364;
        bh=F73RG8CacFW4ufAQv04PMvYtdV5CimSEtBHF9fc93qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1RF3GzcgijWF1AzwbCyQmGirvYOn7lv2oXeBLhEmDVikfMDlmlz6/NQC7Irs4Iu5
         wGxWdTmbRfa49eKHLbWwk7E6EVavGzlGZZW8DhvY2IyDH9StcFgSPXNoDWeFd4p9zn
         q0385ik/L0Rl9YR0pIZQpi6x6LR+NdSKYWLKcV5Q=
Date:   Thu, 13 Feb 2020 11:25:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] clk: imx8mn: add snvs clock
Message-ID: <20200213032554.GL11096@dragon>
References: <20200116073718.4475-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116073718.4475-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 09:37:15AM +0200, Horia Geantă wrote:
> v2: add commmit message for trivial patch 1/3
> 
> This patch set adds the clock for snvs module on imx8mn.
> DT bindings, clk driver are updated accordingly.
> DT for imx8mn (snvs-rtc-lp node) is also updated.
> 
> Horia Geantă (3):
>   dt-bindings: clock: imx8mn: add SNVS clock
>   clk: imx8mn: add SNVS clock to clock tree
>   arm64: dts: imx8mn: add clock for snvs rtc node

Applied all, thanks.
