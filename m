Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766E420637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584059511;
	bh=U6yu3h1JK3KYJor/2fq9U7mcNdls4bBnMQ63AohUn3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Lm3BGwa0hLeChg1Hv1Yjv2Zhr+5pYlBhXQNDdX/evnRERf2pgClPEv8z74iGSmsFM
	 74gWQFrHh/O+DeeTe46GLM5laiREjCbdkubFTuoTWUIR1xVj4P926766iQefgD+Y9E
	 /OoT4lGV7T29aGq6KHW76199b4k2VqigKULQF9ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCMAbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMAbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:31:50 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9E6205F4;
        Fri, 13 Mar 2020 00:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584059509;
        bh=U6yu3h1JK3KYJor/2fq9U7mcNdls4bBnMQ63AohUn3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k0hfjg76kLJmC1o/ed6y+DKXm+1hSq9XjHy56gkrPxIn1xmxjuNe6vjBVy5dF6Jzy
         3JWhHOXmBXxL+uAHm+kAtb0I8xUJgj7kFd1q4VpC8sgTYXdjA55Xf56X+iT+3/lHU5
         On1nYG8MSqt41J1nrnU4vHCSkaCmrROEUWrISTdo=
Date:   Thu, 12 Mar 2020 17:31:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-Id: <20200312173148.6647751b1ad538687563f652@linux-foundation.org>
In-Reply-To: <20200312182725.618ca518@canb.auug.org.au>
References: <20200312182725.618ca518@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 18:27:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> mm/gup.c:119:13: warning: 'put_compound_head' defined but not used [-Wunused-function]
>   119 | static void put_compound_head(struct page *page, int refs, unsigned int flags)
>       |             ^~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   6379e529ebe4 ("mm/gup: fixup for 9947ea2c1e608e32 "mm/gup: track FOLL_PIN pages"")
> 

Thanks.

I think this is right.  And I don't think it'll apply to most recent
-next.

--- a/mm/gup.c~mm-gup-track-foll_pin-pages-fix-2-fix
+++ a/mm/gup.c
@@ -78,21 +78,6 @@ static __maybe_unused struct page *try_g
 	return NULL;
 }
 
-static void put_compound_head(struct page *page, int refs, unsigned int flags)
-{
-	if (flags & FOLL_PIN)
-		refs *= GUP_PIN_COUNTING_BIAS;
-
-	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
-	/*
-	 * Calling put_page() for each ref is unnecessarily slow. Only the last
-	 * ref needs a put_page().
-	 */
-	if (refs > 1)
-		page_ref_sub(page, refs - 1);
-	put_page(page);
-}
-
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
  *
@@ -1967,7 +1952,24 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * This code is based heavily on the PowerPC implementation by Nick Piggin.
  */
 #ifdef CONFIG_HAVE_FAST_GUP
+
+static void put_compound_head(struct page *page, int refs, unsigned int flags)
+{
+	if (flags & FOLL_PIN)
+		refs *= GUP_PIN_COUNTING_BIAS;
+
+	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
+	/*
+	 * Calling put_page() for each ref is unnecessarily slow. Only the last
+	 * ref needs a put_page().
+	 */
+	if (refs > 1)
+		page_ref_sub(page, refs - 1);
+	put_page(page);
+}
+
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+
 /*
  * WARNING: only to be used in the get_user_pages_fast() implementation.
  *
_

