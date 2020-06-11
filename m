Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07335206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrnu4O8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgFKOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFKOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:04:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80F8C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:04:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so6554635ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tAQkTDxR6OkbsLR77e3L5/n0JEewLIpdbP+HGlmOso=;
        b=Qrnu4O8lrdL0KYy5wqcY0H/DSv7fGsDcQgHQ357ugoTAE+I9omd+S4+aQ8AFF7ntku
         J15ns1pEF7tp2kagz/i4l2eCEZFdIoLWtWWNin0+ElkkFh9sfTH3r+ziLdUzohpngh8S
         KWYnVhp/RE0twDGY+hPM+VQ/3ds2aYU3SwbA/HytFCmYG6CwWCLwZpib6qmFHgsVcaeD
         2xIMLuJAmFCrDaJgXaGHw1S4slPHo7XUor3C8wGyXz0Q33EOwJUA/DLcUG4FihwaE+3Y
         fwzUj4yoY79fsieLc3GhHPPJ1abPEwVPm+Zj5qAKEbKiKiuXk8LnRoTZHP0WPZgMMsGq
         HIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tAQkTDxR6OkbsLR77e3L5/n0JEewLIpdbP+HGlmOso=;
        b=U1QDENKbfx7NQvu/Qq3JPv0EZSKL1lPJELRKPgX4MHouJg8tK5F6pIGFY62g8LcPr/
         zgZ68nlN1jN7I170iwC63QvFT9SvG/tS92GR47W86BpyGLT5SOSkVkdiV6VrExbHpmVq
         eTBDnQUY+RMfF3KEjsLnY42hZHosGiP1MQWmd5DMh2XSboId9oSJvklBJ0Q7iVbuiihd
         az9pNUDFVG8yMPAf5mcU8f2yGUqaHlFHMYZFTN921/zzD9b9KszkR0IrcPaqpZEHIHCf
         IBqu4Hf9Ewygy2Y2AN9Ds80SfkAQpC9DORLytml1fuEwzJQEOx5TpMXtYvn9+DGvoow5
         +g7w==
X-Gm-Message-State: AOAM532M8LE1+9bp6LnN2pXuHUnUzEdMwwICZvlDs4rrxcCHRc8mIZCF
        d+unuX6i4ieiwv5VQAYFlnM=
X-Google-Smtp-Source: ABdhPJxXyGK1xtU5Dkh20lntkoPDiXZokmp0W8yf+dpF3rch+rOVEuV+n+sqF79m89oSORQFZ7iS2Q==
X-Received: by 2002:a17:906:4406:: with SMTP id x6mr8402478ejo.160.1591884262536;
        Thu, 11 Jun 2020 07:04:22 -0700 (PDT)
Received: from archlap.tendawifi.com ([185.32.231.210])
        by smtp.gmail.com with ESMTPSA id s13sm1936787ejv.29.2020.06.11.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:04:19 -0700 (PDT)
From:   Ilias Stamatis <stamatis.iliass@gmail.com>
To:     tglx@linutronix.de, pmladek@suse.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Ilias Stamatis <stamatis.iliass@gmail.com>
Subject: [PATCH] kthread: remove incorrect comment in kthread_create_on_cpu()
Date:   Thu, 11 Jun 2020 16:59:21 +0300
Message-Id: <20200611135920.240551-1-stamatis.iliass@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally kthread_create_on_cpu() parked and woke up the new thread.
However, since commit a65d40961dc7 ("kthread/smpboot: do not park in
kthread_create_on_cpu()") this is no longer the case. This patch removes
the comment that has been left behind and is now incorrect / stale.

Signed-off-by: Ilias Stamatis <stamatis.iliass@gmail.com>
---
 kernel/kthread.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..38fa07ae59f6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -455,7 +455,6 @@ EXPORT_SYMBOL(kthread_bind);
  *	     to "name.*%u". Code fills in cpu number.
  *
  * Description: This helper function creates and names a kernel thread
- * The thread will be woken and put into park mode.
  */
 struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  void *data, unsigned int cpu,
-- 
2.27.0

