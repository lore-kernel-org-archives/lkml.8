Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD631C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F2722CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260980;
	bh=i+3+PryJpfOp9qSe/SEHL8B1V+B5vk4u0MIU9vb2jN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XpcagdEuGWmQ+7FWFzHgkXQzHg4ureLgTy61yG1AtKA76T6C/0qJicS23D8cTQFEB
	 gqS0kiIEoqz1TveRs3uKd0wMUjEmtq4jb3KxM8TI9uxIdSAdTaXgqSyKEpxiWeSy62
	 zu9QqexluC3EYDOoFXEYrPVJhnx0b3YMTlEMbEmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgGTQC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbgGTQCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01F520684;
        Mon, 20 Jul 2020 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260974;
        bh=i+3+PryJpfOp9qSe/SEHL8B1V+B5vk4u0MIU9vb2jN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjEUK8t+vo0NTxpWPAFnOPPl4Odnk7urvDqUdHW2HZ7eHr+DslV6tWYV4ihADMusE
         mgdHta5TmOqfLeljf9cYrFnSKo0TasJR6FUuigBcwi9IQiCszVGgm2WXb6bwZW7mLy
         N0VVPtIEDQ3kn1byxYr/lSDF9note3hzlVKllK/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.4 133/215] mtd: rawnand: marvell: Fix probe error path
Date:   Mon, 20 Jul 2020 17:36:55 +0200
Message-Id: <20200720152826.518828494@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit c525b7af96714f72e316c70781570a4a3e1c2856 upstream.

Ensure all chips are deregistered and cleaned in case of error during
the probe.

Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200424164501.26719-5-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/marvell_nand.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2673,6 +2673,16 @@ static int marvell_nand_chip_init(struct
 	return 0;
 }
 
+static void marvell_nand_chips_cleanup(struct marvell_nfc *nfc)
+{
+	struct marvell_nand_chip *entry, *temp;
+
+	list_for_each_entry_safe(entry, temp, &nfc->chips, node) {
+		nand_release(&entry->chip);
+		list_del(&entry->node);
+	}
+}
+
 static int marvell_nand_chips_init(struct device *dev, struct marvell_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
@@ -2707,21 +2717,16 @@ static int marvell_nand_chips_init(struc
 		ret = marvell_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
 			of_node_put(nand_np);
-			return ret;
+			goto cleanup_chips;
 		}
 	}
 
 	return 0;
-}
 
-static void marvell_nand_chips_cleanup(struct marvell_nfc *nfc)
-{
-	struct marvell_nand_chip *entry, *temp;
+cleanup_chips:
+	marvell_nand_chips_cleanup(nfc);
 
-	list_for_each_entry_safe(entry, temp, &nfc->chips, node) {
-		nand_release(&entry->chip);
-		list_del(&entry->node);
-	}
+	return ret;
 }
 
 static int marvell_nfc_init_dma(struct marvell_nfc *nfc)


