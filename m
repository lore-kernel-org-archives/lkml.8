Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1A2206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BwHS5FnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgFPIDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:03:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F839C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3LeCba4mbLZy+8I9XCqALq/Zp+vARf9z2EXRoJnbONI=; b=BwHS5FnObgRQYIAoHrlje2lgKV
        VhlBTVM91Sy5Y12v3ohFP/7/D++XECwPyx02Nua4pH6XzzD2Uq7NQKjGa/m2p2UplmGPR6TBXHkKY
        wM0l3PtKi9EHTEbTTEkcNfXhZfJVkh/DKw6IevygP/Duflz39LXHSiPGwPktPVoWOsCrapsOrPRc1
        U+24EJztR0moL5xvvG2oDIXnlaANw0C66lJQn+jOUTjsgh27mHrhEFPee3TLmWA+rEIqVXLwXpSPD
        bB0ZJn/IPTSPf0zw/v8gwNs8FrtDsgWidh3IVJhYBWJhyUT3LSmhewi1TrUA5MULaY1GoW7ZYdihr
        odeBdVjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl6Yn-0004oG-VA; Tue, 16 Jun 2020 08:03:09 +0000
Date:   Tue, 16 Jun 2020 01:03:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, sassmann@redhat.com,
        jeffrey.t.kirsher@intel.com, jacob.e.keller@intel.com,
        jlelli@redhat.com
Subject: Re: [Patch v1] i40e: limit the msix vectors based on housekeeping
 CPUs
Message-ID: <20200616080309.GA21210@infradead.org>
References: <20200615202125.27831-1-nitesh@redhat.com>
 <20200615202125.27831-2-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615202125.27831-2-nitesh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:21:25PM -0400, Nitesh Narayan Lal wrote:
> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
> +	mask = housekeeping_cpumask(hk_flags);
> +	cpus = cpumask_weight(mask);

Code like this has no business inside a driver.  Please provide a
proper core API for it instead.  Also please wire up
pci_alloc_irq_vectors* to use this API as well.
