Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30A0C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41262077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCYJyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:38 -0400
Received: from verein.lst.de ([213.95.11.211]:40008 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgCYJyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:54:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEB4368AFE; Wed, 25 Mar 2020 10:54:35 +0100 (CET)
Date:   Wed, 25 Mar 2020 10:54:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] MIPS: remove cpu_has_64bit_gp_regs and
 cpu_has_64bit_addresses
Message-ID: <20200325095435.GA27807@lst.de>
References: <20200324161525.754181-1-hch@lst.de> <20200324161525.754181-2-hch@lst.de> <alpine.LFD.2.21.2003250226450.2689954@eddie.linux-mips.org> <20200325083012.GA21605@lst.de> <20200325085524.GA28706@sx9> <20200325085852.GA23786@lst.de> <20200325092446.GB28706@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325092446.GB28706@sx9>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:24:46AM +0100, Fredrik Noring wrote:
> > > The (slightly outdated) patch series under review
> > > is available here:
> > > 
> > > https://lore.kernel.org/linux-mips/cover.1567326213.git.noring@nocrew.org/T/
> > 
> > You don't happen to have a git tree available somewhere?
> 
> https://github.com/frno7/linux/tree/ps2-v5.4
> 
> is stable at v5.4,
> 
> https://github.com/frno7/linux/tree/ps2-master
> 
> has more experimental stuff (also at v5.4 at the moment). There are some
> (work-in-progress) notes on the R5900 psABI, that may be of interest, here:
> 
> https://github.com/frno7/linux/wiki/R5900-processor-specific-ABI-(psABI)

So from what I can tell this uses a 32-bit kernel and 32-bit userspace,
and sets both pu_has_64bit_gp_regs and cpu_has_64bit_addresses to 0.

Now if you ever wanted to make use of the 64-bit registeres it would
require quite some changes, which probably really should have a new
Kconfig option.  In fact a lot of the workaround for the 64-bit
registeres that are in the code already should be keyed off such an
option rather than CONFIG_CPU_R5900.
