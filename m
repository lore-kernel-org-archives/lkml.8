Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C0DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB53D2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203650;
	bh=7Q6CZYyu5yNzedIqh5sJBgI5/YLkukvok0P9JrKqBOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uH+9JvnlDanIpVOuVMYuhiaFbS/uUgtdWOb1+SAifWema05PD6JDeUdfkPGfRN/X1
	 Yai8BflqAGrsk1TnZgrYf0bgDV/pRB/DhqsjqbgGEEhoLlGONMsaDnwNxE5MhXjLvy
	 wBYZ3FHEW1m902kAIjz3dhkv9p+Gsc4Iz2FapzZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgFOGrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgFOGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:12 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80BB520707;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203631;
        bh=7Q6CZYyu5yNzedIqh5sJBgI5/YLkukvok0P9JrKqBOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Timn/k2a8kskuaPhpAvq549OmLmEiCyRYr4NrxeeI7y3+mBdKafYyssRAolCcXAER
         6gDuLwCtPCxR/KQRZTDb5BMrxehqO64T4uq41LKCGp0ihsTG6q7lzXZflW7Aj6wjVv
         gu6QUjZRFARYeaID4FEuFmJHaDHD1HKXYKkT3xw8=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nm0-D8; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Subject: [PATCH 01/29] mm: vmalloc.c: remove a kernel-doc annotation from a removed parameter
Date:   Mon, 15 Jun 2020 08:46:40 +0200
Message-Id: <cf778850a32adce7b06831cc7973f98400fc0775.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
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
index 3091c2ca60df..957a0be77270 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1862,7 +1862,6 @@ EXPORT_SYMBOL(vm_unmap_ram);
  * @pages: an array of pointers to the pages to be mapped
  * @count: number of pages
  * @node: prefer to allocate data structures on this node
- * @prot: memory protection to use. PAGE_KERNEL for regular RAM
  *
  * If you use this function for less than VMAP_MAX_ALLOC pages, it could be
  * faster than vmap so it's good.  But if you mix long-life and short-life
-- 
2.26.2

