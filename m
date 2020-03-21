Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8EC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C20C20776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E41elm12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgCUWaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:30:10 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51293 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgCUWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:30:09 -0400
Received: by mail-pj1-f67.google.com with SMTP id hg10so4219497pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B5qFJrGFQqJyZwNKSurlZaktra2A1JiMh2eH8abzUa8=;
        b=E41elm12jd11riNXAxZcemim/OxYinkuqYLL8oC+r4tkR5+6JCTftkVbwJxr5NWhwd
         bQAP85rscxX0Jx/qnXpQqUDzgnu/EAKq8c24Y55N1UWxdS7IRe+ClebYXwlWq4DQPPDU
         PyVvsznktL62JBkK3d4x6NrQdzlJ0C0CUGGEFm8y+9Vqt3iNEY8HkxrPOXdGHtKNs6k5
         lN1OiTf71jTBZoRR7XrC1EYosNoiLW7gbmWH3SLT8BdBunOzNHGLulEKWbic20Q0iVz8
         e9XjmvnAsPDgVvnMeeXXh4X/c/+umih9KwNGJF8x3iMEENXElRKdiPXmt4rXl6FJYGQK
         +QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B5qFJrGFQqJyZwNKSurlZaktra2A1JiMh2eH8abzUa8=;
        b=CzxkBYZ/ZWAgzt8+KRIPRf9m+eZ6L+vi5UaQI8bOEKVRwGm7I762g7XJWgga6RC1Bo
         u41NXAtwHTwnxNf4TH24SZG1/ZeAr/a7R0tvgrwkcR9m9XrzVTeNOfC7CD+zBGNO0wFV
         pck/+tj4U9T4Xilgs1TSYcvbma7s5EUJ6qYsObp+D8lMGjKvB/1n/RfQpjjy7L53FEVO
         heiqxhdK9bobuHCTdaaS82RDHUhgqbB8bXB+PT2a31o8AiDZyeRPzdcxR0W+X9ZJj6dE
         o3keSia1PwHHqu+8qFvji12tMOUM1gnEO03RsyAtIhtGIoJf7a1P0/j8xHneY/oftBdx
         LsUA==
X-Gm-Message-State: ANhLgQ383GfaUCaF3zLQIkJPAF4V87Sef72sKmSxWzF8+8O70T9MTt5x
        PECMGsMI0P+sHDqFOhDU/G8=
X-Google-Smtp-Source: ADFU+vvkkhBVrJVmLGfrS6hCjDf1bFoMlXdSo23YEMHegOOqFAtPPj7TpLoW0FaWvzEON9K1okVv9Q==
X-Received: by 2002:a17:902:b198:: with SMTP id s24mr14576295plr.89.1584829808477;
        Sat, 21 Mar 2020 15:30:08 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id k6sm8136655pje.8.2020.03.21.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:30:08 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 11/11] Staging: rtl8188eu: rtl8188eu_xmit: Add space around operators
Date:   Sun, 22 Mar 2020 04:00:02 +0530
Message-Id: <cf8c629e7aa360fb3f86329d8d7df7e49ec360d4.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1584826154.git.shreeya.patel23498@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around operators for improving the code
readability.
Reported by checkpatch.pl

git diff -w shows no difference.
diff of the .o files before and after the changes shows no difference.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff rtl8188eu_xmit_old.o rtl8188eu_xmit.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 2808f2b119bf..7d315bd438d4 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -58,12 +58,12 @@ void rtl8188e_fill_fake_txdesc(struct adapter *adapt, u8 *desc, u32 BufferLen, u
 	/* offset 0 */
 	ptxdesc->txdw0 |= cpu_to_le32(OWN | FSG | LSG); /* own, bFirstSeg, bLastSeg; */
 
-	ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE+OFFSET_SZ)<<OFFSET_SHT)&0x00ff0000); /* 32 bytes for TX Desc */
+	ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) & 0x00ff0000); /* 32 bytes for TX Desc */
 
-	ptxdesc->txdw0 |= cpu_to_le32(BufferLen&0x0000ffff); /*  Buffer size + command header */
+	ptxdesc->txdw0 |= cpu_to_le32(BufferLen & 0x0000ffff); /*  Buffer size + command header */
 
 	/* offset 4 */
-	ptxdesc->txdw1 |= cpu_to_le32((QSLT_MGNT<<QSEL_SHT)&0x00001f00); /*  Fixed queue of Mgnt queue */
+	ptxdesc->txdw1 |= cpu_to_le32((QSLT_MGNT << QSEL_SHT) & 0x00001f00); /*  Fixed queue of Mgnt queue */
 
 	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error vlaue by Hw. */
 	if (ispspoll) {
@@ -91,16 +91,16 @@ static void fill_txdesc_sectype(struct pkt_attrib *pattrib, struct tx_desc *ptxd
 		/* SEC_TYPE : 0:NO_ENC,1:WEP40/TKIP,2:WAPI,3:AES */
 		case _WEP40_:
 		case _WEP104_:
-			ptxdesc->txdw1 |= cpu_to_le32((0x01<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw1 |= cpu_to_le32((0x01 << SEC_TYPE_SHT) & 0x00c00000);
 			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
 			break;
 		case _TKIP_:
 		case _TKIP_WTMIC_:
-			ptxdesc->txdw1 |= cpu_to_le32((0x01<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw1 |= cpu_to_le32((0x01 << SEC_TYPE_SHT) & 0x00c00000);
 			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
 			break;
 		case _AES_:
-			ptxdesc->txdw1 |= cpu_to_le32((0x03<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw1 |= cpu_to_le32((0x03 << SEC_TYPE_SHT) & 0x00c00000);
 			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
 			break;
 		case _NO_PRIVACY_:
@@ -127,7 +127,7 @@ static void fill_txdesc_vcs(struct pkt_attrib *pattrib, __le32 *pdw)
 		*pdw |= cpu_to_le32(HW_RTS_EN);
 		/*  Set RTS BW */
 		if (pattrib->ht_en) {
-			*pdw |= (pattrib->bwmode&HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(27)) : 0;
+			*pdw |= (pattrib->bwmode & HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(27)) : 0;
 
 			if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 				*pdw |= cpu_to_le32((0x01 << 28) & 0x30000000);
@@ -144,7 +144,7 @@ static void fill_txdesc_vcs(struct pkt_attrib *pattrib, __le32 *pdw)
 static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 {
 	if (pattrib->ht_en) {
-		*pdw |= (pattrib->bwmode&HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(25)) : 0;
+		*pdw |= (pattrib->bwmode & HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(25)) : 0;
 
 		if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			*pdw |= cpu_to_le32((0x01 << DATA_SC_SHT) & 0x003f0000);
@@ -171,7 +171,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
-			ptxdesc = (struct tx_desc *)(pmem+PACKET_OFFSET_SZ);
+			ptxdesc = (struct tx_desc *)(pmem + PACKET_OFFSET_SZ);
 			pull = 1;
 		}
 	}
@@ -263,11 +263,11 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 				ptxdesc->txdw4 |= cpu_to_le32(BIT(24));/*  DATA_SHORT */
 			ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
 		}
-	} else if ((pxmitframe->frame_tag&0x0f) == MGNT_FRAMETAG) {
+	} else if ((pxmitframe->frame_tag & 0x0f) == MGNT_FRAMETAG) {
 		/* offset 4 */
 		ptxdesc->txdw1 |= cpu_to_le32(pattrib->mac_id & 0x3f);
 
-		qsel = (uint)(pattrib->qsel&0x0000001f);
+		qsel = (uint)(pattrib->qsel & 0x0000001f);
 		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
 
 		ptxdesc->txdw1 |= cpu_to_le32((pattrib->raid << RATE_ID_SHT) & 0x000f0000);
@@ -278,7 +278,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw2 |= cpu_to_le32(BIT(19));
 
 		/* offset 12 */
-		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum<<SEQ_SHT)&0x0FFF0000);
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum << SEQ_SHT) & 0x0FFF0000);
 
 		/* offset 20 */
 		ptxdesc->txdw5 |= cpu_to_le32(RTY_LMT_EN);/* retry limit enable */
@@ -288,7 +288,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw5 |= cpu_to_le32(0x00300000);/* retry limit = 12 */
 
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
-	} else if ((pxmitframe->frame_tag&0x0f) == TXAGG_FRAMETAG) {
+	} else if ((pxmitframe->frame_tag & 0x0f) == TXAGG_FRAMETAG) {
 		DBG_88E("pxmitframe->frame_tag == TXAGG_FRAMETAG\n");
 	} else {
 		DBG_88E("pxmitframe->frame_tag = %d\n", pxmitframe->frame_tag);
@@ -301,7 +301,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 		/* offset 8 */
 
 		/* offset 12 */
-		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum<<SEQ_SHT)&0x0fff0000);
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum << SEQ_SHT) & 0x0fff0000);
 
 		/* offset 20 */
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
@@ -466,7 +466,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
 
 	/* 3 2. aggregate same priority and same DA(AP or STA) frames */
 	pfirstframe = pxmitframe;
-	len = xmitframe_need_length(pfirstframe) + TXDESC_SIZE + (pfirstframe->pkt_offset*PACKET_OFFSET_SZ);
+	len = xmitframe_need_length(pfirstframe) + TXDESC_SIZE + (pfirstframe->pkt_offset * PACKET_OFFSET_SZ);
 	pbuf_tail = len;
 	pbuf = round_up(pbuf_tail, 8);
 
@@ -517,7 +517,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
 		pxmitframe->agg_num = 0; /*  not first frame of aggregation */
 		pxmitframe->pkt_offset = 0; /*  not first frame of aggregation, no need to reserve offset */
 
-		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset*PACKET_OFFSET_SZ);
+		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
 		if (round_up(pbuf + len, 8) > MAX_XMITBUF_SZ) {
 			pxmitframe->agg_num = 1;
-- 
2.17.1

