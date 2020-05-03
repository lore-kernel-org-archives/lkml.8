Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41090C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1320752
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="veK8wxud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgECN3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728378AbgECN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:29:30 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 06:29:30 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 3D4693ED5; Sun,  3 May 2020 15:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 3D4693ED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588512568;
        bh=IQWaprTDszXjBPTNKWxkbdKG2lr6Lb8LwJMD7ral41Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veK8wxuduDeH9QdwdctFpKbdeQGHJsczEwvkqxVOb2SpB5uMp7LgnwAoZACP4OdYJ
         zJDj1mxI5wl+ZKryJPFbfMLLYH3/2m3aRg3PbLbnpad8pFIQj3hFNYENN4VdTBcUcS
         Urd2833oN9vjH4bu3R8LdW34fC6aU19ohk24QJh8=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 3/5] staging: vt6655: remove else after return and invert condition
Date:   Sun,  3 May 2020 15:29:10 +0200
Message-Id: <1588512552-12297-4-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will prepare us to make return at the end of case body

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 01ceace253a4..61f7077bb75f 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -260,13 +260,13 @@ s_uGetDataDuration(
 						     byPktType, 14,
 						     pDevice->byTopCCKBasicRate);
 		}
-		if (((uMACfragNum == 1)) || bLastFrag) {/* Non Frag or Last Frag */
-			if (bNeedAck) {
-				return pDevice->uSIFS + uAckTime;
-			} else {
+		/* Non Frag or Last Frag */
+		if ((uMACfragNum == 1) || bLastFrag) {
+			if (!bNeedAck)
 				return 0;
-			}
-		} else {/* First Frag or Mid Frag */
+			return pDevice->uSIFS + uAckTime;
+		} else {
+			/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len, wRate, bNeedAck);
 
 			return pDevice->uSIFS + uAckTime + uNextPktTime;
@@ -279,13 +279,13 @@ s_uGetDataDuration(
 						     byPktType, 14,
 						     pDevice->byTopOFDMBasicRate);
 		}
-		if (((uMACfragNum == 1)) || bLastFrag) {/* Non Frag or Last Frag */
-			if (bNeedAck) {
-				return pDevice->uSIFS + uAckTime;
-			} else {
+		/* Non Frag or Last Frag */
+		if ((uMACfragNum == 1) || bLastFrag) {
+			if (!bNeedAck)
 				return 0;
-			}
-		} else {/* First Frag or Mid Frag */
+			return pDevice->uSIFS + uAckTime;
+		} else {
+			/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len,
 						       wRate, bNeedAck);
 
@@ -300,13 +300,13 @@ s_uGetDataDuration(
 						     byPktType, 14,
 						     pDevice->byTopOFDMBasicRate);
 		}
-		if (((uMACfragNum == 1)) || bLastFrag) { /* Non Frag or Last Frag */
-			if (bNeedAck) {
-				return pDevice->uSIFS + uAckTime;
-			} else {
+		/* Non Frag or Last Frag */
+		if ((uMACfragNum == 1) || bLastFrag) {
+			if (!bNeedAck)
 				return 0;
-			}
-		} else { /* First Frag or Mid Frag */
+			return pDevice->uSIFS + uAckTime;
+		} else {
+			/* First Frag or Mid Frag */
 			if (wRate < RATE_18M)
 				wRate = RATE_18M;
 			else if (wRate > RATE_54M)
-- 
2.26.2

