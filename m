Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A28C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC71020704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9qBiCBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGQGiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgGQGiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:38:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18270C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 23:38:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so7858884qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d584XoPbDW7hlIkJtQT1npOx7x+pM42T6jax2r9SE5I=;
        b=X9qBiCBA7FJW0TvN2azmUlAzK6pLaPLgqz81RORRVQTlEz5Ydt2XHGXAU2LkfgwsUM
         yifW4ap7o770pgTkoMhWjmtfKJSbfZKP5yd6+u6o24TSkuloRA5i/UnK1Dl4qLc1U2ZX
         qD9dZU71i6QncCF56h9QzQf971oUG7zB2yRTTlKQ6ETYsCpxk/Ap4guOavwwK5I4lcj8
         w6jDiHC8+eVK0AmwMShC7uG6LIQlpH/cIjrkChJW/R9iRAtHA2bEL9V7Ujn8rt8eC9H3
         dzfdbM6kGq/zocpRhHOIjKowhnHXNuEanFOH26G6I5g8BbOuq5Q5l9qadDRBbKoWNLQU
         Qtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d584XoPbDW7hlIkJtQT1npOx7x+pM42T6jax2r9SE5I=;
        b=nc5NAJlOAwP8T6uyDGFJYrQpLOxW6DXPHmnTJkd4Z2YlWvm44m8mgLDDJoEJaJccel
         qS3Tmyw9vaK4GpqnH2VrRL5f36Blad9Y8GpRb/4+CKvZQL7HLqM3XzE9YP3PDXswA9oB
         GIW2rWyVoD0Iby22UMCgRcPtwlOA8hx4AdP4r4aLILU2JEHi/ykzoTLjCZh/3w1x/gum
         Fi+xPpm5ElV1HH73EbpiWtR9hznTcjRLfIi2sjuN6mc5LZuJfpO7Nm8j7tZ9kLVlcl6H
         z/1GfvgJC4xCvf4lCcmFcFAEGkX0IIcZ/7ZacuQRWAVeNKeHAquc3JF5BPnYKqC+e7fi
         SWiw==
X-Gm-Message-State: AOAM5316HG3SpgMSsL+H9qniwYBWYQRBgKE46K51+y8nCO6UngvKBeso
        QXgpZkx2KGz0wc8IFOUSFCo=
X-Google-Smtp-Source: ABdhPJy3nlLH2vt89rYnGUKO+9HW9CMDIhDGa1KgfxgZ5gJD7TrR33GJxPUYHP1COIgvuZzdR0hp0Q==
X-Received: by 2002:a37:b0c5:: with SMTP id z188mr7354683qke.412.1594967903336;
        Thu, 16 Jul 2020 23:38:23 -0700 (PDT)
Received: from dev.localdomain ([183.134.211.54])
        by smtp.gmail.com with ESMTPSA id i26sm10043537qkh.14.2020.07.16.23.38.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 23:38:23 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [RFC PATCH 1/1] Softirq:avoid large sched delay from the pending softirqs
Date:   Fri, 17 Jul 2020 02:37:53 -0400
Message-Id: <1594967873-29522-1-git-send-email-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

When get the pending softirqs, it need to process all the pending
softirqs in the while loop. If the processing time of each pending
softirq is need more than 2 msec in this loop, or one of the softirq
will running a long time, according to the original code logic, it
will process all the pending softirqs without wakeuping ksoftirqd,
which will cause a relatively large scheduling delay on the
corresponding CPU, which we do not wish to see. The patch will check
the total time to process pending softirq, if the time exceeds 2 ms
we need to wakeup the ksofirqd to aviod large sched delay.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..602d9fa 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -299,6 +299,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		}
 		h++;
 		pending >>= softirq_bit;
+
+		if (time_after(jiffies, end) && need_resched())
+			break;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
-- 
1.8.3.1

