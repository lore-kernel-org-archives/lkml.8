Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9560C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800F12072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgHYE5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:23 -0400
Received: from smtprelay0144.hostedemail.com ([216.40.44.144]:33320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728803AbgHYE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:12 -0400
X-Greylist: delayed 125017 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 00:57:12 EDT
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7D2D418224D86;
        Tue, 25 Aug 2020 04:57:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer77_2f11fd827059
X-Filterd-Recvd-Size: 1989
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 15/29] mtd: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:12 -0700
Message-Id: <ae92f4c0507c470d9461886410dc7030192f9014.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/mtd/devices/lart.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/lart.c b/drivers/mtd/devices/lart.c
index 56f50d27b7fd..aecd441e4183 100644
--- a/drivers/mtd/devices/lart.c
+++ b/drivers/mtd/devices/lart.c
@@ -436,7 +436,10 @@ static int flash_read (struct mtd_info *mtd,loff_t from,size_t len,size_t *retle
 	 {
 		int gap = BUSWIDTH - (from & (BUSWIDTH - 1));
 
-		while (len && gap--) *buf++ = read8 (from++), len--;
+		while (len && gap--) {
+			*buf++ = read8 (from++);
+			len--;
+		}
 	 }
 
    /* now we read dwords until we reach a non-dword boundary */
@@ -518,7 +521,10 @@ static int flash_write (struct mtd_info *mtd,loff_t to,size_t len,size_t *retlen
 		i = n = 0;
 
 		while (gap--) tmp[i++] = 0xFF;
-		while (len && i < BUSWIDTH) tmp[i++] = buf[n++], len--;
+		while (len && i < BUSWIDTH) {
+			tmp[i++] = buf[n++];
+			len--;
+		}
 		while (i < BUSWIDTH) tmp[i++] = 0xFF;
 
 		if (!write_dword (aligned,*((__u32 *) tmp))) return (-EIO);
-- 
2.26.0

