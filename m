Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D75B22D6F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgHJPh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:37:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgHJPh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:37:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B80AACA2;
        Mon, 10 Aug 2020 15:38:16 +0000 (UTC)
Message-ID: <1899fe01e1eb5c23270541e1833b12365818c150.camel@suse.com>
Subject: Re: [PATCH AUTOSEL 5.8 70/72] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
From:   Martin Wilck <mwilck@suse.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Date:   Mon, 10 Aug 2020 17:37:54 +0200
In-Reply-To: <20200808233542.3617339-70-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
         <20200808233542.3617339-70-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-08 at 19:35 -0400, Sasha Levin wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> [ Upstream commit fbd6a42d8932e172921c7de10468a2e12c34846b ]
> 
> When nvme_round_robin_path() finds a valid namespace we should be
> using it;
> falling back to __nvme_find_path() for non-optimized paths will cause
> the
> result from nvme_round_robin_path() to be ignored for non-optimized
> paths.
> 
> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/nvme/host/multipath.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Hello Sasha,

this patch needs a fix that I recently submitted to linux-nvme.
The same holds for the respective 5.7 and 5.4 AUTOSEL patches.

http://lists.infradead.org/pipermail/linux-nvme/2020-August/018570.html

Regards,
Martin


