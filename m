Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4D324953
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrjpmSwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEBPOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgEBPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:14:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4111C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 08:14:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so5288644ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skusR49BI6YUP3gg0TBWvBnZGkXreqlKpGeUcw662Io=;
        b=QrjpmSwflLd6OCaJYYGYLDkc8xHXg4aCcQElDZt+GfOtKyRJ4v4eSkhp/vivxp6b0K
         zmJ5XP22SCAPz4KfcT+HhtcsrTUI9X2kDEivOi1Ab1odYMnvXFnsB5kr8/7aMYr8IUqN
         4mdZlDVBeaTE8I8+w03iP2RgpzWKLwXbwOtOThvQxJ4ADRoi0xqrABkN9YsD1ShD+Z78
         7G7xTq2RLcm1kZb5MzEp3INZuYcyw481ZZkgGeqp9vcEkpYP/9sKZf1jSNr5ad5V178D
         jLeb/RebOhenJCvirn4+WeAHfcMpSuVKL3vbbh8gC/HiW/u9SvgMp51r1Z2xzdLNwcTH
         +pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skusR49BI6YUP3gg0TBWvBnZGkXreqlKpGeUcw662Io=;
        b=g+SlM6drb7arshot4ey4KsVWQvCFV9y73mFZK0e0utE55UXsX09bQphZW1HpIjNo5q
         Gl7VLOE+dq85bSXpi0KGDERLLRkxr7h4s4SO/4Yv4X6BGbuaEx1x3Xr1R6Cz2IlPxb+T
         rLCi0uxUWu5NNJe1IR5VGMvQJBEJbaV1kg8urr5bcCZ9ZqFOLrthLMtJStEUQtf6QYbF
         mlgmWdByMJpIxLI9acd8UOp6ayP3PZVLeaurmEVekmLgd51Pp+Ptaxu/2mquMZWhpxTP
         RPjUlH8rJ4bqioE/TY4XsbVaaXrbigYCELeFXrgV66Vf1t1IduinCQrFHsA44Ih/fPIZ
         EfnA==
X-Gm-Message-State: AGi0PuYHvGn81Z/vrQDxXEenBc2tWseyQZrW96xWmO7ZoDdpqSGj8ezr
        ku5HpRFPyJRQVcyT6F/fSw0=
X-Google-Smtp-Source: APiQypKftxsTAGKlKn/g9X22khhPV1YL3tOrbyRLxmVTHhvDcpdFm3HGW++Gr2q0DR14tUadntkHIg==
X-Received: by 2002:a2e:3a0a:: with SMTP id h10mr4988841lja.54.1588432477120;
        Sat, 02 May 2020 08:14:37 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id r20sm4031231ljj.44.2020.05.02.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 08:14:36 -0700 (PDT)
Received: (nullmailer pid 43711 invoked by uid 1000);
        Sat, 02 May 2020 15:19:19 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Simran Singhal <singhalsimran0@gmail.com>,
        R Veera Kumar <vkor@vkten.in>,
        Michael Straube <straube.linux@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lukasz Szczesny <luk@wybcz.pl>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:rtl8723bs: eliminate usage of skb_clone after skb allocation fail
Date:   Sat,  2 May 2020 18:19:05 +0300
Message-Id: <20200502151905.43663-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb allocated when out of memory
is likely to be discarded during subsequent processing.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    | 44 ++++++-------------
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 19 +++-----
 2 files changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index c3051ebaeb78..29c29e2e125b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -311,39 +311,21 @@ static void rtl8723bs_recv_tasklet(unsigned long priv)
 				}
 
 				pkt_copy = rtw_skb_alloc(alloc_sz);
-
-				if (pkt_copy) {
-					pkt_copy->dev = padapter->pnetdev;
-					precvframe->u.hdr.pkt = pkt_copy;
-					skb_reserve(pkt_copy, 8 - ((SIZE_PTR)(pkt_copy->data) & 7));/* force pkt_copy->data at 8-byte alignment address */
-					skb_reserve(pkt_copy, shift_sz);/* force ip_hdr at 8-byte alignment address according to shift_sz. */
-					memcpy(pkt_copy->data, (ptr + rx_report_sz + pattrib->shift_sz), skb_len);
-					precvframe->u.hdr.rx_head = pkt_copy->head;
-					precvframe->u.hdr.rx_data = precvframe->u.hdr.rx_tail = pkt_copy->data;
-					precvframe->u.hdr.rx_end = skb_end_pointer(pkt_copy);
-				} else {
-					if ((pattrib->mfrag == 1) && (pattrib->frag_num == 0)) {
-						DBG_8192C("%s: alloc_skb fail, drop frag frame\n", __func__);
-						rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
-						break;
-					}
-
-					precvframe->u.hdr.pkt = rtw_skb_clone(precvbuf->pskb);
-					if (precvframe->u.hdr.pkt) {
-						_pkt *pkt_clone = precvframe->u.hdr.pkt;
-
-						pkt_clone->data = ptr + rx_report_sz + pattrib->shift_sz;
-						skb_reset_tail_pointer(pkt_clone);
-						precvframe->u.hdr.rx_head = precvframe->u.hdr.rx_data = precvframe->u.hdr.rx_tail
-							= pkt_clone->data;
-						precvframe->u.hdr.rx_end = pkt_clone->data + skb_len;
-					} else {
-						DBG_8192C("%s: rtw_skb_clone fail\n", __func__);
-						rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
-						break;
-					}
+				if (!pkt_copy) {
+					DBG_8192C("%s: alloc_skb fail, drop frame\n", __func__);
+					rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
+					break;
 				}
 
+				pkt_copy->dev = padapter->pnetdev;
+				precvframe->u.hdr.pkt = pkt_copy;
+				skb_reserve(pkt_copy, 8 - ((SIZE_PTR)(pkt_copy->data) & 7));/* force pkt_copy->data at 8-byte alignment address */
+				skb_reserve(pkt_copy, shift_sz);/* force ip_hdr at 8-byte alignment address according to shift_sz. */
+				memcpy(pkt_copy->data, (ptr + rx_report_sz + pattrib->shift_sz), skb_len);
+				precvframe->u.hdr.rx_head = pkt_copy->head;
+				precvframe->u.hdr.rx_data = precvframe->u.hdr.rx_tail = pkt_copy->data;
+				precvframe->u.hdr.rx_end = skb_end_pointer(pkt_copy);
+
 				recvframe_put(precvframe, skb_len);
 				/* recvframe_pull(precvframe, drvinfo_sz + RXDESC_SIZE); */
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 60c35d92ba29..560221723d70 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -60,21 +60,14 @@ _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8
 	pattrib = &prframe->u.hdr.attrib;
 
 	sub_skb = rtw_skb_alloc(nSubframe_Length + 12);
-	if (sub_skb) {
-		skb_reserve(sub_skb, 12);
-		skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
-	} else {
-		sub_skb = rtw_skb_clone(prframe->u.hdr.pkt);
-		if (sub_skb) {
-			sub_skb->data = pdata + ETH_HLEN;
-			sub_skb->len = nSubframe_Length;
-			skb_set_tail_pointer(sub_skb, nSubframe_Length);
-		} else {
-			DBG_871X("%s(): rtw_skb_clone() Fail!!!\n", __func__);
-			return NULL;
-		}
+	if (!sub_skb) {
+		DBG_871X("%s(): rtw_skb_alloc() Fail!!!\n", __func__);
+		return NULL;
 	}
 
+	skb_reserve(sub_skb, 12);
+	skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
+
 	eth_type = RTW_GET_BE16(&sub_skb->data[6]);
 
 	if (sub_skb->len >= 8 &&
-- 
2.26.2

