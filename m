Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A816FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2632053B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="g8wTcgSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFNHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgFNHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:10:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3177BC03E96F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:10:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so5430608pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryP8cAu4wXnxt+VFYVN54rpFGELZrqJgme1cG9J5OqU=;
        b=g8wTcgSEiMfnC3eceuFg8o2iLz2trcVbGEeT5fDXa+nd4+w3H8KMZ08t2JmyGvh6H4
         Hk0GhdgsHbLVd9wSbqTqa43AcP0r3owR8zakL7PR1XpCriBPPKKipezk2LW4Jz2VIOW1
         ui07vW5/tqW/yCqVJFOO4pM8MRePhCsFSJMMI5hVYsEbuy+jOc91F97aJFkQE2qVjWUs
         qUNlZ+lPtmtQTurxPTCnOX7rE1b76M2eNAH70O3qltXCWU4L4HO9E9gHePYZpiQ/3VLY
         qOzDN5numvZJHGIS4miCsRa3aPyFC67LO+u7g8xrNRkjLDzEsTpYiglDUw9ALwdfQ1lI
         YBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryP8cAu4wXnxt+VFYVN54rpFGELZrqJgme1cG9J5OqU=;
        b=CUaR+ZNTVzCJOaF5pYr8FCpcp2/Vk9hK0Alh3FAtRrh5IosUi0SPgshsu5M3lLEmvs
         VsChFPWqbCEN6iv03izjPKKCSRD65sYoZRjoc/aLtrWDCRffxdZ0qlAWtq4sHF0bHjnu
         oJrhmN91Dm1g/zbnZvWyoZOuhtCazQq31nEDoYVSWp7AD7riSK6DwXLKTgdnSVjJBflI
         ncDk6kEdS40XszFaRjsfrl86R01fumPIF50NLo9rXqDNn0vHxE33WrvbvJ7emnzVv89n
         UxOUKoVFmKWyYiNGbhtRMXNhYSf1++LXXcumCNiNkKBgxmWDQ7jVOq+jgwTv5r9roKxq
         2ylQ==
X-Gm-Message-State: AOAM5334jnMKQEGVWrhkuY7l58rvhUyVxqimQR6dh1GoSOnG9nUAti2c
        OHFPaUNFj1vOhlbEnmYbb6ds7A==
X-Google-Smtp-Source: ABdhPJzNVoLlmCiafNPTUNImFxjozsh2/voaziymVaz7SWMkKprBhenAlqpLq+wsa5VwQmkrF+P2QA==
X-Received: by 2002:a17:90a:32ee:: with SMTP id l101mr6855322pjb.213.1592118633549;
        Sun, 14 Jun 2020 00:10:33 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id q145sm10483669pfq.128.2020.06.14.00.10.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 00:10:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] smp: Fix a potential usage of stale nr_cpus
Date:   Sun, 14 Jun 2020 15:10:20 +0800
Message-Id: <20200614071020.86037-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_option() maybe return 0, it means that the nr_cpus is
not initialized. Then we will use the stale nr_cpus to initialize
the nr_cpu_ids. So fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 472c2b274c65..2a9a04acf123 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -634,8 +634,7 @@ static int __init nrcpus(char *str)
 {
 	int nr_cpus;
 
-	get_option(&str, &nr_cpus);
-	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
+	if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
 		nr_cpu_ids = nr_cpus;
 
 	return 0;
-- 
2.11.0

