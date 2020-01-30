Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6E6C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FAE214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTYRlrP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgA3Orx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:47:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38740 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgA3Orv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so1436471plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8j7vPXQ8NnTfCALzCvlEWGGchYaunD8ZmjFF9OfryBo=;
        b=dTYRlrP1Sg5/xLx73QGqX7OvqDFxXjeAQpEcGzWdvNok45gR/uNcMELPLogJvlqukJ
         5p6eRnQKAbCK+qxWIuVY8ecUzC35l3XjURCG9TmnYqtJDnGYqCcULECCl8n4gLWy1muU
         zd1xmyRkjTwHELeVGWvx8ku+TYdQpEesAFPd61I6wmI4hUQ2878FMLmlZdGCy4c0zBx2
         AZ9l4ruslNPJ4yCPjHNECJKtZs5fIMHSByDfxIr0QxPzGmCDi3mY+d5hPkbQwH3AwTTJ
         ATO6K/wdTw2kRcqd9UuUimpgQnjlBuiCQ0Q8t6/+FhMdxKU/84RmSgaOQJYUczl86xuR
         +23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8j7vPXQ8NnTfCALzCvlEWGGchYaunD8ZmjFF9OfryBo=;
        b=rbDVqvullL1FHuAlsFQU7+YLOR09uIvpZnW6+6UM+S7pgEqPxhXHFowX03t2Jjlsq+
         SMGz8AiECyjUQ56ZO7W8lNaOieW3orkbj2xWJ/FksRBGrM0aMMDO5dCr4zF4l8am3p9V
         gK8+tuDM5QPdh/AEk8NgP6EcbNr160auzOT3JP42Sew0zOFUdTr5O46YBsH7QYyLXX6y
         GuR+oHoRaVh+PV8zUfypkZNPg6UR08EcmbBeZJrNXzDNRhYxDIhGry6hDIy7b/tVuvPU
         hub4VSzpPap2jLMFJp6mqUMQbSZKsiTkbKLUB8fyDQ3qcOpsqLO/Fgdj+JXtrihWxHYc
         VDAg==
X-Gm-Message-State: APjAAAUKMiYU2XTI+KhurxCxM+X/eUM+R3auA82cKkrX6vlxCTJZs4OV
        /8hcMWdmO1qCUaxxG+P0Mye7W7s=
X-Google-Smtp-Source: APXvYqxweGS12eq7xzPRA2TGNxLW34igZlRxFgUer0mcaJqfFCqFllIcyokHKrPw9a9xIZBKM24v8g==
X-Received: by 2002:a17:90a:e653:: with SMTP id ep19mr6606383pjb.58.1580395671183;
        Thu, 30 Jan 2020 06:47:51 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee1:f815:d421:7a49:b2e4:2bd6])
        by smtp.gmail.com with ESMTPSA id b1sm7204927pfg.182.2020.01.30.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:47:50 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        olsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, frextrite@gmail.com,
        joel@joelfernandes.org, paulmck@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] perf_event.h: Add RCU Annotation to struct ring_buffer in perf_event
Date:   Thu, 30 Jan 2020 20:17:28 +0530
Message-Id: <20200130144728.24072-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse errors in events/core.c
and events/ring_buffer.c by adding RCU Annotation to struct
ring_buffer in perf_event:

kernel/events/core.c:5597:9: error: incompatible types in comparison expression
kernel/events/core.c:5303:22: error: incompatible types in comparison expression
kernel/events/core.c:5439:14: error: incompatible types in comparison expression
kernel/events/core.c:5472:14: error: incompatible types in comparison expression
kernel/events/core.c:5529:14: error: incompatible types in comparison expression
kernel/events/core.c:5615:14: error: incompatible types in comparison expression
kernel/events/core.c:5615:14: error: incompatible types in comparison expression
kernel/events/core.c:7183:13: error: incompatible types in comparison expression

kernel/events/ring_buffer.c:169:14: error: incompatible types in comparison expression

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..1691107d2800 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -694,7 +694,7 @@ struct perf_event {
 	struct mutex			mmap_mutex;
 	atomic_t			mmap_count;
 
-	struct ring_buffer		*rb;
+	struct ring_buffer __rcu	*rb;
 	struct list_head		rb_entry;
 	unsigned long			rcu_batches;
 	int				rcu_pending;
-- 
2.17.1

