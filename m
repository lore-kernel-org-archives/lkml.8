Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E97C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF0A20738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586298;
	bh=ZG0oMv+HAmfDvF6gKBVrwMs/TY/KDebSAxhQTCOFCJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XyvA85uLySe7rz40+Si14ayZBUE9NRcpYKxyS8/iwMWOAnKXb+8KBuyhnwdfn02pY
	 HbBvOWdiprAaaz9BIQ8n4QK4czXFcCD8BkddkxXRwBv6/uDjWdYcyiMLvWsQmrM0zu
	 h+wi7qSLYH7+KH8CFWrv5m1tY7QF6Gp2jfTa/DpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHEALg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgHEAKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377AE22CB2;
        Wed,  5 Aug 2020 00:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586248;
        bh=ZG0oMv+HAmfDvF6gKBVrwMs/TY/KDebSAxhQTCOFCJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCFzfMrXiUAktqoUvo1TrakZ1jX/Hiq5FbAB/HngkgLWCda/6vDhxXVLcfdkn5wuD
         IJa25u3QWX3sMK5Y+UW/lfR+r5zqZEmDcfx96LF/ugXU31jF9VGiNFNzKtvC+pzmSt
         hw2VcPyZo1jw4NjXKatxvGG+kmQcUlb1Rq5a8UCs=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 03/14] tools/kernel.h: extend with dummy RCU functions
Date:   Tue,  4 Aug 2020 20:10:32 -0400
Message-Id: <20200805001043.3331907-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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
index a7e54a08fb54c..902d3b9ab4c17 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -117,4 +117,11 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
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
2.25.1

