Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7EF20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gz1R9td3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgFKRyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:54:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0DCC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:54:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so2595452plv.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=fp+zT9km85FGnqPFWjENTTSWII2vpTFTYsBocgH2XVU=;
        b=gz1R9td3whTeOsnqSemH0JyPz0DUhMYRZ/g6Y+uKLaSh8mDVJYFxq2wrTuBuifrbVM
         ataNaaREFegmXoYMPMCfluJbCgkYlEHrc6eYq8uyVrmRV6bq2HB9RlYfs1HUhs6KxjI5
         qQWCthLhkECbEA5aFgpw7tev4PV2Ryt66M212/OfKbWBCbC5HPaW5kebFyhxMwztSQoN
         hP47iH0khzkwDpwiuu5Vd+9K4dscf3oo88mR/efR/N6i5UoDginbNAkp864ZlXlUS1v1
         i00Chv3iI6i33RFDfYWM/ZRgkKARPnDAiQ6V3mI382DOeQuIbvEAYEXcn08/GFJwk4q/
         HdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=fp+zT9km85FGnqPFWjENTTSWII2vpTFTYsBocgH2XVU=;
        b=gKRZZiox9+DX7szRsFvfDLyJwbKZuWreHmxOVxzZ0DvclXrRdePrBeYF+edlQHvzCe
         cMZFtKcwSj14tHjg+MTKj2YrLwD536nkq3hxiAgRbpheQiKjFNrpfwGrb8wYyinVchrn
         ix4NJPCYOKExUBzqvry6QB+2GOq81EbVES5N75xUbmoQV2UzyiIhjX//1PvV0SRcGV9i
         8hQS5GkbLwgYAKRX3o+EUL4zeQFG1kxbbwwebrXS0UezzAEtPI8ns0IgyaUQF98Vfiow
         whrso0w0M3pFpvoP3Jt13BpErDpjPCdYcnQMCmI1x6cByIyvZgzh57bXPvjEqJpxg1Za
         7DWQ==
X-Gm-Message-State: AOAM531fXSaexSV69O+0XGvedy5zeCPsap53I66c5b8qdqIGS+2iyOrP
        adJrn7t6tkaDNoyGZjEnC+SetQ==
X-Google-Smtp-Source: ABdhPJx0LZGJuQSD2va3G0YwfetWlhas45vjWWqt1GSueHT4DcNiF6Lm9+8FFZQkMBwcuGYjsy0m9g==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr9184990pjb.121.1591898043186;
        Thu, 11 Jun 2020 10:54:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x18sm3726356pfr.106.2020.06.11.10.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:54:02 -0700 (PDT)
Subject: [PATCH] irqchip: riscv-intc: Fix a typo in a pr_warn()
Date:   Thu, 11 Jun 2020 10:53:02 -0700
Message-Id: <20200611175302.253540-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

Anup originally re-spun his patch set to include this fix, but it was a bit too
late for my PR so I've split it out.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index a6f97fa6ff69..8017f6d32d52 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -99,7 +99,7 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	hartid = riscv_of_parent_hartid(node);
 	if (hartid < 0) {
-		pr_warn("unable to fine hart id for %pOF\n", node);
+		pr_warn("unable to find hart id for %pOF\n", node);
 		return 0;
 	}
 
-- 
2.27.0.290.gba653c62da-goog

