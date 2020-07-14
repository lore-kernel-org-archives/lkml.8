Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD336C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3EA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGNLWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:22:13 -0400
Received: from verein.lst.de ([213.95.11.211]:54001 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGNLWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:22:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 805CF68CFC; Tue, 14 Jul 2020 13:22:08 +0200 (CEST)
Date:   Tue, 14 Jul 2020 13:22:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dma-pool: Introduce dma_guess_pool()
Message-ID: <20200714112208.GA18261@lst.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de> <20200709161903.26229-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709161903.26229-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one doesn't appear to actually apply on top of Linus' tree plus the
two previous patches.
