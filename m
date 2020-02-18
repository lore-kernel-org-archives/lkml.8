Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E1C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4417215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993709;
	bh=GDyB1o+3rEe/BJPQXo2Mz8NKN/OqEpXbpdHB030RUxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WqatsrYmXISufA3ZbxNA7AtbeEeNvQfaSBFk0N2fs4ZfnVqmztZ7jtPlm0GzTKrT
	 jtuwcTTR5yScoGBE4JSoKy/xgVScPv3uuOZJSOy5APeXLJlUUJJFYnnK+FP+eYjBXT
	 aLB8KxVZhc5yYDWmdNQpC4bWMWxrw0EnekqGOT8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgBRCls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRClp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F42721D56;
        Tue, 18 Feb 2020 02:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993705;
        bh=GDyB1o+3rEe/BJPQXo2Mz8NKN/OqEpXbpdHB030RUxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvDd21kfA+oSbvwMWN0w4+9PaUgtC0rjDFtsuCT91NBc5iRtUzmyspI1/c++ToOZL
         XEfEJj2GbIr87mSB+8KxQs+aJiroPTLK3mk3b1PHNGzp2J3s1FFhNFDTB70lmlXYrH
         LEjKIHBWQLQKCDi2spbXxlpU0zIWoZS7r2lBgwFc=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 02/11] tools headers: Add rcupdate.h header
Date:   Mon, 17 Feb 2020 21:41:24 -0500
Message-Id: <20200218024133.5059-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
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
index 0000000000000..100e6edb54af1
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
2.20.1

