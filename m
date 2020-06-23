Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76292083E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896158;
	bh=bbYZkxOkNOh8W5wHFisjBS2E9wCz49v/LCMR7ImbOD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oGHxHz7i5ODtsrUrH6JBmVq4LDPDCr4ihluj0OSGiaAUdWTtUACyxSGkoD7yxRxf2
	 gy5qu25hs7D7w3pLa9LS1i8S7NylUKd1DNfyS+etE12yenVkrLAQ+PWQ0QX8d68AO6
	 JMaf4X8CSneDZt3mZh3lpmW+g/SI2KwYaN+qBMNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgFWHJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbgFWHJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:15 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F043C206B7;
        Tue, 23 Jun 2020 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=bbYZkxOkNOh8W5wHFisjBS2E9wCz49v/LCMR7ImbOD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiI+3zGNpBrxM1Lh4QdMbTFUFH8aKePsECcWTKuYWqxI3Hq3N9lUni2cLrzSprhD6
         it602gzeTUfh6/hN4TSAcBWn0Asym4N5aeJODK+++JKQ9poVWmyBTUsFZLjH3QZHiR
         /HWZC5JJy3yR1sCyXhFNHosipoMqjWsFzvcVumRg=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3Q-003qii-VC; Tue, 23 Jun 2020 09:09:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Subject: [PATCH v2 01/15] mm: vmalloc.c: remove a kernel-doc annotation from a removed parameter
Date:   Tue, 23 Jun 2020 09:08:57 +0200
Message-Id: <5cd93bdc2f19f94266f42fcbf88a7fd207f7127b.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prot argument was removed. Drop it als from the kernel-doc
markup.

Fixes: 3c8ce1be43d3 ("mm: remove the prot argument from vm_map_ram")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 963db1037f61..c3b3f94e08da 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1809,7 +1809,6 @@ EXPORT_SYMBOL(vm_unmap_ram);
  * @pages: an array of pointers to the pages to be mapped
  * @count: number of pages
  * @node: prefer to allocate data structures on this node
- * @prot: memory protection to use. PAGE_KERNEL for regular RAM
  *
  * If you use this function for less than VMAP_MAX_ALLOC pages, it could be
  * faster than vmap so it's good.  But if you mix long-life and short-life
-- 
2.26.2

