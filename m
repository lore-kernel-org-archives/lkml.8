Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E81C38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E17321D79
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgDRMo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgDRMo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:44:56 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E43C061A0C;
        Sat, 18 Apr 2020 05:44:55 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7275A48C; Sat, 18 Apr 2020 14:44:54 +0200 (CEST)
Date:   Sat, 18 Apr 2020 14:44:53 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "drake@endlessm.com" <drake@endlessm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Message-ID: <20200418124452.GE6113@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200417010335.31739-1-drake@endlessm.com>
 <aafed865c0254934986528b3ce9c4d34ff2fccad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafed865c0254934986528b3ce9c4d34ff2fccad.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, Hi Daniel,

On Fri, Apr 17, 2020 at 01:14:30AM +0000, Derrick, Jonathan wrote:
> Hi Daniel> I should have CCed you on this, but it should temporarily resolve that
> issue:
> https://lists.linuxfoundation.org/pipermail/iommu/2020-April/043253.html

Yes, this is an issue in the hotplug handling path which I already fixed
in my branch. With next post of this series it should work.

Regards,

	Joerg
