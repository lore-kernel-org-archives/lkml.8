Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BA6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C171A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRdZ04hI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgEUNuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgEUNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:50:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CFDC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:50:11 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y85so6205845oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=+rx34frGAhxyFDztnsG4UwVe/jVB01cbcYcfehMFKm8=;
        b=kRdZ04hIwcg5sBPK4ZhOUKQ/+STfLXkTdU84uMqlC08Tc2YPDWygXEH7X+YlXQLiJ1
         9gvo9hHQo1liVi1sL/9l5aWnHUTFJo9laFK227tXIyQva+USV1GWzP5eDF0LeZ73cX1b
         rxUshQh//HagrZkGxp/e7RIGnDHRl/jDvkMN1G3P3uhAKYLTT9e2QXK29XMFV8FrOhoD
         4d/ULAkAXoPNkDKJCyr8489YH3miJ5sAOeQUs4iLLxQDWbA+ltkCQDTItEN0GaUSWzS5
         gawh9LukYIKnqmGkntX3ShtKxhORzdJVDObLxpu/VffC2Z3L1gKBxmX+LS0erxSK5BaR
         BX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=+rx34frGAhxyFDztnsG4UwVe/jVB01cbcYcfehMFKm8=;
        b=iXWFFyKHoX/eepsFES/UK+KRXLwhyxhILEB9wb2bgSiQXj0Ur3kmAoKLYfJ78gWzOK
         ohZZ2T8xEMYTsufQeFUIzSKFsI7HAftxf0Ae1aSy6B8WbU1i1wRMctG1MtxRTeA5UkNi
         S9WLOKq7HMFRenSgvT4lRQfDb0gRz0aAR0QNptUGZe3jKezm3ndthN/a2mBdCWnM2N7y
         h/2b7QilQAHELbx0ah+Bokj4CCxrJfgQUA7UoqMjGwUXyfXyuypaJG5E9F4uNct2cHU/
         ADtVHbDVUWYlpw6zz/s8ID4orc8nIrNC7ew13EH7BGLkyF/RlxKDro0URYCVf9YeRaM/
         nkjA==
X-Gm-Message-State: AOAM531maAr8vx81NRUrZxqL1r/nslRHxl7jcqTjfijhH8yasj83wZ/2
        q6ahNaiBFbxLOKZ6Pf4zUBooUA==
X-Google-Smtp-Source: ABdhPJyhaSNhjeHFlsDhzLGECwTxxbYZQS3ikIOsP8AocLiNXEM3A1jjJtyElbPfeZXokR8Vgsc16w==
X-Received: by 2002:a54:4512:: with SMTP id l18mr6970406oil.81.1590069010565;
        Thu, 21 May 2020 06:50:10 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q16sm1599162ota.3.2020.05.21.06.50.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 21 May 2020 06:50:09 -0700 (PDT)
Date:   Thu, 21 May 2020 06:49:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm/vmstat: Add events for PMD based THP migration
 without split fix
Message-ID: <alpine.LSU.2.11.2005210643340.482@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 5.7-rc6-mm1 page migration crash in unmap_and_move(): when the
page to be migrated has been freed from under us, that is considered 
a MIGRATEPAGE_SUCCESS, but no newpage has been allocated (and I don't
think it would ever need to be counted as a successful THP migration).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Fix to mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch

 mm/migrate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 5.7-rc6-mm1/mm/migrate.c	2020-05-20 12:21:56.117693827 -0700
+++ linux/mm/migrate.c	2020-05-20 15:08:12.319476978 -0700
@@ -1248,7 +1248,7 @@ out:
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		if (PageTransHuge(newpage))
+		if (newpage && PageTransHuge(newpage))
 			thp_migration_success(true);
 		put_page(page);
 		if (reason == MR_MEMORY_FAILURE) {
