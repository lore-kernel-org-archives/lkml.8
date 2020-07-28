Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F71CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D54C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595958682;
	bh=6jcL8Ywxu0wIDS2/EBltw8otMDCJosWWa2C5+dsi7N0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cDrm8pjnQ8J39dGcQcaoBltmUrru5o4OHgWxeUEGhPQHTZEF8H4RUwmxXL4utr86s
	 09EiX7efC4X0FE1xiAKdsrvdD6/n0/iLWarvZ0AUOIeMGh/veKcVLfHhPKAZyTUqaH
	 Y5l+vWy83cBHqxVicmhaqDEYleTbNhlsXwKxl9Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgG1RvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbgG1RvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:51:20 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232102083B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595958680;
        bh=6jcL8Ywxu0wIDS2/EBltw8otMDCJosWWa2C5+dsi7N0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RQFyeY9oZhZ7LptyowMlRda8iRBLxGZb/JQd4LXHzTq6cXGnqdVU9FjXqH970bQ5l
         0HTDrqL4n7m2JmgNPlbtl+r+O4A1pmo2cOPEmviaUBTrjdrcwOe/eboIUqfmRJ/7hO
         LRp7le7a82T2WmIQjVBNwV/ONSaUTl86An3vXANI=
Received: by mail-ot1-f41.google.com with SMTP id w17so15521591otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:51:20 -0700 (PDT)
X-Gm-Message-State: AOAM530NOi/OYNuvAD+ntG4XfOBS+Dwvz2j+r8b+vLr0VZOyn7JICOFk
        iUn0TBsfcVxQhYMqQf59tf5ltHEyGteyCmrKSHY=
X-Google-Smtp-Source: ABdhPJxmJNqVhgo0Y4CcIESwnMCLsnEZlDA6hxQ1ZKFwUiNhCh8xheV1iZBQ2JhCxsnEnn/0tVSbR4oHrpi/Zcdc/nI=
X-Received: by 2002:a05:6830:1094:: with SMTP id y20mr13388085oto.90.1595958679426;
 Tue, 28 Jul 2020 10:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com> <20200725031648.GG17052@linux.intel.com>
 <20200726081408.GB2927915@kernel.org> <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
 <20200728171715.0800093e2226e3d72b04a3ae@kernel.org> <CAMj1kXGJ_7mUtFHWsLaBj-MSK_VxpBet=wi1Z7frkKRVEgozpQ@mail.gmail.com>
 <20200728223545.ce4ff78cac73b571a27bb357@kernel.org>
In-Reply-To: <20200728223545.ce4ff78cac73b571a27bb357@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jul 2020 20:51:08 +0300
X-Gmail-Original-Message-ID: <CAMj1kXG9Fr6ym43JN9FLnzk9vdANPFe95LPKaLK6KF8BiRK0NQ@mail.gmail.com>
Message-ID: <CAMj1kXG9Fr6ym43JN9FLnzk9vdANPFe95LPKaLK6KF8BiRK0NQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 at 16:35, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 28 Jul 2020 13:56:43 +0300
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Tue, 28 Jul 2020 at 11:17, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > Masami or Peter should correct me if I am wrong, but it seems to me
> > > > that the way kprobes uses these pages does not require them to be in
> > > > relative branching range of the core kernel on any architecture, given
> > > > that they are populated with individual instruction opcodes that are
> > > > executed in single step mode, and relative branches are emulated (when
> > > > needed)
> > >
> > > Actually, x86 and arm has the "relative branching range" requirements
> > > for the jump optimized kprobes. For the other architectures, I think
> > > we don't need it. Only executable text buffer is needed.
> > >
> >
> > Thanks for the explanation. Today, arm64 uses the definition below.
> >
> > void *alloc_insn_page(void)
> > {
> >   return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> >     GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> >     NUMA_NO_NODE, __builtin_return_address(0));
> > }
> >
> > Do you think we could use that as the generic implementation if we use
> > MODULES_START/_END as the allocation window?
>
> Yes, but for the generic implementation, we don't need to consider the
> relative branching range since we can override it for x86 and arm.
> (and that will be almost same as module_alloc() default code)

Indeed. So having kprobes specific macros that default to
VMALLOC_START/END but can be overridden would be sufficient.

> BTW, is PAGE_KERNEL_ROX flag available generically?
>

Turns out that it is not :-(

> Thank you,
> --
> Masami Hiramatsu <mhiramat@kernel.org>
