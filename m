Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7293C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2DB2063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUs298ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgDCFRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:17:14 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52182 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDCFRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:17:13 -0400
Received: by mail-pj1-f65.google.com with SMTP id w9so2509037pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a2eICLyqFyh4QsLaF0H40/0dZ9ZOOwOLAxDPtmgoFDY=;
        b=UUs298ubfCuhPH6SN/2XxvO13V9fNrExsVlVQizMPNHaoelia7fvSr6cBlD9uJYpfT
         H2Sh+TWKXfeViTLycxHZLqsF9XLEDU41MDHmkukuMhCN3iTvBmcWReTA1WIaqxjbRNYa
         VqeT/TxF8Z+CIRQcQoa0sixgB0E6quf4wl2C10fqbs3t0drT3X5falKaiRozDAeCHiIS
         FX685j/oOVCIUBMW+VCIixv9rbhh1o3CJAUzTI6fdgFmhWiWn6SW0dOhy+5w5wO2yqg4
         FDZkIyLsVFaw2ZG9eCIcyeS0rRwADzJ9WZQssIcJgcgN2F3xAqdT3ALkLaq/gSlQ3pJ6
         J1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2eICLyqFyh4QsLaF0H40/0dZ9ZOOwOLAxDPtmgoFDY=;
        b=iTkdjLv96c0VRCAxsNi3icWVfwiogKafdeTm1hwc7Nxr/HU8tKutqWeZSNGa+2rD2j
         7Zg28I2VAdi2KDiBicghiJl0DhyUOBJKePRE31kWGQeCMMtQ0juP0BNUtEW0tKDTeTsn
         wyrVWd0PwrucsJ/9uS8pbpwjeIwkm+a6YaB8iWEpQVeV9KYqC9b3clWkG5wv/xzv1743
         DPJJEbzXX+Ztr+RMPQNzgNp5K0KbgbKrIC3a+ODopoR9cZa8TdCCts95V5wxulePYm26
         xVop2SoBRHhF5aJwKCRViMtYlSVH0Z9KpU3rrCItz3VNEc1tZ4f8tWIRMOJ+Z/xOgpZ3
         ojKg==
X-Gm-Message-State: AGi0PuY2tu/GuAHs4wBbtLz/9f2M0RtKuKfAG7ZY4kz6XVWMCJIZlH3s
        spu9e+lQgJaJ583QqrsKL5zwlbQU
X-Google-Smtp-Source: APiQypIxPeDcSIM6JCWVivHxiZBCtXEqYFZqU+AY22TVTZD4PQk1fx6O3A+Fp6ofdehgjeZ4g4UG1A==
X-Received: by 2002:a17:90b:3752:: with SMTP id ne18mr8110223pjb.143.1585891033038;
        Thu, 02 Apr 2020 22:17:13 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id l22sm4849296pjq.15.2020.04.02.22.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 22:17:12 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] kmod: fix a typo "assuems" -> "assumes"
Date:   Fri,  3 Apr 2020 13:17:09 +0800
Message-Id: <1585891029-6450-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in comment. Fix it.
s/assuems/assumes

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kmod.c b/kernel/kmod.c
index bc6addd..8b2b311 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -35,7 +35,7 @@
  *		       (u64) THREAD_SIZE * 8UL);
  *
  * If you need less than 50 threads would mean we're dealing with systems
- * smaller than 3200 pages. This assuems you are capable of having ~13M memory,
+ * smaller than 3200 pages. This assumes you are capable of having ~13M memory,
  * and this would only be an be an upper limit, after which the OOM killer
  * would take effect. Systems like these are very unlikely if modules are
  * enabled.
-- 
1.8.3.1

