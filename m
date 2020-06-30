Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52833C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DB02065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="DHEhOZRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgF3VdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgF3VdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E3C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 35so9026522ple.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pxi/wyHIF44tvV/JLf/LlI24pXaiTE4ct5buGjr26HE=;
        b=DHEhOZRtOJUlPHEUsd5Bciiqc96dD7FgHNGZsIYLbW6ZdYKz1XU22l4N4+L9JUVG6G
         nkjN2RFx1h3uM1PT+s/ZHxuvQovF6wQtUDga0qwgR3lGfHhFvrlzjtyDEfb2mJvRMhM5
         hbzwkPiWEfFoMJY8S9AAUk0yarZqu2T4Snunw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pxi/wyHIF44tvV/JLf/LlI24pXaiTE4ct5buGjr26HE=;
        b=ZN7o9+NYlmdAcJtSG1DSHWqCt50AlPFZ0Pgz1OA4Rs9mvaQ1B9N9nB8us3lkBwkrZf
         TMwW0zJF+QaZKWv9JtsyqGWGFOkWFFYucS1d2NV/qvXAmyGOS3bdbQ2xZMz+legxCuGK
         rgxagi+0wozMopOD56ljsF9Z5nGHiNkkc//RUwPJ3QWD1cmtmz4/YDhKuOn0ya1SDkTp
         Oq2okpGzWh7Pz5KqqfuHll/9YTx2cGMswIxxa8No+qUK4Ri8ruA8gb8hc5KRutBaaW/7
         De3y1glOCnzoRgPC4hcI9BS0izCv7mBRMPDF5e2n7PSECmN+35Yp94Tl9r6F9sKDX1fj
         z98Q==
X-Gm-Message-State: AOAM531Ee3/TVYQmuSH4Cfe5MygmtlLE6mHpzSRqq56B7m/mhWO9Dmn9
        +fcUvRrVtW1CeNR5n3ylUoEEIQ==
X-Google-Smtp-Source: ABdhPJzTn5v4FvAlMPi/4EES+ojO0LBxpc0rMFyrvx3LD4fBzK8Oglms9s3ZW/kEhyrUy+IoSdz6uw==
X-Received: by 2002:a17:902:8a82:: with SMTP id p2mr18549387plo.316.1593552786824;
        Tue, 30 Jun 2020 14:33:06 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id a68sm3180492pje.35.2020.06.30.14.33.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:06 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC PATCH 04/16] sched/fair: Add a few assertions
Date:   Tue, 30 Jun 2020 21:32:25 +0000
Message-Id: <8916c2d1121bb35ef0fe52fd050bf9705e673793.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e9f11c8256f..e44a43b87975 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6203,6 +6203,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	}
 
 symmetric:
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
@@ -6644,8 +6649,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6656,6 +6659,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
 
-- 
2.17.1

