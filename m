Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29404C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E719320836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064284;
	bh=s8x98rN3JIFXforeIZi6fVqHqm3rsPtMjmu01QfsNfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t03j2wD9BnRtBDd4hw7aRZlMy5rlTXAeuTQIIjTWCZ06eW0RrDUIytPbmVwWFTHx6
	 n7Z1UlmfFob3nIaP94RgtoySxEs1+nqDz2JR6OROtZVD4bEffixjehi1VR50ohrfiQ
	 E/3VcxmknOG1F0r6JbBvv1zR/x9a/75G2aaMIHvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgCXPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgCXPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:33 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E9220789;
        Tue, 24 Mar 2020 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064252;
        bh=s8x98rN3JIFXforeIZi6fVqHqm3rsPtMjmu01QfsNfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBzUO2WGI5lj7iwjFs8aSh+KQqoMKFYHe90bplIwTE4gioxy+X25SSJLiJoCNjbka
         JDsmyp6svbZTccZH2vARyX1NXmdry8evOEje8IzAtXp1X7NQ2rh/Huu9fvSkxKBSGu
         YhnooLqeg6ja2dhQBNpJp/ipNv7JCu9VGBjLhF5M=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: [RFC PATCH 17/21] linux/bit_spinlock.h: Include linux/processor.h
Date:   Tue, 24 Mar 2020 15:36:39 +0000
Message-Id: <20200324153643.15527-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for cpu_relax().

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/bit_spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..505daa942527 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/processor.h>
 
 /*
  *  bit-based spin_lock()
-- 
2.20.1

