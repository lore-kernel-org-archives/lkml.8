Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00553C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF5B20724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCXHyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:54:05 -0400
Received: from verein.lst.de ([213.95.11.211]:34305 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCXHyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:54:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E210B68BFE; Tue, 24 Mar 2020 08:54:02 +0100 (CET)
Date:   Tue, 24 Mar 2020 08:54:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200324075402.GJ23447@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de> <87sghz2ibh.fsf@linux.ibm.com> <20200323172256.GB31269@lst.de> <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:05:54PM +1100, Alexey Kardashevskiy wrote:
> This is for persistent memory which you can DMA to/from but yet it does
> not appear in the system as a normal memory and therefore requires
> special handling anyway (O_DIRECT or DAX, I do not know the exact
> mechanics). All other devices in the system should just run as usual,
> i.e. use 1:1 mapping if possible.

On other systems (x86 and arm) pmem as long as it is page backed does
not require any special handling.  This must be some weird way powerpc
fucked up again, and I suspect you'll have to suffer from it.
