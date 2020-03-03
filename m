Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC915C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964C215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583218660;
	bh=eMV16bVN0WQ9MVZE50jt1350rup/xeTAFYsN36sAH0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c0ddiRdnV9fiKuj1Smll/sH5+D14vr0XvVa/6dzo85t3wbMKRnzKZi611tUvxHDx/
	 JlNjtZThAcXRVLeyuyEQ5eH6An7N2QcAiz+kRJ4tRv7DMLJzFmhIgeDTjWXiGXqtD5
	 E04+65p5Vkg4B8munq1hYOJMZXB48K6vBJkYin5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCCG5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgCCG5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:57:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC8C2146E;
        Tue,  3 Mar 2020 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583218657;
        bh=eMV16bVN0WQ9MVZE50jt1350rup/xeTAFYsN36sAH0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTJHmZDYmeL5xxqFPtWZLWtpCwxli2ovEUWtHm/uOEqSBBsqmXCLGYdBLsmlEiT8V
         ArGSb2GFozas9kjLgSAgbh22MiHacOks+om+UXvoVGM8vspsw8zaf6iAWFcaYH6dOT
         53vqyIFDN0iFwPW7tD+2ivEFDmARZUknNiUS5Wzo=
Date:   Tue, 3 Mar 2020 07:57:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200303065735.GA1172591@kroah.com>
References: <20200221114404.14641-1-will@kernel.org>
 <20200302192811.n6o5645rsib44vco@localhost>
 <20200302193658.GA272023@kroah.com>
 <20200302193957.GA276441@kroah.com>
 <1183544004.13859.1583180227118.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1183544004.13859.1583180227118.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 03:17:07PM -0500, Mathieu Desnoyers wrote:
> ----- On Mar 2, 2020, at 2:39 PM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:
> 
> > On Mon, Mar 02, 2020 at 08:36:58PM +0100, Greg Kroah-Hartman wrote:
> >> On Mon, Mar 02, 2020 at 02:28:11PM -0500, Mathieu Desnoyers wrote:
> >> > On 21-Feb-2020 11:44:01 AM, Will Deacon wrote:
> >> > > Hi folks,
> >> > > 
> >> > > Despite having just a single modular in-tree user that I could spot,
> >> > > kallsyms_lookup_name() is exported to modules and provides a mechanism
> >> > > for out-of-tree modules to access and invoke arbitrary, non-exported
> >> > > kernel symbols when kallsyms is enabled.
> >> > > 
> >> > > This patch series fixes up that one user and unexports the symbol along
> >> > > with kallsyms_on_each_symbol(), since that could also be abused in a
> >> > > similar manner.
> >> > 
> >> > Hi,
> >> > 
> >> > I maintain a GPL kernel tracer (LTTng) since 2005 which happens to be
> >> > out-of-tree, even though we have made unsuccessful attempts to upstream
> >> > it in the past. It uses kallsyms_lookup_name() to fetch a few symbols. I
> >> > would be very glad to have them GPL-exported upstream rather than
> >> > relying on this work-around. Here is the list of symbols we would need
> >> > to GPL-export:
> >> > 
> >> > stack_trace_save
> >> > stack_trace_save_user
> >> > vmalloc_sync_all (CONFIG_X86)
> >> > get_pfnblock_flags_mask
> >> > disk_name
> >> > block_class
> >> > disk_type
> >> 
> >> I hate to ask, but why does anyone need block_class?  or disk_name or
> >> disk_type?  I need to put them behind a driver core namespace or
> >> something soon...
> > 
> 
> In LTTng, we have a "statedump" which dumps all the relevant state of
> the kernel at trace start (or when the user asks for it) into the
> kernel trace. It is used to collect information which helps translating
> compact numeric data into human-readable information at post-processing.
> 
> For block devices, the statedump contains the mapping between the
> device number and the disk name [1]. It uses the "block_class",
> "disk_name", and "disk_type" symbols for this. Here is the
> post-processing output:
> 
> [14:48:41.388934812] (+?.?????????) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 1048576, diskname = "ram0" }
> [...]
> [14:48:41.442548745] (+0.003574998) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 1048591, diskname = "ram15" }
> [14:48:41.446064977] (+0.003516232) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289728, diskname = "vda" }
> [14:48:41.449579781] (+0.003514804) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289729, diskname = "vda1" }
> [14:48:41.453113808] (+0.003534027) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289744, diskname = "vdb" }
> [14:48:41.456640876] (+0.003527068) compudjdev lttng_statedump_block_device: { cpu_id = 0 }, { dev = 265289745, diskname = "vdb1" }
> 
> This information is then used in our I/O analyses to show information
> comprehensible to a user.

But all of that is availble to you today in userspace, why dig through
random kernel symbols?

Look in /sys/dev/block/ or in /sys/block/ for all of that information.
Is there something that you can only find by the internal symbols that
is not present today in sysfs?

> > Wait, disk_type is a static variable.  And there's multiple ones of
> > them, how does that work?
> 
> Yes, this is far from ideal. Here are the ones I observe in the kernel
> sources:
> 
> block/genhd.c
> 40:static const struct device_type disk_type;   <---- the one we use
> 
> lib/raid6/test/test.c
> 41:static char disk_type(int d)  <---- this is a stand-alone user-space test program, not part of the kernel image.
> 
> crypto/async_tx/raid6test.c (depends on CONFIG_ASYNC_RAID6_TEST)
> 44:static char disk_type(int d, int disks) <---- the compiler optimizes away this function, so this symbol is not present in the kernel image.
> 
> I think a better approach to solve this would be to implement and expose an
> iterator function in the core kernel which could invoke a callback. However,
> the main issue remains: if the only user is out-of-tree, I cannot justify
> adding an exported kernel helper for this.

I think the best thing would be to use the userspace api :)

thanks,

greg k-h
