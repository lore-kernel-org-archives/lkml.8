Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F1C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DBE217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mzJCouoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGNCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:02:13 -0500
Received: from ozlabs.org ([203.11.71.1]:43897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:02:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Db6p3MKHz9sRK;
        Sat,  8 Feb 2020 00:02:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581080530;
        bh=Qy9/A3AZ8TqCt5x8oTZIOpHaij9Y4E0F/EsEzB8ieCg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mzJCouoYSo0yi1YOIRjSMLQItfcUbzSFp252N0DUHY7/8Vk98TdQNP1F3TzglcjfD
         kIQw87GfDId5dkb4oDAb6NyVZYsLlKSf+q4fS4DgTvrpWdUniTDVZh71HhvuJFGsNN
         AnL0qSF4IOGnyp9KAJPY4xmf0kj75icUmtdWJ/IkHR2EhUdTeX9QUw0QPZSlzbjDYs
         jq6qOFlYZ+4XxMKnCyCRDrnjzYy4MwQqYOvujRcetApcb3h8hxUPn3Cqh0mKeWoLJc
         iImr5gEqQtRPb+IHZPPCHf9CBj8tmdczj8UcZL2O1qgyVOF8vaMn7O4KKqtRPEPwqn
         VF2bZFba+Ac7g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 06/26] tools: bootconfig: Add bootconfig command
In-Reply-To: <20200114210336.581160276@goodmis.org>
References: <20200114210316.450821675@goodmis.org> <20200114210336.581160276@goodmis.org>
Date:   Sat, 08 Feb 2020 00:02:04 +1100
Message-ID: <87o8ua1rg3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> From: Masami Hiramatsu <mhiramat@kernel.org>
>
> Add "bootconfig" command which operates the bootconfig
> config-data on initrd image.
>
> User can add/delete/verify the boot config on initrd
> image using this command.
>
> e.g.
> Add a boot config to initrd image
>  # bootconfig -a myboot.conf /boot/initrd.img
>
> Remove it.
>  # bootconfig -d /boot/initrd.img
>
> Or verify (and show) it.
>  # bootconfig /boot/initrd.img
>
> Link: http://lkml.kernel.org/r/157867223582.17873.14342161849213219982.st=
git@devnote2
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> [ Removed extra blank line at end of bootconfig.c ]
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  MAINTAINERS                                 |   1 +
>  tools/Makefile                              |  11 +-
>  tools/bootconfig/.gitignore                 |   1 +
>  tools/bootconfig/Makefile                   |  20 ++
>  tools/bootconfig/include/linux/bootconfig.h |   7 +
>  tools/bootconfig/include/linux/bug.h        |  12 +
>  tools/bootconfig/include/linux/ctype.h      |   7 +
>  tools/bootconfig/include/linux/errno.h      |   7 +
>  tools/bootconfig/include/linux/kernel.h     |  18 +
>  tools/bootconfig/include/linux/printk.h     |  17 +
>  tools/bootconfig/include/linux/string.h     |  32 ++
>  tools/bootconfig/main.c                     | 353 ++++++++++++++++++++

This doesn't seem to build:

  $ cd tools/bootconfig
  $ make
  cc ../../lib/bootconfig.c main.c -Wall -g -I./include -o bootconfig
  In file included from ./include/linux/kernel.h:8,
                   from ../../lib/bootconfig.c:12:
  ../../lib/bootconfig.c: In function =E2=80=98xbc_init=E2=80=99:
  ./include/linux/printk.h:10:38: error: expected expression before =E2=80=
=98)=E2=80=99 token
     10 |  (pr_output ? printf(fmt, __VA_ARGS__) : 0)
        |                                      ^
  ./include/linux/printk.h:12:16: note: in expansion of macro =E2=80=98prin=
tk=E2=80=99
     12 | #define pr_err printk
        |                ^~~~~~
  ../../lib/bootconfig.c:740:3: note: in expansion of macro =E2=80=98pr_err=
=E2=80=99
    740 |   pr_err("Error: bootconfig is already initialized.\n");
        |   ^~~~~~
  make: *** [Makefile:14: bootconfig] Error 1


That's on Fedora 30, x86_64, but I see the same elsewhere.

cheers
