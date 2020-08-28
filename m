Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A71C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E5B20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="V6KMxLhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgH1Ty5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgH1Twu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E578C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:50 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so436071qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oIb65ASfbKXg/SMNVuqzS+vdYF4f56w1EFWwackJJ1s=;
        b=V6KMxLhbmNVvZH1km0YNIrK4NeqQThXbp97ov7AdrGsm4A3B077a80GFDsgieUjddN
         k5Ge1NANBBfalKd0Ka33Xgq5k5fWTuzqjxs4hsTD1zXAKBhg2uqPelw3nDpwkkdguO7v
         o3RQNWUew32RW80sGqBIXfLpNdlu9BgAT18Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oIb65ASfbKXg/SMNVuqzS+vdYF4f56w1EFWwackJJ1s=;
        b=crURPAlldLYh939cYwT1PcLhC3uDh+5Q5Xb/bQeE2mNr54imkYnFPQCELFh02QT8+h
         dZWSPsLEfSe2ygzUMwpLHnex2paGp6j6xVQMXB2b7rbwvrgeqZQtkV4iTSu1an2U2eIn
         /InQG1wAMiWCHXFpPSTuLf+3fXRqXYIHv25Wwc3t54DkXq/HiJAOj4mVRRwD8fTSBJ7D
         4Y0FYBYrNVQGCXmG5bXKGdEhCrARghoA5bgMxRujSYlE2Wgi1kuPK+s3wuQdaAFCSQH2
         vbYTAUNLWmSVnzDoXE7Tt4+l96wAWexIxucF9Z/i9WS9j2a/Aa3vm4e8JV1Qw/AaCX2Q
         URXA==
X-Gm-Message-State: AOAM533AIZfOtMST4t8m6fk0xjY+pbbJNsJgQxp9xwnyjYycPH0XOyd+
        vv3ukA/hvkY9w6zuS7CFM7NtVQ==
X-Google-Smtp-Source: ABdhPJzutjgRHCg8nucSqXLpiE92co/BCk0sTb1azyxg8LQV6CKwoAhW4O01hYFldehEXEzdOG2PyA==
X-Received: by 2002:aed:2f02:: with SMTP id l2mr3199217qtd.48.1598644369352;
        Fri, 28 Aug 2020 12:52:49 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:48 -0700 (PDT)
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
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        paulmck@kernel.org
Subject: [RFC PATCH v7 14/23] irq_work: Add support to detect if work is pending
Date:   Fri, 28 Aug 2020 15:51:15 -0400
Message-Id: <c283856632af132e32b87a7ba0fc8b71f01c8508.1598643276.git.jdesfossez@digitalocean.com>
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

When an unsafe region is entered on an HT, an IPI needs to be sent to
siblings to ensure they enter the kernel.

Following are the reasons why we would like to use irq_work to implement
forcing of sibling into kernel mode:

1. Existing smp_call infrastructure cannot be used easily since we could
   end up waiting on CSD lock if previously an smp_call was not yet
   serviced.

2. I'd like to use generic code, such that there is no need to add an
   arch-specific IPI.

3. IRQ work already has support to detect that previous work was not yet
   executed through the IRQ_WORK_PENDING bit.

4. We need to know if the destination of the IPI is not sending more
   IPIs due to that IPI itself causing an entry into unsafe region.

Support for 4. requires us to be able to detect that irq_work is
pending.

This commit therefore adds a way for irq_work users to know if a
previous per-HT irq_work is pending. If it is, we need not send new
IPIs.

Memory ordering:

I was trying to handle the MP-pattern below. Consider the flag to be the
pending bit. P0() is the IRQ work handler. P1() is the code calling
irq_work_pending(). P0() already implicitly adds a memory barrier as a
part of the atomic_fetch_andnot() before calling work->func(). For P1(),
this patch adds the memory barrier as the atomic_read() in this patch's
irq_work_pending() is not sufficient.

        P0()
        {
                WRITE_ONCE(buf, 1);
                WRITE_ONCE(flag, 1);
        }

        P1()
        {
                int r1;
                int r2 = 0;

                r1 = READ_ONCE(flag);
                if (r1)
                        r2 = READ_ONCE(buf);
        }

Note: This patch is included in the following:
https://lore.kernel.org/lkml/20200722153017.024407984@infradead.org/

This could be removed when the above patch gets merged.

Cc: paulmck@kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/irq_work.h |  1 +
 kernel/irq_work.c        | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 30823780c192..b26466f95d04 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -42,6 +42,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu);
 
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
+bool irq_work_pending(struct irq_work *work);
 
 #ifdef CONFIG_IRQ_WORK
 #include <asm/irq_work.h>
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index eca83965b631..2d206d511aa0 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -24,6 +24,17 @@
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 
+bool irq_work_pending(struct irq_work *work)
+{
+	/*
+	 * Provide ordering to callers who may read other stuff
+	 * after the atomic read (MP-pattern).
+	 */
+	bool ret = atomic_read_acquire(&work->flags) & IRQ_WORK_PENDING;
+
+	return ret;
+}
+
 /*
  * Claim the entry so that no one else will poke at it.
  */
-- 
2.17.1

