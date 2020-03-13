Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13437C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE851206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCMOb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:31:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:31:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jClLP-0005r2-1U; Fri, 13 Mar 2020 15:31:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8BA6F1C2230;
        Fri, 13 Mar 2020 15:31:22 +0100 (CET)
Date:   Fri, 13 Mar 2020 14:31:22 -0000
From:   "tip-bot2 for Peter Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/vector: Remove warning on managed interrupt migration
Cc:     Peter Xu <peterx@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200312205830.81796-1-peterx@redhat.com>
References: <20200312205830.81796-1-peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <158410988219.28353.1324427859860216725.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     469ff207b4c4033540b50bc59587dc915faa1367
Gitweb:        https://git.kernel.org/tip/469ff207b4c4033540b50bc59587dc915faa1367
Author:        Peter Xu <peterx@redhat.com>
AuthorDate:    Thu, 12 Mar 2020 16:58:30 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Mar 2020 15:29:26 +01:00

x86/vector: Remove warning on managed interrupt migration

The vector management code assumes that managed interrupts cannot be
migrated away from an online CPU. free_moved_vector() has a WARN_ON_ONCE()
which triggers when a managed interrupt vector association on a online CPU
is cleared. The CPU offline code uses a different mechanism which cannot
trigger this.

This assumption is not longer correct because the new CPU isolation feature
which affects the placement of managed interrupts must be able to move a
managed interrupt away from an online CPU.

There are two reasons why this can happen:

  1) When the interrupt is activated the affinity mask which was
     established in irq_create_affinity_masks() is handed in to
     the vector allocation code. This mask contains all CPUs to which
     the interrupt can be made affine to, but this does not take the
     CPU isolation 'managed_irq' mask into account.

     When the interrupt is finally requested by the device driver then the
     affinity is checked again and the CPU isolation 'managed_irq' mask is
     taken into account, which moves the interrupt to a non-isolated CPU if
     possible.

  2) The interrupt can be affine to an isolated CPU because the
     non-isolated CPUs in the calculated affinity mask are not online.

     Once a non-isolated CPU which is in the mask comes online the
     interrupt is migrated to this non-isolated CPU

In both cases the regular online migration mechanism is used which triggers
the WARN_ON_ONCE() in free_moved_vector().

Case #1 could have been addressed by taking the isolation mask into
account, but that would require a massive code change in the activation
logic and the eventual migration event was accepted as a reasonable
tradeoff when the isolation feature was developed. But even if #1 would be
addressed, #2 would still trigger it.

Of course the warning in free_moved_vector() was overlooked at that time
and the above two cases which have been discussed during patch review have
obviously never been tested before the final submission.

So keep it simple and remove the warning.

[ tglx: Rewrote changelog and added a comment to free_moved_vector() ]

Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>                                                                                                                                                                       
Link: https://lkml.kernel.org/r/20200312205830.81796-1-peterx@redhat.com

---
 arch/x86/kernel/apic/vector.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b..48293d1 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -838,13 +838,15 @@ static void free_moved_vector(struct apic_chip_data *apicd)
 	bool managed = apicd->is_managed;
 
 	/*
-	 * This should never happen. Managed interrupts are not
-	 * migrated except on CPU down, which does not involve the
-	 * cleanup vector. But try to keep the accounting correct
-	 * nevertheless.
+	 * Managed interrupts are usually not migrated away
+	 * from an online CPU, but CPU isolation 'managed_irq'
+	 * can make that happen.
+	 * 1) Activation does not take the isolation into account
+	 *    to keep the code simple
+	 * 2) Migration away from an isolated CPU can happen when
+	 *    a non-isolated CPU which is in the calculated
+	 *    affinity mask comes online.
 	 */
-	WARN_ON_ONCE(managed);
-
 	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
 	irq_matrix_free(vector_matrix, cpu, vector, managed);
 	per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
