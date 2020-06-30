Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B8CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D300206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE7AsZJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgF3NfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbgF3NfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:35:20 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CCCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:35:20 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p25so3409206vsg.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tB0fuvE9XkXUicIj7TkXEw1CQTq9dQjVMcGs6V04Fs=;
        b=nE7AsZJxn03bQvW0Wfy21hXDu5LwSRwi5sqZdn5Xw6M0wKfAkpw8BrW+7W7zBVCjrl
         jgpbtYfkGv0VUa4zn6IVpxw365bkY5Hn3gAranlrll2ZqJH4t/z0tDXGjM2tcijDspBO
         /KNvNQGfv1OKmRcl8MhW3QHp0dBix4TtpsPAtLd4dPgiLJa6L+i+8BZJlvxSMvdQqk7p
         gN6sKj8KOE3hRQnH7VCaX0PCJhiOO/ovWzhzlQPyFKnPjS31Wz7/cJsiaeqL/TZnTD8R
         9iCg49Kv74mPn4nzkaAcIlPr0dE6ppYKcG+oQadw9bFmcKrbmPT+UC0wJpZ0CpbZHSdf
         8FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tB0fuvE9XkXUicIj7TkXEw1CQTq9dQjVMcGs6V04Fs=;
        b=X308jUYAlIlObjbk1NHrS2yFrkr8aPVPQw91ZSgD2Bygom/wn7FyxBDXsmPFTtIkgA
         knMVWIWdBaK+5fs0VEKgg9PQyoZdK/R5MQpHWRzgvgWK6H3o/MF7f3AT997jvRm6ECrh
         VTzPZpe+OqNyk73cKu/oiFyGyNB7QIQxWK3SfBhMurd2em19sEkn7YlCxu/R2/CxbSTv
         1CJnC8p9yT/q/MWjUU1FNVYPfvNvsi1mIMtEn+C3m8B/Y6y3a/RKaBVyTob8z8sMfnMw
         6DiswEDPlhMa9yuYWYXDb7WipRDcTESOkwi3yZGmP0w64tPnbpltfhSrMqkZCU0UrimD
         q7Nw==
X-Gm-Message-State: AOAM53315UiBBrdNLwH8Wt3YzHl0l9HqWZ2xosomDxkLP5jMkRrDdWJ7
        Jz50MPmTQuReI/CqB7TV7UXnJSfgVZbP4qQQKHY=
X-Google-Smtp-Source: ABdhPJyuENQTwT1P4tSS3M52Aywm0AqmxoFvqrcTeIZXqG4kvlXx63MC7X35eXWh91DDagBK39ayTMBcFdhVIfcL688=
X-Received: by 2002:a67:d88c:: with SMTP id f12mr12854246vsj.92.1593524117177;
 Tue, 30 Jun 2020 06:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200611142009.1098058-1-jim.cromie@gmail.com> <20200630093754.GA13271@linux-8ccs.fritz.box>
In-Reply-To: <20200630093754.GA13271@linux-8ccs.fritz.box>
From:   jim.cromie@gmail.com
Date:   Tue, 30 Jun 2020 07:34:51 -0600
Message-ID: <CAJfuBxz5YzZfko_M5ap3QW-7ZJsHJDqzEqfN=GZVtDz4W2edLQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/module: add name size info to pr_debug() calls
To:     Jessica Yu <jeyu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:37 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Jim Cromie [11/06/20 08:20 -0600]:
> >when booted with arg: module.dyndbg=+p
> >dmesg gets volumes of info about loaded modules.
> >This adds module & symbol names, and sizes where pertinent.
> >Now I can know which module's info Im looking at.
>
> Hi,
>
> Could you please fix the changelog formatting according to
> Documentation/process/submitting-patches.rst? More specifically,
> complete sentences, line wrapped at 75 columns, and a Signed-off-by:
> line at the end. There are plenty of examples if you look through the
> lkml mailing list.
>

ack.  less casual next time. and with -s

> >---
> > kernel/module.c | 14 +++++++-------
> > 1 file changed, 7 insertions(+), 7 deletions(-)
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index e8a198588f26..d871d9cee9eb 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -2294,8 +2294,8 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
> >
> >               case SHN_ABS:
> >                       /* Don't need to do anything */
> >-                      pr_debug("Absolute symbol: 0x%08lx\n",
> >-                             (long)sym[i].st_value);
> >+                      pr_debug("Absolute symbol: 0x%08lx %s\n",
> >+                               (long)sym[i].st_value, name);
>
> I would prefer "Absolute symbol %s:" rather than putting the symbol
> name at the end.

i chose this for a more tabular appearance,
names vary in length, so value afterwards looks cluttered.
plus its more consistent with preceding messages

[    3.458007] 0xffffffffc0023d40 0x00000030 .bss
[    3.458008] 0xffffffffc0028000 0x00001158 .symtab
[    3.458010] 0xffffffffc0029158 0x00000af5 .strtab
[    3.458021] Absolute symbol: 0x00000000 rapl.mod.c
[    3.458022] Absolute symbol: 0x00000000 rapl.c


>
> >                       break;
> >
> >               case SHN_LIVEPATCH:
> >@@ -2409,7 +2409,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
> >       for (i = 0; i < info->hdr->e_shnum; i++)
> >               info->sechdrs[i].sh_entsize = ~0UL;
> >
> >-      pr_debug("Core section allocation order:\n");
> >+      pr_debug("Core section allocation order for: %s\n", mod->name);
>
> I would slightly prefer "Core section allocation order for %s:", but
> it's a matter of taste.
>

done everywhere you noted.


> >       for (m = 0; m < ARRAY_SIZE(masks); ++m) {
> >               for (i = 0; i < info->hdr->e_shnum; ++i) {
> >                       Elf_Shdr *s = &info->sechdrs[i];
> >@@ -2442,7 +2442,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
> >               }
> >       }
> >
> >-      pr_debug("Init section allocation order:\n");
> >+      pr_debug("Init section allocation order for: %s\n", mod->name);
>
> Same here.
>
> >       for (m = 0; m < ARRAY_SIZE(masks); ++m) {
> >               for (i = 0; i < info->hdr->e_shnum; ++i) {
> >                       Elf_Shdr *s = &info->sechdrs[i];
> >@@ -3276,7 +3276,7 @@ static int move_module(struct module *mod, struct load_info *info)
> >               mod->init_layout.base = NULL;
> >
> >       /* Transfer each section which specifies SHF_ALLOC */
> >-      pr_debug("final section addresses:\n");
> >+      pr_debug("final section addresses for: %s\n", mod->name);
>
> Let's capitalize the "f" in "final section addresses" to be consistent
> with the other two above.
>
> >       for (i = 0; i < info->hdr->e_shnum; i++) {
> >               void *dest;
> >               Elf_Shdr *shdr = &info->sechdrs[i];
> >@@ -3294,8 +3294,8 @@ static int move_module(struct module *mod, struct load_info *info)
> >                       memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> >               /* Update sh_addr to point to copy in image. */
> >               shdr->sh_addr = (unsigned long)dest;
> >-              pr_debug("\t0x%lx %s\n",
> >-                       (long)shdr->sh_addr, info->secstrings + shdr->sh_name);
> >+              pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
> >+                       (long)shdr->sh_size, info->secstrings + shdr->sh_name);
>
> Any reason why you added sh_size here? Is it really needed? You can
> usually deduce how much space a section is taking up in a module by
> looking at the final section address printout. Plus the elf section
> size is not entirely accurate here as each module section is aligned
> to page boundaries when the module loader allocates memory for each
> section. I would prefer to just leave it out.
>

mostly I added it cuz it was available.
I do not know when it might be useful, but seeing it can help decide that.
Having the data there makes your deduction possible,
without seeing the data, it wouldnt occur to me that there are "inaccuracies".
And seeing it in hex form might illuminate the page alignment too.

Also, this is in move-module, which I havent seen in action AFAIK

I'll send v2 shortly, as above, unless you want a tweak.

> Thanks,
>
> Jessica
