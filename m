Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F8CC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70332084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMaPXvTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBDBZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:25:10 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:42653 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDBZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 20:25:09 -0500
Received: by mail-pj1-f73.google.com with SMTP id hi12so839657pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 17:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QUGZT2MVbSZ5vv9JAqfeam9eYCtpwd6NYyrPTQGL4Vw=;
        b=LMaPXvTVHWRjR4OY/kwNL2KfAHa8UpJCbQ0fB/vH0vTkR8weS3+o9HmWUvxODuRA4v
         9eGAqaftuBVncplz+Wug33AL9+V/WCN7uk+FPQfHd5+A1AsXHSPQlSeQaweYV0uSixD2
         +R7y90zPyGDs/57TAHOvUZrRDaToG9qNnQvZcYcBx92QXf7LzAJPBkrN8fwwAWzqO8xR
         z2+Fz4CR8lpoCEsdkzQo+V70TvTVhNfa5MSC3MpGeLYmhY9RxuxWO7+JNbPLoS67HTNK
         OLQ4bDNxSF/Zyg0ujWp5pA9GN9o3W70W9mJr4rJmiqr3bu4xFkH4ZeZl4YSzsyVQymwL
         IFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QUGZT2MVbSZ5vv9JAqfeam9eYCtpwd6NYyrPTQGL4Vw=;
        b=VwUPI1VjGOdzrRnkndu8cv8x2tQwc6TdAf5lEakcgvsFwTqmHYdKXsGWleTLEK1ljC
         0HTQ9/CcZmR1u/3IDrMr94XLzSplgjIDRVdn22B0UYl+eAynTt/qW2SSlqvQsRwbciKn
         OON1DUIKqsMFf0ez1cuERePoGgCujp4dnIvHABdd6guX9JoTBR1Fcgt8KFgwYozIP0A/
         qYhPf+jQ8hbuGYtOc8TTIZAVDHOpTV2O912gdk1BJ2dbWZ1xC+a9wDIbeyG/jAl56cpl
         9+LF2dg1QYHF2g3N7AJDoGs5IEJkdl+L2tQRLq55IM4xA1nrH7usC0DyET93gQeOlLM+
         61dQ==
X-Gm-Message-State: APjAAAWULwN0e/8PsofURn9NQpqFWB9FoY16PwlD46ZwkMYwAcoXGUHE
        LgQeJpLnXhFL8EndOTycZ5hugcY8lcUu6hk=
X-Google-Smtp-Source: APXvYqyOkoVhkCWzz0zCy43+eQxoSu+yTApt3/SxLxfSIAKMDlDHWIT8cwq3rPNiC0x1HQmUNKFf5+CNs1BjSLo=
X-Received: by 2002:a63:cd04:: with SMTP id i4mr20017956pgg.281.1580779508971;
 Mon, 03 Feb 2020 17:25:08 -0800 (PST)
Date:   Mon,  3 Feb 2020 17:25:04 -0800
Message-Id: <20200204012504.9590-1-ehankland@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [kvm-unit-tests PATCH] x86: pmu: Test WRMSR on a running counter
From:   Eric Hankland <ehankland@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Eric Hankland <ehankland@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the value of the counter was successfully set to 0 after
writing it while the counter was running.

Signed-off-by: Eric Hankland <ehankland@google.com>
---
 x86/pmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/x86/pmu.c b/x86/pmu.c
index cb8c9e3..8a77993 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -419,6 +419,21 @@ static void check_rdpmc(void)
 	report_prefix_pop();
 }
 
+static void check_running_counter_wrmsr(void)
+{
+	pmu_counter_t evt = {
+		.ctr = MSR_IA32_PERFCTR0,
+		.config = EVNTSEL_OS | EVNTSEL_USR | gp_events[1].unit_sel,
+		.count = 0,
+	};
+
+	start_event(&evt);
+	loop();
+	wrmsr(MSR_IA32_PERFCTR0, 0);
+	stop_event(&evt);
+	report("running counter wrmsr", evt.count < gp_events[1].min);
+}
+
 int main(int ac, char **av)
 {
 	struct cpuid id = cpuid(10);
@@ -453,6 +468,7 @@ int main(int ac, char **av)
 	check_counters_many();
 	check_counter_overflow();
 	check_gp_counter_cmask();
+	check_running_counter_wrmsr();
 
 	return report_summary();
 }

