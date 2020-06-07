Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5600D2063A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 22:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii72jtuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFGWmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 18:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgFGWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 18:41:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9EC08C5C3;
        Sun,  7 Jun 2020 15:41:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so15576794qkn.8;
        Sun, 07 Jun 2020 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w9RUYk+FYrkNZpyFQLKdkYCd+eGPXjHrgHAfGA3ZD7I=;
        b=ii72jtuIdASqodTG3eYQJ4Kvw4hV7FE02bIJN+8YHJQp01Ze2pmvORKACgKyphxYui
         fKqSSlqVkZL2sM17k9o6+rm3ajvlIcXDaI9nbB6SKzJtkQQEC8pJdAUqiJiacjD1HxF7
         zedhOmV4gmKAAZPcSsedpYuAXBmiM6FwRNlP6SH/NMX9VbnisWVjT/Q+qK4Ah6REKQrv
         vWZrYgTR+7i8tE4dQsNBbbaB4oMBviAWqG8qBKZYupXiCX/sZ0LFdgWpFf0nLlJS5foo
         82Xuw4664MIMWDLjKnN5dpSY7V9lQ/tCWAgB6FHYsqDj4YzQztvMEmOX148IIUoxS8tw
         4m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w9RUYk+FYrkNZpyFQLKdkYCd+eGPXjHrgHAfGA3ZD7I=;
        b=sG3FnwUQ5gonZB1lHD1dIL8qqyl+mmFO2JluX4fEgJCfygf0c+stByzzr6woPgb9zQ
         msJSmxRN1IXq1tKtKNat/EYLmGWNnqY+CZsapSzZ0Vpm4WMvb1+iP+pEjhlwZndYTtKd
         nJWRbVk38svm07rb3zCID4mThD9D4Ukl+eDUdE/LIVyGidXj08d86Qvf3Hhfe+sceqwe
         7yq3pGKIaP5MgBwnLLcQiu9z+QEQ1t1O0G/Cd2JoG1dqQNAHbKnK0rQyVZn0SmIM5D1A
         mrhKRz2hLwFNFFww3lrDjpFqnhSp+2JcVeyVaHo51EIWjF6RVkOqydWCkZT4DkHy14Qh
         DkVA==
X-Gm-Message-State: AOAM533xdtk2W7v9OfrEUJNXTfChSFJKzMIeAQBewbxniDbmAyLxMkeA
        FDFT3LFszqxMs4W15poXtZA=
X-Google-Smtp-Source: ABdhPJy+TmHU9dG9g8azUkR8x8iUD/HsRqfLfhCjVut73Y7QbvM6kBtY5l7f6pMQt0UVAXCUBWIyEw==
X-Received: by 2002:a37:4a90:: with SMTP id x138mr12642955qka.74.1591569718277;
        Sun, 07 Jun 2020 15:41:58 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id p16sm5481879qkg.63.2020.06.07.15.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jun 2020 15:41:57 -0700 (PDT)
Date:   Sun, 7 Jun 2020 22:41:56 +0000
From:   "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rodolfovillordo@gmail.com
Subject: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
Message-ID: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple line over 80 characters fixes by splitting in multiple lines.
Warning found by checkpatch.pl

Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 225 ++++++++++++++++++++++++----------
 1 file changed, 162 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index cfab64d2b312..30ea29ea70cf 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -165,7 +165,8 @@ s_uGetTxRsvTime(
 {
 	unsigned int uDataTime, uAckTime;
 
-	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
+	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+				      cbFrameLength, wRate);
 
 	if (!bNeedAck)
 		return uDataTime;
@@ -206,28 +207,39 @@ s_uGetRTSCTSRsvTime(
 	unsigned int uAckTime = 0;
 	unsigned int uDataTime = 0;
 
-	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wCurrentRate);
+	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+				      cbFrameLength, wCurrentRate);
 	if (byRTSRsvType == 0) { /* RTSTxRrvTime_bb */
-		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopCCKBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     20, pDevice->byTopCCKBasicRate);
+		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
 		uCTSTime = uAckTime;
 	} else if (byRTSRsvType == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
-		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopCCKBasicRate);
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     20, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
+		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopOFDMBasicRate);
 	} else if (byRTSRsvType == 2) { /* RTSTxRrvTime_aa */
-		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopOFDMBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     20, pDevice->byTopOFDMBasicRate);
+		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopOFDMBasicRate);
 		uCTSTime = uAckTime;
 	} else if (byRTSRsvType == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
+		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopOFDMBasicRate);
 		uRrvTime = uCTSTime + uAckTime + uDataTime + 2 * pDevice->uSIFS;
 		return cpu_to_le16((u16)uRrvTime);
 	}
 
 	/* RTSRrvTime */
-	uRrvTime = uRTSTime + uCTSTime + uAckTime + uDataTime + 3 * pDevice->uSIFS;
+	uRrvTime = uRTSTime + uCTSTime + uAckTime + uDataTime
+			+ 3 * pDevice->uSIFS;
 	return cpu_to_le16((u16)uRrvTime);
 }
 
@@ -350,72 +362,102 @@ s_uGetRTSCTSDuration(
 
 	switch (byDurType) {
 	case RTSDUR_BB:    /* RTSDuration_bb */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
+		uDurTime = uCTSTime + 2 * pDevice->uSIFS
+				+ s_uGetTxRsvTime(pDevice, byPktType,
+						  cbFrameLength, wRate,
+						  bNeedAck);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
+		uDurTime = uCTSTime + 2 * pDevice->uSIFS
+				+ s_uGetTxRsvTime(pDevice, byPktType,
+						  cbFrameLength, wRate,
+						  bNeedAck);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopOFDMBasicRate);
+		uDurTime = uCTSTime + 2 * pDevice->uSIFS
+				+ s_uGetTxRsvTime(pDevice, byPktType,
+						  cbFrameLength, wRate,
+						  bNeedAck);
 		break;
 
 	case CTSDUR_BA:    /* CTSDuration_ba */
-		uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType,
+							    cbFrameLength,
+							    wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
+		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
+		    (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate-RATE_18M], bNeedAck);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) &&
+			 (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE0][wRate-RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopOFDMBasicRate);
+		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
+		    (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate-RATE_18M], bNeedAck);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) &&
+			 (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE0][wRate-RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopCCKBasicRate);
+		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
+		    (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2*pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate-RATE_18M], bNeedAck);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) &&
+			 (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE1][wRate-RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
+					     14, pDevice->byTopOFDMBasicRate);
+		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
+		    (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate-RATE_18M], bNeedAck);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) &&
+			 (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE1][wRate-RATE_18M], bNeedAck);
 
 		break;
 
 	case CTSDUR_BA_F0: /* CTSDuration_ba_f0 */
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
+		    (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate-RATE_18M], bNeedAck);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) &&
+			 (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE0][wRate-RATE_18M], bNeedAck);
 
 		break;
 
 	case CTSDUR_BA_F1: /* CTSDuration_ba_f1 */
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
+		    (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate-RATE_18M], bNeedAck);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) &&
+			 (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE1][wRate-RATE_18M], bNeedAck);
 
 		break;
@@ -459,7 +501,8 @@ s_uFillDataHead(
 					  PK_TYPE_11B, &buf->b);
 
 			if (is_pspoll) {
-				__le16 dur = cpu_to_le16(pDevice->current_aid | BIT(14) | BIT(15));
+				__le16 dur = cpu_to_le16(pDevice->current_aid |
+							 BIT(14) | BIT(15));
 
 				buf->duration_a = dur;
 				buf->duration_b = dur;
@@ -477,8 +520,11 @@ s_uFillDataHead(
 									    uMACfragNum, byFBOption));
 			}
 
-			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
-			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
+			buf->time_stamp_off_a =
+				vnt_time_stamp_off(pDevice, wCurrentRate);
+			buf->time_stamp_off_b =
+				vnt_time_stamp_off(pDevice,
+						   pDevice->byTopCCKBasicRate);
 
 			return buf->duration_a;
 		} else {
@@ -501,8 +547,11 @@ s_uFillDataHead(
 			buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
 										 wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
 
-			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
-			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
+			buf->time_stamp_off_a =
+				vnt_time_stamp_off(pDevice, wCurrentRate);
+			buf->time_stamp_off_b =
+				vnt_time_stamp_off(pDevice,
+						   pDevice->byTopCCKBasicRate);
 
 			return buf->duration_a;
 		} /* if (byFBOption == AUTO_FB_NONE) */
@@ -530,7 +579,8 @@ s_uFillDataHead(
 					  byPktType, &buf->ab);
 
 			if (is_pspoll) {
-				__le16 dur = cpu_to_le16(pDevice->current_aid | BIT(14) | BIT(15));
+				__le16 dur = cpu_to_le16(pDevice->current_aid |
+							 BIT(14) | BIT(15));
 
 				buf->duration = dur;
 			} else {
@@ -542,7 +592,8 @@ s_uFillDataHead(
 									    byFBOption));
 			}
 
-			buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
+			buf->time_stamp_off =
+				vnt_time_stamp_off(pDevice, wCurrentRate);
 			return buf->duration;
 		}
 	} else {
@@ -552,7 +603,8 @@ s_uFillDataHead(
 				  byPktType, &buf->ab);
 
 		if (is_pspoll) {
-			__le16 dur = cpu_to_le16(pDevice->current_aid | BIT(14) | BIT(15));
+			__le16 dur = cpu_to_le16(pDevice->current_aid |
+						 BIT(14) | BIT(15));
 
 			buf->duration = dur;
 		} else {
@@ -792,7 +844,8 @@ s_vFillCTSHead(
 	}
 
 	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
-		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
+		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA &&
+		    uDMAIdx != TYPE_BEACONDMA) {
 			/* Auto Fall back */
 			struct vnt_cts_fb *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
@@ -921,50 +974,96 @@ s_vGenerateTxParameter(
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
-			buf->rts_rrv_time_aa = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_bb = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			buf->rts_rrv_time_aa =
+				s_uGetRTSCTSRsvTime(pDevice, 2, byPktType,
+						    cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_ba =
+				s_uGetRTSCTSRsvTime(pDevice, 1, byPktType,
+						    cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_bb =
+				s_uGetRTSCTSRsvTime(pDevice, 0, byPktType,
+						    cbFrameSize, wCurrentRate);
+			buf->rrv_time_a =
+				vnt_rxtx_rsvtime_le16(pDevice, byPktType,
+						      cbFrameSize, wCurrentRate,
+						      bNeedACK);
+			buf->rrv_time_b =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B,
+						      cbFrameSize,
+						      pDevice->byTopCCKBasicRate,
+						      bNeedACK);
+
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize,
+				       bNeedACK, bDisCRC, psEthHeader,
+				       wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-			buf->cts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
+			buf->rrv_time_a =
+				vnt_rxtx_rsvtime_le16(pDevice, byPktType,
+						      cbFrameSize, wCurrentRate,
+						      bNeedACK);
+			buf->rrv_time_b =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B,
+						      cbFrameSize,
+						      pDevice->byTopCCKBasicRate,
+						      bNeedACK);
+			buf->cts_rrv_time_ba =
+				s_uGetRTSCTSRsvTime(pDevice, 3, byPktType,
+						    cbFrameSize, wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
+			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS,
+				       cbFrameSize, bNeedACK, bDisCRC,
+				       wCurrentRate, byFBOption);
 		}
 	} else if (byPktType == PK_TYPE_11A) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rts_rrv_time =
+				s_uGetRTSCTSRsvTime(pDevice, 2, byPktType,
+						    cbFrameSize, wCurrentRate);
+			buf->rrv_time =
+				vnt_rxtx_rsvtime_le16(pDevice, byPktType,
+						      cbFrameSize, wCurrentRate,
+						      bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize,
+				       bNeedACK, bDisCRC, psEthHeader,
+				       wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rrv_time =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A,
+						      cbFrameSize, wCurrentRate,
+						      bNeedACK);
 		}
 	} else if (byPktType == PK_TYPE_11B) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rts_rrv_time =
+				s_uGetRTSCTSRsvTime(pDevice, 0, byPktType,
+						    cbFrameSize, wCurrentRate);
+			buf->rrv_time =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B,
+						      cbFrameSize, wCurrentRate,
+						      bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize,
+				       bNeedACK, bDisCRC, psEthHeader,
+				       wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rrv_time =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B,
+						      cbFrameSize, wCurrentRate,
+						      bNeedACK);
 		}
 	}
 }
-- 
2.17.1

