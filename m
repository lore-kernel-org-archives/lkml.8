Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CB921556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="NjT+J7by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbgFSTe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389103AbgFSTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:10 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65240C0613F0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2DD81500CE9;
        Fri, 19 Jun 2020 21:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a58x5rdp6NhHrxJAuGMfI2H75s3fnGd+ePBOeX7Xa+M=;
        b=NjT+J7byn4REMbkCaJNcDl5spPehj5Bbj8B0BECrg5lB8c4+Ei6rj54pxQOu2abkOHMxnw
        IUfJLr2TON63f5MpUS9mLzXaaJvE0C0T218A8tDLQaQQxeG8h0ViU5DhUSuf/Z8mKZjOgK
        CA8udFN60I3gyTJQCe8IlaXH7ACkaFeaGeO2AOPktmgiIgfrp8y49lPvJoc8fgGskun7qR
        9VwHVE6jE5E0F6kRu2JgCrxMDwW8IZdVSqBH698NAmzQOc4MGTCIN6ND3me1C8k08Ef3lM
        GNkhZWInfEqCpssDVY+fAXBg4Ee2iVgv4ZSQqUQ0leo3/V22Xoo0Rp312pCqNA==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 7/9] drivers: cdrom: miscellaneous code style fixes
Date:   Fri, 19 Jun 2020 21:33:39 +0200
Message-Id: <20200619193341.51209-7-devel@superboring.dev>
In-Reply-To: <20200619193341.51209-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
 <20200619193341.51209-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were mainly reported by scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index f1c02d4d5583..6ff8da08230c 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1093,7 +1093,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
+			if (ret == CDS_NO_DISC || ret == CDS_TRAY_OPEN) {
 				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
 				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
 				ret = -ENOMEDIUM;
@@ -1242,8 +1242,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 		if (ret == CDS_TRAY_OPEN) {
 			cd_dbg(CD_OPEN, "the tray is open...\n");
 			/* can/may i close it? */
-			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
-			    cdi->options & CDO_AUTO_CLOSE) {
+			if (CDROM_CAN(CDC_CLOSE_TRAY) && cdi->options & CDO_AUTO_CLOSE) {
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
 				ret = cdo->tray_move(cdi, 0);
 				if (ret) {
@@ -1471,11 +1470,10 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	kfree(info);
 
 	if (cdi->use_count > 1 || cdi->keeplocked) {
-		if (slot == CDSL_CURRENT) {
-	    		return curslot;
-		} else {
+		if (slot == CDSL_CURRENT)
+			return curslot;
+		else
 			return -EBUSY;
-		}
 	}
 
 	/* Specifying CDSL_CURRENT will attempt to load the currnet slot,
@@ -3015,13 +3013,12 @@ static int cdrom_get_next_writable(struct cdrom_device_info *cdi,
 
 use_last_written:
 	ret = cdrom_get_last_written(cdi, next_writable);
-	if (ret) {
+	if (ret)
 		*next_writable = 0;
-		return ret;
-	} else {
+	else
 		*next_writable += 7;
-		return 0;
-	}
+
+	return ret;
 }
 
 static noinline int mmc_ioctl_cdrom_read_data(struct cdrom_device_info *cdi,
-- 
2.27.0

