Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8070BC433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5548320578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vLtxHrJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgGOMtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:49:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60266 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgGOMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:48:57 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C28EDC3;
        Wed, 15 Jul 2020 14:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594817334;
        bh=sppLBNveVA4+ntWTNOa++wBjLnMfL1GPniNfmwpUoLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLtxHrJ245dFFtbOYlJXhJNdVlV0lKfhkKZQMr21GCsfKYddhFPO4Jzw/vna7NboJ
         /LRylILw+pq2tuuHuBIfUUAn8wMZabs3EiVJILcl8iH3f10AwPTNCdsh5GucHz4pRM
         Vuqa+uktvG2tCXQw0VHIIfqRXAE7/8ZgfuJBy8PM=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     trivial@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/8] kernel: trace: Fix trivial spelling
Date:   Wed, 15 Jul 2020 13:48:37 +0100
Message-Id: <20200715124839.252822-7-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptor -> descriptor

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v2:
 - Fix commit message to reflect actual word replaced
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 780cf3be35d1..5d68f4c46117 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2479,7 +2479,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 }
 
 /*
- * Just create a decriptor for early init. A descriptor is required
+ * Just create a descriptor for early init. A descriptor is required
  * for enabling events at boot. We want to enable events before
  * the filesystem is initialized.
  */
-- 
2.25.1

