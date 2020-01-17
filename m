Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86365C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AAD22464
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAQJ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:59:57 -0500
Received: from 8bytes.org ([81.169.241.247]:60102 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgAQJ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:59:57 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AA481327; Fri, 17 Jan 2020 10:59:55 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:59:54 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON_ONCE()
Message-ID: <20200117095953.GB15760@8bytes.org>
References: <20200116015236.4458-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116015236.4458-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 09:52:36AM +0800, Lu Baolu wrote:
> Address field in device TLB invalidation descriptor is qualified
> by the S field. If S field is zero, a single page at page address
> specified by address [63:12] is requested to be invalidated. If S
> field is set, the least significant bit in the address field with
> value 0b (say bit N) indicates the invalidation address range. The
> spec doesn't require the address [N - 1, 0] to be cleared, hence
> remove the unnecessary WARN_ON_ONCE().
> 
> Otherwise, the caller might set "mask = MAX_AGAW_PFN_WIDTH" in order
> to invalidating all the cached mappings on an endpoint, and below
> overflow error will be triggered.
> 
> [...]
> UBSAN: Undefined behaviour in drivers/iommu/dmar.c:1354:3
> shift exponent 64 is too large for 64-bit type 'long long unsigned int'
> [...]
> 
> Reported-and-tested-by: Frank <fgndev@posteo.de>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Does this need a Fixes and/or stable tag?


Regards,

	Joerg

