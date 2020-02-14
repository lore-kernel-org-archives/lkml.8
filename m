Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5AC3B1B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9FB20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703377;
	bh=tbsB6vHECRwHjZ/VQdlleAytqMHIOfGHbwngLBFASr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRHh67T42XxablgKN1LeYXtBGXm2A77UnYQ+heC28VCZ99lq2bufnSrWxX1VfuUge
	 5PsLsA4AOIT9bZrOZ5uIJf1Px9gxoIQCcrzk27TSCTtiWSVVKzEFV23hyYOAQ5lRRn
	 O2G+KJEWbPnxtcp4+A+1K6axwEJZlghqgGA7bqoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgBNSC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731201AbgBNPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:55:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A37B24686;
        Fri, 14 Feb 2020 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695753;
        bh=tbsB6vHECRwHjZ/VQdlleAytqMHIOfGHbwngLBFASr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLzpgYs9ecIaDxiKNm4N3FB0mVUy1F40aN2hSU7yzLgEISVZZFOg5StBA6leaWBU2
         dE/6TYaE7U6W0GbBisGDnp0OX5e3W6+xfNoRyNtNC2eQyMcSpulT0rJ29JhMOFV2SQ
         J0/1oVjdrGrytmg7bFcBfN+MTe6UF44pQRQOTSd0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 322/542] ARM: at91: pm: use SAM9X60 PMC's compatible
Date:   Fri, 14 Feb 2020 10:45:14 -0500
Message-Id: <20200214154854.6746-322-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 6b9dfd986a81a999a27b6ed9dbe91203089c62dd ]

SAM9X60 PMC's has a different PMC. It was not integrated at the moment
commit 01c7031cfa73 ("ARM: at91: pm: initial PM support for SAM9X60")
was published.

Fixes: 01c7031cfa73 ("ARM: at91: pm: initial PM support for SAM9X60")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/1576062248-18514-2-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d5af6aedc02c4..03250768340e4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -751,6 +751,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d3-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[1] },
 	{ /* sentinel */ },
 };
 
-- 
2.20.1

