Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E437C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D6220767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4IcdZvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgIASvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIASvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:51:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACA1C061244;
        Tue,  1 Sep 2020 11:51:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so2701175wrn.0;
        Tue, 01 Sep 2020 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TXEzcWJ+iyLKfV7X1dfYtC/wjmL+DYnzFdGmA5IIs0=;
        b=t4IcdZvb7sveYXthFXDSHlRCX7N+1EHxjFYaFZ8j4PBl5mOYPJL/KqUOqtgBB0CN3w
         BUkMFdyb6IoMBD0x5dcd/ATPlifMnYRrwOtG7D2gaX7KJ+qDclsF5nbOyhtpIUWJmYFf
         QtJvfgIaaa0DFPalkig6bq6tWYHVxyLoQ054Tt4C3eAsdWYiUbor7KRkNP1cbKZdNvX9
         oLP9baSjzxhBSn13dM9vkuVdlAzymncm0RC/BHU8jkD2XVJZ4O0/deR4xDy/NY0KTbfL
         x15ugTmBX4RorXf8+wU2usgl0rVoK89oLJBU/63C38mU7ExwQON5Rv/joT1gZBBWCwp2
         hGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TXEzcWJ+iyLKfV7X1dfYtC/wjmL+DYnzFdGmA5IIs0=;
        b=SoCrMX32y35gJ/zPCjOFp2F6BTVCdhvzTwy9dTu+uUo4uQf/OI1g0m7MbuHMY3MbK0
         Tx9zRlNXNKnaytCqmFlpS6dKOFtJ090Vr952okNvA0cQXy4VhCZOoMiqDkf/xHg2/JKq
         H8UqMkYOPtgEYhMhXFQmh4QbW2VMxaR5fWcGDmhe58tk6KsHMw7Wy5ZPLndW+U4hu78v
         FgztYqoZcUetqrT6kpnNhFHdpwSyNUyVdIzzwLGMJfncILPvN15lSte4OFrtVCF2G1+l
         cERRRrGdYpjuZFKssD5FImJPIcsffPYN4buA8/hW4vP3lDJTCvScqABMa3EBNcGxZ4HM
         vw4Q==
X-Gm-Message-State: AOAM532e58tfzGoQneTCITYzN4mhBcIl3/uyY2qxUdNVdaVdSfi7EmxD
        kc9hxsGYWj076vT6AeHaIK6lkbdMivb4rX54v4O/Y7IENXM=
X-Google-Smtp-Source: ABdhPJz89gweGT1D+G+/2fDz4AEThn8B/NKXCeiFPVmTHwv9epdCPYcwe3QhmsbLfwyKLPSGMUjoYnJCL1vyeOiB/cc=
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr3337312wrg.399.1598986270722;
 Tue, 01 Sep 2020 11:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200829111437.96334-1-wqu@suse.com>
In-Reply-To: <20200829111437.96334-1-wqu@suse.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 1 Sep 2020 11:50:58 -0700
Message-ID: <CAKi4VAJ_nZ9DT1Tm=uufbJPGgZJu+4j+DVVA9otv6oGXuD3jxg@mail.gmail.com>
Subject: Re: [PATCH] module: Add more error message for failed kernel module loading
To:     Qu Wenruo <wqu@suse.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 4:15 AM Qu Wenruo <wqu@suse.com> wrote:
>
> When kernel module loading failed, user space only get one of the
> following error messages:
> - -ENOEXEC
>   This is the most confusing one. From corrupted ELF header to bad
>   WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
>   all returns this error number.
>
> - -EPERM
>   This is for blacklisted modules. But mod doesn't do extra explain
>   on this error either.
>
> - -ENOMEM
>   The only error which needs no explain.
>
> This means, if a user got "Exec format error" from modprobe, it provides
> no meaningful way for the user to debug, and will take extra time
> communicating to get extra info.
>
> So this patch will add extra error messages for -ENOEXEC and -EPERM
> errors, allowing user to do better debugging and reporting.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel/module.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 1c5cff34d9f2..9f748c6eeb48 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2096,8 +2096,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>         int i;
>
>         for (i = 0; i < hdr->e_shnum; i++) {
> -               if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
> +               if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
> +                       pr_err(
> +                       "Module %s section %d has invalid WRITE|EXEC flags\n",
> +                               mod->name, i);
>                         return -ENOEXEC;
> +               }
>         }
>
>         return 0;
> @@ -3825,8 +3829,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
>         char *after_dashes;
>
>         err = elf_header_check(info);
> -       if (err)
> +       if (err) {
> +               pr_err("Module has invalid ELF header\n");
>                 goto free_copy;
> +       }
>
>         err = setup_load_info(info, flags);
>         if (err)
> @@ -3834,6 +3840,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>
>         if (blacklisted(info->name)) {
>                 err = -EPERM;
> +               pr_err("Module %s is blacklisted\n", info->name);

I wonder why would anyone actually add the blacklist to the command
line like this and have no
way to revert that back. This was introduced in
be7de5f91fdc modules: Add kernel parameter to blacklist modules
as a way to overcome broken initrd generation afaics. Either kernel
command line (using modprobe.blacklist)
or /etc/modprobe.d options are honoured by libkmod and allow a
sufficiently privileged user to bypass it.

+Rusty, +Prarit: is there anything this module parameter is covering
that I'm missing?

For the changes here,

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>                 goto free_copy;
>         }
>
> --
> 2.27.0
>
