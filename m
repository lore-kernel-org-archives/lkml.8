Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483AB2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgDTRYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:24:49 -0400
Received: from verein.lst.de ([213.95.11.211]:42035 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTRYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:24:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4854D68C4E; Mon, 20 Apr 2020 19:24:46 +0200 (CEST)
Date:   Mon, 20 Apr 2020 19:24:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200420172445.GA1372@lst.de>
References: <20200420200009.54554500@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420200009.54554500@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

can you fold in these two fixes into the original patches?


diff --git a/mm/nommu.c b/mm/nommu.c
index d32ab47b58a9..371697bf372d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -155,13 +155,13 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		pgprot_t prot, unsigned long vm_flags, int node,
 		const void *caller)
 {
-	return __vmalloc(size, gfp);
+	return __vmalloc(size, gfp_mask);
 }
 
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller)
 {
-	return __vmalloc(size, gfp);
+	return __vmalloc(size, gfp_mask);
 }
 
 static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
