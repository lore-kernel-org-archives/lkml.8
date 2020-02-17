Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC42C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EFC2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfVFosKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgBQO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:26:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35104 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBQO0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:26:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id v23so5865183pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1A6TYOxCqBJgjeIIO9IA0dhPxwCgjry9FpeoSZZn2E=;
        b=qfVFosKY+4nEorpoWT+SQJg/3sxsaEdR60jC58OI3OWoAMRBdtwXB6SxsF2XlfBD3c
         iwjhwsO/5u/n9SkbqgBbhqefidWuI7flw1i9cM8z/ofHb5UwhSbzYEbZkVtyhzAPKsFq
         B50xb2hkKwl4AFy2EyCF7Rzr9IFS785xxM5Bcu7STgoe1UmMVAdY91EO/v3+cuw329Hj
         MBIlPuO/5nWcQ3AfdbQRRXBTggFMqnNGgD64biLPhXbKK4cfDuhSE8lPrHpZ+Ri8qgtl
         3OMXpEVlwOBAmoZboCVqTchAmHcT7axVVxCCS/PVCRsW+mHh1dkePOYSZEzCcO86PIvx
         cK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1A6TYOxCqBJgjeIIO9IA0dhPxwCgjry9FpeoSZZn2E=;
        b=rlAzZw90nZ8YtOeNW4OReS2hb/CIgHvT8RCHZs4AwoGh3SI2Vit83i2+rg05ixTkTq
         FADrzY7dohSAc0wsW8iXIYAgXcPPzsl7ZGMA+uagjVA03ExL6LErA6rIBjwxCMY+UlQW
         fDxraJFeZq4gnm7ztMm5F7+P9JKoVm1pP+9tbRLEmk+ZoxGufYNWf4PGT62Q89YLj5xI
         2LVwz0gH4JuUKYztNVNLfcfqGinm49whWzMGVdUdBrEC7lBXtKqp31KnowjenVtg9P4F
         F8LpsxhorJxwJ0bPNNOfAKsUY9T1r6prnAw2YqChOwJxViWuEneObTjqWGTGWMw7O10r
         EuAg==
X-Gm-Message-State: APjAAAVHw2LBx0EHCZOC0x/tYwjZdRfZTqeaeQQVGb82/bXm5RreI+sR
        ThysoBETqcFU6OOO8jdhpng=
X-Google-Smtp-Source: APXvYqwAtvOffHaElXAqgxPar2FES1USsYsZzrii6zC6XZbgwy+aZVUal9RsY82vdNQqfEF6GJdATg==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr16921230pfz.246.1581949614386;
        Mon, 17 Feb 2020 06:26:54 -0800 (PST)
Received: from localhost.localdomain ([2408:8025:ad:7e20:f532:3cc5:d0f0:19dc])
        by smtp.gmail.com with ESMTPSA id k8sm1111207pgg.18.2020.02.17.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:26:53 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, bigeasy@linutronix.de, namit@vmware.com,
        linux-kernel@vger.kernel.org, smuchun@gmail.com,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] kernel/smp: Use smp_call_func_t in on_each_cpu()
Date:   Mon, 17 Feb 2020 06:26:16 -0800
Message-Id: <20200217142616.3510-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

There is already a typedef smp_call_func_t, so we can just use it,
maybe better.

Fixes: 3a5f65df5a0fc ("Typedef SMP call function pointer")
Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d0ada39eb4d4..6819a3f114be 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -619,7 +619,7 @@ void __init smp_init(void)
  * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
  * of local_irq_disable/enable().
  */
-void on_each_cpu(void (*func) (void *info), void *info, int wait)
+void on_each_cpu(smp_call_func_t func, void *info, int wait)
 {
 	unsigned long flags;
 
-- 
2.20.1

