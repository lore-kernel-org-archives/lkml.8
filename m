Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C9C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgEEKPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:15:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgEEKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:15:45 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jVubI-0000qy-Lm
        for linux-kernel@vger.kernel.org; Tue, 05 May 2020 10:14:56 +0000
Received: by mail-pg1-f200.google.com with SMTP id s126so874013pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 03:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3jQdO0StdvNBvV4/pWErSvlqKP7ZpKyE2C4p/RjopqA=;
        b=IZdrF/V9GtH2SGFFLHPLqJGLNEIm/3hFhVSP1KRLhd9qaztzqeeRIECVOFdxowGM2I
         SmJ86zLs3glZrr+aCcn5ihmlyic3dlhqMOWoSA5jmoppYm4nKJcUb6Ky6P+O0cKHJkEv
         QbBfx6/JIaEa9wz1U4Sbp5OIfDKpQMDm+GLdte4BFk9vgvoOR0CTFkzDBZoJRhtJ4R9+
         OqXZMzSvmeRtiqYhwWu5qHi5Nu2/kLQKEVdKmdpPJ+JhCz8JlU9YbaOriVjfKM5RIMCy
         asL7u5BMEwIyE6n6y3rOSbTpOH1Tq3XCuHKOL9SeqSgAdRqlseXBkUC7qlo2G1TKvZ0O
         VEtA==
X-Gm-Message-State: AGi0PuZQoZAqEO2lpbhtzE5qzNxKxncuLDyjTUnajxM1NuB9peVdxK+/
        eZz706DrXJvl7ye4c+ZA62k1yOWQQSuFcyccK4TMttHEK4jiAuUkJnNoI9GPxn+5YUug6k2mvq4
        Jdp59Ht2reh12tr0+kjh6BtKpaoaNZlh5hbhyUU0/
X-Received: by 2002:a63:4d3:: with SMTP id 202mr2384179pge.248.1588673694646;
        Tue, 05 May 2020 03:14:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGgjuYe84gOCOst55qT44cCXLJjkRPwtBO7m2lJXOC7uPLyI8xx1unsOLavkC6BInlPCukhA==
X-Received: by 2002:a63:4d3:: with SMTP id 202mr2384156pge.248.1588673694369;
        Tue, 05 May 2020 03:14:54 -0700 (PDT)
Received: from localhost.localdomain (111-71-115-42.emome-ip.hinet.net. [111.71.115.42])
        by smtp.gmail.com with ESMTPSA id d35sm1235727pgd.29.2020.05.05.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:14:53 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, mhiramat@kernel.org, po-hsu.lin@canonical.com,
        joel@joelfernandes.org
Subject: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as unresolved if the test module does not exist
Date:   Tue,  5 May 2020 18:14:45 +0800
Message-Id: <20200505101445.27063-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UNRESOLVED state is much more apporiate than the UNSUPPORTED state
for the absence of the test module, as it matches "test was set up
incorrectly" situation in the README file.

A possible scenario is that the function was enabled (supported by the
kernel) but the module was not installed properly, in this case we
cannot call this as UNSUPPORTED.

This change also make it consistent with other module-related tests
in ftrace.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
index cbd1743..2b82c80e 100644
--- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -17,7 +17,14 @@ unsup() { #msg
     exit_unsupported
 }
 
-modprobe $MOD || unsup "$MOD module not available"
+unres() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unresolved
+}
+
+modprobe $MOD || unres "$MOD module not available"
 rmmod $MOD
 
 grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
-- 
2.7.4
