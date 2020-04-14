Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0CEC352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01EA206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cNfCC3/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgDNIPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407053AbgDNIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:15:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FEBC0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMnsJWGnn/nFfa6VeGd0dp8M4eB4NXe4aAT+p9Z7jQU=; b=cNfCC3/8l7kAjcB3Ine/8IO+qO
        euv1IG6OasKoYWOIraty2tztaAvY6nVmWlcOSyz4ppLdfFxd5ccybT9I2r9w73Yl1O7D6aDpUVN07
        yM7bAPX4cI6ydO3Ot1sDzTtU/FQQ5Q0wawnW91NATGzw4NkbLO/+DvsT2nHt7lAeWuKGJz3KzT+0Z
        NDHdv+5PB7jTv647zBtWOkWMkZRlvTNWdhY6O94pMi55/zXyi5D5MrTG9e5mxfXA41nugMmBGF+qS
        lrvKD6tAq8XPJ/pH02ibFXfE3v7EJ8p5r326XssUFtynYxOvBj6qlKkHWhgLn7cJvJ0pGtSpzrkdp
        f4XZsQkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOGii-0005li-3U; Tue, 14 Apr 2020 08:15:00 +0000
Date:   Tue, 14 Apr 2020 01:15:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200414081500.GB7315@infradead.org>
References: <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
 <20200331085444.44bee0bb@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
 <20200402113604.6eea1e6f@jacob-builder>
 <20200413134157.395981a6@jacob-builder>
 <20200413162129.313b3b5a@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413162129.313b3b5a@w520.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:21:29PM -0600, Alex Williamson wrote:
> Is the objection to a global version or to any version fields?  I don't
> really understand the global version, I'd think a mechanism to check
> extensions plus a per structure flags/version would be preferred.  The
> former should resolve how userspace can test support for features
> requiring multiple interfaces.  A global version also implies that
> we're only ever adding features and never removing.  For example,
> feature Foo is added in version 4, but it's replaced by feature Bar in
> version 5, now userspace can't simply test version >= 4 must include
> feature Foo.

The objection is to versions vs the much more sensible struct size +
capability flags.  Making it global just increases the problems with
a version for all of the above reasons.

> It seems to me that version and flags can also be complimentary, for
> example a field might be defined by a version but a flag could indicate
> if it's implemented.  With only the flag, we'd infer the field from the
> flag, with only the version we'd need to assume the field is always
> implemented.  So I have a hard time making a blanket statement that all
> versions fields should be avoided.

s/version/struct size/, but otherwise agreed.
