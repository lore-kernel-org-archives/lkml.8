Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02632C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0118207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbgFXHWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:22:04 -0400
Received: from verein.lst.de ([213.95.11.211]:43123 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgFXHWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:22:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17DCE68B02; Wed, 24 Jun 2020 09:22:01 +0200 (CEST)
Date:   Wed, 24 Jun 2020 09:22:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] mm: fix migrate_vma_setup() src_owner and
 normal pages
Message-ID: <20200624072200.GA18609@lst.de>
References: <20200622222008.9971-1-rcampbell@nvidia.com> <20200623114018.GA17496@lst.de> <a0dbf913-2bd0-b032-596e-520e678d5b5b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0dbf913-2bd0-b032-596e-520e678d5b5b@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:05:19AM -0700, Ralph Campbell wrote:
>
> On 6/23/20 4:40 AM, Christoph Hellwig wrote:
>> On Mon, Jun 22, 2020 at 03:20:08PM -0700, Ralph Campbell wrote:
>>> The caller of migrate_vma_setup() does not know what type of page is
>>> stored in the CPU's page tables. Pages within the specified range are
>>> free to be swapped out, migrated, or freed until after migrate_vma_setup()
>>> returns. The caller needs to set struct migrate_vma.src_owner in case a
>>> page is a ZONE device private page that the device owns and might want to
>>> migrate. However, the current code skips normal anonymous pages if
>>> src_owner is set, thus preventing those pages from being migrated.
>>> Remove the src_owner check for normal pages since src_owner only applies
>>> to device private pages and allow a range of normal and device private
>>> pages to be migrated.
>>
>> src_owner being set means we want to migrate from device private
>> memory to normal host DRAM.  What kind of problem do you see of
>> not touching already present pages in that path?
>>
>
> The problem is that migrate_vma_setup() invalidates the address range so any
> previously migrated pages to device private memory have to be faulted in
> again. By having the PFN of those device private pages in the src array, the
> driver can reinstate the device MMU mappings and avoid the page faults.

Maybe add that to the changelog?
