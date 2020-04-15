Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5158C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2A220737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955263;
	bh=+e9qoTMeeUTLIN6LPfEmAaCFBw1h2Jg68LOFaxYeyAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ll/yZKQVznR07ARItN/1X0USec+bFyZrcWCPDGgqB+0cr9SOxGKt+fWLKL16gdqJC
	 3LYIxwaI6ByB1hb7tTy1IJSZSi5WvO+6srwTJ7ay7sNqk6ZuXC20PJs593Vvd4Dczu
	 /81/1PeV2O21JVHxWsPYSDJp0F7dbfiDoO+x5SBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898273AbgDOMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897213AbgDOLhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:37:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDB62137B;
        Wed, 15 Apr 2020 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950629;
        bh=+e9qoTMeeUTLIN6LPfEmAaCFBw1h2Jg68LOFaxYeyAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwS1YlAJT6gP/834hCev4b3oHXIEtBqS5DakUoJOPP5ASYfJzXACfmtDaCp7ps/m0
         XXoX/Ich1JI7wJ6Pwta+5VtRdTjC+Wf+dYmZfiVGwSW/8Fpa9PdSujWkatdBqMEGU6
         cXIecAuDmPuTORMuTGap12qcmi1kLlbS7UwXc990=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuantian Tang <andy.tang@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 120/129] thermal: qoriq: Fix a compiling issue
Date:   Wed, 15 Apr 2020 07:34:35 -0400
Message-Id: <20200415113445.11881-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

[ Upstream commit cbe259fd80b7b02fba0dad79d8fdda8b70a8b963 ]

Qoriq thermal driver is used by both PowerPC and ARM architecture.
When built for PowerPC architecture, it reports error:
undefined reference to `.__devm_regmap_init_mmio_clk'
To fix it, select config REGMAP_MMIO.

Fixes: 4316237bd627 (thermal: qoriq: Convert driver to use regmap API)
Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200303084641.35687-1-andy.tang@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5a05db5438d60..5a0df0e54ce3e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -265,6 +265,7 @@ config QORIQ_THERMAL
 	tristate "QorIQ Thermal Monitoring Unit"
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	help
 	  Support for Thermal Monitoring Unit (TMU) found on QorIQ platforms.
 	  It supports one critical trip point and one passive trip point. The
-- 
2.20.1

