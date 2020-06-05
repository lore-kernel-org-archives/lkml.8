Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A87206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgFESPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:15:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37136 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgFESPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:15:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id x22so6375555lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 11:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLtVBAQHt79nrKp5l8gcbQoeTzLDxbZbAEut5UfqQPo=;
        b=awgz5BfPntR7n10eECfi7FiVWnkSDYIVburQtOzUeGSK+thIx/htnoWC31Y8SvrYN1
         vOck4ajTt1BvJQvhG/Dkdv4GNb709m/n+GiiAiYYmkXkYeR5Dkdut5SbDZit4AW8l5Vr
         QrBxJH7+GyfhwuiwwUKOFspy+WWiXBVlq7zFshf8GJnpJTNresmQBj3aw48S2GuiwLne
         6MfmLgXqHB76D2WlUtpXp11dZxHgvjR14bv5REMblGNp2vHpCBhfKlI7zAcLRNz8+rzr
         Y8XWMiVcSPWPHR/zgBgtIkvVHPwPnsrNB2njmuOgMOnxozNVY+MA+REf1TR5Lea26lZH
         7GsA==
X-Gm-Message-State: AOAM532UEDYpQD2zgaI8+ExCuGV6DBqQBZhaXKJqL1qVLpyHAa8RXjqo
        AWw1+Q8IgupxE3ze2GDKGkc=
X-Google-Smtp-Source: ABdhPJzKHMsKE8ClyLyxqEZg6cRGaaIv7YE5pplZGmBmwx4+tTKTkQhw2OhUzUAPoKaz5kP4NqBFBA==
X-Received: by 2002:a19:642:: with SMTP id 63mr6064091lfg.173.1591380941170;
        Fri, 05 Jun 2020 11:15:41 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id x69sm1254625lff.19.2020.06.05.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:15:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] f2fs: use kfree() to free super in read_raw_super_block()
Date:   Fri,  5 Jun 2020 21:15:32 +0300
Message-Id: <20200605181533.73113-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree() instead of kvfree() to free super in
read_raw_super_block() because the memory is allocated with
kzalloc() in the function.

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8a9955902d84..9a3c8eba37e2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3130,7 +3130,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 
 	/* No valid superblock */
 	if (!*raw_super)
-		kvfree(super);
+		kfree(super);
 	else
 		err = 0;
 
-- 
2.26.2

