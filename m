Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC371C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70832206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="takVL8CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDFHsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:48:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35773 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:48:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id c12so5601962plz.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sy3+CnK3aJQFxNlJGKsfXRCVNXkjSadKztVU/sq9rEQ=;
        b=takVL8COdVXG8g83n/9c45esWVh8dnArMXnd6GJFp31OjDlnW+PpVgXGy87fiCaDq3
         SgO+Y9UjJlMjNk2IJczz+rHcbrBUQhRvbaobRjQC1Bbum/JO7bQM8aIKWbKIrB04WQ+H
         w22n7UblB7tfU/k7L0TlSRuMf6B7DQoaHzcCEWq/XR6u7oZprAR4hbY6L0lw/wknmlsR
         /xin29AS3a6lVNzxAbB2TLGnYNnVl6yI49F6OYsjrPj3JSoV14LWyrQMGrtR6U8skdze
         r92RrUX30EESGjjdOzAR+08cRZ75e2TAnjuh6ceD2psYYCU9lDAvTrEyUMXgbwDvAiSY
         PSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sy3+CnK3aJQFxNlJGKsfXRCVNXkjSadKztVU/sq9rEQ=;
        b=KrwYHKtp5MwrT9VCKZjnsRkga4DJ/8AxXhFfOUlJuT4Ofx0uvsWv1MZ3dn6bYPycbY
         VO5HBB5YKVl7P9Up0iJuE4pmWzukv2CFg9MdT8qiwN6tTKpNkgrXAnvNysoHGq/fTiAp
         yl6k7lTfnW3Fep0tugs6EcQp062muIzVANKWk2O8btGWkQSpRk9AJGd7OCBYlMUZDfZV
         onRhQhxQ2sFNJXY/v0yf3F/ZxkhoSMAwRiQVoJx99fh0LH46l1inLe6EPgJJJ1ex4p18
         UQ/9c9djnLsAb0dNOEXAaMGb3E21eQjyvrY8LjO2DQV5+H29V16wsUdx4h4JwXrqjW2P
         p2FQ==
X-Gm-Message-State: AGi0PuZNroz9NPFv05ObCGJAZ+sL2ldpYQapflAhS5sNRjcnhIF/9DoN
        OpYq9gknb2AmD8QfodW4hhg7XTLAyliBug==
X-Google-Smtp-Source: APiQypLGWMbwNk5TQn7gNKADnE/e8+Of3ff2g6/F2dJAPKTSE5OIplw+mzy+ukbysPSThJFDhaocpw==
X-Received: by 2002:a17:90a:e289:: with SMTP id d9mr23977896pjz.172.1586159302456;
        Mon, 06 Apr 2020 00:48:22 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id c207sm10993308pfb.47.2020.04.06.00.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 00:48:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] sched/fair: add __init to sched_init_granularity functions
Date:   Mon,  6 Apr 2020 15:47:50 +0800
Message-Id: <20200406074750.56533-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sched_init_granularity() is only called from __init
functions, so mark it __init as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1141c7e77564d..6f05843c76d7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -191,7 +191,7 @@ static void update_sysctl(void)
 #undef SET_SYSCTL
 }
 
-void sched_init_granularity(void)
+void __init sched_init_granularity(void)
 {
 	update_sysctl();
 }
-- 
2.11.0

