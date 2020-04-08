Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DEAC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECD02074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgDHOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:19:18 -0400
Received: from 8bytes.org ([81.169.241.247]:58562 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgDHOTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:19:18 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A7BD32B6; Wed,  8 Apr 2020 16:19:16 +0200 (CEST)
Date:   Wed, 8 Apr 2020 16:19:15 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200408141915.GJ3103@8bytes.org>
References: <20200407021246.10941-1-cai@lca.pw>
 <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Tue, Apr 07, 2020 at 11:36:05AM -0400, Qian Cai wrote:
> After further testing, the change along is insufficient. What I am chasing right
> now is the swap device will go offline after heavy memory pressure below. The
> symptom is similar to what we have in the commit,
> 
> 754265bcab78 (“iommu/amd: Fix race in increase_address_space()”)
> 
> Apparently, it is no possible to take the domain->lock in fetch_pte() because it
> could sleep.

Thanks a lot for finding and tracking down another race in the AMD IOMMU
page-table code.  The domain->lock is a spin-lock and taking it can't
sleep. But fetch_pte() is a fast-path and must not take any locks.

I think the best fix is to update the pt_root and mode of the domain
atomically by storing the mode in the lower 12 bits of pt_root. This way
they are stored together and can be read/write atomically.

Regards,

	Joerg

