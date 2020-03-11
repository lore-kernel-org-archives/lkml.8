Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL_NO_RDNS autolearn=no autolearn_force=no version=3.4.0
Received: from mout.gmx.net ([212.227.15.15]:60243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgCKPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:34:43 -0400
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To: Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
From: "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
Date: Wed, 11 Mar 2020 15:34:38 +0000
MIME-Version: 1.0
In-Reply-To: <20200311152453.GB23704@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/20 3:24 PM, Christoph Hellwig wrote:
> pdev->dma_mask = parent->dma_mask ? *parent->dma_mask : 0;

This patch makes no difference.

The kernel panics with the same call trace which starts with:

RIP: 0010:kmem_cache_alloc_trace
...

? acpi_ds_create_walk_state
acpi_ds_create_walk_state
acpi_ds_call_control_method
acpi_ds_parse_aml
acpi_ps_execute_method
acpi_ns_evaluate
acpi_ut_evaluate_object
...

