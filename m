Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE40CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9343D20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgFIPgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:36:53 -0400
Received: from verein.lst.de ([213.95.11.211]:43019 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgFIPgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:36:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B476668B02; Tue,  9 Jun 2020 17:36:46 +0200 (CEST)
Date:   Tue, 9 Jun 2020 17:36:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>, hch@lst.de,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if
 device support reserved memory
Message-ID: <20200609153646.GA17969@lst.de>
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com> <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com> <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com> <CAL9mu0+__0Z3R3TcSrj9-kPxsyQHKS9WqK1u58P0dEZ+Jd-wbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL9mu0+__0Z3R3TcSrj9-kPxsyQHKS9WqK1u58P0dEZ+Jd-wbQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:22:24PM +0800, dillon min wrote:
> Hi Vladimir,
> 
> Thanks for reviewing.
> 
> Hi Christoph Hellwig,
> 
> I just want to know if kernel dma mapping/direct is focused on
> platforms with MMU.
> leave arch code to handle dma coherent memory management themself for
> no-MMU platform.

No, I'd really like to consolidate everything that isn't overly
arch specific eventually.

> 
> so, you just return error code in kernel/dma/mapping.c,direct.c
> without CONFIG_MMU defined ?
> which means dma-direct mapping doesn't support !CONFIG_MMU is not a
> bug, but design as it's.
> or, just return error code currently, will add dma direct mapping
> support for !CONFIG_MMU in the
> future?
> 
> As Vladimir Murzin's suggestion has changes in kernel code, I need
> your input to get
> the design goal about dma-direct mapping, thanks.

Can someone repost the whole patch?
