Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCA2C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0977020735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406096AbgDNGor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 02:44:47 -0400
Received: from verein.lst.de ([213.95.11.211]:37692 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgDNGoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:44:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C623E68BEB; Tue, 14 Apr 2020 08:44:41 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:44:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
Message-ID: <20200414064441.GC23359@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com> <20200410145520.17864-1-hdanton@sina.com> <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 12:37:20PM -0700, David Rientjes wrote:
> I'll rely on Christoph to determine whether it makes sense to add some 
> periodic scavening of the atomic pools, whether that's needed for this to 
> be merged, or wheter we should enforce some maximum pool size.

I don't really see the point.  In fact the only part of the series
I feel uneasy about is the growing of the pools, because it already
adds a fair amount of complexity that we might not need for simple
things, but shrinking really doesn't make any sense.  So I'm tempted
to not ever support shrinking, and even make growing optional code under
a new config variable.  We'll also need a way to query the current size
through e.g. a debugfs file.
