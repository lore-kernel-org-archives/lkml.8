Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277302080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Uqt6Xzxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGUDmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:42:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53675C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:42:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so894730pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFxFeoQn/SQYRyQDfbG1IBUQ/zoH7xIjzBCHtw1UDhU=;
        b=Uqt6XzxucAzfhz+eY8v2XOh+631yFjGkuxbG+ZlwBaQsOgPHLtnENdj7UTezv56eA9
         8KtzBp9i7Teyeep/z3TW/cyIKSK0bAdD2v3lG67dmeJHIXSjdZKngDkmsnbTFWYKGMxD
         ATihstNkkR9cgP82PR91gx8y+CahXmslPoQ7o1C1o1Mt0KO1LL+RFDUWvWm1zY/pWbg1
         UMZ9EOisk1k2wc7MQ/HcksslKT4aR+Km9muLeBgWnxDTd67jt9KB93PfuZsL5qua/JEC
         ZsGGqfASs1vMdzLwDJac62sR/N+hl06cmaqrMpThXKUnRr+KydmonxuggnR7QUC70uq5
         FlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFxFeoQn/SQYRyQDfbG1IBUQ/zoH7xIjzBCHtw1UDhU=;
        b=okuu8+HnDTO+QgqRhUsnLlok/lEqXiOEu90mO/TqhoAaUZVceEZwVH2+U3dPHLkxzD
         OSwLnO28dqdqAm0ictWadagIE/ugV3FQ74T25htdsgeSsvD6E/On3E2TY2+6yXQDd4FM
         t3Eh2e2C1YCSCrCuRWVD1gd83mqS4ZwB7UkBlewf5weFfyRlUil08lmeuJxGNPWawXZx
         oiOvgkeIG4IKsOyhcU16nHS+XqicBgXauwkdCnluwjr/P3LCC/XqNYrSIq+fEFSWb+uG
         OxWo4blQUxSk1b5fsu4K9h7P3RZNXxWpswhiNDLszAYf0ZPaUI0gk2wtK1dwQK0eCwlM
         7vTw==
X-Gm-Message-State: AOAM531oxz4cpE0CtDjTwTIQoMlpVbzHO2x0SCeyKiJnABJ2ZAIHoAC9
        vmeokyVcSkbm11OUoKdC6icX9hnoBibqdQ==
X-Google-Smtp-Source: ABdhPJwJmTEoCOdbRJN3jKDXIxQyb0PCdXv1iNb0euoJIEFzwHswtkBL0TSHNmAFEqBEpkY1lxlUxA==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr2465527pjo.97.1595302967933;
        Mon, 20 Jul 2020 20:42:47 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id p127sm18300468pfb.17.2020.07.20.20.42.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 20:42:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] smp: Fix a potential usage of stale nr_cpus
Date:   Tue, 21 Jul 2020 11:42:39 +0800
Message-Id: <20200721034239.72013-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the cmdline of "nr_cpus" is not valid, the @nr_cpu_ids is assigned
a stale value. The nr_cpus is only valid when get_option() return 1. So
check the return value to prevent this.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
changelog in v3:
 1) Return -EINVAL when the parameter is bogus. 

changelog in v2:
 1) Rework the commit log.
 2) Rework the return value check.

 kernel/smp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index a5a66fc28f4e..0dacfcfcf00b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -772,9 +772,13 @@ static int __init nrcpus(char *str)
 {
 	int nr_cpus;
 
-	get_option(&str, &nr_cpus);
+	if (get_option(&str, &nr_cpus) != 1)
+		return -EINVAL;
+
 	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
 		nr_cpu_ids = nr_cpus;
+	else
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.11.0

