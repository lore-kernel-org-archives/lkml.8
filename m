Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE4C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C320B20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgIDIlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIDIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:41:45 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE8C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:41:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 49EED3D5; Fri,  4 Sep 2020 10:41:37 +0200 (CEST)
Date:   Fri, 4 Sep 2020 10:41:35 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: mtk: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200904084135.GA6714@8bytes.org>
References: <20200727181842.8441-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727181842.8441-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 08:18:42PM +0200, Krzysztof Kozlowski wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/iommu/mtk_iommu.c:833:34: warning: 'mtk_iommu_of_ids' defined but not used [-Wunused-const-variable=]
>       833 | static const struct of_device_id mtk_iommu_of_ids[] = {
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
