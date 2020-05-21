Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB12C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514F820671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmUoelMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgEUX3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUX3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:29:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C66C061A0E;
        Thu, 21 May 2020 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9+Y4GrdpClNs6dOQez6Q/Hq2GUKZ7fNwPhgdPdL175M=; b=bmUoelMosRe7hQUHZlH2tUXoEg
        pReNbQUridxcNh44KO8glMSsmIlRzgp5vwVfJjYirSM/LAxReB2EEpA+NU6Yja9F6wMdtAxwlmY2c
        octCCt9G7beTA4sx5i+obaKgJ+1KG13qUCPE4XSMCx638L8FYXmT/y97mXqr4cdKh1X+tFZIFQlV2
        2bQyW6KPkz6KKNVTrfqauKKlBObAz6rne7fV95zdnvA9AusqZgdp1WTa89QE5R8jROfBEVhPCzZzz
        C151YNultnIGYtRsfPtcZkSM3RM1dtP0ikHJx8B4qQT6ncom9p5s79Shss0UCQ0oA8D7PCHMEwtzM
        F1H8CvhA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbucd-0006Jt-0Q; Thu, 21 May 2020 23:29:07 +0000
Date:   Thu, 21 May 2020 16:29:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/36] fs: Add a filesystem flag for large pages
Message-ID: <20200521232906.GF28818@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-8-willy@infradead.org>
 <20200521215523.GR2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521215523.GR2005@dread.disaster.area>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 07:55:23AM +1000, Dave Chinner wrote:
> If you've got to dereference 4 layers deep to check a behaviour
> flag, the object needs it's own flag.  Can you just propagate this
> to the address space when the inode is instantiated and the address
> space initialised?

Sure.  I'll fold in something like this:

+++ b/fs/inode.c
@@ -181,6 +181,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
        mapping->a_ops = &empty_aops;
        mapping->host = inode;
        mapping->flags = 0;
+       if (sb->s_type->fs_flags & FS_LARGE_PAGES)
+               __set_bit(AS_LARGE_PAGES, &mapping->flags);
        mapping->wb_err = 0;
        atomic_set(&mapping->i_mmap_writable, 0);
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
+++ b/include/linux/pagemap.h
@@ -29,6 +29,7 @@ enum mapping_flags {
        AS_EXITING      = 4,    /* final truncate in progress */
        /* writeback related tags are not used */
        AS_NO_WRITEBACK_TAGS = 5,
+       AS_LARGE_PAGES = 6,     /* large pages supported */
 };
 
 /**
@@ -118,7 +119,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 
 static inline bool mapping_large_pages(struct address_space *mapping)
 {
-       return mapping->host->i_sb->s_type->fs_flags & FS_LARGE_PAGES;
+       return test_bit(AS_LARGE_PAGES, &mapping->flags);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)



