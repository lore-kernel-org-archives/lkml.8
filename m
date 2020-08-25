Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C15C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430D32071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=popple.id.au header.i=@popple.id.au header.b="TbR5NIO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgHYGnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgHYGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:43:18 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B887BC061574;
        Mon, 24 Aug 2020 23:43:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BbKFG27zGz9sTY;
        Tue, 25 Aug 2020 16:43:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=popple.id.au;
        s=202006; t=1598337794;
        bh=8N/iHSLK5FilP1L0fcoIeCnUrRCEEemp2bK1xK1CiXE=;
        h=From:To:Cc:Subject:Date:From;
        b=TbR5NIO3aYdM28GtfQB11RYJxtU09KXKYg8mxSd0JD5+dFdQevRo3DoKjLE3vFvsp
         w2UMfmNBu3id0uQVBz65bTd+ICw/H9WJP8C5CpODzNh45VhwLmNPsE4aUjwxGq2O3f
         BEXPAIRdAcdpnji85sNXQWfgkGX4snxAHuadTNCulqhBecWXEZGv1V9suxmDFUIme/
         T4Cnl6pxuaMJMF/Juk3poqX2ZR79/yKVm/AiGQFF3OKbT7nRWSHhb2blGRaE455JU2
         /DUQLD8PGzbJpO1yB+KKULq0bHgOgc59d7Bw3cc/+CDACobxtdlnJxJlII/a3fM53v
         1+rY1ZxMmftvQ==
From:   Alistair Popple <alistair@popple.id.au>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Alistair Popple <alistair@popple.id.au>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/migrate: Fixup setting UFFD_WP flag
Date:   Tue, 25 Aug 2020 16:42:31 +1000
Message-Id: <20200825064232.10023-1-alistair@popple.id.au>
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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

