Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E811BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C326E217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9jhREfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgFRFba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:31:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C020C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j59LIKt0ZBQcjPYvOJ7LYaon1Ej4A1gLEpf436VqWNs=; b=B9jhREfEDVEPKppsrv5l3+GSyX
        NmO5I92C5oyvQRZ0R6/4dEJPMO4klMHZu03udlGfjPd99a9xBx5BwyJKmX8IeGOOOLVUr8xyMlGiC
        wTkPy+f5swuMFEjEfnbWBSNCr6+LZvdjYBLCQQKBbtZ62mNw/32aL0Ue+4yMrLAggsaRLXOXWD5Lx
        3fNOkeMxXBIktbivYw6KvsJDOJR8+WwCIFCOPf16Ad+8tRJXklYeSAwjDoAbkX8JRByGy2ztHSKM8
        uj5ZVv2uEM5giaVXlmYgnYp7u5JL6KH120HaEt8SnMdFapo3iHEm9Uy33pkpAmk+T68KVLAw0s4ji
        7ZzI7kvw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jln91-0005Vv-9O; Thu, 18 Jun 2020 05:31:23 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] lib: fix test_hmm.c reference after free
Message-ID: <c845c158-9c65-9665-0d0b-00342846dd07@infradead.org>
Date:   Wed, 17 Jun 2020 22:31:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Coccinelle scripts report the following errors:

lib/test_hmm.c:523:20-26: ERROR: reference preceded by free on line 521
lib/test_hmm.c:524:21-27: ERROR: reference preceded by free on line 521
lib/test_hmm.c:523:28-35: ERROR: devmem is NULL but dereferenced.
lib/test_hmm.c:524:29-36: ERROR: devmem is NULL but dereferenced.

Fix these by using the local variable 'res' instead of devmem.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Ralph Campbell <rcampbell@nvidia.com>
---
 lib/test_hmm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20200617.orig/lib/test_hmm.c
+++ linux-next-20200617/lib/test_hmm.c
@@ -520,8 +520,7 @@ static bool dmirror_allocate_chunk(struc
 err_free:
 	kfree(devmem);
 err_release:
-	release_mem_region(devmem->pagemap.res.start,
-			   resource_size(&devmem->pagemap.res));
+	release_mem_region(res->start, resource_size(res));
 err:
 	mutex_unlock(&mdevice->devmem_lock);
 	return false;

