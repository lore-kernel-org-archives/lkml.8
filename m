Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70057C54FD4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5191C20724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCYChE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:37:04 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:40720 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYChA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:37:00 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992798AbgCYCg5y2cvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Wed, 25 Mar 2020 03:36:57 +0100
Date:   Wed, 25 Mar 2020 02:36:57 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Fredrik Noring <noring@nocrew.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] MIPS: remove cpu_has_64bit_gp_regs and
 cpu_has_64bit_addresses
In-Reply-To: <20200324161525.754181-2-hch@lst.de>
Message-ID: <alpine.LFD.2.21.2003250226450.2689954@eddie.linux-mips.org>
References: <20200324161525.754181-1-hch@lst.de> <20200324161525.754181-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Christoph Hellwig wrote:

> Both macros are always identical to CONFIG_64BIT.

 I think this abstraction makes sense, especially if we want to support 
64-bit CPUs that only support 32-bit segments, i.e. MIPS architecture 
processors whose CP0.Config.AT=1, or legacy MIPS processors that had a 
similar limitation, such as the R5900 currently under review.

  Maciej
