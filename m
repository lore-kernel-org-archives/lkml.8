Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C42CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7FA20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbgEMIkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:40:33 -0400
Received: from 8bytes.org ([81.169.241.247]:42220 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMIkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:40:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 81C26379; Wed, 13 May 2020 10:40:31 +0200 (CEST)
Date:   Wed, 13 May 2020 10:40:30 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd: fix variable "iommu" set but not used
Message-ID: <20200513084030.GB9820@8bytes.org>
References: <20200509015645.3236-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509015645.3236-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:56:45PM -0400, Qian Cai wrote:
> The commit dce8d6964ebd ("iommu/amd: Convert to probe/release_device()
> call-backs") introduced an unused variable,
> 
> drivers/iommu/amd_iommu.c: In function 'amd_iommu_uninit_device':
> drivers/iommu/amd_iommu.c:422:20: warning: variable 'iommu' set but not
> used [-Wunused-but-set-variable]
>   struct amd_iommu *iommu;
>                     ^~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/amd_iommu.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

