Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3014EC38149
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD422CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G++1zEYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgHFG6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgHFG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:58:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF75C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uoVENN0m/ajn2+m/T1lGKfdUU/BbhArpJv86UOgrRFY=; b=G++1zEYuNW9wXk5l0CTikmwm7j
        XAhofXvtYgeP2y9ZRieOg0FzoOmetBTMRG5Oebq2G+6Mcx8W527IjexwCAWbi7rJkmAAaaCvTUB60
        JgABgCTJiJ/MFx0GT7e5LWEHFGtDOAHpgpDklN1DpxZ1Nh23895Kup+CbMGo5+8rkDzayMtuzdRK8
        yoK0gL1HWZYL3818vyyzxov9q01JFaS2aG7aaQDXY1UOTkx+z2U7jAgwGQU5PxhhC598dTrt4Bk3s
        ZYWIBoKwA0AqMzpVM2yTw9BLpemDZWgap8e6tzZn+Z5TsUAU0M2595ECneDjUatfOyVaz3nOkCE1c
        YQefsxRw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Zqj-0002iU-Ug; Thu, 06 Aug 2020 06:58:01 +0000
Date:   Thu, 6 Aug 2020 07:58:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ajay Kumar <ajaykumar.rs@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, will@kernel.org, joro@8bytes.org,
        robin.murphy@arm.com, nleeder@codeaurora.org
Subject: Re: [RFC PATCH] dma-iommu: allow devices to set IOVA range
 dynamically
Message-ID: <20200806065801.GA9618@infradead.org>
References: <CGME20200803140026epcas5p4f9898295d70c373bc3f52680f0b11586@epcas5p4.samsung.com>
 <20200803133620.13840-1-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803133620.13840-1-ajaykumar.rs@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not entirely sure this is the right mechanism.  Can you please
send it along with your intended user so that we can get a better
picture?  Also the export needs to be a _GPL one for any kind of
functionality like this,
