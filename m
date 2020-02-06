Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F902C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6267720720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k0QW1zod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgBFHcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:32:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKS2dna2ZWLnRfXzTY1qmCv1+KkdOP5HPIrpAL96RDk=; b=k0QW1zoda1V1au22RMPPgv+A1W
        XiXP3A+av1NH05g4Bq8JGruOkyr1WwEOY9zScW+CRzD8kznSWq3XEJDfXA1ieutabQCYuNDvBgLHd
        seIAfGZcaYXIrJXDPNPzQGEH+yevCf4pc1woyje1FETptiMuNpoMH+GbWpTT4apmkK4i9U9+cAdaG
        qiMjoKwVVMtV/egiAsLx44Iyem1m9l5se+eofCKUX3QL8j4uQ8B293n2xYqTxx58QfpZAVSeNgiai
        Y7ROgakzy5WsEOXoEPbNahn6EI4YtefEhGwcYJbWDSw+q0Wj6JOaDwmrmn9JUrUvEie5pGY0mhuHl
        RnDhPRXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izbe9-0007N1-KC; Thu, 06 Feb 2020 07:32:21 +0000
Date:   Wed, 5 Feb 2020 23:32:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
Message-ID: <20200206073221.GA27797@infradead.org>
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
 <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
 <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com>
 <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
 <CAPpJ_efn0jwHf8rWjBm0=BwrFd=z7MATWkNsqNfHuyrn4wAt+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpJ_efn0jwHf8rWjBm0=BwrFd=z7MATWkNsqNfHuyrn4wAt+w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:25:48PM +0800, Jian-Hong Pan wrote:
> Here is the original issue: There are more and more laptops equipped
> with Intel Rapid Storage Technology (RST) feature.  That makes the
> NVMe SSD hidden and as the cache.  However, there is no built in
> driver for it.  So, Daniel prepares a driver called intel-nvme-remap
> [1] to remap and show up the hidden NVMe SSD and make it as a normal
> SSD.  The driver is developed and refers to
> drivers/pci/controller/vmd.c.
> 
> Recently, we get a laptop with Intel RST feature enabled in BIOS and
> two NVMe SSDs after the RAID bus controller.  So, those two NVMe SSDs
> are hidden by Intel RST.  Then, intel-nvme-remap is going to remap and
> show up the NVMe SSDs.  But it hits two issues:

So you are using a driver that has been rejeced because it and the
Intel magic it tries to work around are completely broken, and then
complain it doesn't work?  There is no reason to hack up the intel-iommu
to work around your broken patched kernel then.
