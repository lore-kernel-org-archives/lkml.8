Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E8C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB302076D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrSjIe8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEAIoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEAIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:44:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83426C035494;
        Fri,  1 May 2020 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RZeiBC9EJZtL3o9wl9DzrRwokyorK8vs365JFKguCFg=; b=WrSjIe8BMSfRLI3jpUdAEwYOJE
        tXYY9oHJxbcwtR63YkJacY1tOmRSo0VlWUfCBXPQ+9tbl6oJlB6VD5LcDihqELSVjdYutoJQPLF/4
        8oHd/jG9oqEktRgyDMVRMOdWgUxvFWtmrO8QVY5Bwuyx4kwsw09MghtZa6r2wfdwKKLrFF/HWbKx2
        Zi8C52D4aGGC5APfXtvEL4/oyOvcKOr0v4gdC7IVh3dTxxV50jGh/gnhlOpbRnTobeSX5FvfQg+XE
        AQYdMumCk1/McWx3/D54ShlP8u9koPQ1WhpJQpMsvcc6VEQhQ4YMiNhkqLNpVJLQbjN9J2nQBExHY
        I+WV6DYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jURHq-00008h-NO; Fri, 01 May 2020 08:44:46 +0000
Date:   Fri, 1 May 2020 01:44:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: sparc-related comment, to Re: [PATCH V1 07/10] arch/kmap: Ensure
 kmap_prot visibility
Message-ID: <20200501084446.GG27858@infradead.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
 <20200430203845.582900-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430203845.582900-8-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/sparc/mm/highmem.c
> +++ b/arch/sparc/mm/highmem.c
> @@ -33,6 +33,7 @@
>  #include <asm/vaddrs.h>
>  
>  pgprot_t kmap_prot;
> +EXPORT_SYMBOL(kmap_prot);

Btw, I don't see why sparc needs this as a variable, as there is just
a single assignment to it.

If sparc is sorted out we can always make it a define, and use a define
for kmap_prot that defaults to PAGE_KERNEL, avoiding a little
more duplication.
