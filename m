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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18623C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E7920801
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5wYfa5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgEaS0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:26:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7BC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 11:26:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so5408764ljn.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhUKdkxEft6nfXa1bSZjn8ZV2z/LvCOdEDYS/DQ0vVs=;
        b=L5wYfa5jjbO3UasXEK47PX2DzUNEb/iXxOA1wo11xyBqd+YwfEFz1YQKpmevBRqrrQ
         H+9I2EWB5kF8Q3wkorqFNuCGL6Xnn8ACBEhShq6f4LoaYhotoq38vQxyQZ6s1/4JAgce
         FahBshoFpH2ttRXvhXVPtQlRpnQz32VvJLzslGS/uASlenPlzKnyjsJfMiLoPxW2kXfJ
         nS8LQrxFgBmY28W1i44Jm/Kk4Ogc4nICy1Iz5nRFiPADUOUWfoLI7F3qD3RsLbz6d1dp
         99uHVNFhDMRnB0a/A0jpqSAo/LCIW+6ZUdpsy0SaGoELyGtG8CicbqlXpO653QWdtdyb
         SanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhUKdkxEft6nfXa1bSZjn8ZV2z/LvCOdEDYS/DQ0vVs=;
        b=XDHn7CkgD3NBfqIYkB+j7DCSBfVt6NQGdfo2V+pWsnf1yIO+38Z5WceKLa2KPZF+gD
         1BH88rD7b1nwj2iZUKGyw24UwJ+o0Xxc2KtLauLfTiHJqzIQ5/1veDE1DtL0BbwDTZso
         nc9PWqpRJiSv4O791PWpgNaSTa6uXbDmmR/8/5sfUKuDjKJadqWwSvk3Nu3IBDuy4UgY
         Lzz8GN13NEp/NHz+1wgBvud9XcUFdsGMNcL0G+ffvenSy18xcoEeAstsQd4qcY0AY7GV
         TaDsHCElTCGBf/Sq4vsnvDRSXBZYI1GV90LZl8/X0HtEbeTOFKs/FbTYXq/pSTpQMM04
         b1Eg==
X-Gm-Message-State: AOAM5306dvKOyxD3zjF8EDhkkovKlKUA0mG4jnlqfKqIoE1oAC1UakX3
        7udN7L2ZF8RMinID9CHpIaA=
X-Google-Smtp-Source: ABdhPJz0rUAOzlz9y9LZbKi8Su6ICT/PIqmYq6NxSCagYLO4x0cgipgUTrymIwWMLEWcKltLeRUcIw==
X-Received: by 2002:a2e:b550:: with SMTP id a16mr6854221ljn.345.1590949584594;
        Sun, 31 May 2020 11:26:24 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id a8sm3396969ljp.102.2020.05.31.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 11:26:23 -0700 (PDT)
Received: (nullmailer pid 42072 invoked by uid 1000);
        Sun, 31 May 2020 18:31:11 -0000
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
Subject: [PATCH v2] staging:r8723bs: remove wrappers around skb_clone() and remove unnecessary in_interrupt() call
Date:   Sun, 31 May 2020 21:17:52 +0300
Message-Id: <20200531181751.41830-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrappers around skb_clone() do not simplify the driver code.

The skb_clone() is always called from an interrupt handler,
so use GFP_ATOMIC allocation only.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
Changes in v2:
  - in_interrupt() removal has been described.

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

