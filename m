Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8202067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="G+DZxD0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGPHFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPHFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:05:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:05:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so3237507pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryP8cAu4wXnxt+VFYVN54rpFGELZrqJgme1cG9J5OqU=;
        b=G+DZxD0YAith1B1UP6I+ej0HyRvbj9dcbS2NtkptlwIxknfaVmWYjzzvWYIz5KnojX
         QKCNvXBHj9ekbupKZMyqMP69g9WaVr26KE9OpyNfjbJ0NAT2N2wcWrvZ0EMwKPyA7iGQ
         mArq87+Z57DFrnS1s+H0JFCHkwy5VP+mPvSd7WQnm77BRAXm34FfBfTmXY/2DB9IpT8/
         lfNKPpOtIgOe8SEdEdYYmRnczKGfaNTzl03pWV+EjVxwkP54YNmrcAXWUrKtIsLMEsbk
         s9slfGGmnvox7s+snK+U0VdnCS9ArJyGJmJ07Tr5r1WBMu3PTcI+C8JQwDX/aSvC1gW0
         IFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryP8cAu4wXnxt+VFYVN54rpFGELZrqJgme1cG9J5OqU=;
        b=SD4dKvvDJjT3e7w5cwTRNKc6u4GPNaLpf6LYLs9r1IzGo0lEzb0gm40ZRnon9YBEpw
         i4H7jYLEfkbXA1yHGmL1UJ+A7e1JVjClg236PkdytPZkPJQZsHQvEI6p7MiuYGe66u3o
         agUbzz9lR3rlOcZtVIXfxI1SkIEriqjcLlMDSv4xE88Y7fuvyOGKT5+OzUIE1VKONQrI
         z55HTyffOH3oawyYhzPyDPvQWB9NGsWvS35jRPWwzMeFPNCKZc+78n4IxKVnVx5lBEnN
         Byou3/qAbemzepcpwJXBzIf1Gls497pV2btmETPV274Xo8EZ5VsrseQRSUVojVkwDlO8
         Y4Ow==
X-Gm-Message-State: AOAM530hosldajhvuV9HkI9BRpVCLsoEnzdMqmi4GgWh0INP+xNkpODA
        rAG1TWRiRcKabZfsBz5RnCEKYw==
X-Google-Smtp-Source: ABdhPJyCGDBuKMoR1lMMNlBRqbnhkR5f8IVQjijFy3LK3JSFNhKcBH5/A7gpkZ1KSsTr6wnTtBcsXQ==
X-Received: by 2002:a63:4b44:: with SMTP id k4mr3200939pgl.305.1594883109390;
        Thu, 16 Jul 2020 00:05:09 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id 64sm4286950pgb.63.2020.07.16.00.05.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 00:05:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND] smp: Fix a potential usage of stale nr_cpus
Date:   Thu, 16 Jul 2020 15:04:57 +0800
Message-Id: <20200716070457.53255-1-songmuchun@bytedance.com>
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

