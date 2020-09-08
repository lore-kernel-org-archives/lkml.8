Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65547C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E566821897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0E3zr9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgIHGXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgIHGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:23:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01927C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sksp/t0ni/xrmSuCxSHeJAbkuuheoDez0O8NIcBsyNY=; b=m0E3zr9AelfXyWNRedxJdmPxni
        /5kOwchSrWI2cUO0Kcaakoe0rgd0DMbjZelgTJTiAXThC5QLC8QCvHTgL6y+HhaqjWuPx5Ywqh8wI
        ClsQw8MY+LH5Bwa2ThIPoe7KR1wxLxnTwgOTS+315FS2eIzyUGq+YZUbfa/dnPAC9XQPMWu+uURuM
        xfoswb7HyU5gjU4Yf6JXFCFBaTq8VqvMe0lozrt4izVdTS7WXAV6d3Ox3GLZh2VnLVN+XuLZUVDGO
        fvlfFMIlwEzcWsF/F3Y8EDDplTYAfXs718yKVGEMySswnjnCgp6u3Y3Ms8p58Xc92B/UVOOQMx9vM
        uUAupsNA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFX2M-0006nR-W4; Tue, 08 Sep 2020 06:23:27 +0000
Date:   Tue, 8 Sep 2020 07:23:26 +0100
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
Message-ID: <20200908062326.GB20774@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org>
 <20200908055510.GA19078@infradead.org>
 <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 02:04:53PM +0800, Lu Baolu wrote:
> Do you mind telling where can I find Marek's series?

[PATCH v10 00/30] DRM: fix struct sg_table nents vs. orig_nents misuse

on various lists including the iommu one.
