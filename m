Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858BDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622C42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbgAXO3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:29:19 -0500
Received: from 8bytes.org ([81.169.241.247]:60796 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391259AbgAXO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:29:12 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 44E89AA1; Fri, 24 Jan 2020 15:29:10 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:29:07 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     suravee.suthikulpanit@amd.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during
 init
Message-ID: <20200124142907.GA27081@8bytes.org>
References: <20200123223214.2566-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123223214.2566-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:32:14PM -0700, Shuah Khan wrote:
> init_iommu_perf_ctr() clobbers the register when it checks write access
> to IOMMU perf counters and fails to restore when they are writable.
> 
> Add save and restore to fix it.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> -- Fix bug in sucessful return path. Add a return instead of
>    fall through to pc_false error case
> 
>  drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied for v5.5, thanks.
