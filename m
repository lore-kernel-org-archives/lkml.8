Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F710C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CC620823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgENLXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:23:22 -0400
Received: from 8bytes.org ([81.169.241.247]:42820 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:23:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 490C9379; Thu, 14 May 2020 13:23:20 +0200 (CEST)
Date:   Thu, 14 May 2020 13:23:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on jetson-tk1
Message-ID: <20200514112317.GH18353@8bytes.org>
References: <5eb9fab4.1c69fb81.a1f1c.0e95@mx.google.com>
 <a868fa70-9039-f72a-39c6-5464a9d06db2@collabora.com>
 <20200512151600.GD8135@suse.de>
 <c9745450-a6d0-1944-a9af-ef9ce18fed12@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9745450-a6d0-1944-a9af-ef9ce18fed12@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:16:14PM +0100, Guillaume Tucker wrote:
> which this time gave me:
> 
> <4>[    2.540558] PC is at iommu_probe_device+0x1c/0x15c
> <4>[    2.545606] LR is at of_iommu_configure+0x15c/0x1c4
> <4>[    2.550736] pc : [<c092e0e4>]    lr : [<c0932c0c>]    psr: a0000013
> 
> which in turn brings us to:
> 
> (gdb) l *0xc092e0e4
> 0xc092e0e4 is in iommu_probe_device (drivers/iommu/iommu.c:232).
> 227		int ret;
> 228	
> 229		if (!dev_iommu_get(dev))
> 230			return -ENOMEM;
> 231	
> 232		if (!try_module_get(ops->owner)) {
> 233			ret = -EINVAL;
> 234			goto err_out;
> 235		}
> 236

Okay, so ops is NULL. I queued a fix for that in the iommu-tree. If you
test the latest master branch the problem should be gone.

Thanks for the report,


       Joerg
