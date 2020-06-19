Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC5FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42C520B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PySG8fTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390993AbgFSUvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389446AbgFSUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:51:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A118CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 13:51:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so6196866qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zN53ocDKgPo4aU+Lx16idVT7HiHaxgZRqdMOPyg8GnY=;
        b=PySG8fTHWaISqWyr5B+UmFnKxEU2vQoohGNc/yiUsQA1bnJ7RZrJh1hgPIL2qqCV2i
         5udW0uLFRbw4SECK3DY6FquCVCab6hXNsSK/N3ZW8/d9OdsornNnbYl8ueMABCKIVOGS
         hbMVJNtRVk4yMkPuNoZeoArru9j9dloLBxlpkqh5RWImG152eN9l54Exg9KAXIa8T6rO
         hO4X9xHtS/cfN8DqWN8L8r0jWN4s1GsyWQhg2nLeKsSMgTpTAAzDc+55QuqoNozvSruj
         73R+LaRW6jjnighY1YNUAxe3/Kuqi2Bsp2dMqUMr4J0/sgjlklAGFhbUC15BuUrRhPL3
         QObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zN53ocDKgPo4aU+Lx16idVT7HiHaxgZRqdMOPyg8GnY=;
        b=IfgkYVAegb+0uUKRRakp+R+d3oFr2N75oIKt0DzD4lQDixH08kmalU0S9KUJnOO/Uy
         Rl2QjgbAKSfBISqZOQtDvPHQaU+9eQatAt54fvY+gtOyDlV5BSUzhEmN7a9ROhR/6ES4
         5dYyUGMSIS78twoPKGsfTKmm1M3RC9qK+RRlpoBxhwehAgI/zNLoSpvn/kxv6WSjLKGq
         oQb49wJD5PgWvcPX/tOCVrYzpvK09dDeLtNZl6Yo013Rt82BXvAzXNsmTfbaI6bHm2uI
         dR9SKmIZ1a4FrHQ8COyBHial1c2NuBIAxWQ9CjTUjuR0CX+kX81msfvR7mCdulnHKHWU
         8i9w==
X-Gm-Message-State: AOAM530QXLNjI7F7WgPWEPcbu4XmBvU8SrnidqLENtaVRa5STvri5/cf
        P9JesVy+0FMSJXV1Gz8wWmY=
X-Google-Smtp-Source: ABdhPJwVMsALt+fpbzh3SghydU/aJYCZXsjL49YBTXK6SUrlg0EKQEdTdU9sN5WTA8Csf9DnigC9zA==
X-Received: by 2002:ac8:24e8:: with SMTP id t37mr5375278qtt.319.1592599871829;
        Fri, 19 Jun 2020 13:51:11 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:7035:d058:65bb:d314])
        by smtp.gmail.com with ESMTPSA id k188sm6212448qkb.23.2020.06.19.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:51:10 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Andryuk <jandryuk@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/idt: Make idt_descr static
Date:   Fri, 19 Jun 2020 16:51:02 -0400
Message-Id: <20200619205103.30873-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3e77abda65b1 ("x86/idt: Consolidate idt functionality")'s commit
message stated idt_descr could be made static, but it did not actually
make the change.  Make it static now.

Fixes: 3e77abda65b1 ("x86/idt: Consolidate idt functionality")
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 arch/x86/kernel/idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 0db21206f2f3..7ecf9babf0cb 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -160,7 +160,7 @@ static const __initconst struct idt_data apic_idts[] = {
 /* Must be page-aligned because the real IDT is used in the cpu entry area */
 static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
 
-struct desc_ptr idt_descr __ro_after_init = {
+static struct desc_ptr idt_descr __ro_after_init = {
 	.size		= IDT_TABLE_SIZE - 1,
 	.address	= (unsigned long) idt_table,
 };
-- 
2.25.1

