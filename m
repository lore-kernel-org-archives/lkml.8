Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBFAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244E7205CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIDJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:42:37 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF7C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:42:36 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CD0339CE; Fri,  4 Sep 2020 11:42:34 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:42:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5] iommu/mediatek: check 4GB mode by reading infracfg
Message-ID: <20200904094233.GP6714@8bytes.org>
References: <20200831105639.2856-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831105639.2856-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:56:39PM +0800, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> [1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
> [2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
> [3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

You forgot to add the tags here from v4, at least Matthias' Reviewed-by
is missing. Please add the missing tags and resend.


	Joerg
