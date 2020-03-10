Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9832071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWoXpiIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCJXZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:25:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33773 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCJXZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:25:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id g15so93485otr.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFjDio0RBC9Ro+1dWHvbTXYCexYzMv87LgebC+GcvxM=;
        b=KWoXpiInXMXxU2hznUDQ66l76Y1c0uRm/xCWDHAIJhqvrOgFAMrJmjLcHl9olgPeJ9
         C5mMBOjfrzXloXCHduMqiqxzkjpSQj7gsDpO2XoS+w0OvOzTkExvCDyiwHoF7pB/MReB
         vlejKbURCY3Xto9ud26A9HUFAStx240xyRJ6mn8YHeh6abLOp4zJF2hs69K0OGCVuSnM
         q4kZ23Vsdh3WEO4Xi2Czt+ose2Dx/IbIoUblALBUMYhYDXOxMBSdqxziTX2O0CF4F3HO
         /1Uq/7dmEbqDi1K8uzlraB2UC3P12m9mAhJoJhW8cTLmN5O8897dV4mF5scmrJM0+lzf
         J26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFjDio0RBC9Ro+1dWHvbTXYCexYzMv87LgebC+GcvxM=;
        b=rfLf7whpyoDBMNb4GrwP7pJ4K+H9JzQyhpvtlPRzO7sxQoons1VF3Ir49dCFl61fjg
         YPEzCWUdvxWaCSBjnGFOnnhVBGVKTE9XyQmrMqPl+x5UgYIOrSF2zQyqSs1DZzCw77B7
         Hy5rAAT2vTwAIa/AnAmLb6o5FVOL1/0ZeqMN08Xc+m1OJO/CxqUiITpBSkinkqi71AKf
         ki/lKkwC059Tv7ztAtN7a9kXU+D5HToHZICiIz7z95uOVeofWlfQXBUK85SQRCOk0jpe
         3lxNpARPqy5L3zSOBSR4XITdauG8xd20fdQUjEzV1ddE8f/EULq2kMpSS7S0bLKpmFHP
         I+/Q==
X-Gm-Message-State: ANhLgQ22MwL/Hv9VwP0v+/n419frlFTrygc0nayknpTEn0hU27zFrbk2
        vHf3p8fzSRug/zG03nDDHvw=
X-Google-Smtp-Source: ADFU+vsSsYsONyl0ITi9npDiUJlPy79ZrwMI5OA30Cy9VpdQ9cwFR6ANQkJvfAf9BAEpb2z73KgTOA==
X-Received: by 2002:a9d:5e82:: with SMTP id f2mr146921otl.240.1583882757608;
        Tue, 10 Mar 2020 16:25:57 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s2sm9187966otp.35.2020.03.10.16.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 16:25:57 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] arm64: Mark call_smc_arch_workaround_1 as __maybe_unused
Date:   Tue, 10 Mar 2020 16:25:44 -0700
Message-Id: <20200310232544.8792-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allnoconfig:

arch/arm64/kernel/cpu_errata.c:174:13: warning: unused function
'call_smc_arch_workaround_1' [-Wunused-function]
static void call_smc_arch_workaround_1(void)
            ^
1 warning generated.

Follow arch/arm and mark this function as __maybe_unused.

Fixes: 4db61fef16a1 ("arm64: kvm: Modernize __smccc_workaround_1_smc_start annotations")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/kernel/cpu_errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6a2ca339741c..df56d2295d16 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -171,7 +171,7 @@ static void install_bp_hardening_cb(bp_hardening_cb_t fn,
 
 #include <linux/arm-smccc.h>
 
-static void call_smc_arch_workaround_1(void)
+static void __maybe_unused call_smc_arch_workaround_1(void)
 {
 	arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
 }
-- 
2.26.0.rc1

