Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E6BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D99320787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opcW+Syg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgEAKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgEAKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:22:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46760C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 03:22:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so11018740wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RdVIC3YIQFyu8urT7zjdWEwHBVKl2OyL0ZV9zzoG76c=;
        b=opcW+SygN2MlxXFPpvkL1LawTKos+FIxVumGnJRRers9BpyMFpHuFnf7COK9b7mhs7
         KRMDNhrTckGyvj5U+cUMa/euYs3uhEHEAKsr9wv9T4msIqxSXTr1ETLKwbK5vJCTC1VM
         jjEaKdJ6G/gjJKU9we0oDpgyxe2vdzUtrUlO3V8XqI14JmB/VBhpSJyvxm/o1xwSB6tj
         iJUzaFB0io6r8CWEeafysWDwHnkYSzRQJK7kIRyncuLafU3cVOQAjnIZYuULolZJ3FZe
         uaHbtkHvWygr0KQ7P/qY54tY9MfkSU88Cv8HctcVUzGqY9NMWdmxGaDeFt319S6aT3sx
         SEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RdVIC3YIQFyu8urT7zjdWEwHBVKl2OyL0ZV9zzoG76c=;
        b=phUI/6TAtu7uGzQTYaT/RELELsc9IIS5NYurV/34NZIxrgdo2mvCVo9t44IrlpEbC4
         NudNzaRHdAdSqlsqxQHz6zIHchHClGsN1nlRzGk9/j1CmHGB0trgFbdwDjwdibiKhRvg
         kWpkZyo82lapmXfvjs4asumavRAwPiFU1Z7EKxSMmeG14+y3buBJeEjQAtQQGN5Fxhj0
         vzCu1mHOlmqIRANhezOm1PaYsCGmHy5mxmaqOF1ITHbu6BuNV+EBOfrlfaqSLxCrYUvC
         kYPjavsSzAtPbWCWgtiaTm1vQ7OErSvR3e5shzBDqxZB4gfm+55tmzd2+0zKdZW8tyuo
         xTRg==
X-Gm-Message-State: AGi0PuZNfzOJeHFUrqutPVieODrp2kRX32r9Uxt8y7H6mdY/iDLEG3BR
        1c5pR94IWhYcrl06vCuwF2+vcLkn
X-Google-Smtp-Source: APiQypKxSZ1Qs4jIf235zrEuXMlpoFqM8GksJvjrfSUuXD49l3PleXxRL4rVkLTLopYkRgnrz9V3ew==
X-Received: by 2002:a05:6000:1242:: with SMTP id j2mr3377369wrx.274.1588328555570;
        Fri, 01 May 2020 03:22:35 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u3sm3528121wrt.93.2020.05.01.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 03:22:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Dotan Barak <dbarak@habana.ai>
Subject: [PATCH] habanalabs: print all CB handles as hex numbers
Date:   Fri,  1 May 2020 14:28:19 +0300
Message-Id: <20200501112819.5466-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dotan Barak <dbarak@habana.ai>

Make all the CB handles printed in the same way and not some as decimal and
some as hex numbers.

Signed-off-by: Dotan Barak <dbarak@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index 6cb92efce4d9..02d13f71b1df 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -288,7 +288,7 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	cb = hl_cb_get(hdev, &hpriv->cb_mgr, handle);
 	if (!cb) {
 		dev_err(hdev->dev,
-			"CB mmap failed, no match to handle %d\n", handle);
+			"CB mmap failed, no match to handle 0x%x\n", handle);
 		return -EINVAL;
 	}
 
@@ -357,7 +357,7 @@ struct hl_cb *hl_cb_get(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	if (!cb) {
 		spin_unlock(&mgr->cb_lock);
 		dev_warn(hdev->dev,
-			"CB get failed, no match to handle %d\n", handle);
+			"CB get failed, no match to handle 0x%x\n", handle);
 		return NULL;
 	}
 
-- 
2.17.1

