Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A2C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D9920714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgBLR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:58:00 -0500
Received: from verein.lst.de ([213.95.11.211]:39692 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLR6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:58:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4718868C65; Wed, 12 Feb 2020 18:57:57 +0100 (CET)
Date:   Wed, 12 Feb 2020 18:57:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Roger Quadros <rogerq@ti.com>, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        stefan.wahren@i2se.com, afaerber@suse.de, hverkuil@xs4all.nl,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: dma_mask limited to 32-bits with OF platform device
Message-ID: <20200212175756.GA6034@lst.de>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com> <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com> <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com> <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:04:31PM +0000, Robin Murphy wrote:
>> For now, let's say that we limit dma-ranges to 4GB size. with "dma-ranges 
>> = <0x00000000 0x00000000 0x1 0x00000000>;"
>> Then, dma_bus_limit is set correctly to 0xffffffff, SATA driver sets masks 
>> to 64-bit as IP supports that.
>>
>> [   13.306847] ahci 4a140000.sata: dma_mask 0xffffffffffffffff, 
>> coherent_mask 0xffffffffffffffff, dma_bus_limit 0xffffffff
>>
>> However, the SATA controller still tries to do DMA above 32-bits.
>> dma_alloc() doesn't seem to be taking dma_bus_limit into account?
>
> Yay ARM LPAE... Peter and Christoph have already been playing whack-a-mole 
> with other bugs under that config - is this with or without SWIOTLB? (and 
> whichever way, does the other work any better?)

Hmm.  ARM LPAE still uses the arm legacy dma alloc coherent, and that
might not be taking the dma_bus_limit into account.  Let me check..
