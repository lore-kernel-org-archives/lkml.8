Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B226FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864EC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863836;
	bh=7VSQKbGMMscl4B1bdBXn6qoEVc6g38iNuhlh4ppHep0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBR+e3S5xTZ/3xuss/XWnIH4B2WD7O0/J0HwCR/2u1NDzOsfGNo19SYx13qXtzFzR
	 DoUjXyya1zUzoVTOxu862nFZGq1kC8Y77lltyN1qYlakooaDAPjH88wVAjnu3HQyjG
	 kqCndhMRwsU38rtCh967hJZNVWGKY1ebzesw7qrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgAXLDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbgAXLDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:03:51 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135812071A;
        Fri, 24 Jan 2020 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863830;
        bh=7VSQKbGMMscl4B1bdBXn6qoEVc6g38iNuhlh4ppHep0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Td4dqvY5wlZzg9RfHPSwx62prMWXbCU4Co/0no+KtjdzsAko0IHs7eAb9lS4B80N1
         gQ4QG9rpw9EBoWbwuaWT87W3e64TSHx2KGWFSoR2ZepHVAyVVXXPtN/vXMJ3YT3ahl
         9PH/LUOSK7u7adEDTKhIpUAl/QKP1uTHhy9aLnbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/639] pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b group
Date:   Fri, 24 Jan 2020 10:24:17 +0100
Message-Id: <20200124093058.245785019@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index 5811784d88cb9..f5b4255570b28 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -3220,8 +3220,7 @@ static const unsigned int qspi_data4_b_pins[] = {
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



