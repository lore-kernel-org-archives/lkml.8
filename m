Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD21C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD0C24672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBSJqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:46:08 -0500
Received: from 8bytes.org ([81.169.241.247]:54824 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:46:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 38850346; Wed, 19 Feb 2020 10:46:06 +0100 (CET)
Date:   Wed, 19 Feb 2020 10:46:04 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Liam Mark <lmark@codeaurora.org>, pratikp@codeaurora.org,
        kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200219094604.GI22063@8bytes.org>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Some devices have a memory map which contains gaps or holes.
> In order for the device to have as much IOVA space as possible,
> allow its driver to inform the DMA-IOMMU layer that it should
> not allocate addresses from these holes.
> 
> Change-Id: I15bd1d313d889c2572d0eb2adecf6bebde3267f7
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>

Ideally this is something put into the IOMMU firmware table by the
platform firmware. If its not there, a quirk is the best way to handle
this.

Regards,

	Joerg
