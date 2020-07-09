Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B350207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGIPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGIPXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:23:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EBC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:23:43 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8F70D272; Thu,  9 Jul 2020 17:23:40 +0200 (CEST)
Date:   Thu, 9 Jul 2020 17:23:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 07/34] iommu: Add probe_device() and release_device()
 call-backs
Message-ID: <20200709152337.GB27672@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200704090957.8892-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704090957.8892-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 05:09:57PM +0800, Hillf Danton wrote:
> > +	group = iommu_group_get_for_dev(dev);
> > +	if (!IS_ERR(group)) {
> 
> Typo?

Yes, fortunatly it gets fixed again in patch 11 of this series.

Regards,

	Joerg
