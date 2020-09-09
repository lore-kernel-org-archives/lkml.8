Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B3A21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QWCA9gPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIIHG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIHG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:06:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE77C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hCw8xGdlNdOCLWn3JTGudEyCmE42OPi648sQ0UReuL4=; b=QWCA9gPZCZ3wzIlKZV6poclcFq
        LzfIY4lmnE8VjlKQlNvIxOZhHe41lSL2CEaz90i97YxxVXfVK2X9ipiCtBI5MxDA/GrklQLLksV9N
        A+Npi3L42x5yATBqMul+YVCITK1IZThjOn0EUXnndO9qp7cPI0FFjw4jGkioLYG7yo+OIXJ90SVhh
        p828BaX8dZFZEzYrjLX+PcMmEzTQ4QaFDIf9VTMHiOulzyKvRLp4LgQRkKE6IWheY0Qo2AZRcG4t/
        E31RYqm6VXEyf9QSWC6uKFR7sdjlY3BZMedrpiAOMTsUbtVtomspvCxcQvlyn4mr8HghIktPWnf/d
        Z5aMpAyA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFuBQ-0007rM-HR; Wed, 09 Sep 2020 07:06:20 +0000
Date:   Wed, 9 Sep 2020 08:06:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Tom Murphy <murphyt7@tcd.ie>, intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
Message-ID: <20200909070620.GB28245@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org>
 <20200908055510.GA19078@infradead.org>
 <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
 <20200908062326.GB20774@infradead.org>
 <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 09:43:09AM +0800, Lu Baolu wrote:
> +       /*
> +        * The Intel graphic device driver is used to assume that the
> returned
> +        * sg list is not combound. This blocks the efforts of converting
> the

This adds pointless overly long lines.

> +        * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
> +        * device driver work and should be removed once it's fixed in i915
> +        * driver.
> +        */
> +       if (dev_is_pci(dev) &&
> +           to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
> +           (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
> +               for_each_sg(sg, s, nents, i) {
> +                       unsigned int s_iova_off = sg_dma_address(s);
> +                       unsigned int s_length = sg_dma_len(s);
> +                       unsigned int s_iova_len = s->length;
> +
> +                       s->offset += s_iova_off;
> +                       s->length = s_length;
> +                       sg_dma_address(s) = dma_addr + s_iova_off;
> +                       sg_dma_len(s) = s_length;
> +                       dma_addr += s_iova_len;
> +               }
> +
> +               return nents;
> +       }

This wants an IS_ENABLED() check.  And probably a pr_once reminding
of the workaround.
