Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B8E2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390465AbgEYLxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390302AbgEYLxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F4AEABD1;
        Mon, 25 May 2020 11:53:15 +0000 (UTC)
Date:   Mon, 25 May 2020 13:53:10 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/vt-d: fix a GCC warning
Message-ID: <20200525115310.GG5075@suse.de>
References: <20200521215030.16938-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521215030.16938-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 05:50:30PM -0400, Qian Cai wrote:
> The commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced a GCC warning,
> 
> drivers/iommu/intel-iommu.c:5330:1: warning: 'static' is not at beginning of
> declaration [-Wold-style-declaration]
>  const static int
>  ^~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
