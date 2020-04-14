Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3984CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F322072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="POeXOIAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407040AbgDNIL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407026AbgDNILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:11:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ECBC0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O3a96vzOf8hcQ+GezCIAovhsKAxB8eo+WBGQ45KCX08=; b=POeXOIAptoTj/Yv6Ki2m1jlizY
        SxzCLvkF1HNMJqQxXxGYrkEtBQCB86xeql3/X+yfB9OGtIznYp/evwZFEqU6yV9GNXYeHPO77F+LX
        fNLOF1JgUhd0mcQZBLYhSN1utCuvFesLW6jT2Eys1R3rBQOaKkiKIc8msi8jU4aKZJfWihFHrOMZo
        2zdtGfUKzkJF8s86Edb9VhlsK2t2wwhsdtWIKThTMHM6DbncakxX/CVJLtOKHlgqJlOckb8nM8dT5
        SWJOQVoB21dEFVpsaFbTqHfckHB38+JD6flXhIOEUM94Rl1B9QCYnJexQWdNLwuG0DMZPMIe4pUKM
        U6GuOFwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOGey-0004qv-0O; Tue, 14 Apr 2020 08:11:08 +0000
Date:   Tue, 14 Apr 2020 01:11:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200414081107.GA7315@infradead.org>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
 <20200331085444.44bee0bb@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
 <20200402113604.6eea1e6f@jacob-builder>
 <20200413134157.395981a6@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413134157.395981a6@jacob-builder>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 01:41:57PM -0700, Jacob Pan wrote:
> Hi All,
> 
> Just a gentle reminder, any feedback on the options I listed below? New
> ideas will be even better.
> 
> Christoph, does the explanation make sense to you? We do have the
> capability/flag based scheme for IOMMU API extension, the version is
> mainly used for size lookup. Compatibility checking is another use of
> the version, it makes checking easy when a vIOMMU is launched.

No.  If you truely need different versions use different ioctl
identifiers.  If it really is just the size pass the size and not a
version.
