Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDAEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5353020823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgESMTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:19:03 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A61C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:19:02 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A4833386; Tue, 19 May 2020 14:19:01 +0200 (CEST)
Date:   Tue, 19 May 2020 14:19:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
Subject: Re: [PATCH] iommu/mediatek-v1: Fix a build warning for a unused
 variable 'data'
Message-ID: <20200519121900.GI18353@8bytes.org>
References: <1589875064-662-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589875064-662-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 03:57:44PM +0800, Yong Wu wrote:
> This patch fixes a build warning:
> drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_release_device':
> >> drivers/iommu/mtk_iommu_v1.c:467:25: warning: variable 'data' set but
> >> not used [-Wunused-but-set-variable]
> 467 |  struct mtk_iommu_data *data;
> |                         ^~~~
> 
> It's reported at:
> https://lore.kernel.org/linux-iommu/202005191458.gY38V8bU%25lkp@intel.com/T/#u
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.
