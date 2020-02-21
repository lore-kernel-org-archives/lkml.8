Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF283C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECF3206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J41etYRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBUWmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:42:33 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50023 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUWmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:42:33 -0500
Received: by mail-pg1-f202.google.com with SMTP id u14so1955380pgq.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 14:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AYMrtaQFpEAhf4N2/PSLyY8BVuR8zCZktSQFDW5VeUU=;
        b=J41etYRpVeAqdqvHtns7EtNVVbjYCZAT4uPwTfXxmVxBP1EywH9V7naMIWd8JKOJSi
         K7Wn5PluMFO1qq21ZIL07fltzyJR/7kmvXNlng5dPs2SQ8GpoYrGYofV1WWHdxo3ts8x
         mrzNRWXAy2ANyWXWY9qp1ZADnIWwUhGpXShQ8UJAjBuePE7EXawDC7WOrps0GlX3lhfW
         nPR40Ce5lQAJwEmjc+x6h5EAsEP3JLWMUmEnEQA3zfzLNt9/C01LO/6l+IPk1wNCwsxz
         tNV/VKd+lyqLwVRLzzhKr/fkvAgWtgSWZREkCmpno7vHpmkwqywbD+kq5YMkBGM5Is2n
         4Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AYMrtaQFpEAhf4N2/PSLyY8BVuR8zCZktSQFDW5VeUU=;
        b=cscn3JcB9/KUEJWki6xwBTJZKkbDLtv50mjgeukTo5FVc4jGJlc54DmE3E+Z3D+Jbf
         KMbHtxMq2BTurrvL3SL8xmEU+XgXYimTN9bgHLyGlvyMXLi3FsF9+vzsv2N5Co0cV4Sg
         pIgAvuywMZAObf2A9IOAh3O//EKtMmh47RIaROzY4EMHo5PucEvpp4AFGKkjz2ef5TwY
         +ec/WUpRgGJAXoiNnx/kZT/eXL3sdMKMRupc70O4mBSlMhovCem4q2s3ARXXPrhmTLfB
         +pTkJ87VKCxiVHgM5jxXO8voWbyO01J4c9jtBDJ4QXfU0hhwCQJOMOgFNrOgVLSei2Qh
         yVqw==
X-Gm-Message-State: APjAAAUBhmdScI0gMShdupZh5Yy3792aQsD1yQ0pCi2ef/DGa/eOVvzz
        vZpxq43NQH5xpsME46OvMkfqluDqC47MwtE=
X-Google-Smtp-Source: APXvYqwhKRzJVoCpjzPLGuzmWUd8MIiF3zvv55ptCrBdix9MKGePuOLZi4sMXv45LyYtWbbT5/yE8lmhWXoMIAI=
X-Received: by 2002:a63:aa07:: with SMTP id e7mr40537889pgf.90.1582324952547;
 Fri, 21 Feb 2020 14:42:32 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:41:33 -0800
Message-Id: <20200221224133.103377-1-ehankland@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [kvm-unit-tests PATCH] x86: pmu: Test perfctr overflow after WRMSR on
 a running counter
From:   Eric Hankland <ehankland@google.com>
To:     Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Eric Hankland <ehankland@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that a WRMSR on a running counter will correctly update when the
counter should overflow (similar to the existing overflow test case but
with the counter being written to while it is running).

Signed-off-by: Eric Hankland <ehankland@google.com>
---
 x86/pmu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index c8096b8..f45621a 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -422,17 +422,34 @@ static void check_rdpmc(void)
 
 static void check_running_counter_wrmsr(void)
 {
+	uint64_t status;
 	pmu_counter_t evt = {
 		.ctr = MSR_IA32_PERFCTR0,
 		.config = EVNTSEL_OS | EVNTSEL_USR | gp_events[1].unit_sel,
 		.count = 0,
 	};
 
+	report_prefix_push("running counter wrmsr");
+
 	start_event(&evt);
 	loop();
 	wrmsr(MSR_IA32_PERFCTR0, 0);
 	stop_event(&evt);
-	report(evt.count < gp_events[1].min, "running counter wrmsr");
+	report(evt.count < gp_events[1].min, "cntr");
+
+	/* clear status before overflow test */
+	wrmsr(MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+	      rdmsr(MSR_CORE_PERF_GLOBAL_STATUS));
+
+	evt.count = 0;
+	start_event(&evt);
+	wrmsr(MSR_IA32_PERFCTR0, -1);
+	loop();
+	stop_event(&evt);
+	status = rdmsr(MSR_CORE_PERF_GLOBAL_STATUS);
+	report(status & 1, "status");
+
+	report_prefix_pop();
 }
 
 int main(int ac, char **av)
