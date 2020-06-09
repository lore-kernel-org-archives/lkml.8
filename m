Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6585620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgFIFnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:43:12 -0400
Received: from verein.lst.de ([213.95.11.211]:40741 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgFIFnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:43:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28BA868AFE; Tue,  9 Jun 2020 07:43:07 +0200 (CEST)
Date:   Tue, 9 Jun 2020 07:43:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Christoph Hellwig <hch@lst.de>, alsa-devel@alsa-project.org,
        bp@alien8.de, hch@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200609054306.GA9606@lst.de>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost> <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 07:31:47PM -0700, David Rientjes wrote:
> On Mon, 8 Jun 2020, Alex Xu (Hello71) wrote:
> 
> > Excerpts from Christoph Hellwig's message of June 8, 2020 2:19 am:
> > > Can you do a listing using gdb where this happens?
> > > 
> > > gdb vmlinux
> > > 
> > > l *(snd_pcm_hw_params+0x3f3)
> > > 
> > > ?
> > > 
> > 
> > (gdb) l *(snd_pcm_hw_params+0x3f3)
> > 0xffffffff817efc85 is in snd_pcm_hw_params (.../linux/sound/core/pcm_native.c:749).
> > 744             while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
> > 745                     runtime->boundary *= 2;
> > 746
> > 747             /* clear the buffer for avoiding possible kernel info leaks */
> > 748             if (runtime->dma_area && !substream->ops->copy_user)
> > 749                     memset(runtime->dma_area, 0, runtime->dma_bytes);
> > 750
> > 751             snd_pcm_timer_resolution_change(substream);
> > 752             snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
> > 753
> > 
> 
> Working theory is that CONFIG_DMA_NONCOHERENT_MMAP getting set is causing 
> the error_code in the page fault path.  Debugging with Alex off-thread we 
> found that dma_{alloc,free}_from_pool() are not getting called from the 
> new code in dma_direct_{alloc,free}_pages() and he has not enabled 
> mem_encrypt.

While DMA_COHERENT_POOL absolutely should not select DMA_NONCOHERENT_MMAP
(and you should send your patch either way), I don't think it is going
to make a difference here, as DMA_NONCOHERENT_MMAP just means we
allows mmaps even for non-coherent devices, and we do not support
non-coherent devices on x86.

From the disassembly it seems like a vmalloc allocation is NULL, which
seems really weird as this patch shouldn't make a difference for them,
and I also only see a single places that allocates the field, and that
checks for an allocation failure.  But the sound code is a little
hard to unwind sometimes.
