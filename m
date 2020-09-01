Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB05C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CA12071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIAHUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:20:14 -0400
Received: from verein.lst.de ([213.95.11.211]:52176 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:20:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E569468B05; Tue,  1 Sep 2020 09:20:07 +0200 (CEST)
Date:   Tue, 1 Sep 2020 09:20:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, ganapatrao.kulkarni@cavium.com,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com, huangdaode@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v8 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA
 CMA
Message-ID: <20200901072007.GA30123@lst.de>
References: <20200823230309.28980-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823230309.28980-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree.
