Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5885AC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285E8208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="YvbktAIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgEBWQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728530AbgEBWQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 18:16:49 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA9C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 15:16:49 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 660E218CB; Sun,  3 May 2020 00:16:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 660E218CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588457807;
        bh=2+ok7hSFqmJ9p6NZRS3iB+ks9qy0qquKr2HJfKft10E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvbktAIT615fXGeU1BszZYJYUx4uMSlrhuWIN4yTspPjZTsvW+S3VFfV85HYU1uCU
         7XLB3Z46YKQLOvZjPdpjk3cUwUnXJdj6B+Z723//7idA3sx8rmqSnM35pXgoB+w7wK
         1n+5FzRYzOarZYQFYdWcWiTM/Foe+vmQwwER6vhc=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 2/2] staging: vt6655: fix LONG_LINE warning
Date:   Sun,  3 May 2020 00:16:34 +0200
Message-Id: <1588457794-31438-2-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588457794-31438-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588457794-31438-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will fix LONG_LINE error from checkpatch, by createing temporary
variable so call to the function is not in if/else block.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index dda578436e64..782177dfd67e 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -164,16 +164,24 @@ s_uGetTxRsvTime(
 )
 {
 	unsigned int uDataTime, uAckTime;
+	unsigned short basic_rate;
 
 	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
 
 	if (!bNeedAck)
 		return uDataTime;
 
-	if (byPktType == PK_TYPE_11B) /* llb,CCK mode */
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopCCKBasicRate);
-	else /* 11g 2.4G OFDM mode & 11a 5G OFDM mode */
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopOFDMBasicRate);
+	/*
+	 * CCK mode  - 11b
+	 * OFDM mode - 11g 2.4G & 11a 5G
+	 */
+	if (byPktType == PK_TYPE_11B)
+		basic_rate = (unsigned short)pDevice->byTopCCKBasicRate;
+	else
+		basic_rate = (unsigned short)pDevice->byTopOFDMBasicRate;
+
+	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
+				     basic_rate);
 
 	return uDataTime + pDevice->uSIFS + uAckTime;
 }
-- 
2.26.2

