Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEDFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6347A20639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=popple.id.au header.i=@popple.id.au header.b="C3rzlWdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgHXJ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:57:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53387 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgHXIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:34:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BZlmX32Kmz9sPB;
        Mon, 24 Aug 2020 18:34:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=popple.id.au;
        s=202006; t=1598258093;
        bh=B7PNZnSY6ZfbLv7chxp4iihY52HWlmjN0VC92TU+vSU=;
        h=From:To:Cc:Subject:Date:From;
        b=C3rzlWdckFpUv3mCwBnbKR3eu8hr/yMHqefUWdAsdba4EFZYwEqsUkQGgyXogOSGf
         JFGbpHuV/lcVDquhEERC1Zc91krNoTEXixwPTJ6wmttuWNII/Fyvhj2TU/uRuuvEjz
         ZMzS9nM5+jsrcEsL6zBvLF/aX7kRvMgtTLFKpB8bjImxgZ1RPDKsbgX2tai6ufkAyN
         vcRzd2+Ps5Yj6zESTMZBZQ9dNPPcwXMw6hJaV1nZ81s6kvnFtVSCU7+R7E9qJMehyE
         dLWJ1tvKCJyi7u/2ILTsI9DVTXuaVAAfVYF748ZljFgKv/dht3zTe8uapeiZgkI+7J
         vpBzH2MM7rXNg==
From:   Alistair Popple <alistair@popple.id.au>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Alistair Popple <alistair@popple.id.au>, stable@vger.kernel.org
Subject: [PATCH 1/2] mm/migrate: Fixup setting UFFD_WP flag
Date:   Mon, 24 Aug 2020 18:31:27 +1000
Message-Id: <20200824083128.12684-1-alistair@popple.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f45ec5ff16a75 ("userfaultfd: wp: support swap and page
migration") introduced support for tracking the uffd wp bit during page
migration. However the non-swap PTE variant was used to set the flag for
zone device private pages which are a type of swap page.

This leads to corruption of the swap offset if the original PTE has the
uffd_wp flag set.

Fixes: f45ec5ff16a75 ("userfaultfd: wp: support swap and page migration")
Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: stable@vger.kernel.org
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 34a842a8eb6a..ddb64253fe3e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -251,7 +251,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				entry = make_device_private_entry(new, pte_write(pte));
 				pte = swp_entry_to_pte(entry);
 				if (pte_swp_uffd_wp(*pvmw.pte))
-					pte = pte_mkuffd_wp(pte);
+					pte = pte_swp_mkuffd_wp(pte);
 			}
 		}
 
-- 
2.20.1

