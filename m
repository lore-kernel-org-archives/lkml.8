Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBBAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F8122482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260290;
	bh=nBlrAHqeGQBA0lnHqR2Olyd8e7caxmdF2n7El7K/J4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TEDPABGsn0FiPaIPsx5hE3bJ3HjUuAcBaV01EWGZ42uJM/eH6+1qePop5qegG3+xt
	 PcbN02g18x32NxP5qZ7bYzOretw56Q6+gu6wJyWV2efHcjAsv54grcmB3Z902hch0r
	 U7Qsr+oBgEcqR3V2RgOPen7iqsCeO+mSiNpe3N0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgGTPv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbgGTPvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:51:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8DB2064B;
        Mon, 20 Jul 2020 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260283;
        bh=nBlrAHqeGQBA0lnHqR2Olyd8e7caxmdF2n7El7K/J4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmGS1SD4W1Yx0yXajSCCkDJ9bbpIAVWlZB57xl47rz4aCQNMY5WthVmUTVbPiWzO9
         W2G0CuMRsABnhYw23pT/yKMHUOoGpi0CDGjPuhRfmYB6DyNxXMcij0CJhvQhZ9Trri
         g4v1OL1W+hb2R8m08syWWU7AnRd5pOeZIDkrsMHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/133] ARM: at91: pm: add quirk for sam9x60s ulp1
Date:   Mon, 20 Jul 2020 17:36:34 +0200
Message-Id: <20200720152805.987275494@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit bb1a0e87e1c54cd884e9b92b1cec06b186edc7a0 ]

On SAM9X60 2 nop operations has to be introduced after setting
WAITMODE bit in CKGR_MOR.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/1579522208-19523-9-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/pm_suspend.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index a7c6ae13c9453..d650a5a1dfee9 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -220,6 +220,10 @@ ENDPROC(at91_backup_mode)
 	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
+	/* Quirk for SAM9X60's PMC */
+	nop
+	nop
+
 	wait_mckrdy
 
 	/* Enable the crystal oscillator */
-- 
2.25.1



