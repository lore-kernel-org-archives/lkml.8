Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9957C3402F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C22215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993707;
	bh=gyswfYZtdXPqF+LXQGoN3Io3M6E6chIV97t2MjFPJR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8cMi3gwGD6Kj4zr1BsR09jUTi05depjmcoyCz2PDLoDi/zhpDvLb9dU1WBlwn930
	 vFT3hzl7bBXPx1W89HKztZDcuhN2b5SaARwiGKmm0/GFjXfUnIzNhpR4/FRBqUkrAH
	 xCdPgqdpBNUUCfv4JCEgCx1s4rYf/ZRADZYpH+Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRClq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgBRClo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D1C2176D;
        Tue, 18 Feb 2020 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993703;
        bh=gyswfYZtdXPqF+LXQGoN3Io3M6E6chIV97t2MjFPJR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjEPAfaio/kyLqE8KajiFeFGWcfAfhZAghtE0izK2L8l6evUqT1atzBlQZqihotWJ
         yFlMU2cropKesXfoZOghMcvKQtQpOCbb9ofR4Ajk3sgGDbx7bgFUCRF7MtxTJVnJ7i
         w/S9UK5GRhbJGvrCugIVR8PKSPQMiOIdDDag4a3U=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 01/11] tools headers: Add kprobes.h header
Date:   Mon, 17 Feb 2020 21:41:23 -0500
Message-Id: <20200218024133.5059-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
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
2.20.1

