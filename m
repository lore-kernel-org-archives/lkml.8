Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E4AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339941;
	bh=tqudFgJQF68WZGOzqx9JHGYkd5LrLvCgMybrR5I8n4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMESg9RFe/Ga8q1PGo/Lhbjhu40l9jWdKb84mXUybsDw2ZJRAOlArzBhf5bIu10Ac
	 fDgFDpjfinxDEiexs1P5bckMPp3rM19AKd2n3kl5XizdRTmCwk1IupOpM0/EGB6XtS
	 5aS1o10xgRpnrwwqGM0CtCIUJ3SKwynOLi85ayZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgBJNFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbgBJMkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:01 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFF420873;
        Mon, 10 Feb 2020 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338400;
        bh=tqudFgJQF68WZGOzqx9JHGYkd5LrLvCgMybrR5I8n4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/tkY4Pl3zErLuHnSBpZb2jGwUTye7r155UYh4AMjMbIyO0VKtvRVE1lSpVCp7heA
         H3tejf0VuA8k9gmTBPpSwUuFZHrJ72QlenIsu8oNtl9sqLe9HcAli5vymRtqf5JBew
         0/jnoW/nenmcOX3s7Q3vTtJ9oTcFxvPvX7SqOno0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.5 072/367] arm64: acpi: fix DAIF manipulation with pNMI
Date:   Mon, 10 Feb 2020 04:29:45 -0800
Message-Id: <20200210122430.817611509@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

commit e533dbe9dcb199bb637a2c465f3a6e70564994fe upstream.

Since commit:

  d44f1b8dd7e66d80 ("arm64: KVM/mm: Move SEA handling behind a single 'claim' interface")

... the top-level APEI SEA handler has the shape:

1. current_flags = arch_local_save_flags()
2. local_daif_restore(DAIF_ERRCTX)
3. <GHES handler>
4. local_daif_restore(current_flags)

However, since commit:

  4a503217ce37e1f4 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")

... when pseudo-NMIs (pNMIs) are in use, arch_local_save_flags() will save
the PMR value rather than the DAIF flags.

The combination of these two commits means that the APEI SEA handler will
erroneously attempt to restore the PMR value into DAIF. Fix this by
factoring local_daif_save_flags() out of local_daif_save(), so that we
can consistently save DAIF in step #1, regardless of whether pNMIs are in
use.

Both commits were introduced concurrently in v5.0.

Cc: <stable@vger.kernel.org>
Fixes: 4a503217ce37e1f4 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
Fixes: d44f1b8dd7e66d80 ("arm64: KVM/mm: Move SEA handling behind a single 'claim' interface")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/daifflags.h |   11 ++++++++++-
 arch/arm64/kernel/acpi.c           |    2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -38,7 +38,7 @@ static inline void local_daif_mask(void)
 	trace_hardirqs_off();
 }
 
-static inline unsigned long local_daif_save(void)
+static inline unsigned long local_daif_save_flags(void)
 {
 	unsigned long flags;
 
@@ -50,6 +50,15 @@ static inline unsigned long local_daif_s
 			flags |= PSR_I_BIT;
 	}
 
+	return flags;
+}
+
+static inline unsigned long local_daif_save(void)
+{
+	unsigned long flags;
+
+	flags = local_daif_save_flags();
+
 	local_daif_mask();
 
 	return flags;
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -274,7 +274,7 @@ int apei_claim_sea(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
 		return err;
 
-	current_flags = arch_local_save_flags();
+	current_flags = local_daif_save_flags();
 
 	/*
 	 * SEA can interrupt SError, mask it and describe this as an NMI so


