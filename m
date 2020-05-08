Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FEFC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8227208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588903690;
	bh=ksEqcqImipmxWT3Iy/S3JUAYsjC/OSyXI0gG+NiBwk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M39ZEvxzUZDXArhZ3ac84VpVWnSAVrot3FA72xitiw5ipenQvj1nmWaogdgpadl13
	 x7e/ihbhbg5LlLDAHuyaw4BuwQOe2odJz3x/QRlxHlg9bYErtxqnAHFRmcjghOuT+d
	 YkMiU5hqojn+E5JgGbe2ZFPIAqRxYSXT9FH3GjIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEHCIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgEHCIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:08:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 298292075E;
        Fri,  8 May 2020 02:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588903689;
        bh=ksEqcqImipmxWT3Iy/S3JUAYsjC/OSyXI0gG+NiBwk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PLBCeydaQyu0oOyiHn6JxAxH+fAjVnKeKDYLwzI8b/aSvxuvJ9QGI0YYFultEwPh8
         J+c6O0CgkncOBptSUnEOAw0pDeri23FDwaMsi27VmLdI900zwmoDYuJbafWO799E9x
         wuquKUTzN8n6SHU/45QtMQGhFRTrp2QZl+m0mdlM=
Date:   Thu, 7 May 2020 19:08:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20200507190808.c6cdd5ffd68d0a154ef8ff18@linux-foundation.org>
In-Reply-To: <20200508114338.02d2b843@canb.auug.org.au>
References: <20200507221721.0330271c@canb.auug.org.au>
        <20200508114338.02d2b843@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 11:43:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Thu, 7 May 2020 22:17:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the akpm-current tree, today's linux-next build (arm
> > collie_defconfig and many others) failed like this:
> > 
> > arch/arm/mm/dma-mapping.c: In function 'dma_cache_maint_page':
> > arch/arm/mm/dma-mapping.c:892:6: error: implicit declaration of function 'kunmap_high' [-Werror=implicit-function-declaration]
> >       kunmap_high(page);
> >       ^
> > arch/arm/mm/flush.c: In function '__flush_dcache_page':
> > arch/arm/mm/flush.c:221:6: error: implicit declaration of function 'kunmap_high' [-Werror=implicit-function-declaration]
> >       kunmap_high(page + i);
> >       ^
> > 
> > Caused by commit
> > 
> >   6b66ab470b4d ("arch/kunmap: remove duplicate kunmap implementations")
> > 
> > kunmap_high() is now only declared when CONFIG_HIGHMEM is defined.
> 
> Is there anything that can be done quickly about this as it broke a
> large number of builds ...

This?  It's based on Ira's v3 series but should work.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: arch-kunmap-remove-duplicate-kunmap-implementations-fix

fix CONFIG_HIGHMEM=n build on various architectures

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/highmem.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/highmem.h~arch-kunmap-remove-duplicate-kunmap-implementations-fix
+++ a/include/linux/highmem.h
@@ -53,6 +53,7 @@ static inline void *kmap(struct page *pa
 }
 
 void kunmap_high(struct page *page);
+
 static inline void kunmap(struct page *page)
 {
 	might_sleep();
@@ -111,6 +112,10 @@ static inline void *kmap(struct page *pa
 	return page_address(page);
 }
 
+static inline void kunmap_high(struct page *page)
+{
+}
+
 static inline void kunmap(struct page *page)
 {
 }
_

