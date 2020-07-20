Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E51C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A051F22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260155;
	bh=6QA7lOPVFm34R9uCn2TjEj6wifVTLqjsygFdGfQVirU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s5boDCh7iyS6Pk7gSpc6rrR/GRzv2ifzRRWFjkzSciuZSPNSeCmdgMpIubgJPiL/E
	 924YmQubr4pdCKsP+4J1IZbdGHZRbg6BCHKVWGQLXvkwH1kIGc0Z8U1GLbfLVndZ55
	 NC2/cV0wM+w2ks1vOjjsGHmrSJQvnld9jUcZKFU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgGTPtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbgGTPtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:49:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67A72065E;
        Mon, 20 Jul 2020 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260147;
        bh=6QA7lOPVFm34R9uCn2TjEj6wifVTLqjsygFdGfQVirU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LB9ABmgYhu26yBHG3XK6r0ax758l378YkGzhF1DKcVEKSrDfnXMjxllT2PJaAiuvZ
         YFCO2ZZNrk+ohfKcDF7DHIWa2AJTuxUmEk9rbTbWsPxa42eG8o34yS+YK904PVHUd9
         tFnlGoIXUXBJSGdr2o6pVkoavIs6Oz4kQHr+9ffM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.14 093/125] mtd: rawnand: oxnas: Release all devices in the _remove() path
Date:   Mon, 20 Jul 2020 17:37:12 +0200
Message-Id: <20200720152807.514422880@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 0a5f45e57e35d0840bedb816974ce2e63406cd8b upstream.

oxnans_nand_remove() should release all MTD devices and clean all NAND
devices, not only the first one registered.

Fixes: 668592492409 ("mtd: nand: Add OX820 NAND Support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-39-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/oxnas_nand.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/oxnas_nand.c
+++ b/drivers/mtd/nand/oxnas_nand.c
@@ -184,9 +184,13 @@ err_clk_unprepare:
 static int oxnas_nand_remove(struct platform_device *pdev)
 {
 	struct oxnas_nand_ctrl *oxnas = platform_get_drvdata(pdev);
+	struct nand_chip *chip;
+	int i;
 
-	if (oxnas->chips[0])
-		nand_release(oxnas->chips[0]);
+	for (i = 0; i < oxnas->nchips; i++) {
+		chip = oxnas->chips[i];
+		nand_release(chip);
+	}
 
 	clk_disable_unprepare(oxnas->clk);
 


