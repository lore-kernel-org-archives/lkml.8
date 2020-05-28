Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2786C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC09021508
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPpZpcfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgE1HpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1HpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:45:08 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8433C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:45:08 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id l67so9263595ybl.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3Mj/cWa4xpcUJ8BLSKg6bmXtb9cSqMOt8PTdoqJX30=;
        b=LPpZpcfFS1dm7aNBfZmif9Jb3defh3gSd6L7uz2BNhwXhknyTdhTYHZsrWPGdzV5CK
         WLK59cl+stQT7Bmmvx5rlwQN/pGtXJr/jQO+EwTz29kco1v3bW3iJ7McW1Ty7g0vRqXp
         j3+d9jXDHhno8mUVj/5TIkEGc0BxNDDS44gzvzSu7RiDzcqkufZlIcF3S+b6lpsSaiIe
         XZkNmSEjITnitZh5pS4cklsKC8RSs4kywGKYqvtz4tvSDxDYd/Z0wBGfqsN44FAFGBeO
         yIIPJltuVKf9xeHPDCXo5eit8wBtJQSoaLh4JATHTTXffc+Uaj1Ih4QB8/VsvameBae1
         LBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3Mj/cWa4xpcUJ8BLSKg6bmXtb9cSqMOt8PTdoqJX30=;
        b=DiblS4hJd8o+z4Ce8nrfDdyowbT7jU3Ux17OHkYtyY/vgnE7qpHZgQJfct8ETvKLJw
         yZJroFF//VGQ+zWyg7BK+qcwCB/obEVQjWzjQQJOZeqqm1/XWrerCmEUXyJS8g5qJ/Lx
         MIRBI5NJw3EUbq2VgARUb0ZqXk+W9YPa5DtnRr95laa/FdN3x3eCMme+YgC2lWHFFleD
         R2jIinL92S1Xx4PH2ToBJRs4Cj/F4dh7sdXJpit7h81HOcu+s5Ccom2e/GNbBtgLJr1Q
         pseUlrHdImSdcxynVkKkb4dmJ5j2kIKyd2TuFDRwWcg6saX8jeaOtDodDcl8CWYTIpj9
         QvOg==
X-Gm-Message-State: AOAM533A4u8mxyzQQmLxD66oZxWNB4HFyIxttAn7OyqmNKgo39SAQryx
        GYj6U2JTW70X06Wb17Lv+PYi8WQgmJajAr7YuO/9PQ==
X-Google-Smtp-Source: ABdhPJy+mQj+Gzg5+KOOm8x8XkZXrRCbixq5tQ+QOrgyB2Irjtqy3UhzaOBWGIWOv63kwB9r6OUsoR7xFE23LjAz+IY=
X-Received: by 2002:a25:790e:: with SMTP id u14mr3108965ybc.324.1590651907863;
 Thu, 28 May 2020 00:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200528051916.6722-1-nick.gasson@arm.com>
In-Reply-To: <20200528051916.6722-1-nick.gasson@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 May 2020 00:44:56 -0700
Message-ID: <CAP-5=fWCLq+2xjViJaYxFs9b=3BxSvKmVAdv6xX3re8AoBLHWg@mail.gmail.com>
Subject: Re: [PATCH] perf jit: Fix inaccurate DWARF line table
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:19 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> Fix an issue where addresses in the DWARF line table are offset by
> -0x40 (GEN_ELF_TEXT_OFFSET). This can be seen with `objdump -S` on the
> ELF files after perf inject.

Without too much knowledge this looks good to me. The original code
came from oprofile's jit support:
https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/opjitconv/debug_line.c#l325

Acked-by: Ian Rogers <irogers@google.com>

> Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> ---
>  tools/perf/util/genelf_debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index 30e9f618f6cd..dd40683bd4c0 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -342,7 +342,7 @@ static void emit_lineno_info(struct buffer_ext *be,
>          */
>
>         /* start state of the state machine we take care of */
> -       unsigned long last_vma = code_addr;
> +       unsigned long last_vma = 0;
>         char const  *cur_filename = NULL;
>         unsigned long cur_file_idx = 0;
>         int last_line = 1;
> @@ -473,7 +473,7 @@ jit_process_debug_info(uint64_t code_addr,
>                 ent = debug_entry_next(ent);
>         }
>         add_compilation_unit(di, buffer_ext_size(dl));
> -       add_debug_line(dl, debug, nr_debug_entries, 0);
> +       add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
>         add_debug_abbrev(da);
>         if (0) buffer_ext_dump(da, "abbrev");
>
> --
> 2.26.2
>
