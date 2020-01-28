Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC69C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1365D20702
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222440;
	bh=VzXJPmaWA/gDN1YLBGPq35UEFNLmxmSPhNJckE0qFCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A7GLtVPIBAz/adxkBLaRkBnkkDEGsVo+6aLqoS5BzewjyGNPkfU5KgZzK8GQUn1kh
	 jQbY5bXHBnk5I16fTPuzHEoH7VUnk+5Q+MNgxxNtIRGpXsrG3kXEiK0sIxVvqQ6SxZ
	 MHdeEZ3u/mC0kPNuQowbBrF99bZWWJmad4nT229k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgA1Okj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgA1OPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:15:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB7024681;
        Tue, 28 Jan 2020 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220923;
        bh=VzXJPmaWA/gDN1YLBGPq35UEFNLmxmSPhNJckE0qFCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XX3fEodiRSk3v0zI3lT/L3q8imYrxW6Bk3PqfYXcQEuzmmg7R4kOmVd4fUmLAOYH2
         4PB3q2/7LFStfoUVGIbxAmDQs8MrkF3HYAGu6ldELuelGlVp4IuHYH+zv01wUOmv1i
         c6RMYuTlSp56xff2urdYP67LHO7Mh7i+hHRozVDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 018/271] pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b group
Date:   Tue, 28 Jan 2020 15:02:47 +0100
Message-Id: <20200128135854.027574288@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 884fa25fb6e5e63ab970d612a628313bb68f37cc ]

The qspi_data4_b_mux[] array contains pin marks for the clock and chip
select pins.  The qspi_data4_b_pins[] array rightfully does not contain
the corresponding pin numbers, as the control pins are provided by a
separate group (qspi_ctrl_b).

Fixes: 2d0c386f135e4186 ("pinctrl: sh-pfc: r8a7791: Add QSPI pin groups")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index baa98d7fe9473..fcf731994811f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -3136,8 +3136,7 @@ static const unsigned int qspi_data4_b_pins[] = {
 	RCAR_GP_PIN(6, 4),
 };
 static const unsigned int qspi_data4_b_mux[] = {
-	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
-	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK,
+	MOSI_IO0_B_MARK, MISO_IO1_B_MARK, IO2_B_MARK, IO3_B_MARK,
 };
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
-- 
2.20.1



