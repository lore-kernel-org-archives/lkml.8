Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1797C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA0A20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956273;
	bh=5nkV7eDi5Bx2nfm80C2yfyXLGRKXoar9TVzuNHHDrnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNdqt/hfLvZ5W/m7zQhz0jP3TXY4W8/V+yM/chMy0C3kKw1jCkz3fzj6dAPZT421Q
	 WrNJlVSRNzqysffq9PoPvIpXjcmuOBcgSd9oDx4bJePV5z3xgk/Qy76IvPFNNFitBD
	 Gg03gsuJOJ06wtXFLmxZBxwlUzkrSwUw2p6BLNT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506080AbgDONLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897070AbgDOLfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2706A2076D;
        Wed, 15 Apr 2020 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950539;
        bh=5nkV7eDi5Bx2nfm80C2yfyXLGRKXoar9TVzuNHHDrnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvE3ET8DbF6V4BOsCMJJsWdBSHgZzBDcHGClpCcl9aD5FZaxzGvTnlZWLS9a8sU1z
         G30ayAlDwoiLxT1ToGL5j0zntPS9IdWG9uujSbpZzTJcrOY4MDY2ZzdiB5KzikCA7E
         MNtNSwZyTxDXIwsOx46joD2SuFLPyU/SY2OzObyE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 047/129] s390/cpuinfo: fix wrong output when CPU0 is offline
Date:   Wed, 15 Apr 2020 07:33:22 -0400
Message-Id: <20200415113445.11881-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 872f27103874a73783aeff2aac2b41a489f67d7c ]

/proc/cpuinfo should not print information about CPU 0 when it is offline.

Fixes: 281eaa8cb67c ("s390/cpuinfo: simplify locking and skip offline cpus early")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
[heiko.carstens@de.ibm.com: shortened commit message]
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/processor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 6ebc2117c66c7..91b9b3f73de6e 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -165,8 +165,9 @@ static void show_cpu_mhz(struct seq_file *m, unsigned long n)
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	unsigned long n = (unsigned long) v - 1;
+	unsigned long first = cpumask_first(cpu_online_mask);
 
-	if (!n)
+	if (n == first)
 		show_cpu_summary(m, v);
 	if (!machine_has_cpu_mhz)
 		return 0;
@@ -179,6 +180,8 @@ static inline void *c_update(loff_t *pos)
 {
 	if (*pos)
 		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	else
+		*pos = cpumask_first(cpu_online_mask);
 	return *pos < nr_cpu_ids ? (void *)*pos + 1 : NULL;
 }
 
-- 
2.20.1

