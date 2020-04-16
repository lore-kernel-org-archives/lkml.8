Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45898C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DF22245
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636279AbgDPQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:13:48 -0400
Received: from verein.lst.de ([213.95.11.211]:53074 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506930AbgDPQNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:13:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7880268BEB; Thu, 16 Apr 2020 18:13:35 +0200 (CEST)
Date:   Thu, 16 Apr 2020 18:13:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/7] ASoC: txx9: don't work around too small
 resource_size_t
Message-ID: <20200416161334.GA13919@lst.de>
References: <20200416150011.820984-1-hch@lst.de> <20200416150011.820984-2-hch@lst.de> <20200416161226.GN5354@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161226.GN5354@sirena.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:12:26PM +0100, Mark Brown wrote:
> On Thu, Apr 16, 2020 at 05:00:05PM +0200, Christoph Hellwig wrote:
> > The txx9 sound driver deends on HAS_TXX9_ACLC, which is only set for
> > three tx49xx SOCs, and thus always has a 64-bit phys_addr_t and
> > resource_size_t.  Instead of poking into ioremap internals to work
> > around a potentially too small resource_size_t just add a BUILD_BUG_ON
> > to catch such a case.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> or can I just apply this independently of the rest of the series?

No, once ioremap is moved out of line the driver would otherwise
fail to compile as it doesn't pull in the defintitions anymore.
