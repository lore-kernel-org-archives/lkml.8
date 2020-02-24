Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F325CC35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA71020675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YnvgoyzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBXEiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXEiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3x72YyawiT+qy2td7cpd28NQAFlPEu7/enza7D57Et4=; b=YnvgoyzDCY7RY0g+SAmg6beiS+
        ZxADpTEUvAfco3MMCmW2+jIaN/5jUoEeRSOth35TpB+zO89Nd7QPAmtF2tNA/5EFvRTI9ASvQcBTZ
        S811CVIJn5Z61wJcKTnhjULCopl2lMpaSlzG2P209wiZEz/A4Gm838o9rSt3ju0q2HheM9nKP4mwL
        sSEZtCJCAJ7JPsGeqB8JwK5p9p7gNig9e5CVSjRUtjtyQEmC0+lm94GK1srxAlmp3xhmuFWhvlKza
        4AdO6LBTv4ODP59vG9o46FZE4VeF7HplPeIie846DiECSHQO8R6h7xmOIHsbX+UXWR4GxVCf9P//M
        Y1y1PXqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j65V8-0001aO-Bq; Mon, 24 Feb 2020 04:37:50 +0000
Date:   Sun, 23 Feb 2020 20:37:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory
 devices
Message-ID: <20200224043750.GM24185@bombadil.infradead.org>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva wrote:
> V3:
>   - Rebase against next/next-20200220
>   - Move driver to arch/powerpc/platforms/powernv, we now expect this
>     driver to go upstream via the powerpc tree

That's rather the opposite direction of normal; mostly drivers live under
drivers/ and not in arch/.  It's easier for drivers to get overlooked
when doing tree-wide changes if they're hiding.

