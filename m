Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFAAC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9848205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193517;
	bh=uHDst8UX4z8oIJF3ujRDjA/O0+RqS6TJFAo6QrE7GAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mc+YR4G/TqbLpFEN5wriwfjYuliONbOy21ySjLg6QMDC0ii3ObkzwIpIep/+Hj+n/
	 vxl8Z6mocimdL3jRTVAv2b5Dzih+uW6k+cl/54bb/AUSP6b5+EcXrGi0Qx99bBJ428
	 ktRAdhYnVOEA71aoXbDapmOpXE8QU0CoC0A4rIHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgAPQv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgAPQvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:51:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E7F205F4;
        Thu, 16 Jan 2020 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193514;
        bh=uHDst8UX4z8oIJF3ujRDjA/O0+RqS6TJFAo6QrE7GAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6fvMwRvX+C2hszQCJF2JCJqvjYldymZm4lmGTD9R0pHBl4zryLG2CufFcQmEC0gO
         uyKIOTflAsffdMfaFOxFEnRFrVesdOC8OHKgpi4nVlxjb1xYuz3h/3Er67co044ett
         RvyxGkVoooNEdSTRu19SarepFw+GYNm+hC/WM14M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 094/205] soc: renesas: Add missing check for non-zero product register address
Date:   Thu, 16 Jan 2020 11:41:09 -0500
Message-Id: <20200116164300.6705-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 4194b583c104922c6141d6610bfbce26847959df ]

If the DTB for a device with an RZ/A2 SoC lacks a device node for the
BSID register, the ID validation code falls back to using a register at
address 0x0, which leads to undefined behavior (e.g. reading back a
random value).

This could be fixed by letting fam_rza2.reg point to the actual BSID
register.  However, the hardcoded fallbacks were meant for backwards
compatibility with old DTBs only, not for new SoCs.  Hence fix this by
validating renesas_family.reg before using it.

Fixes: 175f435f44b724e3 ("soc: renesas: identify RZ/A2")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191016143306.28995-1-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/renesas/renesas-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 3299cf5365f3..6651755e9f20 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -326,7 +326,7 @@ static int __init renesas_soc_init(void)
 	if (np) {
 		chipid = of_iomap(np, 0);
 		of_node_put(np);
-	} else if (soc->id) {
+	} else if (soc->id && family->reg) {
 		chipid = ioremap(family->reg, 4);
 	}
 	if (chipid) {
-- 
2.20.1

