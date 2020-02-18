Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32704C3402F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A1215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993712;
	bh=gW215AqnCmv+ZJwRViyZ6q+3vb5MXtzVyhaAOAfQf3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rdMXK9xDy9v8p+5DqW+v/jxUCMZcJppkh8pDUpFk23BstTxkE5JgDdyOoplU3S6Dk
	 leuAi2YPNFX7cmFpF51ZJKTsPNifrd886u7BEr6nKwAnaYtEdUZYVK7O9XFCt/Ai/M
	 S3gn+MSDG6w7/JB1iUySi0QZapWm5+t/r8k8w9gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgBRClv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgBRClr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701C620836;
        Tue, 18 Feb 2020 02:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993706;
        bh=gW215AqnCmv+ZJwRViyZ6q+3vb5MXtzVyhaAOAfQf3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7er++0rSPAdEFhpTuy7XQq0tZ/+GhQ/Vke5dvm/uXmM4a3XT6qQByDH345sGvm0y
         fDj+eHu/BiYfFtVa/b65hoqWYGE47Tu106klc1fwuLmeLQoMRq80JHWROtPKH0JF37
         RrqEdodgf3JMKEe1gBCB2e4/S5n9o7a7F1TV2AyI=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 03/11] tools/kernel.h: extend with dummy RCU functions
Date:   Mon, 17 Feb 2020 21:41:25 -0500
Message-Id: <20200218024133.5059-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These calls were added by 108c14858b9e ("locking/lockdep: Add support
for dynamic keys") and require no special handling in userspace, so just
add empty function definitions.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index cba226948a0ce..d2b3e1cc0218e 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -119,4 +119,11 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
+static __maybe_unused int system_state;
+#define SYSTEM_SCHEDULING 0
+
+#define might_sleep()
+#define rcu_read_lock()
+#define rcu_read_unlock()
+
 #endif
-- 
2.20.1

