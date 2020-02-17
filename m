Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068DC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6432070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="svQmUgZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgBQPbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:31:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38132 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBQPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:31:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id i23so2125042qtr.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H44Dq1iyOa9lIeDq8Fjbn2xBgEZ/RfgwiE5O0myRxMY=;
        b=svQmUgZ/l1fZZZUwgQbjPvIm/hmPGUR8QOq+oNqwoTqEQrSU5eI66nUSxm8YbdDeCM
         nFVCc4jRCh4hxYRYM2sElMG3aglsUfrKA+rH82tlcqjv74x59Wms/ElBT1pm697kYfqN
         /FqoKK046fFlLxn7h66NmOwKHGmA1z+vlBONltdNSIqB+0ovRJ7/mIK1yswoLsVuAXGS
         wJVInSm8zoDsBY5A/1/lhecz1Tll2+Rptc63ZCfF2+Ul58h0WEC0zVNZVdM39pkAeKpR
         /WyQ1/xOdE9/Jdpc+z6LWkJBg4RjoyV/7XwYbSIyjGbtCO1ulvagjjWuiYirDRFF21q+
         8GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H44Dq1iyOa9lIeDq8Fjbn2xBgEZ/RfgwiE5O0myRxMY=;
        b=V5xNf249q9frqTr9pmYUkehPCn/VFwiCE6g31w48bkXuQPAD8RFqBTgbvxxpcpps5a
         4FdrhBBm0gH4MkJX0exns3AnZMrR3l/hPvGQvKwKvFz87OLJrkNymmTiAWiLKrIPVgL5
         RS2v6dZMbW9yThsZTBIrKC/pZXS4bW7IAlLR2rrniyeN8shvzq5sixZOfoLePf0ZML1q
         39T1FUpzQOqPUw3l6pVOQkB/oy/gG1Bwta+dvyqduYy3GPmhDig2jPTWA/985J4tl6P5
         NzVIIZmqf4Z5aj3ZzrLNI7yjcIuj9Al8DyXhmuDk1dtXBBuaq2JZPQYCtjddKVU++kUY
         wqNQ==
X-Gm-Message-State: APjAAAWempjmWOEiICYwej7Xedrt5h0KzEu/5GOkvnYF7NmVPFQHbNk3
        4g7Yr6ATsHLviuUeU4m4o4+wXfNukfo=
X-Google-Smtp-Source: APXvYqw08zLlS+PNFVz7Zav9IXLuAmIoWLiKJ0KmxRgWf3vfWJ2X0a2/x7gyDSi1Puf58C88lh5rnQ==
X-Received: by 2002:ac8:1385:: with SMTP id h5mr13257067qtj.59.1581953472159;
        Mon, 17 Feb 2020 07:31:12 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p19sm339399qte.81.2020.02.17.07.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 07:31:11 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     almasrymina@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/hugetlb_cgroup: fix a -Wunused-but-set-variable
Date:   Mon, 17 Feb 2020 10:30:54 -0500
Message-Id: <1581953454-10671-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c32300516047 ("hugetlb_cgroup: add interface for
charge/uncharge hugetlb reservations") forgot to remove an unused
variable,

mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_migrate':
mm/hugetlb_cgroup.c:777:25: warning: variable 'h_cg' set but not used
[-Wunused-but-set-variable]
  struct hugetlb_cgroup *h_cg;
                         ^~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/hugetlb_cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index ad777fecad28..8a86a2b62bef 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -774,7 +774,6 @@ void __init hugetlb_cgroup_file_init(void)
  */
 void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 {
-	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);
 
@@ -783,7 +782,6 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 
 	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
 	spin_lock(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(oldhpage);
 	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
 	set_hugetlb_cgroup(oldhpage, NULL);
 
-- 
1.8.3.1

