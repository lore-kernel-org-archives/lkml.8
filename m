Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B061C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D93920409
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCYIaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:30:17 -0400
Received: from verein.lst.de ([213.95.11.211]:39651 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgCYIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:30:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A87AE68AFE; Wed, 25 Mar 2020 09:30:13 +0100 (CET)
Date:   Wed, 25 Mar 2020 09:30:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Fredrik Noring <noring@nocrew.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] MIPS: remove cpu_has_64bit_gp_regs and
 cpu_has_64bit_addresses
Message-ID: <20200325083012.GA21605@lst.de>
References: <20200324161525.754181-1-hch@lst.de> <20200324161525.754181-2-hch@lst.de> <alpine.LFD.2.21.2003250226450.2689954@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2003250226450.2689954@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 02:36:57AM +0000, Maciej W. Rozycki wrote:
> On Tue, 24 Mar 2020, Christoph Hellwig wrote:
> 
> > Both macros are always identical to CONFIG_64BIT.
> 
>  I think this abstraction makes sense, especially if we want to support 
> 64-bit CPUs that only support 32-bit segments, i.e. MIPS architecture 
> processors whose CP0.Config.AT=1, or legacy MIPS processors that had a 
> similar limitation, such as the R5900 currently under review.

The only use of cpu_has_64bit_addresses is the choice of the ioremap
code base.  Which ioremap code does the R5900 want to use?  If it
doesn't match CONFIG_64BIT having a config option for the ioremap
implementation seems much more sensible, and can be added with the
R5900 patch set (do you have a link to it?).
