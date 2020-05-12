Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA9DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A00120659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgELVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:13:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:44818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELVNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:13:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBE4AAC22;
        Tue, 12 May 2020 21:13:22 +0000 (UTC)
Date:   Tue, 12 May 2020 23:13:18 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, x86@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
Message-ID: <20200512211317.GG8135@suse.de>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
 <20200508150734.GP8135@suse.de>
 <ff5eb4e2-89a3-57a5-c6d6-42bf743e5d16@redhat.com>
 <20200512133429.GZ8135@suse.de>
 <26b328dc-2161-fdaa-f533-bf0027c13efc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b328dc-2161-fdaa-f533-bf0027c13efc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lenny,

On Tue, May 12, 2020 at 04:00:26PM -0400, Lenny Szubowicz wrote:
> Some Lenovo laptops provide an ACPI DMAR RMRR that identifies the memory
> range that the kernel should open up for permissable DMA access
> for this purpose. Unfortunately, the PCI device that performs these
> DMA operations is hidden from the kernel by the BIOS. Given that the
> associated PCI device is hidden, the Linux kernel does not act upon
> the associated DMAR RMRR.

That sounds aweful. We should add to the VT-d driver that it sets up
RMRR mappings for request-ids which are not present as a PCI device, to
fix the Laptops which have it.

For the others, is the region the TPM talks to via DMA known so that we
can add a quirk?


	Joerg
