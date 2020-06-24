Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F5A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tILHWMKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbgFXKDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbgFXKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:03:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5BC061573;
        Wed, 24 Jun 2020 03:03:00 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so1210587qtg.4;
        Wed, 24 Jun 2020 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x476Mn/y0mphbsxJns0lxfmywCKbgB/VcIe+XBugAac=;
        b=tILHWMKKSrhBr5plwoYJB+nfH0X2040IojID+zPJKHwwHNXR3hDLdUmJ5qQl5gwP4/
         Lsv5LRj+0TwOM0sQ0+rCiGd8+ROD1/Kban/bWyZzAFVhfbFKHGeEqcjq/ipMfbOsq6jF
         QiH7uEgSr0+nHeRhmvxNwh748oDoUQbpJDpaS5gSHZZ1ki+p54VHTWXIcIqSEFwWq8hh
         oxIi9+aRTRpxnMSc7jhtRstsZIaRpykDWxFD2oN31Tgz8iiRqB6ZiB36N7vFDkBN6tte
         ZpwHlAmr3sBPuY2o0Hu9XzmkOsGpuWzSMPJpMZqbL9+XZBsJxHk/4ArwujkdwIk6VEmL
         GTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x476Mn/y0mphbsxJns0lxfmywCKbgB/VcIe+XBugAac=;
        b=I6H5SqTdjAK1WJKSuAWftphY7562IzqHl2WiYX8Sa0oVMEGoQjYE01LiRehY0FGOGf
         gxGZzMr7l9U6n1qXLAAZls0NOqioqModxI2E7xhwYNWiZ8Ov37CsGaKpSQ1Aqzt9/NkS
         c/R2WGIfyacmK9rxsDNtTOzj0TU0Ax2L2288pm0LBGBkwjn/oVzSb5TiEDv4iQ2zMK25
         adYzkh4xJHuFAB57SOZsRDDAE5nmdSnVIptmZKYtDYkSDmqYBs4H5KzBnvgKu/lm0cJ7
         bu15GFvrc93gZAEv2R3FR8oZAPlIsXBUp2n5z93Zxo9NeHn54fKtWxuYyhN0o1aICYcP
         LmXw==
X-Gm-Message-State: AOAM533TpiVNLGulliWpHV2MQf1Pc+nzoHcTBwjgsGdKhEca7AjfzrnJ
        TCX0lTCuiLHL3ThdffSpycI=
X-Google-Smtp-Source: ABdhPJwPqeM9iy52z0CLO/z/b8R7LjzC44iXeGd8SCklz7kHMj4I+R9PDKFx8TVwACey606Rt8wSzQ==
X-Received: by 2002:ac8:22e5:: with SMTP id g34mr26540758qta.227.1592992979109;
        Wed, 24 Jun 2020 03:02:59 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id x26sm3092571qtr.4.2020.06.24.03.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 03:02:58 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:02:56 +0000
From:   "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        rodolfovillordo@gmail.com
Subject: [PATCH] drivers: staging: vt6655: replace CamelCase names on
 function s_uGetRTSCTSRsvTime
Message-ID: <20200624100256.GA17118@ip-172-31-24-31.ec2.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace function and variables name from CamelCase style to snake_case style.
Remove Hungarian notation.

Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 80 +++++++++++++++++------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index cfab64d2b312..4778439e8757 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -21,7 +21,7 @@
  *      s_uGetDataDuration - get tx data required duration
  *      s_uFillDataHead- fulfill tx data duration header
  *      s_uGetRTSCTSDuration- get rtx/cts required duration
- *      s_uGetRTSCTSRsvTime- get rts/cts reserved time
+ *      get_rtscts_time- get rts/cts reserved time
  *      s_uGetTxRsvTime- get frame reserved time
  *      s_vFillCTSHead- fulfill CTS ctl header
  *      s_vFillFragParameter- Set fragment ctl parameter.
@@ -190,45 +190,41 @@ static __le16 vnt_rxtx_rsvtime_le16(struct vnt_private *priv, u8 pkt_type,
 }
 
 /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
-static
-__le16
-s_uGetRTSCTSRsvTime(
-	struct vnt_private *pDevice,
-	unsigned char byRTSRsvType,
-	unsigned char byPktType,
-	unsigned int cbFrameLength,
-	unsigned short wCurrentRate
-)
+static __le16 get_rtscts_time(struct vnt_private *priv,
+			      unsigned char rts_rsvtype,
+			      unsigned char pkt_type,
+			      unsigned int frame_length,
+			      unsigned short current_rate)
 {
-	unsigned int uRrvTime = 0;
-	unsigned int uRTSTime = 0;
-	unsigned int uCTSTime = 0;
-	unsigned int uAckTime = 0;
-	unsigned int uDataTime = 0;
-
-	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wCurrentRate);
-	if (byRTSRsvType == 0) { /* RTSTxRrvTime_bb */
-		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopCCKBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uCTSTime = uAckTime;
-	} else if (byRTSRsvType == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
-		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopCCKBasicRate);
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-	} else if (byRTSRsvType == 2) { /* RTSTxRrvTime_aa */
-		uRTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 20, pDevice->byTopOFDMBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-		uCTSTime = uAckTime;
-	} else if (byRTSRsvType == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
-		uRrvTime = uCTSTime + uAckTime + uDataTime + 2 * pDevice->uSIFS;
-		return cpu_to_le16((u16)uRrvTime);
+	unsigned int rrv_time = 0;
+	unsigned int rts_time = 0;
+	unsigned int cts_time = 0;
+	unsigned int ack_time = 0;
+	unsigned int data_time = 0;
+
+	data_time = bb_get_frame_time(priv->byPreambleType, pkt_type, frame_length, current_rate);
+	if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
+		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
+		cts_time = ack_time;
+	} else if (rts_rsvtype == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
+		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopCCKBasicRate);
+		cts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+	} else if (rts_rsvtype == 2) { /* RTSTxRrvTime_aa */
+		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopOFDMBasicRate);
+		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		cts_time = ack_time;
+	} else if (rts_rsvtype == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
+		cts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rrv_time = cts_time + ack_time + data_time + 2 * priv->uSIFS;
+		return cpu_to_le16((u16)rrv_time);
 	}
 
 	/* RTSRrvTime */
-	uRrvTime = uRTSTime + uCTSTime + uAckTime + uDataTime + 3 * pDevice->uSIFS;
-	return cpu_to_le16((u16)uRrvTime);
+	rrv_time = rts_time + cts_time + ack_time + data_time + 3 * priv->uSIFS;
+	return cpu_to_le16((u16)rrv_time);
 }
 
 /* byFreqType 0: 5GHz, 1:2.4Ghz */
@@ -921,9 +917,9 @@ s_vGenerateTxParameter(
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
-			buf->rts_rrv_time_aa = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_bb = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
 
@@ -933,7 +929,7 @@ s_vGenerateTxParameter(
 
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-			buf->cts_rrv_time_ba = s_uGetRTSCTSRsvTime(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
+			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
 
 			/* Fill CTS */
 			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
@@ -942,7 +938,7 @@ s_vGenerateTxParameter(
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
@@ -956,7 +952,7 @@ s_vGenerateTxParameter(
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = s_uGetRTSCTSRsvTime(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-- 
2.17.1

