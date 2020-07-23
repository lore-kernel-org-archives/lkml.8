Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE26BC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F4D20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="hZzE9Mwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGWSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:22:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FCC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:22:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so2920347pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VRbfa4L9UjlMv7k71wCSB+XUmtA7HQc7fKrzt8lfBI=;
        b=hZzE9MweST+yC+pQqk+lAGKxwZPdpawXkj6npq7lnB+PKMq2zyTcyrcZy+XbvOrQvn
         0RbsL0GRYc6x7FBsL1dANv/f06BxFIO3/w3IyxcRwkz5an1RLrUN0z/WcT1sdyTJqn/1
         GNvkmYXiyxG+nV2HHq6Pr1juPOvC+wxBt2f28TIJq8j6rZybxaTHxmZMGiyuyWC2UxKN
         6S/xLRd3jcV55YMZwqNzSo/l+HSYLeIDC2m0RAe682U7nvTIQJfZ932NGlwLkpv5XqZD
         Bj1VNbA88qN9SZ70lDEa5Ib5C03K68NWJJUQSKpzsvEUU+vXbxEWJnVOQusUhoOnjqFo
         KhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VRbfa4L9UjlMv7k71wCSB+XUmtA7HQc7fKrzt8lfBI=;
        b=Qvsa4koSCv4SW/bEsA+RmBwrlRomYMok6rrUur57ve5L3aIphtljLQWopS3/DpRrMb
         VTB9eJIdvBZbe77MB2bSPUUBRDLR+lipq3rP9V3qPihhAzTZZt0ceVN7jmk7k/v9AFE9
         kaj7M+XJ9mBCv+BIdAhYPn0Qcg8Dv3Tei2q6iTH2MZllMUPDXhgF4A1oH6FmJy0J9uKz
         qhGAn4tX9nCptOZLjTw1SGBROZQdR8rLiJwsVvrRJrSwl4f9aDEg+vqsXgWsGZZSXSXU
         GnS5/L8OtaN/KD7kUrZs2FRh0Mwob31tOXl5uUJ5ISfqw/e12CHzCmCQmFM30LrayRCp
         Bg6Q==
X-Gm-Message-State: AOAM5337MYidXHKSOrw2vRS5qJ6B9yiPDcnzo5ci5GxSoo9JgjMiQ/zR
        NOrcG6fk4aCt8oxr82IL2K+Cvdg50qw=
X-Google-Smtp-Source: ABdhPJwlQf5cMCTHVExiqh6UCfWl1gotxXG6UbQ96saoISIc70lwO3AFwKVcyBqiis5sH1P++wpz7w==
X-Received: by 2002:a17:90a:f00d:: with SMTP id bt13mr1626632pjb.109.1595528524395;
        Thu, 23 Jul 2020 11:22:04 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:0:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id x23sm3580228pfn.4.2020.07.23.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 11:22:03 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Thomas Graf <tgraf@suug.ch>
Subject: [PATCH] netlink: add buffer boundary checking
Date:   Thu, 23 Jul 2020 11:21:32 -0700
Message-Id: <20200723182136.2550163-1-salyzyn@android.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the nla_get_* inlines fail to check attribute's length before
copying the content resulting in possible out-of-boundary accesses.
Adjust the inlines to perform nla_len checking, for the most part
using the nla_memcpy function to faciliate since these are not
necessarily performance critical and do not need a likely fast path.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Graf <tgraf@suug.ch>
Fixes: bfa83a9e03cf ("[NETLINK]: Type-safe netlink messages/attributes interface")
---
 include/net/netlink.h | 66 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index c0411f14fb53..11c0f153be7c 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1538,7 +1538,11 @@ static inline int nla_put_bitfield32(struct sk_buff *skb, int attrtype,
  */
 static inline u32 nla_get_u32(const struct nlattr *nla)
 {
-	return *(u32 *) nla_data(nla);
+	u32 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1547,7 +1551,11 @@ static inline u32 nla_get_u32(const struct nlattr *nla)
  */
 static inline __be32 nla_get_be32(const struct nlattr *nla)
 {
-	return *(__be32 *) nla_data(nla);
+	__be32 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1556,7 +1564,11 @@ static inline __be32 nla_get_be32(const struct nlattr *nla)
  */
 static inline __le32 nla_get_le32(const struct nlattr *nla)
 {
-	return *(__le32 *) nla_data(nla);
+	__le32 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1565,7 +1577,11 @@ static inline __le32 nla_get_le32(const struct nlattr *nla)
  */
 static inline u16 nla_get_u16(const struct nlattr *nla)
 {
-	return *(u16 *) nla_data(nla);
+	u16 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1574,7 +1590,11 @@ static inline u16 nla_get_u16(const struct nlattr *nla)
  */
 static inline __be16 nla_get_be16(const struct nlattr *nla)
 {
-	return *(__be16 *) nla_data(nla);
+	__be16 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1583,7 +1603,11 @@ static inline __be16 nla_get_be16(const struct nlattr *nla)
  */
 static inline __le16 nla_get_le16(const struct nlattr *nla)
 {
-	return *(__le16 *) nla_data(nla);
+	__le16 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1592,7 +1616,7 @@ static inline __le16 nla_get_le16(const struct nlattr *nla)
  */
 static inline u8 nla_get_u8(const struct nlattr *nla)
 {
-	return *(u8 *) nla_data(nla);
+	return (nla_len(nla) >= sizeof(u8)) ? *(u8 *) nla_data(nla) : 0;
 }
 
 /**
@@ -1627,7 +1651,11 @@ static inline __be64 nla_get_be64(const struct nlattr *nla)
  */
 static inline __le64 nla_get_le64(const struct nlattr *nla)
 {
-	return *(__le64 *) nla_data(nla);
+	__le64 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1636,7 +1664,11 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
  */
 static inline s32 nla_get_s32(const struct nlattr *nla)
 {
-	return *(s32 *) nla_data(nla);
+	s32 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1645,7 +1677,11 @@ static inline s32 nla_get_s32(const struct nlattr *nla)
  */
 static inline s16 nla_get_s16(const struct nlattr *nla)
 {
-	return *(s16 *) nla_data(nla);
+	s16 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1654,7 +1690,7 @@ static inline s16 nla_get_s16(const struct nlattr *nla)
  */
 static inline s8 nla_get_s8(const struct nlattr *nla)
 {
-	return *(s8 *) nla_data(nla);
+	return (nla_len(nla) >= sizeof(s8)) ? *(s8 *) nla_data(nla) : 0;
 }
 
 /**
@@ -1698,7 +1734,11 @@ static inline unsigned long nla_get_msecs(const struct nlattr *nla)
  */
 static inline __be32 nla_get_in_addr(const struct nlattr *nla)
 {
-	return *(__be32 *) nla_data(nla);
+	__be32 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
 }
 
 /**
@@ -1710,6 +1750,7 @@ static inline struct in6_addr nla_get_in6_addr(const struct nlattr *nla)
 	struct in6_addr tmp;
 
 	nla_memcpy(&tmp, nla, sizeof(tmp));
+
 	return tmp;
 }
 
@@ -1722,6 +1763,7 @@ static inline struct nla_bitfield32 nla_get_bitfield32(const struct nlattr *nla)
 	struct nla_bitfield32 tmp;
 
 	nla_memcpy(&tmp, nla, sizeof(tmp));
+
 	return tmp;
 }
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

