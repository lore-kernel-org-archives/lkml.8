Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE692C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B502087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRo2l8Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHADBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHADBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 23:01:14 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 20:01:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i10so11928721pfq.14
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RNPIMUZGL7vWT+JvfOiEDMKbcRoPVihXyc30/AYvQPA=;
        b=nRo2l8PsWIMgTFvFLo9BYbU4Qqp+qZEnO2DJ9fHLVvRlGCRSvEr4I1zg2yDRdKPMd2
         RHLrqoNjZikT9If1scOVkYV8Hb5gtfwj6mUywDp0IvY28z2cDNzAtaaiyaVw8rOdJdgO
         FkZ+j86I9UNflMCm5u3+5P30GhxYR1l747+nhfJUUFiiR5EWk/I+BL4rlHZmUW/B0fdV
         FNCq1t0JglJMMOWZ7RIX1qnZN4lEZBR1e68ZNGaDS0o3oJ5XZDzFoWDqhomi3hboGddm
         ELCaUYM8bzbpZpdHpLytVI6DLqrH1HXeQXgfZYx+rtgVQC+ABlgUNHHKeJbG0j3jCpso
         e4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RNPIMUZGL7vWT+JvfOiEDMKbcRoPVihXyc30/AYvQPA=;
        b=G803K7QXCNeNQ900EOktSeEsR5bigT0F6AtHzG2jDYQ64F4K/6SrCiNpOC3Ajao4Ry
         OfBECoFLgpFVpKAxPNfTfFZgUoOKEK2Ggq/5nAQOrkuIFESnryltDIbA4HeOyrY/eQUd
         V+L3JuqZyzLWjTLuN+wUYbFtlY+Wotcyua50bkTTRYESwoom2GsnMicnByQxJLfMI6NM
         nDPHBVw3gOeiPN/a1xqYpcfRiTXJOOfXz+LxiEzI0DrXfm+RarOmyYl+XwKhUqQleLGG
         u5TT5RxDDNq3XoW6HIo459xu2sBtufE2IefF3bPhANu/T45KEcmWv3M8NwFUuAtB1Kwq
         O6Rw==
X-Gm-Message-State: AOAM531TUSpD/M+mg4ql57fjxk8lfOcIl4jPmy1FLRiOqG1+qII+JRAZ
        rx09LVBZtz5Ze4kuifQaCo+ifSqWtcOf
X-Google-Smtp-Source: ABdhPJwDhMjrPaRKzEdSU4fOynBTgNIiCSD3A9TewtBpeaM/+nNnn5cUl3YC55tWS029i7m4KUojFPg/qJXV
X-Received: by 2002:a62:3741:: with SMTP id e62mr6119344pfa.127.1596250873449;
 Fri, 31 Jul 2020 20:01:13 -0700 (PDT)
Date:   Fri, 31 Jul 2020 20:01:10 -0700
Message-Id: <20200801030110.747164-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH net-next] fib: fix another fib_rules_ops indirect call wrapper problem
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that on commit 41d707b7332f ("fib: fix fib_rules_ops
indirect calls wrappers") I forgot to include the case when
CONFIG_IP_MULTIPLE_TABLES is not set.

Fixes: 41d707b7332f ("fib: fix fib_rules_ops indirect calls wrappers")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 net/core/fib_rules.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index fce645f6b9b10..a7a3f500a857b 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -17,10 +17,16 @@
 #include <linux/indirect_call_wrapper.h>
 
 #ifdef CONFIG_IPV6_MULTIPLE_TABLES
+#ifdef CONFIG_IP_MULTIPLE_TABLES
 #define INDIRECT_CALL_MT(f, f2, f1, ...) \
 	INDIRECT_CALL_INET(f, f2, f1, __VA_ARGS__)
 #else
+#define INDIRECT_CALL_MT(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
+#endif
+#elif CONFIG_IP_MULTIPLE_TABLES
 #define INDIRECT_CALL_MT(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
+#else
+#define INDIRECT_CALL_MT(f, f2, f1, ...) f(__VA_ARGS__)
 #endif
 
 static const struct fib_kuid_range fib_kuid_range_unset = {
-- 
2.28.0.163.g6104cc2f0b6-goog

