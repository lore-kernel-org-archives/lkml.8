Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A915BC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8264720752
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="FfLXLslM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgECN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728634AbgECN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:29:30 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24EC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 06:29:30 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 5D61318CB; Sun,  3 May 2020 15:29:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 5D61318CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588512566;
        bh=sRvT03xiD8wOdZD4cRBTkygtZsp6kCEcj34XZznO6jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfLXLslMP3cb89Z5PrdCHwuD2gA3LnanjGusIW1Tp4UsVvhCmo7ZiL3JiSxS7AWrK
         yUyiIBXfYvASR4eujkg/tZyOVGokrVzO5TsxbcC2En0h2tY3mIgUjeU17YRJ7k9Kl4
         QftYCPUvnVF0/naHOMWd7V16sala97JWN4pG+/z0=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 2/5] staging: vt6655: do calculation of uAckTime first
Date:   Sun,  3 May 2020 15:29:09 +0200
Message-Id: <1588512552-12297-3-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is extracting calculation of uAckTime in one place, at the
start of case body.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 28f0cda36dec..01ceace253a4 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -255,9 +255,13 @@ s_uGetDataDuration(
 
 	switch (byDurType) {
 	case DATADUR_B:    /* DATADUR_B */
+		if (bNeedAck) {
+			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+						     byPktType, 14,
+						     pDevice->byTopCCKBasicRate);
+		}
 		if (((uMACfragNum == 1)) || bLastFrag) {/* Non Frag or Last Frag */
 			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
 				return pDevice->uSIFS + uAckTime;
 			} else {
 				return 0;
@@ -265,19 +269,18 @@ s_uGetDataDuration(
 		} else {/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len, wRate, bNeedAck);
 
-			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType,
-							     byPktType, 14,
-							     pDevice->byTopCCKBasicRate);
-			}
 			return pDevice->uSIFS + uAckTime + uNextPktTime;
 		}
 		break;
 
 	case DATADUR_A:    /* DATADUR_A */
+		if (bNeedAck) {
+			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+						     byPktType, 14,
+						     pDevice->byTopOFDMBasicRate);
+		}
 		if (((uMACfragNum == 1)) || bLastFrag) {/* Non Frag or Last Frag */
 			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
 				return pDevice->uSIFS + uAckTime;
 			} else {
 				return 0;
@@ -286,20 +289,19 @@ s_uGetDataDuration(
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType, len,
 						       wRate, bNeedAck);
 
-			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType,
-							     byPktType, 14,
-							     pDevice->byTopOFDMBasicRate);
-			}
 			return pDevice->uSIFS + uAckTime + uNextPktTime;
 		}
 		break;
 
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
+		if (bNeedAck) {
+			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+						     byPktType, 14,
+						     pDevice->byTopOFDMBasicRate);
+		}
 		if (((uMACfragNum == 1)) || bLastFrag) { /* Non Frag or Last Frag */
 			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
 				return pDevice->uSIFS + uAckTime;
 			} else {
 				return 0;
@@ -322,11 +324,6 @@ s_uGetDataDuration(
 							       bNeedAck);
 			}
 
-			if (bNeedAck) {
-				uAckTime = bb_get_frame_time(pDevice->byPreambleType,
-							     byPktType, 14,
-							     pDevice->byTopOFDMBasicRate);
-			}
 			return pDevice->uSIFS + uAckTime + uNextPktTime;
 		}
 		break;
-- 
2.26.2

