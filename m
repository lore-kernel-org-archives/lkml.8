Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C09C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413762064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="KoS/AZ5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEGHsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:48:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894EC061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:48:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so3544022pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEi8oxDZgiljvgtqHAzPefxRibfafwVfxQ/Qf8yW+Y8=;
        b=KoS/AZ5LkQ06GnueichQTw5LkHZltW8OYzL07W78aCY/jEMpQjuWh7wuJy6ZB52JF9
         cQtWdsyrRLxnbTQ4UpRKkJIbsSuos+U2otKcDWJSQwQFnk1ZKfl8VN5y/+r4Kve5Cce1
         PkL2hDDUzKrR7yFgUtTnx0P//wR8XmNUTAQKbChaXox4cDJGZXVijh7eu0cw7SaaeL+J
         64gh3PZnMZCSLKPtOt9xrlo2pSoY4LqZGlvOh9RenU2SNbuyUXOlePqYFd2VppFRGvuB
         0iZV8+1U95TcPNU6l1TrWpzcyT+0pS5HfrVyy4LJ34diEvBIZ/9GfT9+KwJNZmf/JLT4
         HdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEi8oxDZgiljvgtqHAzPefxRibfafwVfxQ/Qf8yW+Y8=;
        b=EzRpT4zF9D/1KXXndP7+0aaE6HhTqHZngu+2eC+q6cJjUL67qejpq301vzkTP99wIU
         m2jagPAI2ODwWryDEC/V8bW0aN6SPAQwEZxFGASZ1NNpBP+O/lxsLXAjIj50URKLgX5c
         In+PJ/tjvR5GsLJ/pmvWO8nayvSKov8OyqP+J3JGD7b2WirGcGBK/jwR82Dy2VMO0pUF
         OB1eBSpxZBw/F9aGN3uYq845B2QIXbT3iNvOj3x/p1hSIYjrE6yX+dSb/ZIwOor9zlan
         pj4o4anIunWSooA1xmqOhgnjXY/OKvXijTdZnoVxsh4zQxYz0Hx1yua+gRO66JQ2vXUa
         E+dw==
X-Gm-Message-State: AGi0PubYRzO2y4OxbpWTioVMCBWJxGOrTIxyWfDMlkwW6WQzmiBZCRJA
        wPe1USm5Ln9RuO86fwKQOcRbGQ==
X-Google-Smtp-Source: APiQypKAoFYTrSldjOFJstcAdWTPt3uaL44ouRw0Qq7rVOKEyY3vQADztgWZ5gKS/dcxuiTZuNG5Iw==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13mr12137714ply.294.1588837728965;
        Thu, 07 May 2020 00:48:48 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.73])
        by smtp.gmail.com with ESMTPSA id w1sm3152843pgh.53.2020.05.07.00.48.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:48:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] tracing: Remove unused event variable in tracing_iter_reset
Date:   Thu,  7 May 2020 15:47:39 +0800
Message-Id: <20200507074739.43449-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not use the event variable, just remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d2b988126250..6be74d2a7056f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3566,7 +3566,6 @@ static void *s_next(struct seq_file *m, void *v, loff_t *pos)
 
 void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 {
-	struct ring_buffer_event *event;
 	struct ring_buffer_iter *buf_iter;
 	unsigned long entries = 0;
 	u64 ts;
@@ -3584,7 +3583,7 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 	 * that a reset never took place on a cpu. This is evident
 	 * by the timestamp being before the start of the buffer.
 	 */
-	while ((event = ring_buffer_iter_peek(buf_iter, &ts))) {
+	while (ring_buffer_iter_peek(buf_iter, &ts)) {
 		if (ts >= iter->array_buffer->time_start)
 			break;
 		entries++;
-- 
2.11.0

