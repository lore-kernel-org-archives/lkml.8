Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D9A2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhQgZl5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgFOUVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:21:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730054AbgFOUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592252500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=PQmjI/YZfpbhJXMd2wuG++ZBpW4Ksv/DI4nDZX9kmtc=;
        b=bhQgZl5aL7jJrD6NWrqdGXMW7wzHLgnpGKi+493qbRSd+Pg0iG8+FG7X5EcMSxIaAQO/W4
        cW4yAatml3zqDZgil36dmKFEclUS5alOgJ82BVQLY/WsrkA7/416FAQtVZvp3GevaLiAzP
        dO+m6oPT7HnzzDr/rRIFRhhd4Xc4LbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-kppukrEXPhKFS6rxGT-9cg-1; Mon, 15 Jun 2020 16:21:36 -0400
X-MC-Unique: kppukrEXPhKFS6rxGT-9cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2581618FE863;
        Mon, 15 Jun 2020 20:21:35 +0000 (UTC)
Received: from virtlab500.virt.lab.eng.bos.redhat.com (virtlab500.virt.lab.eng.bos.redhat.com [10.19.152.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF556ED96;
        Mon, 15 Jun 2020 20:21:34 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, sassmann@redhat.com,
        jeffrey.t.kirsher@intel.com, jacob.e.keller@intel.com,
        jlelli@redhat.com
Subject: [Patch v1] i40e: limit the msix vectors based on housekeeping CPUs
Date:   Mon, 15 Jun 2020 16:21:25 -0400
Message-Id: <20200615202125.27831-2-nitesh@redhat.com>
In-Reply-To: <20200615202125.27831-1-nitesh@redhat.com>
References: <20200615202125.27831-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a realtime environment, it is essential to isolate
unwanted IRQs from isolated CPUs to prevent latency overheads.
Creating MSIX vectors only based on the online CPUs could lead
to a potential issue on an RT setup that has several isolated
CPUs but a very few housekeeping CPUs. This is because in these
kinds of setups an attempt to move the IRQs to the limited
housekeeping CPUs from isolated CPUs might fail due to the per
CPU vector limit. This could eventually result in latency spikes
because of the IRQ threads that we fail to move from isolated
CPUs. This patch prevents i40e to add vectors only based on
available online CPUs by using housekeeping_cpumask() to derive
the number of available housekeeping CPUs.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5d807c8004f8..9691bececb86 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5,6 +5,7 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 #include <linux/bpf.h>
+#include <linux/sched/isolation.h>
 
 /* Local includes */
 #include "i40e.h"
@@ -10933,11 +10934,13 @@ static int i40e_reserve_msix_vectors(struct i40e_pf *pf, int vectors)
 static int i40e_init_msix(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
+	const struct cpumask *mask;
 	int cpus, extra_vectors;
 	int vectors_left;
 	int v_budget, i;
 	int v_actual;
 	int iwarp_requested = 0;
+	int hk_flags;
 
 	if (!(pf->flags & I40E_FLAG_MSIX_ENABLED))
 		return -ENODEV;
@@ -10968,12 +10971,15 @@ static int i40e_init_msix(struct i40e_pf *pf)
 
 	/* reserve some vectors for the main PF traffic queues. Initially we
 	 * only reserve at most 50% of the available vectors, in the case that
-	 * the number of online CPUs is large. This ensures that we can enable
-	 * extra features as well. Once we've enabled the other features, we
-	 * will use any remaining vectors to reach as close as we can to the
-	 * number of online CPUs.
+	 * the number of online (housekeeping) CPUs is large. This ensures that
+	 * we can enable extra features as well. Once we've enabled the other
+	 * features, we will use any remaining vectors to reach as close as we
+	 * can to the number of online (housekeeping) CPUs.
 	 */
-	cpus = num_online_cpus();
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	mask = housekeeping_cpumask(hk_flags);
+	cpus = cpumask_weight(mask);
+
 	pf->num_lan_msix = min_t(int, cpus, vectors_left / 2);
 	vectors_left -= pf->num_lan_msix;
 
-- 
2.18.4

