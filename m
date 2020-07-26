Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF79CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B2B206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3xlE0HJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGZU6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGZU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:58:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E67C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:58:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so5376139ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YSRlVDFfd+nVXnfyYR/J+RhFeFAvlttVenW7AEJiTA=;
        b=R3xlE0HJ1al84AaZplt1f9mSbEZQiHpZLn888OS1htM00fdtmXC+bS84jsSjdwrT05
         xT1qjEkvSy+0TQYZ+FGt0XBAQ3vSAsjpw9MFMDKEBDlXr4uP9a2gbRBpVuqtsAT6Sj4E
         NzlI3AEZCWzqqZ1SXr9LW0p30KWHwwOvBeE0hlWfp8DuYy5GP1u+tBeLJNigkhUXIpbR
         jh623BG9vFiD33hf3ngS0emBKFYshUT7vv813/jh40QRCAXl2IKTlhZXC0yxVnfJdFPS
         GDK8UMQffOYlNn66DYJxpGljpZxgv68xeLkn1NQZclipZ6aolNr4YF6KZwNw/WnTZrNH
         qUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YSRlVDFfd+nVXnfyYR/J+RhFeFAvlttVenW7AEJiTA=;
        b=I/b5BKbEglN9+YkIHacJCxviFlsV9+PbRLOO5TdSxYUpciYeBki01/VF24SaCEpXUg
         t4M5ON8Z9lQ0LWvoDEL0yela78TSe19v9Aq2EZd41lN34EWtESnaWhw04wSRj83eL9Ij
         z+2moBFcbxKuMYALb7mDqQWiAJcbC0nqLL6ZI7t7TDMfTVzUcAGUXVgS+wDbqiMgA7bk
         LgqgqFRS/jTXiqZhW6Nu8B0YhesuULy4DTfD9roiEl4xxzZ80pC7RQTHY1Fo0AF1tNbh
         zL0HsV78M1Sz2YCUCDSUgFz3UGDwV9/7Zvmwi01z9LHlSdWQFCdSa54xwPFbs/lljYCd
         jsUA==
X-Gm-Message-State: AOAM531u3R6AuW+WjctK6QOq1DwARp0gEXEfCDyMtOg9AG9myt/lE2NU
        tA/vPBiBymBpfOBzeH9qguU=
X-Google-Smtp-Source: ABdhPJy1pY3tvchFHFCHPX6xS0tkdz1KXwh1xG02FCpA1j8IW0QhS4gDYgrrxLyVLfiuIE06mdZDiA==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr8623308ljg.405.1595797129212;
        Sun, 26 Jul 2020 13:58:49 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id v25sm1980618ljg.95.2020.07.26.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 13:58:48 -0700 (PDT)
Received: (nullmailer pid 68697 invoked by uid 1000);
        Sun, 26 Jul 2020 21:03:24 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Simon Fong <simon.fodin@gmail.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Connor Kuehl <connor.kuehl@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: use proper type for second argiment of rtw_(aes|tkip|wep)_(decrypt|encrypt)
Date:   Mon, 27 Jul 2020 00:02:46 +0300
Message-Id: <20200726210246.68633-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_aes_decrypt, rtw_tkip_decrypt, rtw_wep_decrypt, rtw_aes_encrypt,
rtw_tkip_encrypt, rtw_wep_encrypt are takes (u8 *) second argiment and
always uses it as (struct recv_frame *) or (struct xmit_frame *).
This is causes a lot of unnecessary type casts
and complicates refactoring.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c     |  6 +--
 drivers/staging/rtl8188eu/core/rtw_security.c | 50 +++++++++----------
 drivers/staging/rtl8188eu/core/rtw_xmit.c     |  6 +--
 .../staging/rtl8188eu/include/rtw_security.h  | 12 ++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 46a0ac08e90a..98b1ba2e489f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -870,7 +870,7 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	rtw_wep_encrypt(padapter, (u8 *)pmgntframe);
+	rtw_wep_encrypt(padapter, pmgntframe);
 	DBG_88E("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
 }
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 0a4c1b2686b5..5fe7a0458dd2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -384,13 +384,13 @@ static struct recv_frame *decryptor(struct adapter *padapter,
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
-			res = rtw_wep_decrypt(padapter, (u8 *)precv_frame);
+			res = rtw_wep_decrypt(padapter, precv_frame);
 			break;
 		case _TKIP_:
-			res = rtw_tkip_decrypt(padapter, (u8 *)precv_frame);
+			res = rtw_tkip_decrypt(padapter, precv_frame);
 			break;
 		case _AES_:
-			res = rtw_aes_decrypt(padapter, (u8 *)precv_frame);
+			res = rtw_aes_decrypt(padapter, precv_frame);
 			break;
 		default:
 			break;
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 57e171d3e48d..78a8ac60bf3d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -129,12 +129,12 @@ static __le32 getcrc32(u8 *buf, int len)
 /*
 	Need to consider the fragment  situation
 */
-void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
+void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	int	curfragnum, length;
 	u8 *pframe;
 	u8 hw_hdr_offset = 0;
-	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	const int keyindex = psecuritypriv->dot11PrivacyKeyIndex;
@@ -142,16 +142,16 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct sk_buff *skb;
 	struct lib80211_crypto_ops *crypto_ops;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (pxmitframe->buf_addr == NULL)
 		return;
 
 	if ((pattrib->encrypt != _WEP40_) && (pattrib->encrypt != _WEP104_))
 		return;
 
 	hw_hdr_offset = TXDESC_SIZE +
-		 (((struct xmit_frame *)pxmitframe)->pkt_offset * PACKET_OFFSET_SZ);
+		 (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
-	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
+	pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
 	crypto_ops = lib80211_get_crypto_ops("WEP");
 
@@ -198,13 +198,13 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	crypto_ops->deinit(crypto_private);
 }
 
-int rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
+int rtw_wep_decrypt(struct adapter  *padapter, struct recv_frame *precvframe)
 {
-	struct	rx_pkt_attrib	 *prxattrib = &(((struct recv_frame *)precvframe)->attrib);
+	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 
 	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
 		struct	security_priv	*psecuritypriv = &padapter->securitypriv;
-		struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
+		struct sk_buff *skb = precvframe->pkt;
 		u8 *pframe = skb->data;
 		void *crypto_private = NULL;
 		int status = _SUCCESS;
@@ -572,7 +572,7 @@ static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 }
 
 /* The hlen isn't include the IV */
-u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
+u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {																	/*  exclude ICV */
 	u16	pnl;
 	u32	pnh;
@@ -586,17 +586,17 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u8	*pframe, *payload, *iv, *prwskey;
 	union pn48 dot11txpn;
 	struct	sta_info		*stainfo;
-	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	u32	res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (pxmitframe->buf_addr == NULL)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_SIZE +
-		 (((struct xmit_frame *)pxmitframe)->pkt_offset * PACKET_OFFSET_SZ);
-	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
+		 (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
+	pframe = pxmitframe->buf_addr + hw_hdr_offset;
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _TKIP_) {
 		if (pattrib->psta)
@@ -653,7 +653,7 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 }
 
 /* The hlen isn't include the IV */
-u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
+u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 {																	/*  exclude ICV */
 	u16 pnl;
 	u32 pnh;
@@ -666,12 +666,12 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u8	*pframe, *payload, *iv, *prwskey;
 	union pn48 dot11txpn;
 	struct	sta_info		*stainfo;
-	struct	rx_pkt_attrib	 *prxattrib = &((struct recv_frame *)precvframe)->attrib;
+	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	u32		res = _SUCCESS;
 
 
-	pframe = (unsigned char *)((struct recv_frame *)precvframe)->pkt->data;
+	pframe = (unsigned char *)precvframe->pkt->data;
 
 	/* 4 start to decrypt recvframe */
 	if (prxattrib->encrypt == _TKIP_) {
@@ -691,7 +691,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			iv = pframe + prxattrib->hdrlen;
 			payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
-			length = ((struct recv_frame *)precvframe)->pkt->len - prxattrib->hdrlen - prxattrib->iv_len;
+			length = precvframe->pkt->len - prxattrib->hdrlen - prxattrib->iv_len;
 
 			GET_TKIP_PN(iv, dot11txpn);
 
@@ -1214,7 +1214,7 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 	return _SUCCESS;
 }
 
-u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
+u32	rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {	/*  exclude ICV */
 
 	/*static*/
@@ -1225,20 +1225,20 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u8	*pframe, *prwskey;	/*  *payload,*iv */
 	u8   hw_hdr_offset = 0;
 	struct	sta_info		*stainfo;
-	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 
 /*	uint	offset = 0; */
 	u32 res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (pxmitframe->buf_addr == NULL)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_SIZE +
-		 (((struct xmit_frame *)pxmitframe)->pkt_offset * PACKET_OFFSET_SZ);
+		 (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
-	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
+	pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
 	/* 4 start to encrypt each fragment */
 	if (pattrib->encrypt == _AES_) {
@@ -1276,9 +1276,9 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	return res;
 }
 
-u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
+u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 {
-	struct rx_pkt_attrib *prxattrib = &((struct recv_frame *)precvframe)->attrib;
+	struct rx_pkt_attrib *prxattrib = &precvframe->attrib;
 	u32 res = _SUCCESS;
 
 	/* 4 start to encrypt each fragment */
@@ -1288,7 +1288,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 		if (stainfo != NULL) {
 			int key_idx;
 			const int key_length = 16, iv_len = 8, icv_len = 8;
-			struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
+			struct sk_buff *skb = precvframe->pkt;
 			void *crypto_private = NULL;
 			u8 *key, *pframe = skb->data;
 			struct lib80211_crypto_ops *crypto_ops = lib80211_get_crypto_ops("CCMP");
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index d3b1b32bbf76..314790fea1ae 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -713,13 +713,13 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		switch (pattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
-			rtw_wep_encrypt(padapter, (u8 *)pxmitframe);
+			rtw_wep_encrypt(padapter, pxmitframe);
 			break;
 		case _TKIP_:
-			rtw_tkip_encrypt(padapter, (u8 *)pxmitframe);
+			rtw_tkip_encrypt(padapter, pxmitframe);
 			break;
 		case _AES_:
-			rtw_aes_encrypt(padapter, (u8 *)pxmitframe);
+			rtw_aes_encrypt(padapter, pxmitframe);
 			break;
 		default:
 			break;
diff --git a/drivers/staging/rtl8188eu/include/rtw_security.h b/drivers/staging/rtl8188eu/include/rtw_security.h
index 2a3c58fbf805..8ba02a7cea60 100644
--- a/drivers/staging/rtl8188eu/include/rtw_security.h
+++ b/drivers/staging/rtl8188eu/include/rtw_security.h
@@ -292,11 +292,11 @@ void rtw_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
 void rtw_secgetmic(struct mic_data *pmicdata, u8 *dst);
 void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len,
 			u8 *Miccode, u8   priority);
-u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe);
-u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe);
-void rtw_wep_encrypt(struct adapter *padapter, u8  *pxmitframe);
-u32 rtw_aes_decrypt(struct adapter *padapter, u8  *precvframe);
-u32 rtw_tkip_decrypt(struct adapter *padapter, u8  *precvframe);
-int rtw_wep_decrypt(struct adapter *padapter, u8  *precvframe);
+u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
+u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
+void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
+u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
+u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
+int rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
 
 #endif	/* __RTL871X_SECURITY_H_ */
-- 
2.26.2

