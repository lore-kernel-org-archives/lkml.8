Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C5C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DCD20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnUBd3aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBCW0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:26:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726369AbgBCW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580768803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Yr95hrNi5JfgkOfoS1PjLAI5Z/W4hgT7UGFvqBbgOxM=;
        b=KnUBd3aCR/tZuJdEITrkOHznPTqA4xfxWfo16IftF+la0cWZZU1Xb5WPC1haR5VboANGsh
        X+iJ2YFrYl+YR/VN37Z7I0KW8Rc6brm93bRtsrKm7Y8fJDOo5EcrGnl7jXT8Q9f1FWUNZX
        SSWuryi7XaRxoUzO1dGcbSuOMfjtins=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-9LEhusYPMvS5slWbjfBQjA-1; Mon, 03 Feb 2020 17:26:40 -0500
X-MC-Unique: 9LEhusYPMvS5slWbjfBQjA-1
Received: by mail-pg1-f197.google.com with SMTP id n7so5116351pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yr95hrNi5JfgkOfoS1PjLAI5Z/W4hgT7UGFvqBbgOxM=;
        b=O6BB0sqPUjNFDWfXYq39Pj8NMeYOVUPWD0ehuRAWc86Twgd3N9VPzHrU8YVl8m3XX3
         KmCf7KbcFL+Cd+m7wsRqrY9DJj5imn1EnLIFLKNQ8zeB8+GzciDAiffpYqA+pORxrYld
         Y60/4prWaukx9di9GwcugLTrO7qc8VaalAInJDZfQ1yViJd3dPYlxXAKDRZhlRVhQs/8
         wEK4FUFUqdfDaP13BdrdP3/RLlMRY377m66ScLvFGHSPmFftkGwqI2EpkzJmlhn5nmLb
         NCer3XPmEP+d8OXNgwZDSRJjKH+seATGexHBF7aaVzu6wxTUkhldUOHnb94/ubCMWfCB
         20qw==
X-Gm-Message-State: APjAAAVGQRIwFm5ldBRYlEmzWUgDhHrr2zEhWJjiAbAm7jhD/JVNQpkl
        Ljw2jTmLSpYPjkVp5qTKCXaLLKszrJqMcxl2LAfDYw1JCXgBfhQ4QANrtR61LIdiWO7pP2Ye9o1
        0HOOv+JhqizNn11A/EpEM4fDW
X-Received: by 2002:a63:d406:: with SMTP id a6mr28302965pgh.264.1580768799553;
        Mon, 03 Feb 2020 14:26:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCYMKSAbNlHwt3YKkhpBg65LATP/cLjqH1DDC2oSxQhzuOsjngoXE8H7XyY+eiYk4eqMEhiA==
X-Received: by 2002:a63:d406:: with SMTP id a6mr28302937pgh.264.1580768799210;
        Mon, 03 Feb 2020 14:26:39 -0800 (PST)
Received: from localhost ([122.177.227.116])
        by smtp.gmail.com with ESMTPSA id v9sm466061pja.26.2020.02.03.14.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 14:26:38 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bhsharma@redhat.com,
        bhupesh.linux@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] perf/arm64: Allow per-task kernel breakpoints
Date:   Tue,  4 Feb 2020 03:56:24 +0530
Message-Id: <1580768784-25868-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
References: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 478fcb2cdb23 ("arm64: Debugging support") disallowed per-task
kernel breakpoints on arm64 since these would have potentially
complicated the stepping code.

However, we now have several use-cases (for e.g. perf) which require
per-task address execution h/w breakpoint to be exercised/set on arm64:

For e.g. we can set address execution h/w breakpoints, using the
format prescribed by 'perf-list' command:
mem:<addr>[/len][:access]                          [Hardware breakpoint]

Without this patch, currently 'perf stat -e' reports that per-task
address execution h/w breakpoints are 'not supported' on arm64. See
below:

$ TEST_FUNC="vfs_read"
$ ADDR=0x`cat /proc/kallsyms | grep -P "\\s$TEST_FUNC\$" | cut -f1 -d' '`
$ perf stat -e mem:$ADDR:x -x';' -- cat /proc/cpuinfo > /dev/null

<not supported>;;mem:0xffff00001031dd68:x;0;100.00;;

After this patch, this use-case can be supported:

$ TEST_FUNC="vfs_read"
$ ADDR=0x`cat /proc/kallsyms | grep -P "\\s$TEST_FUNC\$" | cut -f1 -d' '`
$ perf stat -e mem:$ADDR:x -x';' -- cat /proc/cpuinfo > /dev/null

5;;mem:0xfffffe0010361d20:x;912200;100.00;;

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 0b727edf4104..c28f04e02845 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -562,13 +562,6 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	/*
-	 * Disallow per-task kernel breakpoints since these would
-	 * complicate the stepping code.
-	 */
-	if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
2.7.4

