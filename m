Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21BBC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A4420737
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVS+HTlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgGYBt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgGYBt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 21:49:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB6C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 18:49:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z187so7565336pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=y5e7Kxmj3rxBUzNftUQkhmDiDPvu1uklbrqjcw+cOAo=;
        b=oVS+HTlNET/lpmLPN+f2LJEMactBsk7fHorTNCz/B4rgLPfoGBZXue3+9E2i+EmgTg
         hrg72xs9Jl/1Jl58qIGykv2MolfPAlLKRk2GHQKWlkKrQcOsLIGvmDJxjO3Zm38KzA0V
         xMfX0+Uq/+BHNqRACXlt5IHNo9jWwzo2hEFEVo748FhokavqEOmLC970yY1erjOhPtUl
         mwXGvul2GQ9qdo4sOssrOVREhR91QZwhRcVdDD8QVaTMHJASIlmUVyI6cU8GNELrtxdr
         vfJcq6kSH4m43QZ6pMGhPaBj2bDBuneK+nnk81tfzQLO4PtbgRkG+ityf4EVAqF99trA
         BLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=y5e7Kxmj3rxBUzNftUQkhmDiDPvu1uklbrqjcw+cOAo=;
        b=jHGytHzzHMtGAbgNeNUkjdBYKiE8Sk3uxYLGAzMcHUbXSiva37hkTTksVvxAvRKe4m
         os87T3o1pwUPuXss+cZXwiOS6d1N2y1uDOwYp9TN/vr/TF0g4NUFswt9zrzguUHwRdsk
         CS8LVcJ69f/ClCdNGYnlkb1r7PvMs0Q5nCYZpowU1vbK1YcmcKc7NbsBvmYOd5fcDijY
         JXT+Zb+dDbmox0+YgS6+Kg0d6st8HRYR+9g+0Sg8G6NY6NSmOH9y7UTJFMRdBZqOzquH
         D9amZbgn0U18xiNRZBr4608y5cXf1/cY9dEd16qU9WmEkd184JL3HiO2a3/ZcdjH9AQU
         ZpJg==
X-Gm-Message-State: AOAM532xm5C6eh8RdLFvur3kYbrG+R6wvClEdTSIAyzBSbXNcOCZmXaY
        uQjbUlfVecPbr8ryiaoRYC3PV9iqZ5wa
X-Google-Smtp-Source: ABdhPJy2sS+P9lS1/SV1ZFFj/ZzqjbvfkdDsmQF7YTKz7RmUObF387CBf5ZOkVxHBF9lM209xqgCqka9g081
X-Received: by 2002:a17:90b:380d:: with SMTP id mq13mr7860640pjb.186.1595641767239;
 Fri, 24 Jul 2020 18:49:27 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:49:09 -0700
Message-Id: <20200725014909.614068-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH net-next] fib: use indirect call wrappers in the most common fib_rules_ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids another inderect call per RX packet which save us around
20-40 ns.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 net/core/fib_rules.c  | 32 ++++++++++++++++++++++++++++----
 net/ipv4/fib_rules.c  | 12 ++++++++----
 net/ipv6/fib6_rules.c | 12 ++++++++----
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index bd7eba9066f8d..ceef012dd0e65 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -14,6 +14,7 @@
 #include <net/sock.h>
 #include <net/fib_rules.h>
 #include <net/ip_tunnels.h>
+#include <linux/indirect_call_wrapper.h>
 
 static const struct fib_kuid_range fib_kuid_range_unset = {
 	KUIDT_INIT(0),
@@ -242,6 +243,10 @@ static int nla_put_port_range(struct sk_buff *skb, int attrtype,
 	return nla_put(skb, attrtype, sizeof(*range), range);
 }
 
+INDIRECT_CALLABLE_DECLARE(int fib6_rule_match(struct fib_rule *rule,
+					    struct flowi *fl, int flags));
+INDIRECT_CALLABLE_DECLARE(int fib4_rule_match(struct fib_rule *rule,
+					    struct flowi *fl, int flags));
 static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 			  struct flowi *fl, int flags,
 			  struct fib_lookup_arg *arg)
@@ -267,11 +272,24 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 	    uid_gt(fl->flowi_uid, rule->uid_range.end))
 		goto out;
 
-	ret = ops->match(rule, fl, flags);
+	ret = INDIRECT_CALL_INET(ops->match,
+				 fib6_rule_match,
+				 fib4_rule_match,
+				 rule, fl, flags);
 out:
 	return (rule->flags & FIB_RULE_INVERT) ? !ret : ret;
 }
 
+INDIRECT_CALLABLE_DECLARE(int fib6_rule_action(struct fib_rule *rule,
+			    struct flowi *flp, int flags,
+			    struct fib_lookup_arg *arg));
+INDIRECT_CALLABLE_DECLARE(int fib4_rule_action(struct fib_rule *rule,
+			    struct flowi *flp, int flags,
+			    struct fib_lookup_arg *arg));
+INDIRECT_CALLABLE_DECLARE(bool fib6_rule_suppress(struct fib_rule *rule,
+						struct fib_lookup_arg *arg));
+INDIRECT_CALLABLE_DECLARE(bool fib4_rule_suppress(struct fib_rule *rule,
+						struct fib_lookup_arg *arg));
 int fib_rules_lookup(struct fib_rules_ops *ops, struct flowi *fl,
 		     int flags, struct fib_lookup_arg *arg)
 {
@@ -298,9 +316,15 @@ int fib_rules_lookup(struct fib_rules_ops *ops, struct flowi *fl,
 		} else if (rule->action == FR_ACT_NOP)
 			continue;
 		else
-			err = ops->action(rule, fl, flags, arg);
-
-		if (!err && ops->suppress && ops->suppress(rule, arg))
+			err = INDIRECT_CALL_INET(ops->action,
+					       fib6_rule_action,
+					       fib4_rule_action,
+					       rule, fl, flags, arg);
+
+		if (!err && ops->suppress && INDIRECT_CALL_INET(ops->suppress,
+								fib6_rule_suppress,
+								fib4_rule_suppress,
+								rule, arg))
 			continue;
 
 		if (err != -EAGAIN) {
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index f99e3bac5cab2..fd3def3ffa6df 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -29,6 +29,7 @@
 #include <net/ip_fib.h>
 #include <net/nexthop.h>
 #include <net/fib_rules.h>
+#include <linux/indirect_call_wrapper.h>
 
 struct fib4_rule {
 	struct fib_rule		common;
@@ -103,8 +104,9 @@ int __fib_lookup(struct net *net, struct flowi4 *flp,
 }
 EXPORT_SYMBOL_GPL(__fib_lookup);
 
-static int fib4_rule_action(struct fib_rule *rule, struct flowi *flp,
-			    int flags, struct fib_lookup_arg *arg)
+INDIRECT_CALLABLE_SCOPE int fib4_rule_action(struct fib_rule *rule,
+			    struct flowi *flp, int flags,
+			    struct fib_lookup_arg *arg)
 {
 	int err = -EAGAIN;
 	struct fib_table *tbl;
@@ -138,7 +140,8 @@ static int fib4_rule_action(struct fib_rule *rule, struct flowi *flp,
 	return err;
 }
 
-static bool fib4_rule_suppress(struct fib_rule *rule, struct fib_lookup_arg *arg)
+INDIRECT_CALLABLE_SCOPE bool fib4_rule_suppress(struct fib_rule *rule,
+						struct fib_lookup_arg *arg)
 {
 	struct fib_result *result = (struct fib_result *) arg->result;
 	struct net_device *dev = NULL;
@@ -169,7 +172,8 @@ static bool fib4_rule_suppress(struct fib_rule *rule, struct fib_lookup_arg *arg
 	return true;
 }
 
-static int fib4_rule_match(struct fib_rule *rule, struct flowi *fl, int flags)
+INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
+					    struct flowi *fl, int flags)
 {
 	struct fib4_rule *r = (struct fib4_rule *) rule;
 	struct flowi4 *fl4 = &fl->u.ip4;
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 6053ef8515555..fb4db803a2531 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -13,6 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/export.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include <net/fib_rules.h>
 #include <net/ipv6.h>
@@ -255,8 +256,9 @@ static int __fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
 	return err;
 }
 
-static int fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
-			    int flags, struct fib_lookup_arg *arg)
+INDIRECT_CALLABLE_SCOPE int fib6_rule_action(struct fib_rule *rule,
+			    struct flowi *flp, int flags,
+			    struct fib_lookup_arg *arg)
 {
 	if (arg->lookup_ptr == fib6_table_lookup)
 		return fib6_rule_action_alt(rule, flp, flags, arg);
@@ -264,7 +266,8 @@ static int fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
 	return __fib6_rule_action(rule, flp, flags, arg);
 }
 
-static bool fib6_rule_suppress(struct fib_rule *rule, struct fib_lookup_arg *arg)
+INDIRECT_CALLABLE_SCOPE bool fib6_rule_suppress(struct fib_rule *rule,
+						struct fib_lookup_arg *arg)
 {
 	struct fib6_result *res = arg->result;
 	struct rt6_info *rt = res->rt6;
@@ -296,7 +299,8 @@ static bool fib6_rule_suppress(struct fib_rule *rule, struct fib_lookup_arg *arg
 	return true;
 }
 
-static int fib6_rule_match(struct fib_rule *rule, struct flowi *fl, int flags)
+INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
+					    struct flowi *fl, int flags)
 {
 	struct fib6_rule *r = (struct fib6_rule *) rule;
 	struct flowi6 *fl6 = &fl->u.ip6;
-- 
2.28.0.rc0.142.g3c755180ce-goog

