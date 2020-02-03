Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C1C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C1B20838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbYqw/Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBCVhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:37:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCVhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EeOvvWZvH50eEtBKHt08qpUyamao6FaQ0LtUnWK0t5w=; b=MbYqw/Vx49lRe78eDwZHP4w6TQ
        AFN++lIatMW4RPg/gX94FI0W6fBb+aofjMfYjdZf2T4WYLPc7hk9sPYr2XepIC2kngyt5oWzR5Ar4
        FcAMWsZ+tpIgZdVNLm7Ys9M1agWjLMHSXX6nGIwvk4lK0hf3Khqnt0Nst+2zDuQQO3b4gBuTDHm5q
        /bQ67UZbBgjnmnrXWRFAE6UlKG/ETmoHmPhfKHNoLJ1mCTjO2ryl4Ix/Tak+7/1IAnzk3gFgDma21
        0G622TPsNo9G0c9ZKdm+yeDwghp2gZLQnxF5JUafrOyFDT3OQZt/W836k7QOwEehg/ZwWiKWps8K7
        Ne8pgJ0A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyjPD-0005ga-0O; Mon, 03 Feb 2020 21:37:19 +0000
Date:   Mon, 3 Feb 2020 13:37:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Barret Rhoden <brho@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC 02/10] mm: Handle pmd entries in follow_pfn()
Message-ID: <20200203213718.GL8731@bombadil.infradead.org>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-3-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110190313.17144-3-joao.m.martins@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:03:05PM +0000, Joao Martins wrote:
> @@ -4366,6 +4366,7 @@ EXPORT_SYMBOL(follow_pte_pmd);
>  int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>  	unsigned long *pfn)
>  {
> +	pmd_t *pmdpp = NULL;

Please rename to 'pmdp'.

