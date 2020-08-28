Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D50C20897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="D/VsHlD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgH1TyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgH1TxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:53:00 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D24C061234
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so463726qtd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IWePKxpkBftPYqtmzs+YhL43QISuEiGRox/pFo9EGLo=;
        b=D/VsHlD3RNvxRqLpjY6MQSA8XvAomyYOtCOLXki/gYqeinL/kLOOCPRNuz5Kj38YjA
         FsYyY5a49RcIoEC5lzHbqDyfpHsChURpa/u2XDiUlR+Mbr7urdYvZQm4gUbX1+bB2s+B
         2in+B0HpILtgwdJx2znealVYaD97kJ+nqQJP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IWePKxpkBftPYqtmzs+YhL43QISuEiGRox/pFo9EGLo=;
        b=eFftKfCucr46aYWv4OM5Hrlu7yrqqDTv3mVrxZMHLhyLLHNDjAKUyTBxqBd+WVmZiB
         vQQwF3YVz+uKmApGZyLRJ5veKzyxmu9o8vzC0rgQMp/qP+INbYcrwWfHzG8kn/zc6hqH
         LpD18cuQCmQAbjVTDvpCijNGTI5v4NvcRcKZcRWp+WwauZ1ybIj0LRtSMEDvV/ZXfz2N
         1mEk/f7IvI6kqZA5rZjnhonhoU22o39V74J0Q7XrgUJIpvCyqtniuSI7n+eX/5owJEI2
         ENRlx5/9PnGeHA1o3S7dniAPJdTqEKD+NvRUCZ8dAci+NRWuQUDdwivzxOtXDDhbrTN4
         JPYg==
X-Gm-Message-State: AOAM530MUlUlJl8mR628kwgvG2ustRfzogzBi/ckKFP9PrMzQ8l8nYLK
        LZ3qkDiZMlPdMt6raTrhn4M/ZQ==
X-Google-Smtp-Source: ABdhPJzfjYinXpt6nzq0Dchp4KLPTlGtoyAMsBLOEyrrQULKTgPVJ190g0pbj9HI0XcAqJvchQDG3Q==
X-Received: by 2002:ac8:c06:: with SMTP id k6mr3002033qti.318.1598644378830;
        Fri, 28 Aug 2020 12:52:58 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:58 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 18/23] entry/idle: Enter and exit kernel protection during idle entry and exit
Date:   Fri, 28 Aug 2020 15:51:19 -0400
Message-Id: <502aa2680a7ba9c796a370b66c917fd1b0f16b6f.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Make use of the generic_idle_{enter,exit} helper function added in
earlier patches to enter and exit kernel protection.

On exiting idle, protection will be reenabled.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/entry-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2ea0e09b00d5..c833f2fda542 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -374,6 +374,9 @@ void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
  */
 static inline void generic_idle_enter(void)
 {
+	/* Entering idle ends the protected kernel region. */
+	sched_core_unsafe_exit();
+
 	rcu_idle_enter();
 }
 
@@ -383,6 +386,9 @@ static inline void generic_idle_enter(void)
 static inline void generic_idle_exit(void)
 {
 	rcu_idle_exit();
+
+	/* Exiting idle (re)starts the protected kernel region. */
+	sched_core_unsafe_enter();
 }
 
 #endif
-- 
2.17.1

