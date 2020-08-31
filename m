Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881D1C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5612083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897302;
	bh=O68wm3njlg+8X7DYUq157S0m3ytqa94CGoqfH9FWrWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvOp06V8O4fOmSIj7bVdGXJ3XBrugPVio+76fTj6Zmb6Nt8t1byAhQP6Sw6VRQ7gu
	 UekD/0YuOSDp+v2Mj8+2d5bsKuLl3OfEhP5q2ThoUxwPOUkd7XQ7e/AsU6A3PaiMzz
	 /wlL01uhtliL1OvJ8KtiQjgPYElK0WSUq7oFQ1Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgHaSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgHaSH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F2B21707;
        Mon, 31 Aug 2020 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897275;
        bh=O68wm3njlg+8X7DYUq157S0m3ytqa94CGoqfH9FWrWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dH3R9vvPgpi2t84qI1DrwIBT5r73lMnlz38DN9bCR+yKcIs2YvBRlHQsJ6PWFGK+0
         mVPI17TRlpJomf4Ss7ju9YQm11rNWp/B3wXLyvp17Wu9Gp8+OOkv/rskRoQnwnBQMk
         Yw68vyDngn6oNjggP0CCA9D05cEWHQa1WGj7QsPo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/19] scftorture: Adapt memory-ordering test to UP operation
Date:   Mon, 31 Aug 2020 11:07:47 -0700
Message-Id: <20200831180749.843-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

On uniprocessor systems, smp_call_function() does nothing.  This commit
therefore avoids complaining about the lack of handler accesses in the
single-CPU case where there is no handler.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 04d3a42..fc22bcc 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -363,7 +363,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_out = true;
 	}
 	if (scfcp && scfsp->scfs_wait) {
-		if (WARN_ON_ONCE(!scfcp->scfc_out))
+		if (WARN_ON_ONCE((num_online_cpus() > 1 || scfsp->scfs_prim == SCF_PRIM_SINGLE) &&
+				 !scfcp->scfc_out))
 			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
 		else
 			kfree(scfcp);
-- 
2.9.5

