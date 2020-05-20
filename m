Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E52220829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ijz61wyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgETOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:50:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD248C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:50:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so1667556pfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+zvcybwxg+mJmXSgIbTzNMcYmg5RQvOvv6kYw20xX4=;
        b=ijz61wyVhqbEsginy5IPC1uQNyW9SOkrsH4hT0JQ1rfisF39jHhixH4I6nBovhVRul
         NiJ5yUsLyMqWP48G0NRJ8y1hw9jisf3Vru0zTOO+knL2pCecpgboOlbHn5ak7+k/xxjK
         RH5V+p0FjP88bgo9LkXtPryrtGRz9AkfZfglJ+S1xFy+yWji/yJB6qRCQZzEpTldgTvd
         o9wh1C1BgWO0xZMJJ/7WTvWzsjSx/0DT7WtgXtH6p8sZvljzOCDI6kJyc0FwGF588xtb
         G1QZDpZFWZ/Gu1CQcGDszJwBYaFXWQD7z+fhDnvBBlkGMhwZxS5Ksy4unPUmKBwiAj3W
         W2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+zvcybwxg+mJmXSgIbTzNMcYmg5RQvOvv6kYw20xX4=;
        b=rftsfbDnXgfSP9nJqO0STz6kNRgRqrN3rU4FAqfwZdga+kdXRG+62ESgEYbFESWDPX
         oS90ZJPuyWqdW2Z7ii3ahKexFsOiDn2xONK0gApTkrdiGWraFZv5RAciWaZ7OOHuUzkr
         aI/UBC1UmcH0OLEd+jJ8W6Njdxo6PMIIUSASE6oHFFApqJwMGtTPTuzKQkcjtd1bWXtE
         1juuzC0Qu/fxblnnV3HHDOps6Hm1A0ZUYtpk5e5qRz5+nCU5VINtLbl3D/vp61xQbur+
         +QhgQWqNj4i5fx2KKSdl4Ed7dohcCP7kBA1qw9f4n5M4gJNmYebt6SBwRsa+clrZWp3R
         GxsQ==
X-Gm-Message-State: AOAM533k8twI4XPOUjIcW3vgKhsdI9ljaa1c6ARREOwXnbFhkFwzcERi
        Mhl766IShzOKwE5tT1rLkk71JYiZt5d7BQ==
X-Google-Smtp-Source: ABdhPJwala6VR6c/ivc6Qn71EXKVWPs4UfJLmpHy3oesN3JrPA2ADSGGW51nelHvngEWs+TAnUlHIA==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr2763515pgl.93.1589986247345;
        Wed, 20 May 2020 07:50:47 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id m9sm2072349pgd.1.2020.05.20.07.50.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 07:50:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     allison@lohutok.net, gregkh@linuxfoundation.org,
        rfontana@redhat.com, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] kprobes/x86: Skip the assignment to ip when there is no post_handler
Date:   Wed, 20 May 2020 22:50:07 +0800
Message-Id: <20200520145007.35479-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is no post_handler, the assignment to ip of regs is
meaningless. So just skip it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/kernel/kprobes/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 681a4b36e9bbe..f1edc0dc860a2 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -39,8 +39,8 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			 * Emulate singlestep (and also recover regs->ip)
 			 * as if there is a 5byte nop
 			 */
-			regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
 			if (unlikely(p->post_handler)) {
+				regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
 				kcb->kprobe_status = KPROBE_HIT_SSDONE;
 				p->post_handler(p, regs, 0);
 			}
-- 
2.11.0

