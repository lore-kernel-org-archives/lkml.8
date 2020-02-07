Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27ADC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70E0217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BzPmmEvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBGU5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:57:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38112 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGU5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:57:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so453956qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQRsNcYrfTCldY8O32r7JFsTeQROEAXHYPJtNEjnlDg=;
        b=BzPmmEvMUSP3fraGs7NCQg9UGljn8jbIQKt7sVzWMQy0XbJo1aSDeXbvaUbuMJRHPU
         MdxJq4IdSrRyg9yN6HXM6FAcIgMQO4F38rNf2+uBD5TRcZyfnpf3cp+W3NRfs86/o0nc
         nig14MLCMtKPTOHoRguq16cQNsAEyOQbk5sN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQRsNcYrfTCldY8O32r7JFsTeQROEAXHYPJtNEjnlDg=;
        b=J80QPKYsQaB1BUYYD5ENZQaC4KKNIR3Cvavyi6nkkipHRux6klKRF/bQqr+MguIuZG
         kZzc5T9jv6g71mjciUjiQrjYJyCeszL+EJQMzTMkf4IjCxcry3ztrD1ginV1pRTYPQp7
         mANU55XL6rLteyfDasV+BXU/Yd/tnT8CC5ezOSewUkZV2Kkq/+oDOHTIXbqdqWyhH7B4
         Jjzc7aHfPaD5DVb3sExAKvhDyihNZVcCwE/sW1lDOM45ulAEHunARqgaVfamRFYxebWX
         0g64MIjN/WxD5/cmJFYeBnD0VyjV/b3xMJbguGAUeHh0elPOR0X32whPjMbntVgz8Coy
         k/+g==
X-Gm-Message-State: APjAAAXTST5dzJF1NHGux54+CuNvicx76jL+nzrD8Qig0WmcsnK2b/7H
        qulDqmNu5cPOmjpnu5gFBxENbSS3spE=
X-Google-Smtp-Source: APXvYqzfFFIjmpeypGP2GMEYh7JdoKTWdFgPVtgoJWi8agw3oVOaKDJ0Lpqh8Vk8RvLMWpe6kMjMQw==
X-Received: by 2002:aed:33e2:: with SMTP id v89mr260580qtd.162.1581109028705;
        Fri, 07 Feb 2020 12:57:08 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 136sm1887431qkn.109.2020.02.07.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:57:08 -0800 (PST)
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
Subject: [RFC 2/3] Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints"
Date:   Fri,  7 Feb 2020 15:56:55 -0500
Message-Id: <20200207205656.61938-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207205656.61938-1-joel@joelfernandes.org>
References: <20200207205656.61938-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 865e63b04e9b2a658d7f26bd13a71dcd964a9118.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 59463c90fdc3d..ab1f13b7f7d2c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -179,10 +179,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
-			rcu_irq_enter_irqson();				\
-		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -194,10 +192,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
+		if (rcuidle)						\
 			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
-		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
-- 
2.25.0.341.g760bfbb309-goog

