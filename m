Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C018E2065C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFDJQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:16:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgFDJQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:16:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51022AB87;
        Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Date:   Thu, 4 Jun 2020 11:16:19 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu: Don't attach deferred device in
 iommu_group_do_dma_attach
Message-ID: <20200604091619.GO6857@suse.de>
References: <20200604073142.74701-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604073142.74701-1-jsnitsel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Thu, Jun 04, 2020 at 12:31:42AM -0700, Jerry Snitselaar wrote:
> Attaching a deferred device should be delayed until dma api is called.
> 
> Cc: iommu@lists.linux-foundation.org
> Suggested-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> If you already have thrown a patch together, then ignore this. Also
> feel free to swap out the signed-off-by with your's since
> this is more your patch than mine. You can put a reviewed-by
> and tested-by instead for me.

Yeah, I already have a patch, just not sent out yet. I updated it with
your tags and will send it out shortly.

Regards,

	Joerg
