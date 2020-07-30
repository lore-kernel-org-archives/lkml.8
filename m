Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA19C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596107016;
	bh=BU/NVzvlBKQTg6cZgDotRhWvLPEGjjEBcGjBKCbfeGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k4Uap6MJRh2cMTbC6oP2hX3FM1lkM/59czWWFLJnzma67PM0d4b7R09TpGBwr5xdq
	 ffSp3W3YXTBELEQie4cQ4Hu3sAsmD97wRyfNjRhLjgnu0NND9uOA77xNTzqtY2ribX
	 OY6e4SkJyt5T1fxMbgRB4ljqyJwidpQxnXrt/QYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgG3LDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3LDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:03:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF16207F5;
        Thu, 30 Jul 2020 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596107014;
        bh=BU/NVzvlBKQTg6cZgDotRhWvLPEGjjEBcGjBKCbfeGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsO/fJ5zWAZepclOxCRIdHmiDSFi2pTwrP71i81awo8IrbE3m3Uikb6GYi9IqCiYf
         wuaql6416ouMTjuCS1zDbEn/qL0VvLdVKsZjiW/7GeFu36uaJBngz7okhFxWDj0Bgd
         U1gZUC1FG2E0hWagUEDvB1VR4AHfhgcwyzdjtXbY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k16LU-00GERW-QN; Thu, 30 Jul 2020 12:03:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Hulk Robot <hulkci@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()
Date:   Thu, 30 Jul 2020 12:03:29 +0100
Message-Id: <159610698265.26075.17743342466571412183.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729155849.33919-1-weiyongjun1@huawei.com>
References: <20200729155849.33919-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: hulkci@huawei.com, s.hauer@pengutronix.de, jason@lakedaemon.net, tglx@linutronix.de, weiyongjun1@huawei.com, shawnguo@kernel.org, qiangqing.zhang@nxp.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 23:58:49 +0800, Wei Yongjun wrote:
> Gcc report warning as follows:
> 
> drivers/irqchip/irq-imx-intmux.c:316:29: warning:
>  variable 'irqchip_data' set but not used [-Wunused-but-set-variable]
>   316 |  struct intmux_irqchip_data irqchip_data;
>       |                             ^~~~~~~~~~~~
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()
      commit: 5b6570bbb26f1dfad5663d99351820865e8c5c7e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


