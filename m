Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7329207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872705;
	bh=bxCEDRw32u/YT7FVuHrHNITGz+a3/RkkJWS2H7K9+TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BpdHm2YrBzSNNFOhhqEURDgpQw/aCMSH2BtQJssTvihpLVqCnmF5Odso0Xbo0a81W
	 jAwe+Ibv/mFZWlxSUWmHPvoSbqnsgJ4GBaaKc0uKm/rAaYnCavxZZpUJIaZTPRDN0R
	 nkWOLn1jhI/2TAceF6u9hDlb4FpdfDH8UXAqGBBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgFWAiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732170AbgFWAh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FBD214D8;
        Tue, 23 Jun 2020 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872678;
        bh=bxCEDRw32u/YT7FVuHrHNITGz+a3/RkkJWS2H7K9+TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLszvU73cl+VAA9/dGm9TPHyE5hYCvDr2fQc5/dOafBbc5757Q0Vk6W4vsSRxSKTK
         kJgnYSo/N45wmuwdVhUWF98upEpzzjvxLok8j5zN0zIxe44ZMFX56R0Xmsr4SHu/7v
         0QKyqQ7yKgyySzPYukDDiTE+ogv56c/6nCk8yRmo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/23] torture: Remove obsolete "cd $KVM"
Date:   Mon, 22 Jun 2020 17:37:51 -0700
Message-Id: <20200623003752.26872-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In the dim distant past, qemu commands needed to be run from the
rcutorture directory, but this is no longer the case.  This commit
therefore removes the now-useless "cd $KVM" from the kvm-test-1-run.sh
script.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 484445b..e07779a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -124,7 +124,6 @@ seconds=$4
 qemu_args=$5
 boot_args=$6
 
-cd $KVM
 kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 if test -z "$TORTURE_BUILDONLY"
 then
-- 
2.9.5

