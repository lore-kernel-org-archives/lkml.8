Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB010C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68102074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgFIRfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:35:00 -0400
Received: from verein.lst.de ([213.95.11.211]:43471 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgFIRfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:35:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3460168AFE; Tue,  9 Jun 2020 19:34:56 +0200 (CEST)
Date:   Tue, 9 Jun 2020 19:34:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        dillon min <dillon.minfei@gmail.com>,
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
Message-ID: <20200609173455.GA25467@lst.de>
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com> <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com> <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com> <CAL9mu0+__0Z3R3TcSrj9-kPxsyQHKS9WqK1u58P0dEZ+Jd-wbQ@mail.gmail.com> <20200609153646.GA17969@lst.de> <031034fb-b109-7410-3ff8-e78cd12a5552@arm.com> <b0c85637-4646-614b-d406-49aa72ce52e1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c85637-4646-614b-d406-49aa72ce52e1@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:25:04PM +0100, Vladimir Murzin wrote:
> Even though commit mentions ARM, I do not see how mmap would continue
> to work for NOMMU with dma-direct. ARM NOMMU needs it's own DMA operations
> only in cases where caches are implemented or active, in other cases it
> fully relies on dma-direct.

> It looks to me that we either should provide NOMMU variant for mmap in
> dma/direct or (carefully) fix dma/mapping.

I think dma-direct is the right place, the common helpers in
dma/mapping.c are basically the red headed stepchilds for misc
IOMMU drivers not covered by dma-iommu only.
