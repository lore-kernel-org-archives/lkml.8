Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C0E206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589437674;
	bh=ZZL/VqoacdeBCG/xZqKQotkNP7fuRxsK35yGhyyUx20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=soOCu7Id5iFZiRUw1QN2DizXkevVBfLUvzhkEQjQQBtwavmY5r3V1hn6Kko/MCL7j
	 i0y5YBgKul+MKPYQ61s/XNqZffQMYDXOJ5M5MgUebvjU3OnsJBz9EEZOeOQyqA3WAo
	 Z3WVVAlQnvebbTVfse1owOT+gIL+RxcjfmDXJAOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgENG1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgENG1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:27:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEED206B6;
        Thu, 14 May 2020 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589437672;
        bh=ZZL/VqoacdeBCG/xZqKQotkNP7fuRxsK35yGhyyUx20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGwF8ASJoWP8ykgSGEL/7yAp6tuDZFLCWd4GHadPK/Jy0EBZUBanEEfCeTEKkWSl/
         gTpl4Q/qikRRcaE8ItuVW2nz+/MdymI14MUHKX8IVb5daWtH8bphPFAUaSuXKS/9ww
         ky/9xD1YMqx6jyqbMhrZX2Kyl0nxHS2VmJkHP6fo=
Date:   Thu, 14 May 2020 08:27:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Validating dma_mmap_coherent() parameters before calling (was Re:
 WARNING in memtype_reserve)
Message-ID: <20200514062750.GA1488715@kroah.com>
References: <000000000000f0d8d205a531f1a3@google.com>
 <20200509074507.GC1831917@kroah.com>
 <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
 <20200513124445.GA1082735@kroah.com>
 <87zhab249p.fsf@nanos.tec.linutronix.de>
 <20200514035458.14760-1-hdanton@sina.com>
 <20200514061417.GA8367@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514061417.GA8367@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:14:17AM +0200, Christoph Hellwig wrote:
> Guys, can you please start formal thread on this?  I have no
> idea where this came from and what the rationale is.  Btw, if the
> pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
> crap, as it is derived from that.  What is the caller, and how is
> this triggered?


Ok, to summarize, commit 2bef9aed6f0e ("usb: usbfs: correct kernel->user
page attribute mismatch") changed a call from remap_pfn_range() to
dma_mmap_coherent() for usb data buffers being sent from userspace.

Details on why this was changed is in the commit changelog, but this has
triggered a WARN_ON() in memtype_reserve when I think some odd data
buffers were sent to it by syzbot fuzzing.

The warning caught the wrong data, but triggered syzbot.

So, the question is, should all callers of dma_mmap_coherent() validate
the parms better before it is called, or should the call chain here
properly sanitize things on their own.

Note, usbfs is not the only direct-from-userspace caller of
dma_mmap_coherent(), it's also used in other userspace apis (frame
buffer drivers, fastrpc, some SoC drivers) but it looks like nothing has
fuzzed those apis before to trigger this.

Does that help explain things better?

thanks,

greg k-h
