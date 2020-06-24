Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE06BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3CD206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlUun5E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbgFXPCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404165AbgFXPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so1547734pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8PwurQU1NxfpMHJph1B1p7tgGvKbCO2GLa0tif4yXmY=;
        b=OlUun5E3PI4k9fogy7yVJiNq+TrLqHRnF/eCqpsxsTKrWCCHAkjh99qm8Kji4aD2gz
         KHzGjJmD5OaGQ/wF2rZ0iHiPc4z3oOuPThTrnL54c1Pn16OfcWOlGTv6GgToadt6HEW3
         IPPESdDzY/Y8HrXQ55n4wc1scWF08vao/QkxZ8cUtcJNSZ3OGyq01R2sVgtKEGeUZat3
         3269OGDWCJOyXGceEmtJd/CQqeu5PhtHTmYMqoke9YDN6yAb/WTsK6KTPkqq2klAY3ci
         ejtgjnMSjft5/g5uE2QYiHq3Nxd/rsLxKVMBS/tsX4chYx8Ol5YEISRvXV2kKdA4bBzZ
         S30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8PwurQU1NxfpMHJph1B1p7tgGvKbCO2GLa0tif4yXmY=;
        b=RhpSGrY/GrsnxtI71Lgj0h33Y/YeaMa8ZLDn5G15Ba7iIP/K1b73WUMkCHRjRQQ8Bk
         3kNeAKwrAiV3T9iSNm6CM+34jocSvkM/32W0Bp6LhPLL375hA+QrMyBkKJI8Qe8Hbl9w
         hzWTXInUOah0ixlRaCXrs0jUdln0ULpIc9iqbhOWt9/VF4+NTT14DIFeNTAv1bEF7UFm
         +P5sJwtaKxk9x4nEficGo9jBK8VjvhdbsZiTANbKFW9iTGhcrzT+vjP/e+YpsBR98Z4L
         XZg+pfoXZjIAQUBXG58kSa6H6AiZ+bWFcmsKEDgrPPL9yaOse9d+OhjFBNe4KgOj6038
         HcrQ==
X-Gm-Message-State: AOAM5305d/Ny44ZRxtmT1+qxst8GDpRwmVX/4MdlG8rPslK+Vu7rSH8l
        mN/g4BMa7DYdOGy1JuH42w==
X-Google-Smtp-Source: ABdhPJy3MaesTnbKm6iBd8AhiEdgYeuKwEA3AyCjJp2Ekr7kLhIMvv7gmu1/KH+Vc+k2Wa4yMwId2A==
X-Received: by 2002:a65:6710:: with SMTP id u16mr16022611pgf.45.1593010914695;
        Wed, 24 Jun 2020 08:01:54 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:01:54 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] mm,madvise: Refactor madvise_inject_error
Date:   Wed, 24 Jun 2020 15:01:26 +0000
Message-Id: <20200624150137.7052-5-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Make a proper if-else condition for {hard,soft}-offline.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/madvise.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
index 275b08edd428..bee1f4ac70d6 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
@@ -869,16 +869,15 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
-	struct page *page;
 	struct zone *zone;
 	unsigned long size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-
 	for (; start < end; start += size) {
 		unsigned long pfn;
+		struct page *page;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
@@ -908,17 +907,14 @@ static int madvise_inject_error(int behavior,
 
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-					pfn, start);
-
+				pfn, start);
 			ret = soft_offline_page(pfn, 0);
-			if (ret)
-				return ret;
-			continue;
+		} else {
+			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
+				pfn, start);
+			ret = memory_failure(pfn, 0);
 		}
 
-		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
-				pfn, start);
-		ret = memory_failure(pfn, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.17.1

