Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598A920748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGJOPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgGJOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:15:35 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F18C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:15:34 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7E62820C; Fri, 10 Jul 2020 16:15:33 +0200 (CEST)
Date:   Fri, 10 Jul 2020 16:15:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200710141532.GK27672@8bytes.org>
References: <20200703162548.19953-1-will@kernel.org>
 <20200710125831.GI27672@8bytes.org>
 <20200710130526.GA30578@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710130526.GA30578@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Jul 10, 2020 at 02:05:27PM +0100, Will Deacon wrote:
> Ah, I'd already got this queued for 5.9:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
> 
> and I've queued a small number of patches on top of it now.
> 
> Are you planning to send it for 5.8? If so, I suspect I'll have to rebase.

No problem, nothing got pushed yet. I removed it from my branch and wait
for your pull-request.


	Joerg
