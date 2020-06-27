Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360F021556
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593256118;
	bh=m0W7oiPf3mtQDUxHdtC2NEBgyqu5tT0E4gLi1FF491Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMj6vC33XNbT9dRra0ow2YfhUrEVzyFq8vQ5OGBjdeno/4ADPCCT7lNe5Wc060utS
	 VAx6qih/Zdfcu4SmgjB/T6nortdtOalflwyWQX/2/eJlRz4HTCHdmoMiXp28B0huLV
	 Qsnyxp4mX87Fca/5eub1dfHWwHkAkGM4yS/OdPEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgF0LIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgF0LIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:08:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C856214DB;
        Sat, 27 Jun 2020 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593256103;
        bh=m0W7oiPf3mtQDUxHdtC2NEBgyqu5tT0E4gLi1FF491Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F933a6xBx+MthAGOPPe1BMRq20jB+4MTvy0leXETzLaqAZd8tZ7a37lglNpUS1T8I
         UWH8ztF/J8PXOsahP3EcbQwvm27OIztJbh/Z6sDgmoe4WkO+apaA38mNDY8Ob9k23R
         yXf38qrKB5Nesjd3cyoyvn6UaCWX9k0EEtbxj0ak=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jp8h3-006s0z-PK; Sat, 27 Jun 2020 12:08:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Andrew Perepech <andrew.perepech@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] irqchip: Use struct_size() helper in devm_kzalloc()
Date:   Sat, 27 Jun 2020 12:08:03 +0100
Message-Id: <159325548742.93134.5441402271189391184.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616230923.GA24937@embeddedor>
References: <20200616230923.GA24937@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, matthias.bgg@gmail.com, brgl@bgdev.pl, tglx@linutronix.de, festevam@gmail.com, s.hauer@pengutronix.de, kernel@pengutronix.de, gustavoars@kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, andrew.perepech@mediatek.com, linux-mediatek@lists.infradead.org, stephane.leprovost@mediatek.com, linux-arm-kernel@lists.infradead.org, pedro.tsai@mediatek.com, bgolaszewski@baylibre.com, fparent@baylibre.com, linux-kernel@vger.kernel.org, gustavo@embeddedor.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 18:09:23 -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied to irq/irqchip-5.9:

[1/1] irqchip/imx-intmux: Use struct_size() helper in devm_kzalloc()
      commit: 2f7a9bda42f74e1169fcd9ef55c8ade989ef8bba

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

