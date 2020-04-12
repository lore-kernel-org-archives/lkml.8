Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D6EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D86206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uubjIeh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgDLOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:44:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46475 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDLOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:44:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so3412717pff.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0W7uHCjDyMa+0dNrN7lUAz8pvlhi03yh6Fbez8d2lWk=;
        b=uubjIeh1pTOdnND4uGqw727a3xfbZWztjDlAuLlR/u+aVj0B0y1NVNwHHjx3Ktg8XL
         lKxKyoVWygmAJ5i01LdyRibUIaGOgEoQFBDUK+RZqxe/QXaHj48c8f2jg8jkzEobcoJi
         wk9l+DTjkV1tS12f4GqiQD9pA6+mO5NIn9eO4zyKgRI90yX/Y2rCHFOQcFBDIT3xqx+4
         keUgmBqXILocSQNDIJhBHJkXd6G48KiVHNs7lYS/6dEfqTj/L/OPDzTiB2VtyAbNBWbk
         bxMUjkhEhr+4ZYiLDcwYANiM2ZhXUEUDaJMVltGP86xCFzsCmmi7v8ztjIPtmTJ6kInG
         93PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0W7uHCjDyMa+0dNrN7lUAz8pvlhi03yh6Fbez8d2lWk=;
        b=kQXx3yImDVXkhCtiUTipXsYnQYc7wCP+Zk2+YEgis7kEIAXWpcskdMFb+6GonPcpUN
         jwnbfXVn3cxsuJG5U+kdeU7WpBB1Rk4YDGyU88YkTafG7ioj7R1+HaBk6B0iSX3URwLf
         /ddqLwguslfEzPHGEvoMM41Z9VmF57wU0nHc7lUrnNKXzohEzbIjTSDD6Fa8WXmHdate
         Of+yOrz0do9G+MqvtdMGXG+HZmzn7PCQ3NTEBXXghlFiR3XgoGurYxe0uQT9eELVGrYF
         CqGwvDQ9HsL2iPsVag9ITAEomfQ6jn/dtQXrUZ/fFu4+yiHa8Dnryx2bS9LvBF6IE30c
         hFFw==
X-Gm-Message-State: AGi0PuYh1qoG7wX3FPNZkNobdlUu1xtklb7N62hb+2czpojZYVfK6D2b
        5X8WHFprdJvjZHwWWY5VspDNpQ==
X-Google-Smtp-Source: APiQypLvBkmF1914266pEdXmc6R9hkHTznF9SLcrWx9Dd+EkOJ3uE/Wh+foYsluDwRE2fSi1996HxQ==
X-Received: by 2002:a63:d049:: with SMTP id s9mr12533544pgi.384.1586702651661;
        Sun, 12 Apr 2020 07:44:11 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.71])
        by smtp.gmail.com with ESMTPSA id m11sm6314641pfh.57.2020.04.12.07.44.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 07:44:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     jpoimboe@redhat.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] objtool: Remove redundant section name comparison
Date:   Sun, 12 Apr 2020 22:44:05 +0800
Message-Id: <20200412144405.4423-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the prefix of section name is not '.rodata', the following
function call can never return 0.

    strcmp(sec->name, C_JUMP_TABLE_SECTION)

So the name comparison is pointless, just remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e637a4a38d2ad..401963179f1b9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1361,8 +1361,8 @@ static void mark_rodata(struct objtool_file *file)
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if ((!strncmp(sec->name, ".rodata", 7) && !strstr(sec->name, ".str1.")) ||
-		    !strcmp(sec->name, C_JUMP_TABLE_SECTION)) {
+		if (!strncmp(sec->name, ".rodata", 7) &&
+		    !strstr(sec->name, ".str1.")) {
 			sec->rodata = true;
 			found = true;
 		}
-- 
2.11.0

