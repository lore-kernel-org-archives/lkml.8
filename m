Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EF0206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586252;
	bh=9CtMykP6oJ+nIhNvBvmA2uj0QvW5lXqLZxmIqM3j2LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e80b3yOncZNHL0OX7GRyjXGDCiPRysr9t4oEvzuB1d+j2VBcqQMw4dznvopHXxY3n
	 OTGuQ+XX2u0h5/gkATsxqkqBbNf2Ru2y7vsDpc5Q3ZKIZ1DLslFeAIb1t4rJSy/IzD
	 s/L9G2zwdXmx7tn+/3Kd1vtKEpO0dIQthtds8opc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHEAKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgHEAKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F8E2177B;
        Wed,  5 Aug 2020 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586247;
        bh=9CtMykP6oJ+nIhNvBvmA2uj0QvW5lXqLZxmIqM3j2LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFdlGbxcrbp3270MlGfrZ8Q+siwyz1R42hHyJdi5IiHA8/xQOw4reIJor3tFnH+NV
         aKzgNKqBvMcKTIcH4WUuxqsQLBvay6HXgUZhUVQUTccTG58/PuDCiKmYEXFpeGV7YG
         VDE++BowBLkgjH98NeqegIeXwOcrFft6Zp6MgX9w=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 01/14] tools headers: Add kprobes.h header
Date:   Tue,  4 Aug 2020 20:10:30 -0400
Message-Id: <20200805001043.3331907-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now needed by liblockdep as a result of 2f43c6022d84 ("kprobes:
Prohibit probing on lockdep functions").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kprobes.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/include/linux/kprobes.h

diff --git a/tools/include/linux/kprobes.h b/tools/include/linux/kprobes.h
new file mode 100644
index 0000000000000..f665725ea4d59
--- /dev/null
+++ b/tools/include/linux/kprobes.h
@@ -0,0 +1,7 @@
+#ifndef _TOOLS_LINUX_KPROBES_H_
+#define _TOOLS_LINUX_KPROBES_H_
+
+#define NOKPROBE_SYMBOL(x)
+#define nokprobe_inline
+
+#endif
-- 
2.25.1

