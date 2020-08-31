Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9E1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3802083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897126;
	bh=X+Gfo49GgR55lBjvGR+id3dRzylSAtZ6yU+i1JNWHCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrOvNbBax5jPCc2qCvbhNRnFgozHv6fJoXTNpT7dDDF1kCVXCyNyXNi/4b0XAgCpe
	 TNTj2as0dXz94XDSqYWDucdfrc3nC9sxQkUkf8mVSgx18Uo9xpw1Dc/CRjIK3lUnNM
	 +nZdlcJbBDyJ1xeWxzA9OpzG+eGIC/2dxOoQ/wo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgHaSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgHaSEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:09 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8871021527;
        Mon, 31 Aug 2020 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897048;
        bh=X+Gfo49GgR55lBjvGR+id3dRzylSAtZ6yU+i1JNWHCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGfPICwUz4+G3P6HuIc8g6oQIYpPPRxLr1koyqq9yyHkh2hF8nO/3NeLj9R0MuKWg
         49K41DeA4hoe2i/KOXJwfasEvevM6cIITLvsZBOuC1vdwPGv2hVPQIYxkMxSx30mW7
         Wt6vZcO24Eo0pzCaWyoTfqtBHH9EhoDat9O2LSTY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/14] torture: document --allcpus argument added to the kvm.sh script
Date:   Mon, 31 Aug 2020 11:03:55 -0700
Message-Id: <20200831180406.494-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e655983..0a08463 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -46,6 +46,7 @@ jitter="-1"
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
+	echo "       --allcpus"
 	echo "       --bootargs kernel-boot-arguments"
 	echo "       --bootimage relative-path-to-kernel-boot-image"
 	echo "       --buildonly"
-- 
2.9.5

