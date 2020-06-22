Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D28C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9CC2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865841;
	bh=WXTjaO/GWX+4a+95F2PVE95dKGK8yFuYV1kK1j13JUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AkuITBuJqfJHn2kFmY2NnOEVja6DrclqHnVgGkBQlDbcfGxmEOn/2gPB59Sb6me0X
	 CGngBPxaL12Kzegu4/AjsPFjZUGCzu4sIou3qrJIL9TN9Y3hE4GEp5KBJSZZg5GVHN
	 VYC9+gKMMl9ZmLb4uCwFugvSRjTQ/HRzQTu5lGiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgFVWnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbgFVWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C815720786;
        Mon, 22 Jun 2020 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865784;
        bh=WXTjaO/GWX+4a+95F2PVE95dKGK8yFuYV1kK1j13JUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaXx+6eSfGYLiiHYkg3kSx2wFywLxOwzl8MmoOZVUUEqtZJCbPGZF+vo4gmHCbo4I
         Uy3cCzBu8V4+0eA+HaudBF+FUzj0cmi2Y/Q3mXPzBQ3BJoQY6j6p8r332KAuZ7RCTV
         vbPe1HYz7FNsQzRJQXxMYVjkuwnMdl7Dj6TDjJcQ=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 02/14] tools headers: Add rcupdate.h header
Date:   Mon, 22 Jun 2020 18:42:46 -0400
Message-Id: <20200622224258.1208588-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
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

