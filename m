Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D189C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4927220729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X55sMVS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgGUVAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUVAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:00:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D939C061794;
        Tue, 21 Jul 2020 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bwiQo21A2ylh/p+I+9OTSPNm40WpIOnq27eIWMKm/9E=; b=X55sMVS1kNJR2vhGCOqr73kg/F
        J8ZZLnC1sC1bvHwjDVkzC/mqkaA0Hc70wlN+CiyS9EKKReXT35Alc3R0bhO6H4+rOHXgOYKuUcJGi
        iq7cBGwq99gRTPv+dzoy0JM8bEeCnorFfgRTuznP7JBFK3Jiyd/N16l8od9n2w5uNVU7F56Fpkm0Z
        0uz0MNucXRZKtkxhGWJKQJ0K91Wuwenp7ehB4wQrRXPJmzZpo7CShzAjK+O1+zvgEgIYFfLfPLuZM
        lDk9lb8DyYa5xleZF6jLafPIkHzRJq4xdwmvo1LYoT/J8GEOHTw2HLwqeJxeGnq51GjWN0g6QA7Fq
        LuVi5mYg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxzNN-0000dH-Db; Tue, 21 Jul 2020 21:00:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] SPARC: backoff.h: delete a duplicated word
Date:   Tue, 21 Jul 2020 14:00:33 -0700
Message-Id: <20200721210033.15408-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "other".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
@David:
In arch/sparc/include/asm/cpu_type.h, line 12,
is that duplicated "ploos" correct?
  sun4u       = 0x03, /* V8 ploos ploos */

 arch/sparc/include/asm/backoff.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/sparc/include/asm/backoff.h
+++ linux-next-20200720/arch/sparc/include/asm/backoff.h
@@ -18,7 +18,7 @@
  *
  * When we spin, we try to use an operation that will cause the
  * current cpu strand to block, and therefore make the core fully
- * available to any other other runnable strands.  There are two
+ * available to any other runnable strands.  There are two
  * options, based upon cpu capabilities.
  *
  * On all cpus prior to SPARC-T4 we do three dummy reads of the
