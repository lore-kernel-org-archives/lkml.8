Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CDC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954E420714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISQg4/jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgC0HrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:47:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0HrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b19GaTvoouD8kMcaiRwYg1jfxWXoAJR1e5018Csa550=; b=ISQg4/jZkMfHz3Oe/OgFV0KEfi
        3D5XqhOJDwgC9ejd8ltLQz+M1CHLZYOOvPh5PW/PNuxJu8Wns/xcNPvI0PW1ijRPGqsa+Mk7FpJ7r
        mdGf14t1jKaNFHfERVUOu/qLv3UKybFaf/xCdJa6CmaxwgmxC6ks2361R0wiKiFKdFJHDQVvSOcBt
        gQDIyy/zRTm9OCvfEZxfOhavW+xywkgXSwPuwaveTip4IQicxmB6QxhuUNTKEi+YhJT8Pj9K4jzH0
        yB9N+II/Fb526ttINVVdvCed64xQkfIwN4N9J9c5NjeLRVoHE703Nyd/vZgB0Sf7xpe88Qhk5e9QV
        b790UI7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHjhm-0007Iu-Kt; Fri, 27 Mar 2020 07:47:02 +0000
Date:   Fri, 27 Mar 2020 00:47:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Message-ID: <20200327074702.GA27959@infradead.org>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> If those API calls are inter-dependent for composing a feature (e.g. SVA),
> shouldn't we need a way to check them together before exposing the 
> feature to the guest, e.g. through a iommu_get_uapi_capabilities interface?

Yes, that makes sense.  The important bit is to have a capability flags
and not version numbers.
