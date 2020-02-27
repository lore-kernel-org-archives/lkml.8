Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594CC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3522E2468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSXCmNT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgB0UYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:24:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43003 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:24:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so256505pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zIepTc7bMQWLXwQxod933KYZK3Dy1h3YkRXIGK0QEKQ=;
        b=DSXCmNT9RejcTnluGJFe5hiSuaRsXgyezu+zWABAFuzLoNina/m+NDis8mRPkzGHNZ
         Mvvdqwg/XBlOfe0htHQF/j2wK2nrgyHWZJmv4sx6cQ5/VP6sQC+mbm+M9X2xuUSUg+hU
         PHhCNHvHQhylpSLDDEB+w6ogSQMG60hM7uU1SiNecNIL23TjXV1wKbDKy4AHGEILdL0b
         pCYAHmSKG6FYm4wU+LiPwBhha/QZK+fBDKYYNH2aydKrnSspiBwpDhkPpm64z3pByhGK
         eth0A+2fOT6AwjeLXIoVyBYDZ1CFs+bQNkSCCAeKFYoJsC/f7V8TBL/WtVAe6w+mG6AH
         sb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIepTc7bMQWLXwQxod933KYZK3Dy1h3YkRXIGK0QEKQ=;
        b=XjmLCav5tn/PE7liHS3jhZDcqwiso/l+H6klqeex4oSq0/54JB/5M2IohMaN5bKJ4g
         t9v92p5RuUsEp+nlTnoGCKUotjulucOnFoCOYM7i6AGdeasOK1izXGOM/10QlLf7nmUA
         Bw5W76sMTgGH02ZDk27GzsquRRa5I7Ls0YYIgjDhAS/xu1/4gBKuuprnUj0Nn3/rUc3P
         dX1v8wPXibmUELkhTdMOVnf/2BHk339QZPs9YdB/zzVIT01q0FLRH+NC+0dvkRLv6f7e
         AbJWWDPfCl9gIGChX6wcLanovNW6Cd7TOO4vx5Is4v5W0LwOIErXfM4/L2sIBLJ0jBnT
         YK5w==
X-Gm-Message-State: APjAAAV30MW5vpm0HTtRXwR/jnfD2ctpY7JlTikxU771RHYwbC6f7Z1/
        kf9oADgzTUGmAt/HGgMr/w==
X-Google-Smtp-Source: APXvYqwQY7TXBRyIGmfKNS8/G+RehgmoWqARF/Kh9J4SGoHtjuR5a5SqJGmzHNcbmzyC54rzi2S1uA==
X-Received: by 2002:a62:e411:: with SMTP id r17mr678292pfh.119.1582835055394;
        Thu, 27 Feb 2020 12:24:15 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1ee1:f31f:74cd:ab46:bb74:a4a3])
        by smtp.gmail.com with ESMTPSA id f9sm7954694pfd.141.2020.02.27.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 12:24:14 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] Enable RCU list lockdep debugging and drop CONFIG_PROVE_RCU_LIST
Date:   Fri, 28 Feb 2020 01:53:55 +0530
Message-Id: <20200227202355.6163-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch drops the CONFIG_PROVE_RCU_LIST option and instead
uses CONFIG_PROVE_RCU for RCU list lockdep debugging.

With this change, RCU list lockdep debugging will be default
enabled in CONFIG_PROVE_RCU=y kernels.

Most of the RCU users (in core kernel/, drivers/, and net/
subsystem) have already been modified to include lockdep
expressions hence RCU list debugging can be enabled by
default.

However, there are still chances of enountering
false-positive lockdep splats because not everything is converted,
in case RCU list primitives are used in non-RCU read-side critical
section but under the protection of a lock. It would be okay to
have a few false-positives, as long as bugs are identified, since this
patch only affects debugging kernels.

Co-developed-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/rculist.h  |  2 +-
 kernel/rcu/Kconfig.debug | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 63726577c6b8..f517eb421b5e 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -56,7 +56,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 
 #define check_arg_count_one(dummy)
 
-#ifdef CONFIG_PROVE_RCU_LIST
+#ifdef CONFIG_PROVE_RCU
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({								\
 	check_arg_count_one(extra);					\
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4aa02eee8f6c..5ec3ea4028e2 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -8,17 +8,6 @@ menu "RCU Debugging"
 config PROVE_RCU
 	def_bool PROVE_LOCKING
 
-config PROVE_RCU_LIST
-	bool "RCU list lockdep debugging"
-	depends on PROVE_RCU && RCU_EXPERT
-	default n
-	help
-	  Enable RCU lockdep checking for list usages. By default it is
-	  turned off since there are several list RCU users that still
-	  need to be converted to pass a lockdep expression. To prevent
-	  false-positive splats, we keep it default disabled but once all
-	  users are converted, we can remove this config option.
-
 config TORTURE_TEST
 	tristate
 	default n
-- 
2.17.1

