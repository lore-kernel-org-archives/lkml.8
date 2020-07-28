Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E739CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21B2206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595943352;
	bh=VhNW/VcN7636dhuyu/1kgMRnPEPrCnyH1NVrMnXimX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pA6KgdOttm3WTiF7SqwdYNePe4MHglfCEbPO5/Yge/Zfn/NWUn6L31UchlvvJX2iq
	 z0vu3Y6RWYt2+IyV7dNd/iy3vJ7qFj2xOCcveaUNrGGM1mHk3xpN/A76yPhgQ5aMWC
	 cklsurckbbCHx/575mD/mygOsZ8p9qKqQu83LML4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgG1Nfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgG1Nfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:35:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D592B20663;
        Tue, 28 Jul 2020 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595943350;
        bh=VhNW/VcN7636dhuyu/1kgMRnPEPrCnyH1NVrMnXimX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s7xlgTWj26GYXPVmvQPSyemnyiVNpxsfCk0lxaMxcOgC8Rag4Wh65Bi12AUpYMCT+
         3mSsI1SVIhhAfLNg5QBP+l8gDt2cQVLKYMVg2bFjTADrmQ9spnrc6ckduRG4bnr+tf
         KCUdnUivnqPoERNrnJrk1jW9WKUSvnlTLjVpPnOY=
Date:   Tue, 28 Jul 2020 22:35:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-Id: <20200728223545.ce4ff78cac73b571a27bb357@kernel.org>
In-Reply-To: <CAMj1kXGJ_7mUtFHWsLaBj-MSK_VxpBet=wi1Z7frkKRVEgozpQ@mail.gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
        <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
        <20200724092746.GD517988@gmail.com>
        <20200725031648.GG17052@linux.intel.com>
        <20200726081408.GB2927915@kernel.org>
        <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
        <20200728171715.0800093e2226e3d72b04a3ae@kernel.org>
        <CAMj1kXGJ_7mUtFHWsLaBj-MSK_VxpBet=wi1Z7frkKRVEgozpQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 13:56:43 +0300
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 28 Jul 2020 at 11:17, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > Masami or Peter should correct me if I am wrong, but it seems to me
> > > that the way kprobes uses these pages does not require them to be in
> > > relative branching range of the core kernel on any architecture, given
> > > that they are populated with individual instruction opcodes that are
> > > executed in single step mode, and relative branches are emulated (when
> > > needed)
> >
> > Actually, x86 and arm has the "relative branching range" requirements
> > for the jump optimized kprobes. For the other architectures, I think
> > we don't need it. Only executable text buffer is needed.
> >
> 
> Thanks for the explanation. Today, arm64 uses the definition below.
> 
> void *alloc_insn_page(void)
> {
>   return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>     GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
>     NUMA_NO_NODE, __builtin_return_address(0));
> }
> 
> Do you think we could use that as the generic implementation if we use
> MODULES_START/_END as the allocation window?

Yes, but for the generic implementation, we don't need to consider the
relative branching range since we can override it for x86 and arm.
(and that will be almost same as module_alloc() default code)
BTW, is PAGE_KERNEL_ROX flag available generically?

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
