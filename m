Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0844C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CC92083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZZMSC/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDQQZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgDQQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:25:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:25:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m21so1262216pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4mvMIU59Tgjzyml3IlfpgeYlc2XX4cjx3GBkz0n/Hs=;
        b=hZZMSC/94+3O3uvUn6raCeZVif/elK1EcJm/A0/ruTeyffcvFB664wQnZLW3iurHku
         s6PrncY7tRmztJEJ34V9K8fWF/LqPu2xjINjcazkwuXpapNrC4XX6+NKmhXFbxC5fkG8
         lXP/z0pkdV2tNTjdbskAVYOUWG5O8ZcL0eMoYOnIp/yzywU7FGxSmuQVSHH6TZaUiGoR
         F6dHHCv6TOhEhO0/ecKfaLS9OuGpa2nWOv7Unoq7+l3M6VFGOQbb90MucKnzNEi4pTO2
         wf7cIQA3fSNvGvTx+1Mfsf5C7SyQSwNbYD0ckjxPG3kFNXndNBoNAla7viRsoGDZWTPh
         orgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4mvMIU59Tgjzyml3IlfpgeYlc2XX4cjx3GBkz0n/Hs=;
        b=H0td0Ck/IpubgpnXctZu4jFlCBOZKpJAXZVce4Zyu7xpriUeTELH3kgPI5/SRxdI6n
         KgUCiRUh4FVrB7in+hzozwv2yyyPeHVP7SBI3itpXZ9p0SQykezy5yJflgHuoh22azGv
         0VQnaL5denDl4YKjBWqJW3L+bOcqSCnfGMN+M4Jzn2Wk7Ti8OSXNE0r8MWUuLXZ4lRI+
         hmL/jkAuIqjfq7pDGKSg3W0gn/ZIfvdkd3bfTmSqH1ml+h396n5KOK8KXDIkqDwD3QnG
         jNxOouBtkguIckBPYaZDvXnCJwGS/X2dABxUc5wutgtDJyZdQxIVIfBkYFyTe7FSDvLU
         kOEQ==
X-Gm-Message-State: AGi0PuZr2eHJUd+6GIJMuFuYTSpxFCSnyxdRpE6cxF0ZpSbQknhfTFoI
        vOyGT3DcZc+Q6r+e/mPxzno=
X-Google-Smtp-Source: APiQypL6Qk8x6GVX5o1FrpTdZQqvfhZ6vNoZ4uFwv6m8gaAdDu25DQIrq4Y1AYiYh/zW9ygGDrlAkQ==
X-Received: by 2002:aa7:842b:: with SMTP id q11mr3953910pfn.302.1587140707439;
        Fri, 17 Apr 2020 09:25:07 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id x16sm6328292pfc.61.2020.04.17.09.25.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 09:25:07 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org, bigeasy@linutronix.de,
        namit@vmware.com, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH RESEND] kernel/smp: Use smp_call_func_t in on_each_cpu()
Date:   Sat, 18 Apr 2020 00:24:51 +0800
Message-Id: <20200417162451.91969-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a typedef smp_call_func_t, so we can just use it,
maybe better.

Fixes: 3a5f65df5a0fc ("Typedef SMP call function pointer")
Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 786092aabdcd..84303197caf9 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -620,7 +620,7 @@ void __init smp_init(void)
  * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
  * of local_irq_disable/enable().
  */
-void on_each_cpu(void (*func) (void *info), void *info, int wait)
+void on_each_cpu(smp_call_func_t func, void *info, int wait)
 {
 	unsigned long flags;
 
-- 
2.20.1

