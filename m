Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8268422464
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194553;
	bh=GJg5Ss8w/jtXi8ZrDM5x3sy3AcMV7TgHDv0CV5c2IoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+RO1ZLYe72swBV6zciuJUnqDqYcDlU+csQ7mpoTcvqodkUfMkJu0M2O4WzyNhkJP
	 iJPP/smclKaSMDPgVXP+Dl9Uk3i0Q8GhWybRQaPcZDtj7xOMPCTT9Nykqc68i9cNFJ
	 wPVAHLuP/lzxRwSbHVvbmpoeGGiNfA9p06N+Fzi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbgAPRJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389610AbgAPRJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7032192A;
        Thu, 16 Jan 2020 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194549;
        bh=GJg5Ss8w/jtXi8ZrDM5x3sy3AcMV7TgHDv0CV5c2IoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXXs0T7CkW3xtL95/mJWNtql4aZn+HfaywEFye0AKRYuHQyBN6V3SCD+6RjSE+V3B
         Ok05qXYxDgLH6fIGnvbz7BmWWZt6B2jkYFVuWdhnLGEdCbFZschdk1dxWjvJj4YfcV
         A8Gm4VfHzeuLtALURN51zr8mPaS6V38u/dVPGJkc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        mpe@ellerman.id.au, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 432/671] perf/ioctl: Add check for the sample_period value
Date:   Thu, 16 Jan 2020 12:01:10 -0500
Message-Id: <20200116170509.12787-169-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

[ Upstream commit 913a90bc5a3a06b1f04c337320e9aeee2328dd77 ]

perf_event_open() limits the sample_period to 63 bits. See:

  0819b2e30ccb ("perf: Limit perf_event_attr::sample_period to 63 bits")

Make ioctl() consistent with it.

Also on PowerPC, negative sample_period could cause a recursive
PMIs leading to a hang (reported when running perf-fuzzer).

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.vnet.ibm.com
Cc: mpe@ellerman.id.au
Fixes: 0819b2e30ccb ("perf: Limit perf_event_attr::sample_period to 63 bits")
Link: https://lkml.kernel.org/r/20190604042953.914-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 751888cbed5c..16af86ab24c4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5012,6 +5012,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (perf_event_check_period(event, value))
 		return -EINVAL;
 
+	if (!event->attr.freq && (value & (1ULL << 63)))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
-- 
2.20.1

