Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DEC3402F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD3B215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993725;
	bh=vMUdywOiH45RYm8rBBrCFHjXlKwxhw+nAnJjls5FQRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYN5MgkCnAaIklmF17x6+Sni636p5qbqL95H/ReeVeVCKRND02HqgKXxJoSNOy2GF
	 KmxP/IeeisQRO50Ht5NKiqY2+29f3V6fl0Np8I2MOSS7ZTQ0xf/g7xMyPUCwXJKowf
	 SHXWoDQhPltgEoKploCN0nyWJoF6kC831mgqkvII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBRCmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgBRCl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50BA621D56;
        Tue, 18 Feb 2020 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993716;
        bh=vMUdywOiH45RYm8rBBrCFHjXlKwxhw+nAnJjls5FQRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REeJovLfFW0zPwWD9zjCO7AUcTwEnBE/gCyQliKeMzr+1Nt2iUImCoQeH/dKP9RXr
         ABeEpoBu4GXje5NcT39VRg6d2vJopMXVdEPg0cOg+7QqIk3gs71e58sdxngcBYMtXn
         gOpQ2Lb/RH2nsEkNOkMk0UFtlM4Sr1vxVZGoXoVs=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 10/11] tools/lib/lockdep: New stacktrace API
Date:   Mon, 17 Feb 2020 21:41:32 -0500
Message-Id: <20200218024133.5059-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel switched to using kernel/stacktrace.c, and the API slightly
changed.

Adjust it to make stack traces work again.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/stacktrace.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/linux/stacktrace.h b/tools/include/linux/stacktrace.h
index ae343ac35bfa7..b290b98d883aa 100644
--- a/tools/include/linux/stacktrace.h
+++ b/tools/include/linux/stacktrace.h
@@ -15,10 +15,18 @@ static inline void print_stack_trace(struct stack_trace *trace, int spaces)
 	backtrace_symbols_fd((void **)trace->entries, trace->nr_entries, 1);
 }
 
+static inline void stack_trace_print(const long unsigned int *entries, unsigned int nr, int spaces)
+{
+	backtrace_symbols_fd((void **)entries, nr, 1);
+}
+
 #define save_stack_trace(trace)	\
 	((trace)->nr_entries =	\
 		backtrace((void **)(trace)->entries, (trace)->max_entries))
 
+#define stack_trace_save(e, m, x) \
+	backtrace((void **)(e), (m))
+
 static inline int dump_stack(void)
 {
 	void *array[64];
-- 
2.20.1

