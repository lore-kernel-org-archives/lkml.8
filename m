Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0041C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A05206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgD0PGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:06:19 -0400
Received: from verein.lst.de ([213.95.11.211]:48868 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgD0PGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:06:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3CC5D68C7B; Mon, 27 Apr 2020 17:06:13 +0200 (CEST)
Date:   Mon, 27 Apr 2020 17:06:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200427150612.GA5910@lst.de>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427123443.520469-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to nvme-5.7.

Not a huge fan of it, though - but I think I have an idea how to sort
some of this mess out with better block layer APIs.
