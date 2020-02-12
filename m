Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E27C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5999E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgBLOEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:04:36 -0500
Received: from foss.arm.com ([217.140.110.172]:33286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLOEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:04:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B43328;
        Wed, 12 Feb 2020 06:04:35 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241AA3F6CF;
        Wed, 12 Feb 2020 06:04:33 -0800 (PST)
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Roger Quadros <rogerq@ti.com>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>
Cc:     stefan.wahren@i2se.com, afaerber@suse.de, hverkuil@xs4all.nl,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com>
 <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
 <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
Date:   Wed, 12 Feb 2020 14:04:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 12:33 pm, Roger Quadros wrote:
[...]
> For now, let's say that we limit dma-ranges to 4GB size. with 
> "dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;"
> Then, dma_bus_limit is set correctly to 0xffffffff, SATA driver sets 
> masks to 64-bit as IP supports that.
> 
> [   13.306847] ahci 4a140000.sata: dma_mask 0xffffffffffffffff, 
> coherent_mask 0xffffffffffffffff, dma_bus_limit 0xffffffff
> 
> However, the SATA controller still tries to do DMA above 32-bits.
> dma_alloc() doesn't seem to be taking dma_bus_limit into account?

Yay ARM LPAE... Peter and Christoph have already been playing 
whack-a-mole with other bugs under that config - is this with or without 
SWIOTLB? (and whichever way, does the other work any better?)

Robin.
