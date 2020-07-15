Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3FBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C02074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9xK19PY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgGOC7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGOC73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:59:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD774C061755;
        Tue, 14 Jul 2020 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wAIHzAvHE2vOoBQAyavxr/tgkrEkpctkW4UXHpkaoQI=; b=B9xK19PYjGOUOozyGfDy/VFMay
        I0Jm0pTDBqOXnZxQoKEaVlQQdDnMvXpHkS/SPgFCOn75J9tW7NnG60yzHpb9RCsL1Qpgti7DROZJs
        kU0tHBMApGIBjUnggAYtolEuTl3E6UuUjxdw4e3KeBO/eWeDk+SwfTNgMk3Yc2ZadE1dZfSffNze4
        HDkKnoa4m9fplqTCLppc/LLqKyWSNemVp/X8ZMF5q5YffDUoA46vIbi4ezJwWSPpMn7gMIxbmycPC
        S7Ppj5kEuaj4FiTHnDUE/dabpTVBDy2k1/2yTQE1mvKVGtuoU7bElAb+g/Ivd5hQeoMSNT0ifpCtT
        EO+L9Xmg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvXdm-0001FT-RI; Wed, 15 Jul 2020 02:59:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 05/13 net-next] net: wimax: fix duplicate words in comments
Date:   Tue, 14 Jul 2020 19:59:06 -0700
Message-Id: <20200715025914.28091-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715025914.28091-1-rdunlap@infradead.org>
References: <20200715025914.28091-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled words in two comments.
Fix a spello/typo.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 include/linux/wimax/debug.h |    4 ++--
 include/net/wimax.h         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200714.orig/include/linux/wimax/debug.h
+++ linux-next-20200714/include/linux/wimax/debug.h
@@ -184,8 +184,8 @@ do {									\
 
 
 /*
- * CPP sintatic sugar to generate A_B like symbol names when one of
- * the arguments is a a preprocessor #define.
+ * CPP syntatic sugar to generate A_B like symbol names when one of
+ * the arguments is a preprocessor #define.
  */
 #define __D_PASTE__(varname, modulename) varname##_##modulename
 #define __D_PASTE(varname, modulename) (__D_PASTE__(varname, modulename))
--- linux-next-20200714.orig/include/net/wimax.h
+++ linux-next-20200714/include/net/wimax.h
@@ -28,7 +28,7 @@
  *
  * USAGE
  *
- * Embed a `struct wimax_dev` at the beginning of the the device's
+ * Embed a `struct wimax_dev` at the beginning of the device's
  * private structure, initialize and register it. For details, see
  * `struct wimax_dev`s documentation.
  *
