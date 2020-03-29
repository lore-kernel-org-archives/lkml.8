Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CBC20733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huAPFZ1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC2QOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:14:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2QOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GNc+X9HG8DT1u4IwAU5h9IVe5ck8+kmkOpD7yEqvcF8=; b=huAPFZ1xjY8kKAIg+736p7/fDf
        Yttw2uKzcijq5GyBpzzSlaAjIxjt2fKfpSxp8NdpUsm6Ri7ej3vy9oFrFET0ZfcniaBeT5F5qK4OP
        7cH5Is1OwylJzfSk9ZH7vWLBgjFrAJBCgUVufaBYh4h5fQwsLpKuzQ60pjWTFm4wx087noN1Ob7Qq
        y945LL2rvKRtQ5Cogetxf8xU6QscT9ix4Z78xAuKutTMxZbk382siwp0XbTFw07DnM3w6iJBpAte5
        UPiV5Zjc9u/quuIjR9B39HfK8FzxtjhUO3hN3VNpLMxBtZ8hDT/Bv6aGTqFKlqcjciXzi/nTkjFAu
        yQLipO3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIaZe-0000S1-E4; Sun, 29 Mar 2020 16:14:10 +0000
Date:   Sun, 29 Mar 2020 09:14:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     walken@google.com, bp@suse.de, akpm@linux-foundation.org,
        srostedt@vmware.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
Message-ID: <20200329161410.GW22483@bombadil.infradead.org>
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
 <CGME20200320055839epcas1p189100549687530619d8a19919e8b5de0@epcas1p1.samsung.com>
 <20200320055823.27089-3-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320055823.27089-3-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 02:58:23PM +0900, Jaewon Kim wrote:
> +	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
> +		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
> +		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,

I didn't see the IS_ERR_VALUE problem that Vlastimil mentioned get resolved?

I might suggest ...

+++ b/include/linux/err.h
@@ -19,7 +19,8 @@
 
 #ifndef __ASSEMBLY__
 
-#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
+#define __IS_ERR_VALUE(x) ((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
+#define IS_ERR_VALUE(x) unlikely(__IS_ERR_VALUE(x))
 
 static inline void * __must_check ERR_PTR(long error)
 {

and then you can use __IS_ERR_VALUE() which removes the unlikely() problem.
