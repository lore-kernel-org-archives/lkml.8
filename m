Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28496C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0622320789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597739342;
	bh=gPFyLTIegbMbhCl/SHxbZho1NDgw4y9nB98xI43nArc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HWH288LH67A8+ejqn9lENJACfbrFuv38Ys467q45g0kaeT/4FIHZ57ZhZsflQLyUe
	 NDupQB4lQn9IFa2aL70l/od8RGu3oM60L7h2WDFpDztAF0JJh2kgYtCg/S1ppv3fHX
	 rN8pd5rOHLKzkwI6azPss/WkxNcHH8aw/RxRp+hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHRI3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRI3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:29:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C49206B5;
        Tue, 18 Aug 2020 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597739339;
        bh=gPFyLTIegbMbhCl/SHxbZho1NDgw4y9nB98xI43nArc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXk37qGMQptQYYGyQs1hk7neeMhgMHNghUpk6hUZihonCozzdkwOKG/6057M2UhZO
         YMAVfOdBg7mFDBkFTd7Xa6ugS61m006dGMSQb6JbFBJj5oL4C+XIOVHwxPo7EKFFDA
         Vg8I8t7hE6jCa1Bu62ua4ap0lhEvXhFZ2im2dcc8=
Date:   Tue, 18 Aug 2020 09:28:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Cho KyongHo <pullip.cho@samsung.com>
Cc:     joro@8bytes.org, catalin.marinas@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, janghyuck.kim@samsung.com,
        hyesoo.yu@samsung.com
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818082852.GA15145@willie-the-truck>
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> Cache maintenance operations in the most of CPU architectures needs
> memory barrier after the cache maintenance for the DMAs to view the
> region of the memory correctly. The problem is that memory barrier is
> very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> involves the memory barrier per every single cache sg entry. In some
> CPU micro-architecture, a single memory barrier consumes more time than
> cache clean on 4KiB. It becomes more serious if the number of CPU cores
> are larger.

Have you got higher-level performance data for this change? It's more likely
that the DSB is what actually forces the prior cache maintenance to
complete, so it's important to look at the bigger picture, not just the
apparent relative cost of these instructions.

Also, it's a miracle that non-coherent DMA even works, so I'm not sure
that we should be complicating the implementation like this to try to
make it "fast".

Will
