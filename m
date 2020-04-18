Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006CBC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02CE21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GV1teu+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgDRUVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728692AbgDRUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0171C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so7199323wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOLlsLoeGnkz0N7/0K+grdJaQY8t0bt6164OUmJLztk=;
        b=GV1teu+EkN/dXOcrFG1aZXfyoKxjuiCN43cg+mi4hSWZIZADkzTexTA4/tnGxujcw2
         s0vo9gUBZ+ivdNffgPp8P7Hhqv5JdfYl18deLPk9FLT0xGcENkUoO/5GmsNpDsa+T1MB
         U29U9xrFANKqpTwv0SBRAHCCP5sqcCI2pONmkoJot9BWleVbgXB/hgcJRNDVDBmuftrT
         rbfzDgUJ554pTgrTSXbDIfDvd7j4EfYAaeiNXrilo3i2Hs9xC3ZMdtgPgugTLp4XpBqm
         NJBurrNKTQBmyCtKr7TLltCAU8iH71u678mHrn3Rx3Mr2UzeMwSxOz4FMrZIkNHID2gP
         O0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOLlsLoeGnkz0N7/0K+grdJaQY8t0bt6164OUmJLztk=;
        b=hxSnrVZBhE+cR/QBdC3zQtAHlbltMZKqb2EghXWIC62e1xm5VKXFZV2ij64BPXUTLN
         C5+klOP4T82+dz+QxzruitG7ZLCyWcj8Ws+KvLaz+RWUgd6GMSmPWwZL1lAUR89SvPMX
         gqkYLkDFrtV/SZPc1ES8RuHuXyI0qMZF3ro6b11i29UhtzdJEO+YELbgcdcdB7Pzfjph
         gHVsZ1P0B0wMk5W9LDqmlggMOccgowxsllwEHk3z7CEHCXCPylo3cl6Cvm5+EDYTREOi
         3aeO7ILxVws/EGj1z1faMPU6aqhxF/ZBVYTmwfd7XhR0+L/WwYfj7igejC1WFw0gYnjc
         cBug==
X-Gm-Message-State: AGi0PuZOlfvstk3/cpX0wJR5xEnstKuKEt9RwfX1vF6Kuu1NU51ZpeYe
        AXIlz2++EiZ5isjluvQY0KI+STO7zmQ=
X-Google-Smtp-Source: APiQypLBhOb36qSo5/8YdCe+7FLbUn6o1FpZQc2VvGXBINdN06jzBHBTC+JL4VAo9roR2oJNh8wqTw==
X-Received: by 2002:adf:f342:: with SMTP id e2mr9945162wrp.146.1587241251338;
        Sat, 18 Apr 2020 13:20:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCHv3 45/50] x86/amd_gart: Print stacktrace for a leak with KERN_ERR
Date:   Sat, 18 Apr 2020 21:19:39 +0100
Message-Id: <20200418201944.482088-46-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's under CONFIG_IOMMU_LEAK option which is enabled by debug config.
Likely the backtrace is worth to be seen - so aligning with log level of
error message in iommu_full().

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 16133819415c..9d2c076be37a 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -159,7 +159,7 @@ static void dump_leak(void)
 		return;
 	dump = 1;
 
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_ERR);
 	debug_dma_dump_mappings(NULL);
 }
 #endif
-- 
2.26.0

