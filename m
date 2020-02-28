Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71908C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468AE246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDnPp8u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1JZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:25:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38557 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1JZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:25:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so1427029pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S4gi9DzSp14YfzPR+D6JqNOQzoOlU/CqGMZ0Lo8rA+c=;
        b=YDnPp8u7WnB9/6IZXgEYCyJSViWmwiFsC345TIUcvvG3v/GUmiz7WpyysoNxEeuY2n
         0YqUP42Fhp54Quqfw6YTz+MHvfenBa98IZ54dyQX++NA00VVfz8nhvbMPSSNCqPGkB8d
         OTZbYbSr9sNmkFzxxH44XoNelFGezLglte3e0L2aV0ROaEmFgEVCX2xI01234NcLd5W/
         81ZLGHaekmYv5WMzhjZIj9klUra0Nw64p/UM6HXaPbrgC6AdrU9VQChR0uy/nG8DR5CL
         3r9TcXl+mLgF31Yz6z2tx1IR5pOqu1yLDrQP/bnT5IcIVcf4+vGUwZwl04BxiN66k//7
         6Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S4gi9DzSp14YfzPR+D6JqNOQzoOlU/CqGMZ0Lo8rA+c=;
        b=Nfp+/n5kCFzxf/g5vLgH+n9TximZpuBHuXdt/tacRCRwGKVBECicyqsElzvHYI7Jj7
         VOOmn9gd8qCXmGNWpxQyfY3AGM2mmgKqWrnBKh/gLZW+dVXHSp5coKWohKQ0ZB/Rni3f
         pnzTsgzf8KRiAangiDNm1nD+gLtgJCApi843aMizx6RYLcPzL+Am/SNDiS2elMqoFGEq
         ZwRqGeqlGIHkjUxXXGeorjBYR/8x6mI52TtCNSEphWWbwi9tRLVgyhIiloH3b5wlQNQ7
         3iyrxGSBdnti8faYnVotV2N/QVzUgwG18I0pzQGaC5Wn7t7qeDmLgJtsptFlBTN3ct4j
         V4NA==
X-Gm-Message-State: APjAAAXbfwJwM67HgNdSVMTjNEVeT/dpd7rU6NVOqMRlei9G2hJjuujv
        v33WYHjl9DZ2zSx1tFO8KQ==
X-Google-Smtp-Source: APXvYqxO8OjxiM4PSWSKvXhkRqfpp3qwCEx8XbNcyqpZsEeoRg2ZZXQB3OB+d/3Pl3ILo7F60MlQGQ==
X-Received: by 2002:a63:f403:: with SMTP id g3mr3764936pgi.62.1582881932838;
        Fri, 28 Feb 2020 01:25:32 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1ee0:f1c2:74cd:ab46:bb74:a4a3])
        by smtp.gmail.com with ESMTPSA id r72sm1660500pjb.18.2020.02.28.01.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 01:25:31 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Date:   Fri, 28 Feb 2020 14:54:51 +0530
Message-Id: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch default enables CONFIG_PROVE_RCU_LIST option with
CONFIG_PROVE_RCU for RCU list lockdep debugging.

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
 kernel/rcu/Kconfig.debug | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4aa02eee8f6c..ec4bb6c09048 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -9,15 +9,10 @@ config PROVE_RCU
 	def_bool PROVE_LOCKING
 
 config PROVE_RCU_LIST
-	bool "RCU list lockdep debugging"
-	depends on PROVE_RCU && RCU_EXPERT
-	default n
+	def_bool PROVE_RCU
 	help
-	  Enable RCU lockdep checking for list usages. By default it is
-	  turned off since there are several list RCU users that still
-	  need to be converted to pass a lockdep expression. To prevent
-	  false-positive splats, we keep it default disabled but once all
-	  users are converted, we can remove this config option.
+	  Enable RCU lockdep checking for list usages. It is default
+	  enabled with CONFIG_PROVE_RCU.
 
 config TORTURE_TEST
 	tristate
-- 
2.17.1

