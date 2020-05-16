Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E519C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE192065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8uZE+WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEPQKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 12:10:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC85C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:10:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so2217430plp.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27vU4ld4hW7yyM1NYFKR33va5wB7Q0CEcPGmC8FA414=;
        b=N8uZE+WX87GWeminnJLGxp2z3xuE4PIY2jZgW1O5lOWNHfKJyUgtL2o0agDtDhsjo4
         JuVk8d0K2sgBGcc4vOx43Mc4LeyXyfZcWpi7PuQRuLV1Pc3Eh528kJGHD/mWkSvhox/y
         nf62lgl2lPJe4LscsaXaSe7RnNQkJHMQQXd9Pns0ecLvohsag0gE7Ml1pAQRvm3z+vcV
         Lu84HtQdoVGTMmVxLbTr/wZXghEGfHgH3upR6ymOx3znogeJpYVGiwnShhjyvZvWKFVA
         BXfabFTgLEGdLGCWTTn5LBiTWa5toj+VFhffm8677Ye7EWlrbk6pllwn55IhzoguMuWd
         xoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27vU4ld4hW7yyM1NYFKR33va5wB7Q0CEcPGmC8FA414=;
        b=MVcXB77uW2g3zkB5lvymzdU+7CeVan4y2HcS+zfEvbOfUuJFglCZ9Vw7tOl8tUhsm4
         zEzmgwjDTROZbcPXoLpQWUWcyyWMcTA2oocZfqK5ecTvyMEhiPZpnvugGKIjz65djN96
         Tdt5rd4Bce0u7lH0NIX2uX7F+jY7koky2GuAIfEGEjStWNGCzThm53j6HGOcvbQ+dDbb
         XR0CVsQ70wy2a5Ku8TvVi4qQUbcozQd3G6LigMir070bZOCVGC1IFn2G3bPAW3neb8t4
         d4e/A4PJ5Zuqj8dHI/xDQu6S6GFCqwtMTu+ZKyPlNTwsWFjQlVRX7x7WN6aU/uLJOCKj
         52dw==
X-Gm-Message-State: AOAM531GbAIcDO4u56BQ2mBZrhXdbMPSK2XrO3iUm3LAIBSRniE3D1u5
        cApxVhIqOAYLks6sfIXULB+K0aBHxRA=
X-Google-Smtp-Source: ABdhPJwgfyaO3Cw+ex/vc3B+hA7FpcoTX2H2tcoSNcpwbQAHS9SWUtiuK/pHuhLTQ7tK01l7jEzibw==
X-Received: by 2002:a17:90a:ead6:: with SMTP id ev22mr9602466pjb.94.1589645406752;
        Sat, 16 May 2020 09:10:06 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a2sm4103558pgh.57.2020.05.16.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 09:10:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] function_graph: apply tracing option 'irq-info'
Date:   Sun, 17 May 2020 00:09:53 +0800
Message-Id: <20200516160953.155630-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing option 'irq-info' is only used by function tracer by far. This
patch makes it also against function graph tracer. Then the two tracers
have consistent behavior of this option.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_functions_graph.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4a9c49c08ec9..86e410907649 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -541,7 +541,7 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		}
 
 		/* Latency format */
-		if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
+		if (tr->trace_flags & (TRACE_ITER_LATENCY_FMT | TRACE_ITER_IRQ_INFO))
 			print_graph_lat_fmt(s, ent);
 	}
 
@@ -753,7 +753,7 @@ print_graph_prologue(struct trace_iterator *iter, struct trace_seq *s,
 	}
 
 	/* Latency format */
-	if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
+	if (tr->trace_flags & (TRACE_ITER_LATENCY_FMT | TRACE_ITER_IRQ_INFO))
 		print_graph_lat_fmt(s, ent);
 
 	return;
@@ -1135,7 +1135,7 @@ static void print_lat_header(struct seq_file *s, u32 flags)
 static void __print_graph_headers_flags(struct trace_array *tr,
 					struct seq_file *s, u32 flags)
 {
-	int lat = tr->trace_flags & TRACE_ITER_LATENCY_FMT;
+	int lat = tr->trace_flags & (TRACE_ITER_LATENCY_FMT | TRACE_ITER_IRQ_INFO);
 
 	if (lat)
 		print_lat_header(s, flags);
-- 
2.25.1

