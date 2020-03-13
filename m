Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C7AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087BC206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6zu35EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCMDKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:10:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38984 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgCMDKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:10:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id d63so7886951oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hbgniz1KICHBiyzs7HbcZAYxLQx9yaTRfc0Ur6qyrFA=;
        b=l6zu35EC5jZiSfiq/F2OiEI3o+cXYB3vRgVYlzUUW38s2rRFBgCbMoX2dURMXnz1O2
         bjQYfFrwHKL+Q1YDqnLGN+q/UWu+HiNdg9rea1Ror1O2EUWpBJjyTwgEWFw/YRBVe9jz
         sibZCw8AfomDGgwi8Muqr2bIaUYa1R8hGck3BtsURH70MTLpHNr0VGBYyCZ3jgDH6gx/
         PbYzvj7HOk8ClVcY6+nGuHswmzc6fnnl6wcKz9f149IQB9xQVe9IytyZ9VMvPGmgKjf1
         KvuL0amDV7YQnFNBSB8rHDd32dLBGpDlj7pLpXoS221kPK5b96LP7vfYlaRS5UrGoD7+
         VNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hbgniz1KICHBiyzs7HbcZAYxLQx9yaTRfc0Ur6qyrFA=;
        b=HRxgDDCxxFs3gw46SrC8LwaqkdNcVyEGoMTHwQ5cQnoDyHWLo4A+pa7Ne0t11w6KYN
         /3HqArLBVtfK7poKPuf2HuxUrJdQykRBViwZcNDlUW1qqpwd8BEOT3EqaibTtxAYpE4U
         46LRykzCpApVkRu0u8JMBx6KrkSVvZNi6o7WXiSsSO/bCfuEMjX08YfEbjR7R/WJD38G
         4FN5L+IgNfeXgU7ts+ATRtmyt/NMeZA93MPQ7yTw2U3VdLg+7f+8igjZE3Gv60L9kqzl
         h/HS34mei/9ofKGMg2s8ofqnhF0CcUETobO1ljXYK+KZFcPemkmfpXCIo/qZJ3uTHJXz
         2uOA==
X-Gm-Message-State: ANhLgQ218SHMjZUlFIm1hOM52qFc5whtS5e40ph6HuoJtPcRBgLHFTDq
        HMNnuP9jLck/PqoYqE3kwYpu0QiC
X-Google-Smtp-Source: ADFU+vusI0iP6ekgedOIv+1cpqQPYli+tad0czpVJcz1FWXl5A2DC9qnqyY120IKaK3SNUgrs3J+sg==
X-Received: by 2002:aca:5f87:: with SMTP id t129mr5460231oib.36.1584068997580;
        Thu, 12 Mar 2020 20:09:57 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.32])
        by smtp.gmail.com with ESMTPSA id k21sm5794812otn.58.2020.03.12.20.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 20:09:57 -0700 (PDT)
From:   ling.ma.program@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     ling.ml@antfin.com
Subject: [RFC PATCH] locks:Remove spinlock in unshare_files
Date:   Fri, 13 Mar 2020 11:10:17 +0800
Message-Id: <20200313031017.71090-1-ling.ma.program@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Ling <ling.ml@antfin.com>

Processor support atomic operation for long/int/short/char type,
we use the feature to avoid spinlock, which cost hundreds cycles.

Appreciate your comments
Ling

Signed-off-by: Ma Ling <ling.ml@antfin.com>
---
 kernel/fork.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 60a1295..fe54600 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3041,9 +3041,7 @@ int unshare_files(struct files_struct **displaced)
 		return error;
 	}
 	*displaced = task->files;
-	task_lock(task);
-	task->files = copy;
-	task_unlock(task);
+	WRITE_ONCE(task->files, copy);
 	return 0;
 }
 
-- 
1.8.3.1

