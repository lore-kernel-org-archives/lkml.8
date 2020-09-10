Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C2E20732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bLqH9LN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgIJIX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbgIJINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DCC061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so3854027pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyToT9usN2RGs0QtGnv24oUTJVHH9I6JpNfhpfVomac=;
        b=bLqH9LN7vYQCfiYsDw9XFJW6EBbgy+BKpL1nE2vQzqHNEWbndeR/jFMs2CF5Yu314Z
         1SkbT0vxBNj8q9eMT1h3QfYhVkyYQwQXsHxTwqge8uDF3xfiSUR25qKxwkuDZ8s5fila
         SjsqxGh89bR38ziXfw30s9GngwHLJaOiIymXYD/hJnB+nUnLxaHphFwgxJcpCS99TGtV
         zoD4gHm8Jx+7D/OhUXxZpUsLm/jsKXKqwUwC+ZXADXsTi4ZOYegUOgNFm5UNbTwbe6HT
         MZ2gJD/pt26iUvZgUE/4qRlSMpRHoWARs7pUmDWXf5CTNXFYihNwWq/KSq9jaLJ5kopR
         r53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyToT9usN2RGs0QtGnv24oUTJVHH9I6JpNfhpfVomac=;
        b=aZ/AJLBGRAvbpibHLWe5DwseZ7dcbZcM9bIN+2fyNUCbXu0pwSHS5gQ6pHArMowYku
         N1R6LctUTDaz9pdITTw3EoZ8pM3rUCtpknNwQr/Knfij7je71O4v3RYXUvJxgqiNVXQw
         pqOGDfLHpMO3YG3ZoMBjk9YXP59xGeZyC+OlDkN/nqOKZyNDLfxBAVjLGNUjsJFegriH
         kfYt6ah1hT0G2PMxF9+Pm56ZhtLkYcUrnEREhK67ykIJa8LRMMgjoYbWExaRfkXshGcJ
         PhzzH92OQrb/q82IL1qhFz7SKMKWrPnikW5DYR8XaB8G2z0GnpTbuSmyse+jtzYeywcX
         7slg==
X-Gm-Message-State: AOAM530AAmcl0bmJk6AJj09F1FQx3k/mgIuJflHBy4k6DT+pyqKGn6KF
        0o2cdBI0bFViAi5WVafEcgly9w==
X-Google-Smtp-Source: ABdhPJynWLjsGJ8rMru7Ua4JcJxOP6VlQ0E5ZU7VHtZQmYKi72QBIcatIakNoD22UeJCg3U0lANssQ==
X-Received: by 2002:a62:f841:0:b029:13c:1611:652a with SMTP id c1-20020a62f8410000b029013c1611652amr4542048pfm.10.1599725593043;
        Thu, 10 Sep 2020 01:13:13 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:12 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Han-Kuan Chen <hankuan.chen@sifive.com>
Subject: [RFC PATCH v7 17/21] riscv: Initialize vector registers with proper vsetvli then it can work normally
Date:   Thu, 10 Sep 2020 16:12:12 +0800
Message-Id: <3e0097c59860fbaa90aadc69d302fcc2e4ab351e.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may cause an illegal instruction exception if it doesn't use vsetvli
before vmv.v.i v0, 0.

Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index e97c7915ae27..74f2fd8430e0 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -375,6 +375,7 @@ ENTRY(reset_regs)
 
 	li	t1, SR_VS
 	csrs	CSR_STATUS, t1
+	vsetvli t1, x0, e8, m1
 	vmv.v.i v0, 0
 	vmv.v.i v1, 0
 	vmv.v.i v2, 0
-- 
2.28.0

