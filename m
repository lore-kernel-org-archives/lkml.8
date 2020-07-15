Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AA02065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGOHM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:12:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57898 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbgGOHM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:12:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC68A6736F; Wed, 15 Jul 2020 09:12:56 +0200 (CEST)
Date:   Wed, 15 Jul 2020 09:12:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/4] dma-pool: Fix atomic pool selection
Message-ID: <20200715071256.GA22500@lst.de>
References: <20200714123928.8581-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714123928.8581-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:39:24PM +0200, Nicolas Saenz Julienne wrote:
> This is my attempt at fixing one of the regressions we've seen[1] after
> the introduction of per-zone atomic pools.
> 
> This combined with "dma-pool: Do not allocate pool memory from CMA"[2]
> should fix the boot issues on Jeremy's RPi4 setup.

I've applied the series as well as that patch to the dma-mapping tree,
thanks.
