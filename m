Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9954207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGJONy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgGJONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:13:53 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:13:53 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E00A920C; Fri, 10 Jul 2020 16:13:50 +0200 (CEST)
Date:   Fri, 10 Jul 2020 16:13:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Chao Hao <chao.hao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: Re: [PATCH v6 00/10] MT6779 IOMMU SUPPORT
Message-ID: <20200710141349.GJ27672@8bytes.org>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 12:41:17PM +0800, Chao Hao wrote:
> Chao Hao (10):
>   dt-bindings: mediatek: Add bindings for MT6779
>   iommu/mediatek: Rename the register STANDARD_AXI_MODE(0x48) to MISC_CTRL
>   iommu/mediatek: Use a u32 flags to describe different HW features
>   iommu/mediatek: Setting MISC_CTRL register
>   iommu/mediatek: Move inv_sel_reg into the plat_data
>   iommu/mediatek: Add sub_comm id in translation fault
>   iommu/mediatek: Add REG_MMU_WR_LEN_CTRL register definition
>   iommu/mediatek: Extend protect pa alignment value
>   iommu/mediatek: Modify MMU_CTRL register setting
>   iommu/mediatek: Add mt6779 basic support

Applied, thanks.
