Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B4CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CB2217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aTfFrArA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBGU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:57:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35640 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgBGU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:57:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so471883qtv.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Bz3q64r/fnFLjoFd3MPYY/1WsS9/sUPncKUUZhRiak=;
        b=aTfFrArAYRdgeNN8kit3/U6aSmM4mLFhncXxSsm3dxe+Mrcpw6HvNpqUfHqjAAzYba
         7n2FSv3CS2HAls/J/TEm4TQnEIPM6TRaXtKn0uAl9gv0DpTI0NIunoHHF9tGdKxBnCPV
         /Wm8sQoqH4gJXycJbhD545PzsjrwnZ4V2Ahio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Bz3q64r/fnFLjoFd3MPYY/1WsS9/sUPncKUUZhRiak=;
        b=g5qYnFlvXCCfdGrAcfOTd1tl3WkrPg345M9ZUAQUcKtMQtzWhjNWNgazqawxUk0djn
         pHQbiF28fpbeXtImp3q5HLjvegVchxUWasLFGWe5KKoYZv67lCFrkvLpYgeHp1WHPq/1
         OHYKGZBsHgJbua0hmm3KUPcJn3oWqGQLN/hWwMQfTZULA0vJ8vBorgk70c5L7cKeeaUY
         78S9Mh4s39dzCidFIJ6r3mN6fC4VPoELntMiFWucUcDgLb4G0haLTuQP1cUxjWIJp4S5
         i8H/WmtTBTdskCoZa2tGxWewYIe6UBCSfEvyVmtK6reGUyeiqrlLB1kz1l7653PILI7k
         UnwA==
X-Gm-Message-State: APjAAAVmMGfUuN23VCkWpoaSlslXGHNCOs02Iww1HvD51eldl97YwIcL
        PKvKJPcv6sci378smZleUpDrc4xHygs=
X-Google-Smtp-Source: APXvYqzKG2i+n992AgtiHnYmlUZ4TdbGrienyADs9rNt+1kyAkl0lOKqLB0JQiniinF2GHtAJakXng==
X-Received: by 2002:aed:3f70:: with SMTP id q45mr248401qtf.310.1581109027671;
        Fri, 07 Feb 2020 12:57:07 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 136sm1887431qkn.109.2020.02.07.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:57:07 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC 1/3] Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make it unique"
Date:   Fri,  7 Feb 2020 15:56:54 -0500
Message-Id: <20200207205656.61938-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207205656.61938-1-joel@joelfernandes.org>
References: <20200207205656.61938-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0c7a52e4d4b5c4d35b31f3c3ad32af814f1bf491.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c533..59463c90fdc3d 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -164,7 +164,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
-		int __maybe_unused __idx = 0;				\
+		int __maybe_unused idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
@@ -180,7 +180,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 * doesn't work from the idle path.			\
 		 */							\
 		if (rcuidle) {						\
-			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
+			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
@@ -196,7 +196,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 									\
 		if (rcuidle) {						\
 			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
+			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
 		}							\
 									\
 		preempt_enable_notrace();				\
-- 
2.25.0.341.g760bfbb309-goog

