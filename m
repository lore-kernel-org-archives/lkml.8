Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D711C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB67124671
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608310;
	bh=WMhpdG/ER20cB7SPcvqxg2P5BMuaboH8up8jD2FXD8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QnggnrKKv0NrDwrx2p5gey+CCyfd+gbLrq8ZX63v/ZqqkVeFArnbHkRPnZWaZaiPB
	 PchqcMLZW0c4aCiUj6/cXosoLgrmop2t/KDmShh3TgH0Vu6d4hNydy3/4tGtCgofr5
	 Qjb4M2gkT3knNniXXUHOu2XGpbwNl9uhX4o9aOyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgBMPi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbgBMP3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:16 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA012468F;
        Thu, 13 Feb 2020 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607755;
        bh=WMhpdG/ER20cB7SPcvqxg2P5BMuaboH8up8jD2FXD8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQlGiJE6pNaTE9j6eEyO/rJzxa2jyZhHzSzbfFkzYRIW8oeWE4TsfhTN4xGPxx881
         XInUgeYyKIDEJq96eKBAOYH2VlMheOzQwBFBgKwWetfdIkOzrF7kbM66QU5ZixNbcB
         HjysYJid7U/3aGU4SW/VKHYh5Z9t7ETwUNtCRWXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5.5 110/120] pinctrl: sh-pfc: r8a77965: Fix DU_DOTCLKIN3 drive/bias control
Date:   Thu, 13 Feb 2020 07:21:46 -0800
Message-Id: <20200213151937.489661118@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit a34cd9dfd03fa9ec380405969f1d638bc63b8d63 upstream.

R-Car Gen3 Hardware Manual Errata for Rev. 2.00 of October 24, 2019
changed the configuration bits for drive and bias control for the
DU_DOTCLKIN3 pin on R-Car M3-N, to match the same pin on R-Car H3.
Update the driver to reflect this.

After this, the handling of drive and bias control for the various
DU_DOTCLKINx pins is consistent across all of the R-Car H3, M3-W,
M3-W+, and M3-N SoCs.

Fixes: 86c045c2e4201e94 ("pinctrl: sh-pfc: r8a77965: Replace DU_DOTCLKIN2 by DU_DOTCLKIN3")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191113101653.28428-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -5998,7 +5998,7 @@ static const struct pinmux_drive_reg pin
 		{ PIN_DU_DOTCLKIN1,    0, 2 },	/* DU_DOTCLKIN1 */
 	} },
 	{ PINMUX_DRIVE_REG("DRVCTRL12", 0xe6060330) {
-		{ PIN_DU_DOTCLKIN3,   28, 2 },	/* DU_DOTCLKIN3 */
+		{ PIN_DU_DOTCLKIN3,   24, 2 },	/* DU_DOTCLKIN3 */
 		{ PIN_FSCLKST,        20, 2 },	/* FSCLKST */
 		{ PIN_TMS,             4, 2 },	/* TMS */
 	} },
@@ -6254,8 +6254,8 @@ static const struct pinmux_bias_reg pinm
 		[31] = PIN_DU_DOTCLKIN1,	/* DU_DOTCLKIN1 */
 	} },
 	{ PINMUX_BIAS_REG("PUEN3", 0xe606040c, "PUD3", 0xe606044c) {
-		[ 0] = PIN_DU_DOTCLKIN3,	/* DU_DOTCLKIN3 */
-		[ 1] = SH_PFC_PIN_NONE,
+		[ 0] = SH_PFC_PIN_NONE,
+		[ 1] = PIN_DU_DOTCLKIN3,	/* DU_DOTCLKIN3 */
 		[ 2] = PIN_FSCLKST,		/* FSCLKST */
 		[ 3] = PIN_EXTALR,		/* EXTALR*/
 		[ 4] = PIN_TRST_N,		/* TRST# */


