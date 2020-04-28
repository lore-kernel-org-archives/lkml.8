Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F1C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FD0206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgD1Nws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:52:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56345 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgD1Nws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:52:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C3B868CEC; Tue, 28 Apr 2020 15:52:46 +0200 (CEST)
Date:   Tue, 28 Apr 2020 15:52:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, hch@lst.de, jk@ozlabs.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/spufs: Add rcu_read_lock() around fcheck()
Message-ID: <20200428135245.GA2827@lst.de>
References: <20200428114811.68436-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428114811.68436-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:48:11PM +1000, Michael Ellerman wrote:
> 
> This comes from fcheck_files() via fcheck().
> 
> It's pretty clearly documented that fcheck() must be wrapped with
> rcu_read_lock(), so fix it.

But for this to actually be useful you'd need the rcu read lock until
your are done with the file (or got a reference).
