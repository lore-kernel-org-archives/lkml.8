Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB0D2224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW+PgodN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHFStk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHFStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so7313148pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrNOopevZrXOPbrUYdqc/luUXjhR4msmU2SD/x7wn8s=;
        b=dW+PgodNF48RAaGwGN8hRaeeIti0F2ClybxPtutZjQItbJoVlpQkZDO8YGZYhEI+3i
         3TUAxO+QufKjTV1DjSHQMdIzHR8kNbkPiimWo01mkhkWReUmIT/MU9HROGCVkwsrcuCQ
         NbzIx8sAdB1hKjhQLcO8nVs/hnUfCR1P7oDITfdVwT4gebqg27MKuQrFurk9DxYw+8q+
         B9SdiirdfpyLP+6gdCPpJmMyt1QnRfL6SD5QWWPmbHHMB/hV3Q0IF3UChhGl4/uvng9t
         fpix0/uSNL+B4TnzZpS4SGzg+es9VjEekHF7iDNSRgxqyXXFLkUgdvHbzw2wjAxwmmiz
         LkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrNOopevZrXOPbrUYdqc/luUXjhR4msmU2SD/x7wn8s=;
        b=tKxfZ1Cgk6onDdapT/ThNjhpqUXOuGmxapAJ27OpioJOUDIuaVnJLc1Ox56EXTAhEE
         OCbXiGllqkVvJjX66ml+2kXk6gD6gyUUcDgv494jE3ng7jL/6TkE+RLhKjB/pPVbEuuC
         Bj1OZqBhqoO2sYTxWmANXkV9CWgCykAYciISsdR4JsQ1NzF8MwWSYOXv1XxecdyHXcZk
         Zi/V4r5Bjn2EQwCWfq7SqzP85wu7+bewFsRpGETxHbq2Mm496P+yE9WI4FPFTimADBxu
         2DmOMXrz4CiI11prDzwNEQLEmD5uniWmGZoZDO3OHlXNAiQRNn02JwFpmmcaBCxnJ7/Z
         k1Bg==
X-Gm-Message-State: AOAM532T413620OO3CohPmT2n2sDtHn3sNEiY7OnZnEN3hucJTcjm+42
        MW2ParvFbQyS05j93TDmUQ==
X-Google-Smtp-Source: ABdhPJyGlRH9DZJICHEHHkgFtaCUSUovuGikU1NNYN8M6nMZv0PwUA/D0NIWAh5ptTVDgEknCjeFuw==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr9036876plq.135.1596739775259;
        Thu, 06 Aug 2020 11:49:35 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:34 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/12] mm, hwpoison: remove recalculating hpage
Date:   Thu,  6 Aug 2020 18:49:13 +0000
Message-Id: <20200806184923.7007-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

hpage is never used after try_to_split_thp_page() in memory_failure(),
so we don't have to update hpage.  So let's not recalculate/use hpage.

Suggested-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memory-failure.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 3d2d61f1c6e9..f8d200417e0f 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1342,7 +1342,6 @@ int memory_failure(unsigned long pfn, int flags)
 		}
 		unlock_page(p);
 		VM_BUG_ON_PAGE(!page_count(p), p);
-		hpage = compound_head(p);
 	}
 
 	/*
@@ -1414,11 +1413,8 @@ int memory_failure(unsigned long pfn, int flags)
 	/*
 	 * Now take care of user space mappings.
 	 * Abort on fail: __delete_from_page_cache() assumes unmapped page.
-	 *
-	 * When the raw error page is thp tail page, hpage points to the raw
-	 * page after thp split.
 	 */
-	if (!hwpoison_user_mappings(p, pfn, flags, &hpage)) {
+	if (!hwpoison_user_mappings(p, pfn, flags, &p)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
 		goto out;
-- 
2.17.1

