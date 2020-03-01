Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF02C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921720880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCAOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:42:57 -0500
Received: from verein.lst.de ([213.95.11.211]:39713 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCAOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 09:42:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71AEC68BE1; Sun,  1 Mar 2020 15:42:54 +0100 (CET)
Date:   Sun, 1 Mar 2020 15:42:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Nori, Sekhar" <nsekhar@ti.com>
Subject: Re: take the bus_dma_limit into account on arm
Message-ID: <20200301144253.GB22459@lst.de>
References: <20200218184103.35932-1-hch@lst.de> <6e0988f4-7958-29d9-6249-24ee51edee3a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0988f4-7958-29d9-6249-24ee51edee3a@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there seems no movement I've added it to my for-next branch so that
it at least gets some linux-next exposure.

But it really needs a few reviews.
