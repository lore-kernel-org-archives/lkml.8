Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C3620855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9dW3ysc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgHFSuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHFSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:50:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:50:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so17607654pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q96l39vKYd7IRXWt1EwDmgBCl4Rsm+1NIezF6mciM4E=;
        b=E9dW3yscPVP6RVcDUq47mGdZrysJ2Y2xuRGdoD91TZWH5t/JUh2muJuwL694zqkPC0
         DEH4YDFqsrDR1qX670wy1moZlPfDElRst8R7BtycOLc2ZLIzhpqHtwMGjtyOkSLBdl88
         mWF6Jux0286C+SZ2QRRURZfTdnxMVVFbbU/BS6dtYSRLI5cfmFUp/Qq/X9QxGxixAeCs
         KZ+iv3V8/T55lk/nBJiwiRDxgQWKPikmr70iHQ8zj/EdKUdY0ooz/NJN/H/R8B0Dthri
         HoCuq/IViLUTM9H3sSPr0QRuQFc6PXmcEvo+JydfIwT1u5Ud2hn4ck9uaHZxk6BGHQVd
         +lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q96l39vKYd7IRXWt1EwDmgBCl4Rsm+1NIezF6mciM4E=;
        b=lsWBbhw8UtWA2LP57whjyfGjbFMMJyQZf8cpAxS1C9+yacvHcjGqtoeV1exJY8royz
         +19DlLAu2fTEAjbJQF2Vpcfw15NLilUfhaERAnRfwapNFQAegUaKlgJ906cupbvFbOPv
         Vc9PC9AJvhO2jFV6IQkTAcEm9eL60kSOhaWef08OENZog4e/24TeSXcbLIFQNdACHn8Z
         LCKcI8AVl3/OxyIdbd62N1ccCwReWGcUf+hlrlbh4baTUc3pEnm1Jpj32Hx2gWOGMR9H
         obHfn7A7uakdjyROG+pvq/VgSbj7dz1LAPe6NIHL6djKhMaLcduXHQp0597g6b0czXe4
         so8A==
X-Gm-Message-State: AOAM530YeNYRvuYxevu9ps4I4wI9AW7Veu0m4YOE9npnI7Y2QM1ql9xR
        4+CsfFMWfZuoZ27bQAzfaw==
X-Google-Smtp-Source: ABdhPJzyAOl6f8GurQSE/pAb6JOOOWA70SkAjYtrFV/WXE9aqoYXoBRZ9K9AEkMSU7inSVE5k+6IoA==
X-Received: by 2002:a17:90a:1fca:: with SMTP id z10mr9642021pjz.209.1596739807113;
        Thu, 06 Aug 2020 11:50:07 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:50:06 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/12] mm,hwpoison: double-check page count in __get_any_page()
Date:   Thu,  6 Aug 2020 18:49:23 +0000
Message-Id: <20200806184923.7007-13-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
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
index bed4b6aac9a0..e6f6559d573e 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1700,6 +1700,9 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 		} else if (is_free_buddy_page(p)) {
 			pr_info("%s: %#lx free buddy page\n", __func__, pfn);
 			ret = 0;
+		} else if (page_count(p)) {
+			/* raced with allocation */
+			ret = -EBUSY;
 		} else {
 			pr_info("%s: %#lx: unknown zero refcount page type %lx\n",
 				__func__, pfn, p->flags);
@@ -1716,6 +1719,9 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 {
 	int ret = __get_any_page(page, pfn, flags);
 
+	if (ret == -EBUSY)
+		ret = __get_any_page(page, pfn, flags);
+
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
 		/*
-- 
2.17.1

