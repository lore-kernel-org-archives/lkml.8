Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA87AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB60F207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596070605;
	bh=JT6jtDG0iOddtAjTvbt4c86jgkq7+Vw0sGLnvvm3bH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zYA69fWPvztnR5H6DqW2cVxapgNCYFgJFWjwKS0r8eeDovbK4ftUzeBvpKYqQ1RGf
	 b3WN2hC07d41Hkepr313rIG02TlLUrs+Wrxh2XaSxfhcYqGvQQiisZD45zd2wBAXoa
	 226M17vPMIuMQGQCFf/6s81DKLs1sguTEynHh2dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgG3A4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgG3A4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:56:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2162075D;
        Thu, 30 Jul 2020 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596070603;
        bh=JT6jtDG0iOddtAjTvbt4c86jgkq7+Vw0sGLnvvm3bH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjiVwMrqcBtHTh37YREBH3CKLQbwfeudi2Efui6/HeeVMCfjeB14SAFmJF9m22Uw3
         EdGTwYGHWKO608B33x5ey+vQQhlnjsKvWROGJWy3A3n3t0a3utx35iKGGfGnXyDfmV
         1rJ80XNm+yS0guiGtS2rCzEod8wCSm4ht+egTKAY=
Date:   Thu, 30 Jul 2020 09:56:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alistair Delva <adelva@google.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] bootconfig: Add value override operator
Message-Id: <20200730095639.71ce61e7826ad72ace675791@kernel.org>
In-Reply-To: <20200716102703.33435594dbf192157cf9655f@kernel.org>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
        <20200715164504.3400efc5@oasis.local.home>
        <20200716073843.e7b1921aae962da9e5714fe0@kernel.org>
        <20200715200212.0db61d5a@oasis.local.home>
        <20200716102703.33435594dbf192157cf9655f@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 16 Jul 2020 10:27:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, 15 Jul 2020 20:02:12 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 16 Jul 2020 07:38:43 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > 
> > > > So the end of the initrd would have:
> > > > 
> > > >  [data][size/checksum/magic][more-data][size/checksum/magic]
> > > > 
> > > > 
> > > > And the kernel could do the following:
> > > > 
> > > >  1. read the end of the initrd for bootconfig
> > > >  2. If found parse the bootconfig data.
> > > >  3. look at the content before the bootconfig
> > > >  4. if another bootconfig exists, goto 2.
> > > >   
> > > 
> > > Yeah, that is possible. But since the total size of the bootconfig
> > > is limited to 32KB (this means data + 1st footer + more-data),
> > > I would like to give a chance of sanity check to the bootloader.
> > 
> > 
> > That's a limit of the size field, right?
> 
> If you mean the size field in the footer, no, it is u32.
> 
> To be honest, the size limitation came from the xbc_node data
> structure. To minimize the memory footprint, I decided to
> pack the data structure into 64bits with 4 fields.
> Each field has 16bits, and the data field needs 1 bit flag
> to distinguish the value and the key.
> Thus the maximum number of nodes can be expanded to 64K
> (but it is not feasible, maybe less than 8K will be a real
> size), but the data field (the offset from the bootconfig
> start address) is 15bits = 32KB long.
> Of course we can use the bitfield to tune it, but maybe current
> balance ( 512 node / 32KB ) is enough.
> 
> Note that if we expand the number of nodes, we need to pre-allocate
> the node data structure as a static data (in .bss) because parsing
> will be done before initializing memory management. 512 nodes means
> 4096B is already allocated. 8K node needs 64KB, and that will be
> not filled in most cases.
> 
> > The bootloader (and all tools including the kernel) could check for
> > multiple instances, and that would even increase the size of what can
> > be added. As each section would be 32KB max size, but there's no limit
> > to how many you have. All tools, bootconfig, the bootloader, and the
> > kernel can perform the checksum.
> 
> In fact, I previously considered the multi-section, but came to the
> conclusion that it wasn't much benefit for both Linux and the
> bootloaders.
> 
> If we support multi-section, we have to mix the section nodes on
> a single tree for overriding values, this means the data field must
> have a section number (and per-section starting address pointers),
> or an offset from the 1st section address.
> 
> And I think it is easy for the bootloader to just concatenate the
> data as below, because the data is already on memory.
> 
> [data][more-data][size/checksum/magic]
> 
> To support multiple-section, the bootloader will do
> 
> 0. load the bootconfig with the initrd from media
> 1. prepare the data
> 2. calculate the size and checksum of the data
> 3. append the data and footer right after the last footer
> 
> and to support single section,
> 
> 0. load the bootconfig with the initrd from media
> 1. prepare the data
> 2. calculate the size and checksum of the data
> 3. increment the size and the checksum 
>    (note that the size and checksum is already on memory)
> 4. append the data and footer right after the last data
> 
> Thus, I think there is no much benefit to support multiple sections.

What would you think?

I guess if we have other types of data appended to the initrd
as similar to the bootconfig, I think we should add the multiple
section support. But only for the bootconfig, we can just update
the bootconfig data as I suggested, since it keeps the code simple.
It might be a chiken-egg problem...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
