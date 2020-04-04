Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E9CC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B0E20735
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585970076;
	bh=4Lmz+/S7SlPMvBnfl+eEEwjVNnxHk+Bjv+KwNBduwyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IeHAoJ96SqxT3Qfts/ibpuWO6bnI3O2fCJWe/Jy7mcipTmimx3rnMLrvEF9qy6I9a
	 fgfMxovEWRkZOe/lWX5EDjuIKCT6IdPSzM3YvLZMSLJVyNUYYh9QQ8Smz05LFiHvhI
	 36ZL6Sy+XsSULIVLt6DA7erxmlrSEiM5sLn+XhHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDDOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgDDDOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 23:14:35 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B200206E2;
        Sat,  4 Apr 2020 03:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585970074;
        bh=4Lmz+/S7SlPMvBnfl+eEEwjVNnxHk+Bjv+KwNBduwyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kyIC+9GaonW5ruza0M6g0/ynePvKYZ0yHSqC7gusaQwnIP3H5nakQfDkWHbmmKFTB
         tOxRT39pzl2KMlmDZaYr2Rv4qpbSUY8Kz55Zmrk8Uo4oSmae23hSxxgHIyE7i5ijU2
         nqN9TPh+A0SMorxTDUt97QNxDzS86cp0h9ydJhHA=
Date:   Sat, 4 Apr 2020 12:14:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] riscv: introduce interfaces to patch kernel code
Message-Id: <20200404121428.596911ba5653f8b18a80eab2@kernel.org>
In-Reply-To: <CANXhq0rMbkNxQ3_qqYEKe8DSbL-vfQku6V9a81Hy9cxW4LaW9g@mail.gmail.com>
References: <cover.1583772574.git.zong.li@sifive.com>
        <d27d9e68491e1df67dbee6c22df6a72ff95bab18.1583772574.git.zong.li@sifive.com>
        <20200401003233.17fe4b6f7075e5b8f0ed5114@kernel.org>
        <CANXhq0ra3o+mgenbYLq_q0eZY2KiXNpWmo2V0amD0cFDqCQkXw@mail.gmail.com>
        <20200402101733.1ef240faeaeada6e4d38ae80@kernel.org>
        <CANXhq0rMbkNxQ3_qqYEKe8DSbL-vfQku6V9a81Hy9cxW4LaW9g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zong,

On Fri, 3 Apr 2020 17:04:51 +0800
Zong Li <zong.li@sifive.com> wrote:

> > > > > +{
> > > > > +     void *waddr = addr;
> > > > > +     bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> > > > > +     unsigned long flags = 0;
> > > > > +     int ret;
> > > > > +
> > > > > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > > >
> > > > This looks a bit odd since stop_machine() is protected by its own mutex,
> > > > and also the irq is already disabled here.
> > >
> > > We need it because we don't always enter the riscv_patch_text_nosync()
> > > through stop_machine mechanism. If we call the
> > > riscv_patch_text_nosync() directly, we need a lock to protect the
> > > page.
> >
> > Oh, OK, but it leads another question. Is that safe to patch the
> > text without sync? Would you use it for UP system?
> > I think it is better to clarify "in what case user can call _nosync()"
> > and add a comment on it.
> 
> The ftrace is one of the cases, as documentation of ftrace said, when
> dynamic ftrace is initialized, it calls kstop_machine to make the
> machine act like a uniprocessor so that it can freely modify code
> without worrying about other processors executing that same code. So
> the ftrace called the _nosync interface here directly.

Hmm, even though, since it already running under kstop_machine(), no
other thread will run. 
Could you consider to use text_mutex instead of that? The text_mutex
is already widely used in x86 and kernel/kprobes.c etc.

(Hmm, it seems except for x86, alternative code don't care about
 racing...)

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
