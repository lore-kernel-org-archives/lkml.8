Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A203FC2D0E0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ED820768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vEAvtJV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgIHRPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbgIHQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53400C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:18:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 125so7062731ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=x95DT5jtosgYGGefTlj6NP8d+p2HyfRsrJ4ad9R8zWg=;
        b=vEAvtJV1mZC5g6CtNtuc1RMBhTCoauFGpyTyKhAUJ/l8U7+S+jFND8ivZyM0HZUL9G
         /K9GAkbQLWDrN9HBiVaizvVbEzzg8FhH/GvHRzPAXOT+ZgfwOsr2nHH/ogS+8LoaNkQ7
         hjEISner+UeNA1r568bv4fUydN5RrUGAQ4NwK1YlfwF4LRI1HpywGTt/FQ7HsOnBloI/
         mv26PTYzLSGrfOBj32MRiM6h/m+UutV/K+Ozm70tXcvvC1ZgGRBUWSS4csaJY1IWW12W
         modcc45TYxK1F54JrtcofO+RXmszyvRGpkgJ0NHsU/ge2bFKPE+N2ZX9vbpaeM7qMWDI
         1GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=x95DT5jtosgYGGefTlj6NP8d+p2HyfRsrJ4ad9R8zWg=;
        b=Mg1IATS1Rh75kP4TddJ8y91vkMUmMaP3Rngut5x2OMAsv4GhSgps8PC8OhnWxqWx6t
         gupdb9+X6cVB8Ij7lZESE+qaMJolGF1HUvnnlW/SjDcygrIMsnxy+hdGVGojHXbd2yo1
         sSFcv59FdvqmO8HwzJc9TuOKPL92vu48zDEV/8qmyyB02u+2P0LngQtJ8XgJq9P0yiwm
         yT8QomFBJt62O75IsLbuJy4mIjGYNyyrWRMqTwpkCZ19YY2F8vh3BndpHa4tF1BaJpli
         py/oCvlHtrXQ8JM21xtDfGIz/7M3JZ9RJ32deXtwAcNq3uIxgUh3PgZweVrtGkd7gxwt
         QLwA==
X-Gm-Message-State: AOAM533441vAECggFDR+nUE4UZaFQe2aDkvzAmU/kI7hMRHSID9tHmA1
        lK05hfu5vh34ygwDhk4wNhaBW/Hg1eip
X-Google-Smtp-Source: ABdhPJySE73XVegcNqbVF+9mab6MmrRL1nEIcLINZ2tVaa7rCwF8UXgmoVqBCwlx6WA3rld8VdOhhWvOkzMl
X-Received: from brianvv.svl.corp.google.com ([2620:15c:2c4:201:a28c:fdff:fee1:c370])
 (user=brianvv job=sendgmr) by 2002:a25:e0d5:: with SMTP id
 x204mr554925ybg.57.1599581931886; Tue, 08 Sep 2020 09:18:51 -0700 (PDT)
Date:   Tue,  8 Sep 2020 09:18:12 -0700
Message-Id: <20200908161812.723044-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] fib: fix fib_rule_ops indirect call wrappers when CONFIG_IPV6=m
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sven Joachim <svenjoac@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_IPV6=m, the IPV6 functions won't be found by the linker:

ld: net/core/fib_rules.o: in function `fib_rules_lookup':
fib_rules.c:(.text+0x606): undefined reference to `fib6_rule_match'
ld: fib_rules.c:(.text+0x611): undefined reference to `fib6_rule_match'
ld: fib_rules.c:(.text+0x68c): undefined reference to `fib6_rule_action'
ld: fib_rules.c:(.text+0x693): undefined reference to `fib6_rule_action'
ld: fib_rules.c:(.text+0x6aa): undefined reference to `fib6_rule_suppress'
ld: fib_rules.c:(.text+0x6bc): undefined reference to `fib6_rule_suppress'
make: *** [Makefile:1166: vmlinux] Error 1

Reported-by: Sven Joachim <svenjoac@gmx.de>
Fixes: b9aaec8f0be5 ("fib: use indirect call wrappers in the most common fib_rules_ops")
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 net/core/fib_rules.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 51678a528f85..7bcfb16854cb 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -16,7 +16,7 @@
 #include <net/ip_tunnels.h>
 #include <linux/indirect_call_wrapper.h>
 
-#ifdef CONFIG_IPV6_MULTIPLE_TABLES
+#if defined(CONFIG_IPV6) && defined(CONFIG_IPV6_MULTIPLE_TABLES)
 #ifdef CONFIG_IP_MULTIPLE_TABLES
 #define INDIRECT_CALL_MT(f, f2, f1, ...) \
 	INDIRECT_CALL_INET(f, f2, f1, __VA_ARGS__)
-- 
2.28.0.526.ge36021eeef-goog

