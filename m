Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C13C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F2A2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J26H4YBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgC0VYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37213 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgC0VY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so13294136wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBdbyoUN01yoZ7UxYctSWg2cmDsZ8i4wniBsQLfNGTM=;
        b=J26H4YBJfcfI7AqNMSkSAbjhs9zBDadfc8kGzXjPfnIkrZVa/ARftywRaITG0xcL3B
         L5I1gMuNwK6NFbHggHbaSxcnIz0OvExfPcwUBKfuefTlyiZeNEVQEqeW9oajinZZv5Lr
         XgwZRrUzQXx3PDXMMgVwJVGx3rAf2jYO38bPJ43qmAy4y00zbe6Wj4ps8x20dero5941
         KvQUVfTNbGkdfxaIoEdap3lU2yLuO2JtIow8gB9BlA4DinSVomfEqS/6hChTxDk3vDWr
         1MibhKIfKGL8cxqHxp4k1pREVIS72f2nHWtAhujIiHwtNjbHAAkYSAbIKnMN131KsnYV
         wYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBdbyoUN01yoZ7UxYctSWg2cmDsZ8i4wniBsQLfNGTM=;
        b=pW31fksmUz97lgfTsMsj9lWKc8vkM/zilaKk/nr9kOtTpPQNmcRKj1ZPZIR08Ha++c
         wrWwgXNUVX2ZR5gKfbOJ28tQL5Xay2kwy2kOMH5gEZcnyqPwX+zxXkWE/hguMf/66DV/
         gdY8DCL3M8qa1iOMRRdVEFrC6TN74QBlhWK5fAr28EjHAcIsGQM4gwGajKALyffWOOQo
         XBGVAu7FIuvI+jz0fgJTZq/L6dzp0U1Bg+kbhXFJ9kyD3wBP1lRtXb8MIYgNiL2Jp0qn
         viMdk4mJU7ngdUwetKZhZzsaa0YD5vHWmCe4CfS5yUMJ6rUmsqkJQqobxI3ZEYEFVhXm
         WG+Q==
X-Gm-Message-State: ANhLgQ0rtQpSkRI70eb38UXvJCEb+D1ITBTud4rqU4rUinhN9oRSnJa2
        ZrbslUxCQy3SIf9hlU54Fg==
X-Google-Smtp-Source: ADFU+vuu0x9FsNL9KC1Uj4An2cSPWndVfnVHHE63cxYdL6WUSY+R/PaHMB9r9URgaFBHbMCzBR0D+A==
X-Received: by 2002:adf:feca:: with SMTP id q10mr1463421wrs.199.1585344268398;
        Fri, 27 Mar 2020 14:24:28 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:28 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/10] trace: Replace printk and WARN_ON with WARN
Date:   Fri, 27 Mar 2020 21:23:55 +0000
Message-Id: <20200327212358.5752-9-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle suggests replacing printk and WARN_ON with WARN

SUGGESTION: printk + WARN_ON can be just WARN.
Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/trace/trace_output.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b4909082f6a4..c0efab8a40c4 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -764,8 +764,7 @@ int register_trace_event(struct trace_event *event)
 		list_add_tail(&event->list, list);
 
 	} else if (event->type > __TRACE_LAST_TYPE) {
-		printk(KERN_WARNING "Need to add type to trace.h\n");
-		WARN_ON(1);
+		WARN(1, "Need to add type to trace.h");
 		goto out;
 	} else {
 		/* Is this event already used */
-- 
2.25.1

