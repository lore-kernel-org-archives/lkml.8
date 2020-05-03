Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E5C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05A921775
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="nKmyMbBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgECN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:29:43 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:59378 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgECN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:29:32 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id C1ED418CB; Sun,  3 May 2020 15:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz C1ED418CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588512570;
        bh=amZ/K/qQy5bwb/wFEfKS9nmEX2XcdVfnm7PUkRKoYiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKmyMbBBkIn5kuOWK2EFqEuUP3x4NUSiEfJOJxG3dbo9tdCC/C1toAXnC+DUUwDvE
         mPXiYuUiUs7Vp31Y8nlxR7ULsCuh6QdcGityBEOTEg+wryNR0ur46c6QeoK6L7RDr+
         mQNk37EhhxXJE0jXg+dh8pi97ZNTfFDXMnqfpYx0=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 4/5] staging: vt6655: return at the ond of case body
Date:   Sun,  3 May 2020 15:29:11 +0200
Message-Id: <1588512552-12297-5-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will unify exit point for s_uGetDataDuration function.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 61f7077bb75f..c4d62c27f1c1 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -264,14 +264,12 @@ s_uGetDataDuration(
 		if ((uMACfragNum == 1) || bLastFrag) {
 			if (!bNeedAck)
 				return 0;
-			return pDevice->uSIFS + uAckTime;
 		} else {
 			/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len, wRate, bNeedAck);
-
-			return pDevice->uSIFS + uAckTime + uNextPktTime;
 		}
-		break;
+
+		return pDevice->uSIFS + uAckTime + uNextPktTime;
 
 	case DATADUR_A:    /* DATADUR_A */
 		if (bNeedAck) {
@@ -283,15 +281,13 @@ s_uGetDataDuration(
 		if ((uMACfragNum == 1) || bLastFrag) {
 			if (!bNeedAck)
 				return 0;
-			return pDevice->uSIFS + uAckTime;
 		} else {
 			/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len,
 						       wRate, bNeedAck);
-
-			return pDevice->uSIFS + uAckTime + uNextPktTime;
 		}
-		break;
+
+		return pDevice->uSIFS + uAckTime + uNextPktTime;
 
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
@@ -304,7 +300,6 @@ s_uGetDataDuration(
 		if ((uMACfragNum == 1) || bLastFrag) {
 			if (!bNeedAck)
 				return 0;
-			return pDevice->uSIFS + uAckTime;
 		} else {
 			/* First Frag or Mid Frag */
 			if (wRate < RATE_18M)
@@ -323,10 +318,9 @@ s_uGetDataDuration(
 							       wFB_Opt1[FB_RATE0][wRate - RATE_18M],
 							       bNeedAck);
 			}
-
-			return pDevice->uSIFS + uAckTime + uNextPktTime;
 		}
-		break;
+
+		return pDevice->uSIFS + uAckTime + uNextPktTime;
 
 	default:
 		break;
-- 
2.26.2

