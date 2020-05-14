Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30932065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgENL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:58:33 -0400
Received: from verein.lst.de ([213.95.11.211]:51537 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENL6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:58:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EA8E68BEB; Thu, 14 May 2020 13:58:29 +0200 (CEST)
Date:   Thu, 14 May 2020 13:58:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeremy Linton <jeremy.linton@arm.com>,
        syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] USB: usbfs: fix mmap dma mismatch
Message-ID: <20200514115829.GA15995@lst.de>
References: <20200514112711.1858252-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514112711.1858252-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:27:11PM +0200, Greg Kroah-Hartman wrote:
> +	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> +		if (remap_pfn_range(vma, vma->vm_start,
> +				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> +				    size, vma->vm_page_prot) < 0) {
> +			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
> +			return -EAGAIN;
> +		}
> +	} else {
> +		if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle,
> +				      size)) {
> +			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
> +			return -EAGAIN;
> +		}

What about a goto label to share the error handling path?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
