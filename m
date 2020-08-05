Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3706C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDAF22CB1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586251;
	bh=WXTjaO/GWX+4a+95F2PVE95dKGK8yFuYV1kK1j13JUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TjF10jCyKflpNBliDjXb0YTGWlH1yOOMvwI46zBIu2v8b1iR1bZtQGeBW5V+G0gY7
	 ZosDiOGNsrDEfV07O9noPreHA3SY3L7gpvfLa16O2K/8Oq6eo3eEN8iHLwR1xqMzGf
	 KKMp9c7ru4JhAp4h+6lASc0zkOgUprkjyF/hAYsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgHEAKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgHEAKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFA922CA0;
        Wed,  5 Aug 2020 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586247;
        bh=WXTjaO/GWX+4a+95F2PVE95dKGK8yFuYV1kK1j13JUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8tPZ5aPc/Y9AaEwHcmxSs9UaQZdWCiz+4EUTBR977mDDnj2cpTgF+3xvfF7iKpE7
         s1yr2AvqHwBEG2+YaM7bGX/BUhZ6UduY1VtI0Pwa8SEpUYcP3WSAnd4F1dgOSpzl4Q
         otr5FxKm22KT5BOlrOnIYWRoS5uCxcD3vPOmAgTI=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 02/14] tools headers: Add rcupdate.h header
Date:   Tue,  4 Aug 2020 20:10:31 -0400
Message-Id: <20200805001043.3331907-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now needed by liblockdep as a result of a0b0fd53e1e6
("locking/lockdep: Free lock classes that are no longer in use").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/rcupdate.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tools/include/linux/rcupdate.h

diff --git a/tools/include/linux/rcupdate.h b/tools/include/linux/rcupdate.h
new file mode 100644
index 0000000000000..1b7abc86f4336
--- /dev/null
+++ b/tools/include/linux/rcupdate.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LIBLOCKDEP_RCUPDATE_H_
+#define _LIBLOCKDEP_RCUPDATE_H_
+
+#define call_rcu(x, y)
+#define init_rcu_head(x)
+
+struct rcu_head {
+	char dummy;
+};
+
+#endif
-- 
2.25.1

