Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C93C38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C1821D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587261484;
	bh=gW215AqnCmv+ZJwRViyZ6q+3vb5MXtzVyhaAOAfQf3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tSGF+oh5LDzfTVdMRquNFf+GdQldG6SViiSsk+tfhnAYDlSSSHdUnDNXBbCgudgkY
	 SA2yDkBMtSvuKbf5tRZe0qxN7JLviYVJa07R21cOFuAZxBtQMNH5TY/1aHYQCsmKAy
	 3XMNVLXjflnjhmHEE10KXYEpA6v00Ch4IA0W9qwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDSB6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgDSB6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A01221E9;
        Sun, 19 Apr 2020 01:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261481;
        bh=gW215AqnCmv+ZJwRViyZ6q+3vb5MXtzVyhaAOAfQf3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAlEJORU7VzatG7ChHzTI7fwgCwezXYCm3Q88OeXLQsNB1ozVrea6JmSLGflLJB/y
         mFO7YLbeGNxMOo7CXhnMkoQidvcZ8DlNSj/56CYj6hKUZeYkiWC76PpR8Ed6dD7nII
         N9eMaQbFgEfMsOdqAy1SF8tSCsfW2s29tWhMSEVY=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 03/12] tools/kernel.h: extend with dummy RCU functions
Date:   Sat, 18 Apr 2020 21:57:45 -0400
Message-Id: <20200419015754.24456-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
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

