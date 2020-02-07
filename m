Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD906C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25FA21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581082769;
	bh=KvFeUB/vhTt36QXLdYwfq6jnfyoEb2sa5gyv2Xx+eBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OzJ7x/XpV/wq3HH6pMA5kK/DcFGKdBHIHBvLrDpbcWqoGWYb6X9qmJU4YRuvQagA+
	 6h7H5UYIOplLlmW2b2XPmoRceMzdeGzYDY6NCI27zOcRyBLmlBsiejRxTZk0163TQV
	 ShsDUgI24ofrmDtrlFDFbbbZVhqH+J4eAA/YggW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGNj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:39:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:39:28 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02106214AF;
        Fri,  7 Feb 2020 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581082767;
        bh=KvFeUB/vhTt36QXLdYwfq6jnfyoEb2sa5gyv2Xx+eBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yuy3sOpWqO9l1BgPJEi+aL6JYlPccECnSYCvEzsvbTs7zxiMO3sBbq+z/KrWtflJc
         tWJIQtDEWTe5xT3ytbpJ6WuGWLxCGpVC/5T0A062rO6o0i8/Tvvs4FslGfvUJhSpBh
         q7vkJCvbGKUFOYsZuetQn/ccqOsMaHuf4UodsVOM=
Date:   Fri, 7 Feb 2020 22:39:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 06/26] tools: bootconfig: Add bootconfig
 command
Message-Id: <20200207223923.b700e363c57f4a6031176205@kernel.org>
In-Reply-To: <87o8ua1rg3.fsf@mpe.ellerman.id.au>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.581160276@goodmis.org>
        <87o8ua1rg3.fsf@mpe.ellerman.id.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Feb 2020 00:02:04 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Add "bootconfig" command which operates the bootconfig
> > config-data on initrd image.
> >
> > User can add/delete/verify the boot config on initrd
> > image using this command.
> >
> > e.g.
> > Add a boot config to initrd image
> >  # bootconfig -a myboot.conf /boot/initrd.img
> >
> > Remove it.
> >  # bootconfig -d /boot/initrd.img
> >
> > Or verify (and show) it.
> >  # bootconfig /boot/initrd.img
> >
> > Link: http://lkml.kernel.org/r/157867223582.17873.14342161849213219982.stgit@devnote2
> >
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > [ Removed extra blank line at end of bootconfig.c ]
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  MAINTAINERS                                 |   1 +
> >  tools/Makefile                              |  11 +-
> >  tools/bootconfig/.gitignore                 |   1 +
> >  tools/bootconfig/Makefile                   |  20 ++
> >  tools/bootconfig/include/linux/bootconfig.h |   7 +
> >  tools/bootconfig/include/linux/bug.h        |  12 +
> >  tools/bootconfig/include/linux/ctype.h      |   7 +
> >  tools/bootconfig/include/linux/errno.h      |   7 +
> >  tools/bootconfig/include/linux/kernel.h     |  18 +
> >  tools/bootconfig/include/linux/printk.h     |  17 +
> >  tools/bootconfig/include/linux/string.h     |  32 ++
> >  tools/bootconfig/main.c                     | 353 ++++++++++++++++++++
> 
> This doesn't seem to build:
> 
>   $ cd tools/bootconfig
>   $ make
>   cc ../../lib/bootconfig.c main.c -Wall -g -I./include -o bootconfig
>   In file included from ./include/linux/kernel.h:8,
>                    from ../../lib/bootconfig.c:12:
>   ../../lib/bootconfig.c: In function ‘xbc_init’:
>   ./include/linux/printk.h:10:38: error: expected expression before ‘)’ token
>      10 |  (pr_output ? printf(fmt, __VA_ARGS__) : 0)
>         |                                      ^
>   ./include/linux/printk.h:12:16: note: in expansion of macro ‘printk’
>      12 | #define pr_err printk
>         |                ^~~~~~
>   ../../lib/bootconfig.c:740:3: note: in expansion of macro ‘pr_err’
>     740 |   pr_err("Error: bootconfig is already initialized.\n");
>         |   ^~~~~~
>   make: *** [Makefile:14: bootconfig] Error 1
> 
> 
> That's on Fedora 30, x86_64, but I see the same elsewhere.

Oops, thanks for reporting!
I found that the above macro doesn't work if the function gets 1 argument.
It should use ##__VA_ARGS__ instead of __VA_ARGS__.
OK, I'll fix it.

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
