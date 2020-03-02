Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6810C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43C24686
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583177893;
	bh=CeT8MrxmedI+zt8aOLIH3orrxcr7WWJylEIMKTJsKOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3QgdhQT/pq/lwl+irTb+/M8Eg9UHh8/zezEQRU/CCpbg3GGOPtWR1wkeWrkZoJpT
	 VDL4/0lkZtQ0RvbfWUohryGXl3oqooZptSQxqhZoGSNqFDZAoz83Ek6yhSz2cJSlFU
	 afnSEMqwwaAg21s37xJuW6Y41PcSZ9LoFZrJjJ08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCBTiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgCBThB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:37:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573AB2080C;
        Mon,  2 Mar 2020 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583177820;
        bh=CeT8MrxmedI+zt8aOLIH3orrxcr7WWJylEIMKTJsKOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8wwXBbNVBTa/A3C4eLRYDldm8MpUPFYC5q8AuT0Y8Zb+HCK4vveOkBj+elCSV/MI
         sOnBhrrrgb/5zAuzNiQHwpucanodU249g6298/y1KlYRydOb7HEoqBgVu/QDIDa+xI
         uecLFtamZ9pR25O62XtbYF8Mxkp+D4Wv86EUOt2Y=
Date:   Mon, 2 Mar 2020 20:36:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200302193658.GA272023@kroah.com>
References: <20200221114404.14641-1-will@kernel.org>
 <20200302192811.n6o5645rsib44vco@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302192811.n6o5645rsib44vco@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:28:11PM -0500, Mathieu Desnoyers wrote:
> On 21-Feb-2020 11:44:01 AM, Will Deacon wrote:
> > Hi folks,
> > 
> > Despite having just a single modular in-tree user that I could spot,
> > kallsyms_lookup_name() is exported to modules and provides a mechanism
> > for out-of-tree modules to access and invoke arbitrary, non-exported
> > kernel symbols when kallsyms is enabled.
> > 
> > This patch series fixes up that one user and unexports the symbol along
> > with kallsyms_on_each_symbol(), since that could also be abused in a
> > similar manner.
> 
> Hi,
> 
> I maintain a GPL kernel tracer (LTTng) since 2005 which happens to be
> out-of-tree, even though we have made unsuccessful attempts to upstream
> it in the past. It uses kallsyms_lookup_name() to fetch a few symbols. I
> would be very glad to have them GPL-exported upstream rather than
> relying on this work-around. Here is the list of symbols we would need
> to GPL-export:
> 
> stack_trace_save
> stack_trace_save_user
> vmalloc_sync_all (CONFIG_X86)
> get_pfnblock_flags_mask
> disk_name
> block_class
> disk_type

I hate to ask, but why does anyone need block_class?  or disk_name or
disk_type?  I need to put them behind a driver core namespace or
something soon...

thanks,

greg k-h
