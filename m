Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D0206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEBs34CU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgC2DAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 23:00:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgC2DAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 23:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tzQQI4sPYIQBmBbwCro/n16BP95THEmRO7t6mifRML4=; b=nEBs34CUPbdlvIX+D+1uQ1RH24
        Ej5dOZ3lLrQuut9PtYNGkXA3koeQSQDdqMsYWaMEp38KgpDHYt8XQzVxIL0+LIbI71dtFlnqUNYUI
        +b8YfoGgqyK7V3Q2hkO5qRe9i9vorjXPJjM783KKCNLoKzNKArwYEbKteh5/DeRV/STBoJRPsqniL
        vyEcyBq095i2wwMZa3rKCvmt4CciHoEdoxVj9OjEF170WeNqffsvP+GXUqd9RDH5LkA9FKVqR4F1I
        VHwBcBcQA7Rtrf8fWswpp038xYh+MxshHzYqQ2kP4XDg9Gu+3InwGR63sWP94CEsMbluooRi8qUR0
        HrUD8Z/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIOAs-0002Hp-Jl; Sun, 29 Mar 2020 02:59:46 +0000
Date:   Sat, 28 Mar 2020 19:59:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 10/25] nvdimm: Add driver for OpenCAPI Persistent
 Memory
Message-ID: <20200329025946.GU22483@bombadil.infradead.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
 <20200327071202.2159885-11-alastair@d-silva.org>
 <20200329025617.GT22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329025617.GT22483@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 07:56:17PM -0700, Matthew Wilcox wrote:
> On Fri, Mar 27, 2020 at 06:11:47PM +1100, Alastair D'Silva wrote:
> > +static struct mutex minors_idr_lock;
> > +static struct idr minors_idr;
> ...
> > +	mutex_lock(&minors_idr_lock);
> > +	minor = idr_alloc(&minors_idr, ocxlpmem, 0, NUM_MINORS, GFP_KERNEL);
> > +	mutex_unlock(&minors_idr_lock);
> ...
> > +	mutex_lock(&minors_idr_lock);
> > +	idr_remove(&minors_idr, MINOR(ocxlpmem->dev.devt));
> > +	mutex_unlock(&minors_idr_lock);
> ...
> > +	mutex_init(&minors_idr_lock);
> > +	idr_init(&minors_idr);
> 
> Unless you look up ocxlpmem by minor number later in the patch series (and
> most of the series didn't make it to my mailbox), this can just be an ida.
> 
> static DEFINE_IDA(minors);
> ...
> minor = ida_alloc_max(&minors, NUM_MINORS, GFP_KERNEL);

Oops.  NUM_MINORS - 1.  Or #define MAX_MINOR 255 since you only seem to use
NUM_MINORS in this one place.

> ...
> ida_free(&minors, MINOR(ocxlpmem->dev.devt));
> ...
> and you can drop the dynamic initialisation.  And the mutex.
