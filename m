Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79299C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574B021744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+cx1OBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbgGaMWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbgGaMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0906C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:22:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id lx9so7654524pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FxsDgzNEqcc+GXlTBcfp5pXxxLZ1MIauOw9FRAHNDPk=;
        b=j+cx1OBS8E2bvt6ejm6GtzbVnuEmdrBXlXUDGDyHS3BN14d+J8qglCNA8P5dyscdbE
         rhejc2/0Tv6FSxi3a/KiNIknFxgHibNSBa7BstR1B4aTgDmtMwDvpFjTrHrgQiV2Io4n
         87litnwpe3vNHIVjCOHjje2lKf9c1C5TVWEFzHZZ9m9xj9jIAqOfWvVQ8RhPS30KKPdC
         hu/De093jGTRJlfZ33ye+FvGa9Y8IsXm7OSUv9jTYCPqIp7RPzo1LVbYwK9SBIMZhC4X
         ZV/NQmbTRf7uXrYGvEK81AEqwsVkAFqUfj8WjxMGmm/Jb998vCq0Exbcfie0jdmxPt4x
         k01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FxsDgzNEqcc+GXlTBcfp5pXxxLZ1MIauOw9FRAHNDPk=;
        b=OZdRiijunaI7qomH9klwewMPmBgllvCKVT3AF0lbix5Njuxnw4UWcyfIHks7X4zhMC
         qE3vm1gWGNrxpfXDk5xB3mt2upvL0dX1OhDv8Box0ArxBqtUlAurmRM69ZkIBT3NvKeH
         4g3He7+PD4V0iM1gJzs1kubEa1TX+s7bD9HtqNupnqRUqh7HcCKEiDbZOZTVQO6owclz
         ZR7xPZDN47DFndOO5BMv52FXvtE/N+Tc8M7MxaPZY20Tf1BQ7pI9vuOTN8HdoKwoFBpG
         zbIFcHwwv6Vnsd+um0dAEY7qomNuBfVdkwgZCsPXvyj5L0L0f4BPA11FD0Q3z+7dhhy9
         FTbQ==
X-Gm-Message-State: AOAM530eCqrEQOiWkxm6Lfddmw/+xv2jA5/fz6M67ew4fMiMugI0i2Zb
        lEX8Shw4YB9JzR1Mb57zDw==
X-Google-Smtp-Source: ABdhPJzUP0XlaaSdllhCQvfkKWyXnPWpkRM/rubUSS361NwIYKwTyjoKlfCaqKjl2tjfdfAQMWg12w==
X-Received: by 2002:a17:90a:ef17:: with SMTP id k23mr3484135pjz.45.1596198127344;
        Fri, 31 Jul 2020 05:22:07 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:22:06 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/16] mm,hwpoison: double-check page count in __get_any_page()
Date:   Fri, 31 Jul 2020 12:21:12 +0000
Message-Id: <20200731122112.11263-17-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Soft offlining could fail with EIO due to the race condition with
hugepage migration. This issuse became visible due to the change by
previous patch that makes soft offline handler take page refcount
by its own.  We have no way to directly pin zero refcount page, and
the page considered as a zero refcount page could be allocated just
after the first check.

This patch adds the second check to find the race and gives us
chance to handle it more reliably.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 6f242a194c64..b2753ce2b85b 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1694,6 +1694,9 @@ static int __get_any_page(struct page *p, unsigned long pfn)
 		} else if (is_free_buddy_page(p)) {
 			pr_info("%s: %#lx free buddy page\n", __func__, pfn);
 			ret = 0;
+		} else if (page_count(p)) {
+			/* raced with allocation */
+			ret = -EBUSY;
 		} else {
 			pr_info("%s: %#lx: unknown zero refcount page type %lx\n",
 				__func__, pfn, p->flags);
@@ -1710,6 +1713,9 @@ static int get_any_page(struct page *page, unsigned long pfn)
 {
 	int ret = __get_any_page(page, pfn);
 
+	if (ret == -EBUSY)
+		ret = __get_any_page(page, pfn);
+
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
 		/*
-- 
2.17.1

