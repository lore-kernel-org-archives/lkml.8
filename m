Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0601FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BBB206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahh7GtjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgFNNvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgFNNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:51:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB945C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:51:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so12243428wmn.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M85fp4mlxAsqnKeurpleUPqwGNGhbJqjvWjVEE6K7nU=;
        b=ahh7GtjBStRV2cV1dGfiRQUA1xcwp/bVJwIqEJBsNoyYgL/sxp8q8Nd/OSb1qlocTm
         L+g+LZCCT+Ra32w29drnXwTtaRC/lzAo9GQliXWfXOf+zZOkXBR4MPH/dLWaOuf87Hv5
         POcBvLkt7AOOs/MyJgZHAKoEfG94wEk8/5RFW3t0VzCIyHyfylllDSlaId+ait6z+L+2
         GR5q9ImsjhvynvPXICYTeT26U6dV9xgJp8E5XixNX2SC5vDFvNFBGNA1DWZxduRehVSE
         sheic6Wn68idy5DuDfoBNffOW3bmXVKOTy0O8iTsLVQcKzr+JjWFfv1xU59axMlLIzPS
         Muew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M85fp4mlxAsqnKeurpleUPqwGNGhbJqjvWjVEE6K7nU=;
        b=m9Ini+G+AXGZDd6ym4nD0TKksFqrgzka9pm0HHzu7DL6OQbKp158d0fqrUH4pfk+Jg
         UgI3j1Z52ImLaj4kRFFPLSudeG6Ca2cqZj5oqDHww4k70kfi1FT6Klev+z/yr1UuHEAr
         L14NOTmIcRYehWZjDr23LTEbye2GYSyJhq3H0CvzpywLtbpXgdNzW/44e7CjxiQHIm92
         hMt127AH+yYKk6WIjWzQ2hgI9q5p1OA6LGCifeZeSxX7w6/T9y6E9iAWopoZ0K57hqdq
         cuQ3lTdXWo3VmgcQoa/iNQjLfC1U44wGKvJexU3ZAibztLw+qKeJAcpUv0OirTMrnAXK
         U/1g==
X-Gm-Message-State: AOAM530JGcn6FI0pEzMDdHlZHlpfQV6UTJFLypWzo4nK0udMD0eS9HSr
        wgP4MmZWf0EKkkhJULoWmPQ=
X-Google-Smtp-Source: ABdhPJw9na/iOco8i1PRs6nNnx9GYqQdGHmshBgpfkcDbMHYtEy2qYQIT7EWIM0FZBALnEEta59tEA==
X-Received: by 2002:a1c:4405:: with SMTP id r5mr8737523wma.72.1592142688154;
        Sun, 14 Jun 2020 06:51:28 -0700 (PDT)
Received: from localhost ([2001:818:dd30:9900:ea5e:f314:5497:ebdb])
        by smtp.gmail.com with ESMTPSA id h188sm18765176wmh.2.2020.06.14.06.51.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 06:51:27 -0700 (PDT)
From:   Ricardo Ferreira <rikajff@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ricardo Ferreira <rikajff@gmail.com>
Subject: [PATCH] Staging: rtl8712: Addressed checkpatch.pl issues related to macro parameter wrapping in parentheses.
Date:   Sun, 14 Jun 2020 14:51:25 +0100
Message-Id: <20200614135125.19502-1-rikajff@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to wet my feet in kernel patch submission by submitting a checkstyle
fix for the rtl8712 driver.

Signed-off-by: Ricardo Ferreira <rikajff@gmail.com>
---
 drivers/staging/rtl8712/basic_types.h         |  2 +-
 drivers/staging/rtl8712/osdep_intf.h          |  2 +-
 drivers/staging/rtl8712/rtl8712_efuse.h       |  8 +--
 drivers/staging/rtl8712/rtl8712_recv.h        |  4 +-
 drivers/staging/rtl8712/rtl871x_cmd.h         | 12 ++---
 .../staging/rtl8712/rtl871x_mp_phy_regdef.h   |  4 +-
 drivers/staging/rtl8712/rtl871x_security.h    |  8 +--
 drivers/staging/rtl8712/rtl871x_xmit.h        | 50 +++++++++----------
 drivers/staging/rtl8712/wifi.h                | 10 ++--
 9 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/rtl8712/basic_types.h b/drivers/staging/rtl8712/basic_types.h
index 4ad7f35b1644..3e6d4ff45a75 100644
--- a/drivers/staging/rtl8712/basic_types.h
+++ b/drivers/staging/rtl8712/basic_types.h
@@ -21,7 +21,7 @@
 
 #define SIZE_T __kernel_size_t
 #define sint signed int
-#define FIELD_OFFSET(s, field)	((addr_t)&((s *)(0))->field)
+#define FIELD_OFFSET(s, field)	((addr_t)&(((s) *)(0))->(field))
 
 /* Should we extend this to be host_addr_t and target_addr_t for case:
  *	host : x86_64
diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 2cc25db1a91d..058287fd0f85 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -17,7 +17,7 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define RND4(x)	(((x >> 2) + (((x & 3) == 0) ?  0 : 1)) << 2)
+#define RND4(x)	((((x) >> 2) + ((((x) & 3) == 0) ?  0 : 1)) << 2)
 
 struct intf_priv {
 	u8 *intf_dev;
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.h b/drivers/staging/rtl8712/rtl8712_efuse.h
index 4969d307e978..f22993d94508 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.h
+++ b/drivers/staging/rtl8712/rtl8712_efuse.h
@@ -13,10 +13,10 @@
 #define PGPKT_DATA_SIZE	8 /* PGPKG_MAX_WORDS*2; BYTES sizeof(u8)*8*/
 #define MAX_PGPKT_SIZE	9 /* 1 + PGPKT_DATA_SIZE; header + 2 * 4 words (BYTES)*/
 
-#define GET_EFUSE_OFFSET(header)	((header & 0xF0) >> 4)
-#define GET_EFUSE_WORD_EN(header)	(header & 0x0F)
-#define MAKE_EFUSE_HEADER(offset, word_en)	(((offset & 0x0F) << 4) | \
-						(word_en & 0x0F))
+#define GET_EFUSE_OFFSET(header)	(((header) & 0xF0) >> 4)
+#define GET_EFUSE_WORD_EN(header)	((header) & 0x0F)
+#define MAKE_EFUSE_HEADER(offset, word_en)	((((offset) & 0x0F) << 4) | \
+						((word_en) & 0x0F))
 /*--------------------------------------------------------------------------*/
 struct PGPKT_STRUCT {
 	u8 offset;
diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl8712/rtl8712_recv.h
index 3e385b2242d8..cdce24efaeda 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.h
+++ b/drivers/staging/rtl8712/rtl8712_recv.h
@@ -33,8 +33,8 @@
 #define RECVBUFF_ALIGN_SZ 512
 #define RSVD_ROOM_SZ (0)
 /*These definition is used for Rx packet reordering.*/
-#define SN_LESS(a, b)		(((a-b) & 0x800) != 0)
-#define SN_EQUAL(a, b)	(a == b)
+#define SN_LESS(a, b)		((((a)-(b)) & 0x800) != 0)
+#define SN_EQUAL(a, b)	((a) == (b))
 #define REORDER_WAIT_TIME	30 /* (ms)*/
 
 struct recv_stat {
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 254182a6ce8e..28b855091f23 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -71,12 +71,12 @@ struct	evt_priv {
 
 #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
 do {\
-	INIT_LIST_HEAD(&pcmd->list);\
-	pcmd->cmdcode = code;\
-	pcmd->parmbuf = (u8 *)(pparm);\
-	pcmd->cmdsz = sizeof(*pparm);\
-	pcmd->rsp = NULL;\
-	pcmd->rspsz = 0;\
+	INIT_LIST_HEAD(&(pcmd)->list);\
+	(pcmd)->cmdcode = code;\
+	(pcmd)->parmbuf = (u8 *)((pparm));\
+	(pcmd)->cmdsz = sizeof(*(pparm));\
+	(pcmd)->rsp = NULL;\
+	(pcmd)->rspsz = 0;\
 } while (0)
 
 void r8712_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj);
diff --git a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
index ca5072e11e22..c1c4a06f5342 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
@@ -427,8 +427,8 @@
 #define	bCCKTxCRC16			0xffff
 #define	bCCKTxStatus			0x1
 #define	bOFDMTxStatus			0x2
-#define IS_BB_REG_OFFSET_92S(_Offset)	((_Offset >= 0x800) && \
-					(_Offset <= 0xfff))
+#define IS_BB_REG_OFFSET_92S(_Offset)	(((_Offset) >= 0x800) && \
+					((_Offset) <= 0xfff))
 
 /* 2. Page8(0x800) */
 #define	bRFMOD			0x1	/* Reg 0x800 rFPGA0_RFMOD */
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index b2dda16cbd0a..a3f73d6b49c2 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -139,17 +139,17 @@ struct security_priv {
 
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst) \
 do { \
-	switch (psecuritypriv->AuthAlgrthm) { \
+	switch ((psecuritypriv)->AuthAlgrthm) { \
 	case 0: \
 	case 1: \
 	case 3: \
-		encry_algo = (u8)psecuritypriv->PrivacyAlgrthm; \
+		encry_algo = (u8)(psecuritypriv)->PrivacyAlgrthm; \
 		break; \
 	case 2: \
 		if (bmcst) \
-			encry_algo = (u8)psecuritypriv->XGrpPrivacy; \
+			encry_algo = (u8)(psecuritypriv)->XGrpPrivacy; \
 		else \
-			encry_algo = (u8)psta->XPrivacy; \
+			encry_algo = (u8)(psta)->XPrivacy; \
 		break; \
 	} \
 } while (0)
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index c0c0c781fe17..802612b100b4 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -38,11 +38,11 @@
 /* Fixed the Big Endian bug when using the software driver encryption.*/
 #define WEP_IV(pattrib_iv, txpn, keyidx)\
 do { \
-	pattrib_iv[0] = txpn._byte_.TSC0;\
-	pattrib_iv[1] = txpn._byte_.TSC1;\
-	pattrib_iv[2] = txpn._byte_.TSC2;\
-	pattrib_iv[3] = ((keyidx & 0x3) << 6);\
-	txpn.val = (txpn.val == 0xffffff) ? 0 : (txpn.val+1);\
+	(pattrib_iv)[0] = txpn._byte_.TSC0;\
+	(pattrib_iv)[1] = txpn._byte_.TSC1;\
+	(pattrib_iv)[2] = txpn._byte_.TSC2;\
+	(pattrib_iv)[3] = (((keyidx) & 0x3) << 6);\
+	txpn.val = ((txpn).val == 0xffffff) ? 0 : ((txpn).val+1);\
 } while (0)
 
 /* Fixed the Big Endian bug when doing the Tx.
@@ -50,30 +50,30 @@ do { \
  */
 #define TKIP_IV(pattrib_iv, txpn, keyidx)\
 do { \
-	pattrib_iv[0] = txpn._byte_.TSC1;\
-	pattrib_iv[1] = (txpn._byte_.TSC1 | 0x20) & 0x7f;\
-	pattrib_iv[2] = txpn._byte_.TSC0;\
-	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3)<<6);\
-	pattrib_iv[4] = txpn._byte_.TSC2;\
-	pattrib_iv[5] = txpn._byte_.TSC3;\
-	pattrib_iv[6] = txpn._byte_.TSC4;\
-	pattrib_iv[7] = txpn._byte_.TSC5;\
-	txpn.val = txpn.val == 0xffffffffffffULL ? 0 : \
-	(txpn.val+1);\
+	(pattrib_iv)[0] = (txpn)._byte_.TSC1;\
+	(pattrib_iv)[1] = ((txpn)._byte_.TSC1 | 0x20) & 0x7f;\
+	(pattrib_iv)[2] = (txpn)._byte_.TSC0;\
+	(pattrib_iv)[3] = BIT(5) | (((keyidx) & 0x3)<<6);\
+	(pattrib_iv)[4] = (txpn)._byte_.TSC2;\
+	(pattrib_iv)[5] = (txpn)._byte_.TSC3;\
+	(pattrib_iv)[6] = (txpn)._byte_.TSC4;\
+	(pattrib_iv)[7] = (txpn)._byte_.TSC5;\
+	txpn.val = (txpn).val == 0xffffffffffffULL ? 0 : \
+	((txpn).val+1);\
 } while (0)
 
 #define AES_IV(pattrib_iv, txpn, keyidx)\
 do { \
-	pattrib_iv[0] = txpn._byte_.TSC0;\
-	pattrib_iv[1] = txpn._byte_.TSC1;\
-	pattrib_iv[2] = 0;\
-	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3)<<6);\
-	pattrib_iv[4] = txpn._byte_.TSC2;\
-	pattrib_iv[5] = txpn._byte_.TSC3;\
-	pattrib_iv[6] = txpn._byte_.TSC4;\
-	pattrib_iv[7] = txpn._byte_.TSC5;\
-	txpn.val = txpn.val == 0xffffffffffffULL ? 0 : \
-	(txpn.val+1);\
+	(pattrib_iv)[0] = (txpn)._byte_.TSC0;\
+	(pattrib_iv)[1] = (txpn)._byte_.TSC1;\
+	(pattrib_iv)[2] = 0;\
+	(pattrib_iv)[3] = BIT(5) | (((keyidx) & 0x3)<<6);\
+	(pattrib_iv)[4] = (txpn)._byte_.TSC2;\
+	(pattrib_iv)[5] = (txpn)._byte_.TSC3;\
+	(pattrib_iv)[6] = (txpn)._byte_.TSC4;\
+	(pattrib_iv)[7] = (txpn)._byte_.TSC5;\
+	txpn.val = (txpn).val == 0xffffffffffffULL ? 0 : \
+	((txpn).val+1);\
 } while (0)
 
 struct hw_xmit {
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 91b65731fcaa..5b6b683655ba 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -243,9 +243,9 @@ static inline unsigned char get_tofr_ds(unsigned char *pframe)
 				(pbuf) + 22)) & 0x0f)
 
 #define SetSeqNum(pbuf, num) ({ \
-	*(__le16 *)((addr_t)(pbuf) + 22) = \
-	cpu_to_le16((le16_to_cpu(*(__le16 *)((addr_t)(pbuf) + 22)) & \
-	0x000f) | (0xfff0 & (num << 4))); \
+	*(__le16 *)((addr_t)((pbuf)) + 22) = \
+	cpu_to_le16((le16_to_cpu(*(__le16 *)((addr_t)((pbuf)) + 22)) & \
+	0x000f) | (0xfff0 & ((num) << 4))); \
 })
 
 #define SetDuration(pbuf, dur) ({ \
@@ -254,13 +254,13 @@ static inline unsigned char get_tofr_ds(unsigned char *pframe)
 })
 
 #define SetPriority(pbuf, tid) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf); \
+	*(__le16 *)((pbuf)) |= cpu_to_le16((tid) & 0xf); \
 })
 
 #define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
 
 #define SetAckpolicy(pbuf, ack) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5); \
+	*(__le16 *)((pbuf)) |= cpu_to_le16(((ack) & 3) << 5); \
 })
 
 #define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
-- 
2.20.1

