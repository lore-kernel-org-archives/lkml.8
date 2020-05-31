Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8052D2074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m12KnDSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgEaQED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 12:04:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF2C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 09:04:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z13so5091067ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jWa79zjp43R39+MRgzum8emlYhe6zDNSyhVpmFy1UM=;
        b=m12KnDSmpBchSpW8O7NIpxxcXDYX30r/lGOgLTRij+5Bjlywkszb/9+4yyx7SC9oOk
         q8USkg8z2klLfxe/wXbn9ST8N66ESi4x2eJ+O2DVkcuybgKqL1frhFwFRBGYtBMaObLA
         mDQMwikzSAewO6l2vRJggLfJJ34q2X+e86XobZc9EpuGuBDDfU5oTHJe3LIJ4+nkM3zq
         LZOU2/LYijae6tH20nxcy076CAif8Md7/YJaokMfaagg5NwVnv53ed/SZgHIVqo5eAsJ
         yIVsY0eJSJLWoTfLatzPWVA8bI2BVFikueanAgNjXKgVGfmgnc4dr4z6xtKPmS25l1p4
         GBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jWa79zjp43R39+MRgzum8emlYhe6zDNSyhVpmFy1UM=;
        b=pfMCx5ogcrxUSrt/8YetW3aog4e7XRZzbmtc4mjp+d2wTNekfjRtQrwPsxEpJLdT/+
         SjhKLeipFtFlBFVxMh1la6KGONTesUQ+jGtKXUjaI5ZPdSEB6L6t0DCUkhEafGlMwVRx
         Tflx2jyoUpS15VHHegv3kS0vJibiZerQ2IWPuh4MXXun3xvOLh6Hh7w4wKD9/NBoZaAN
         2Fx12r7SDs6iZsReYuT0ayXapyjwuwBtX0SstRUFs3a5NOCzdg4tuOR/SFb/tV4GtaSF
         tfxKO4fMvCvPG55UMSsobqCweatf8p4OeKuYQ+DSip4YUigCQgdjuSwhMQx3T4pcHPMu
         BO/g==
X-Gm-Message-State: AOAM531CxeCMxIETC/01sa51mcpnAyQ/ucDE5y5kapWtXvS32k+Uuaxt
        2/NI9sj77qxfQXgeJD28SIw=
X-Google-Smtp-Source: ABdhPJzC+JjHrT0Z33ulGBSRaEIOUqabc6uh9g7UQ6cn2amrY9fSWX6wLgtic+EvPYUAXiiRCSO3iw==
X-Received: by 2002:a05:651c:311:: with SMTP id a17mr3538745ljp.322.1590941040184;
        Sun, 31 May 2020 09:04:00 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id 6sm3329265ljq.115.2020.05.31.09.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 09:03:59 -0700 (PDT)
Received: (nullmailer pid 39166 invoked by uid 1000);
        Sun, 31 May 2020 16:08:52 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lukasz Szczesny <luk@wybcz.pl>, R Veera Kumar <vkor@vkten.in>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:r8723bs: remove wrappers around skb_clone()
Date:   Sun, 31 May 2020 19:08:43 +0300
Message-Id: <20200531160843.39120-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrappers around skb_clone() do not simplify the driver code.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_service.h | 3 ---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c  | 5 -----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c     | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index 5f681899bbec..be34e279670b 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -94,7 +94,6 @@ void _kfree(u8 *pbuf, u32 sz);
 
 struct sk_buff *_rtw_skb_alloc(u32 sz);
 struct sk_buff *_rtw_skb_copy(const struct sk_buff *skb);
-struct sk_buff *_rtw_skb_clone(struct sk_buff *skb);
 int _rtw_netif_rx(_nic_hdl ndev, struct sk_buff *skb);
 
 #define rtw_malloc(sz)			_rtw_malloc((sz))
@@ -103,9 +102,7 @@ int _rtw_netif_rx(_nic_hdl ndev, struct sk_buff *skb);
 #define rtw_skb_alloc(size) _rtw_skb_alloc((size))
 #define rtw_skb_alloc_f(size, mstat_f)	_rtw_skb_alloc((size))
 #define rtw_skb_copy(skb)	_rtw_skb_copy((skb))
-#define rtw_skb_clone(skb)	_rtw_skb_clone((skb))
 #define rtw_skb_copy_f(skb, mstat_f)	_rtw_skb_copy((skb))
-#define rtw_skb_clone_f(skb, mstat_f)	_rtw_skb_clone((skb))
 #define rtw_netif_rx(ndev, skb) _rtw_netif_rx(ndev, skb)
 
 extern void _rtw_init_queue(struct __queue	*pqueue);
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 4238209ec175..6d443197a0cf 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -47,11 +47,6 @@ inline struct sk_buff *_rtw_skb_copy(const struct sk_buff *skb)
 	return skb_copy(skb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 }
 
-inline struct sk_buff *_rtw_skb_clone(struct sk_buff *skb)
-{
-	return skb_clone(skb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
-}
-
 inline int _rtw_netif_rx(_nic_hdl ndev, struct sk_buff *skb)
 {
 	skb->dev = ndev;
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index eb4d1c3008fe..b2a1bbb30df6 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -110,7 +110,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
 				if (bmcast) {
 					psta = rtw_get_bcmc_stainfo(padapter);
-					pskb2 = rtw_skb_clone(pkt);
+					pskb2 = skb_clone(pkt, GFP_ATOMIC);
 				} else {
 					psta = rtw_get_stainfo(pstapriv, pattrib->dst);
 				}
-- 
2.26.2

