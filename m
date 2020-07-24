Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A4EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F303020674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5zgrj3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGXBPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGXBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:15:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F01C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 18:15:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so4253880pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yuCv7rSTWFdifZIFNqO3I4+NeNVh3MdiisjMgkBb1g=;
        b=Q5zgrj3nU2/GDDl7wm1fwGK1Z9Cct98do39AxZPW3ixw7JAarm90ChliRvgkjlNVjj
         DYckStxoPQuGCR85WRrQ+xpdVlfzL+hrMbdDxvp7mKXUR4nB4yyp1yF/wpkzvgLqt127
         xvnGS6APIBBpwP2xs8W7tCqAMcb9L7wcVUk9B2z9UyDiAh/mZTluuCsXRAz6Vx2JG18A
         boHkbMO55MffQgjkQQ00unJ8c6gpA2PnDv1PA8bBZ+3YJZbuVGJUcK8YDEjIJJiqEGDH
         wmwOUtYqTaTOEtwtSKZ60pMSBA9GyW5uIvEEnVm4dkD6OUnFa17+aQ1zXKW580lFzTB5
         I/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yuCv7rSTWFdifZIFNqO3I4+NeNVh3MdiisjMgkBb1g=;
        b=RrEe5Gj14rq/i4Bdn4ee9XRII5s/kfCbRCUboK2OBPDrbU4Nt1GC7v6+x580wjKlVJ
         SfiPgXcBcPGo0t8hrveQ5JqQexkd9TDrTERNCWv8zXr7Sb0s8ukaxKc6kw398vXOKCx4
         7rbyHr52nb7h5Ce1LGPVb+c/jEsqkP2hETvFqGZaJQe9shI2Rj5VEmviqL53PjgNYVeX
         4bZWYe7Mxfv44LM8V41RQ9gxxEZJB482vnjpFwLbf+cT4yhUcIdKIMwLbHRrBZ1BKzJj
         fyXG+knV2NxGU/tza908sg9Skf5u3ergL7IIFKXE8UWZAn17yFWPdFIUouTRTD2Dg/r8
         9yOg==
X-Gm-Message-State: AOAM531m6rG3XBhtJSequ6RmPBoGWjlgVZmE3K9l4zs6vqdIxYc0pHf0
        Z4rCi+rg8qJFCfr80k2ZpHw=
X-Google-Smtp-Source: ABdhPJx38hZerb0a8Bz0OfRKOw2y1liGikzNvVjZlrYvcVq8MMyZCG7iLAeBSDvABp2rqElHS1i0zg==
X-Received: by 2002:a05:6a00:1586:: with SMTP id u6mr6524039pfk.147.1595553333220;
        Thu, 23 Jul 2020 18:15:33 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id 200sm4365587pfy.57.2020.07.23.18.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 18:15:32 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] panic: make print_oops_end_marker() static
Date:   Fri, 24 Jul 2020 09:15:15 +0800
Message-Id: <20200724011516.12756-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Since print_oops_end_marker() is not used externally, also remove it
in kernel.h at the same time.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 include/linux/kernel.h | 1 -
 kernel/panic.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 82d9154..64991ac 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -321,7 +321,6 @@ static inline void might_fault(void) { }
 void nmi_panic(struct pt_regs *regs, const char *msg);
 extern void oops_enter(void);
 extern void oops_exit(void);
-void print_oops_end_marker(void);
 extern int oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
diff --git a/kernel/panic.c b/kernel/panic.c
index e2157ca..dbbd158 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -551,7 +551,7 @@ static int init_oops_id(void)
 }
 late_initcall(init_oops_id);
 
-void print_oops_end_marker(void)
+static void print_oops_end_marker(void)
 {
 	init_oops_id();
 	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
-- 
1.9.1

