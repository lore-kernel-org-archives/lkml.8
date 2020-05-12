Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E92CC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6464B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gr42BgPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgELItL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgELItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:49:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4DBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:49:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so5469527pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t97yRHpmHo8412WgRauzgIXQjp1lspYvNliDKxac5o8=;
        b=gr42BgPt6fH1p27tOaC1DScaH67NkLMkrYxnzMUkrwYYxLwiu82+rNiSSDGp3LwtAf
         hbp0nI1k6l7eH5+YKzgzpxDEcKZlxPutlQxWNVN4Qucn/LIppB45rD9wuVYlDvTGoQJu
         ndVN221ndSVWUvbDeG4Y79IeH2z6kM4dvFBw4QYVKWN6y+3AezfVpySHgx92JlXnhWlL
         KszvYITck8HhhV+vrhuht1XSRcDsG+6irVnuQmdqhXe8UaUrmgPdHVBmnasfWeX8Y6gN
         CuU8qoiZ7Kh3OwrURwe7lYJGIdVtdoTwCV5PANs0mlje4XGdNQ1JamoBm8AZ25pp/7Pa
         pNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t97yRHpmHo8412WgRauzgIXQjp1lspYvNliDKxac5o8=;
        b=oJDzCJ2su4SY5wyp76zuKkKnW/NZXmNRf7+MPTvfWoxvxrKMqFZOiOSAXMP5VQP8A3
         PHOTZR3O8p3LVMG1/9ZR2b6VDUj9d44qME3FNVPJC04q0qQrcDHU3nnBPwsBosrLUYHO
         qFaqilibJosuuM0HXzH8O59x9pgYaGfIXwBDuj3mXDbpcuKU3KDGOzfYHVpDMeb409aZ
         yGl5QLbZi86WKxX26zejlKnZJePl0dXVrP4aWBIR9sTVS+17CIvJ+PP/z2PlQloK8tI+
         0O0mWEwuxti47sZhLdShgPR9S1HmVRErsznoxuCSWLIkTDX/y99+nxV395DUAb453Obb
         0g/Q==
X-Gm-Message-State: AGi0PuazaxSfAGCPUD+IwaA2GSWqkliHGeqL677pdsF8gPogpEDx7+Lb
        tgb5zwbSBZFsbagyqVP6x3GPqw==
X-Google-Smtp-Source: APiQypKCDzca+eCTQuciTT43aXbflnxzTa53g95PcTkGD9z0CskYBxnkXGY5zeFv+78SchqWqu8zcw==
X-Received: by 2002:a62:e80e:: with SMTP id c14mr19361183pfi.83.1589273349558;
        Tue, 12 May 2020 01:49:09 -0700 (PDT)
Received: from localhost.localdomain ([117.196.230.85])
        by smtp.gmail.com with ESMTPSA id 188sm11320866pfg.218.2020.05.12.01.49.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 01:49:08 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kgdb: Fix broken handling of printk() in NMI context
Date:   Tue, 12 May 2020 14:18:34 +0530
Message-Id: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
in NMI"), kgdb entry in NMI context defaults to use safe NMI printk()
which involves CPU specific buffers and deferred printk() until exit from
NMI context.

But kgdb being a stop-the-world debugger, we don't want to defer printk()
especially backtrace on corresponding CPUs. So instead switch to normal
printk() mode in kgdb_cpu_enter() if entry is in NMI context.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Similar change was posted earlier specific to arm64 here [1]. But after
discussions it emerged out that this broken handling of printk() in NMI
context should be a common problem that is relevant to other archs as well.
So fix this handling in kgdb_cpu_enter() as there can be multiple entry
points to kgdb in NMI context.

[1] https://lkml.org/lkml/2020/4/24/328

 kernel/debug/debug_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2b7c9b6..ab2933f 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -567,6 +567,15 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	kgdb_info[ks->cpu].enter_kgdb++;
 	kgdb_info[ks->cpu].exception_state |= exception_state;
 
+	/*
+	 * kgdb entry in NMI context defaults to use safe NMI printk() which
+	 * involves CPU specific buffers and deferred printk() until exit from
+	 * NMI context. But kgdb being a stop-the-world debugger, we don't want
+	 * to defer printk(). So instead switch to normal printk() mode here.
+	 */
+	if (in_nmi())
+		printk_nmi_exit();
+
 	if (exception_state == DCPU_WANT_MASTER)
 		atomic_inc(&masters_in_kgdb);
 	else
@@ -635,6 +644,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 			atomic_dec(&slaves_in_kgdb);
 			dbg_touch_watchdogs();
 			local_irq_restore(flags);
+			if (in_nmi())
+				printk_nmi_enter();
 			return 0;
 		}
 		cpu_relax();
@@ -772,6 +783,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	raw_spin_unlock(&dbg_master_lock);
 	dbg_touch_watchdogs();
 	local_irq_restore(flags);
+	if (in_nmi())
+		printk_nmi_enter();
 
 	return kgdb_info[cpu].ret_state;
 }
-- 
2.7.4

