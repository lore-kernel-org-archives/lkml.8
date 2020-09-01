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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE17C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B2C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WckOabD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgIAURf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIAURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:17:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76123C061244;
        Tue,  1 Sep 2020 13:17:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so2893946wrm.9;
        Tue, 01 Sep 2020 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZmeotuS+laaRvBru8cqS5MsJRn+e3F32IC36oLFMf0=;
        b=WckOabD605oxINHnkV09nVUwEYDsyNosYnrtRmr24xLzZjXt5pc/76QPeU0+SNjTkT
         Kzy6VepT+A3rEwvwlghY1aR94RENU3wc+aveOQsUd09S6vdfdr4/JLsOlwwU/NyJD2qy
         9s0uSiSj9mk9MxosZQqXubfGexcSMfMapBYVf8jB3awuaye5C3REnPsxhmsKbVa1vCJP
         nyfkZxYmiX8OjTOPUP+X7l/t1cejE3O0Zv/TBVUnFgsF1TombIA1/i4I0wyKzUgg8Cp7
         sG5g4ZiBreAq6VpepVC8XBMMiHDmCHbq4hsBymN8bBVwOjVLHOhJnLAF+4fdW2skKsz3
         4FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZmeotuS+laaRvBru8cqS5MsJRn+e3F32IC36oLFMf0=;
        b=GfSdt97CquR8T7WXmX+wi1AeOXCG3HvepvnjzTyHk189vbyTckbp7+b87jX0OCXUW8
         VdUFwZmOO0hc+GOmgNV2fAAoq+pR41KxEp0nhhUroEHtvwIgEAEz0v69CrnBCJ+B1b8Q
         g5fpgOMSDFr8WA6yx77nPmwleGZrVu52fbp59kAaMuPjlMZFn7hVNJ9Cb7mOSiGxIC/I
         38SiEpgyjuD1Sb8TF41zJVeJUPUYaOzHXFf1/SOlggzSWmZslE+mLmxfLbqvF4R4gJH8
         /P+f8DK5o57528JEoyv74K/Vp0Af+LWKTwE6xgCtnhZDHOdArmOxz4kWis4Pv4abf+zy
         Rb+A==
X-Gm-Message-State: AOAM532+znDjsfZYyOze/Y0n589w7gG237B0bE79gHjSiwSwRkyWk8v+
        FHDYfYsEDYGPUuJrxtmDWHphX9nCbnBr7uf8sek=
X-Google-Smtp-Source: ABdhPJzqsGdD+8Ug2gH3XIq/XS6eaNQyEDLClXi4/h7iKVRvrj9QXQ8xRZeNOJaBz1v7J8y8uEx5Z1AmG51OuF8pR9M=
X-Received: by 2002:a5d:4603:: with SMTP id t3mr3467070wrq.424.1598991451043;
 Tue, 01 Sep 2020 13:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200829111437.96334-1-wqu@suse.com> <CAKi4VAJ_nZ9DT1Tm=uufbJPGgZJu+4j+DVVA9otv6oGXuD3jxg@mail.gmail.com>
 <df13d885-6f9d-dc8a-b850-8aa6ae6993eb@redhat.com>
In-Reply-To: <df13d885-6f9d-dc8a-b850-8aa6ae6993eb@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 1 Sep 2020 13:17:18 -0700
Message-ID: <CAKi4VAK4818=-FfSwG7jt-+CwY-3qEYrHfzZ45dTY948smOZ8g@mail.gmail.com>
Subject: Re: [PATCH] module: Add more error message for failed kernel module loading
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Qu Wenruo <wqu@suse.com>, lkml <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 12:56 PM Prarit Bhargava <prarit@redhat.com> wrote:
>
>
>
> On 9/1/20 2:50 PM, Lucas De Marchi wrote:
> > On Sat, Aug 29, 2020 at 4:15 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> When kernel module loading failed, user space only get one of the
> >> following error messages:
> >> - -ENOEXEC
> >>   This is the most confusing one. From corrupted ELF header to bad
> >>   WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
> >>   all returns this error number.
> >>
> >> - -EPERM
> >>   This is for blacklisted modules. But mod doesn't do extra explain
> >>   on this error either.
> >>
> >> - -ENOMEM
> >>   The only error which needs no explain.
> >>
> >> This means, if a user got "Exec format error" from modprobe, it provides
> >> no meaningful way for the user to debug, and will take extra time
> >> communicating to get extra info.
> >>
> >> So this patch will add extra error messages for -ENOEXEC and -EPERM
> >> errors, allowing user to do better debugging and reporting.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  kernel/module.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/module.c b/kernel/module.c
> >> index 1c5cff34d9f2..9f748c6eeb48 100644
> >> --- a/kernel/module.c
> >> +++ b/kernel/module.c
> >> @@ -2096,8 +2096,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> >>         int i;
> >>
> >>         for (i = 0; i < hdr->e_shnum; i++) {
> >> -               if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
> >> +               if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
> >> +                       pr_err(
> >> +                       "Module %s section %d has invalid WRITE|EXEC flags\n",
> >> +                               mod->name, i);
> >>                         return -ENOEXEC;
> >> +               }
> >>         }
> >>
> >>         return 0;
> >> @@ -3825,8 +3829,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >>         char *after_dashes;
> >>
> >>         err = elf_header_check(info);
> >> -       if (err)
> >> +       if (err) {
> >> +               pr_err("Module has invalid ELF header\n");
> >>                 goto free_copy;
> >> +       }
> >>
> >>         err = setup_load_info(info, flags);
> >>         if (err)
> >> @@ -3834,6 +3840,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >>
> >>         if (blacklisted(info->name)) {
> >>                 err = -EPERM;
> >> +               pr_err("Module %s is blacklisted\n", info->name);
> >
> > I wonder why would anyone actually add the blacklist to the command
> > line like this and have no
> > way to revert that back. This was introduced in
>
> Debug.  Debug.  Debug. ;)  The parameter was added to debug broken installations
> and kernel boots.
>
> > be7de5f91fdc modules: Add kernel parameter to blacklist modules
> > as a way to overcome broken initrd generation afaics.
>
> Not the generation of the initramfs, but blocking a module loaded during the
> boot.  The installation may have failed and there's no easy way to then debug
> what module was responsible for the failure.

if you are using initrd, then *inside* the initrd you should have the
/etc/modprobe.d/* file
you want. I said "broken initrd generation" because the tool should
put the file there, and
apparently for you it isn't.

Even if you don't have the file, you could use modprobe.blacklist= and
let the blacklist happen
in the userspace library rather than in the kernel. Module loading is
not like firmware loading
that happens without help from userspace.

>
>  Either kernel
> > command line (using modprobe.blacklist)
> > or /etc/modprobe.d options are honoured by libkmod and allow a
> > sufficiently privileged user to bypass it.
> >
>
> Both of those options only work if the filesystem is mounted IIRC.  It could be
> the case that modprobe.blacklist now works earlier in the boot, however, I've
> never used it because module_blacklist is the biggest and best hammer that I can
> use to get through a broken installation or boot.
>
> In any case you're incorrectly assuming that the system has a filesystem on it.
> That's not necessarily the case as I'll explain below.
>
> > +Rusty, +Prarit: is there anything this module parameter is covering
> > that I'm missing?
>
> This is the situation I have repeatedly come across :  A system at a remote site
> will not boot any flavor of Linux.  Since the system would not install the only
> way to debug was to provide install images to workaround a module load failure.
> As you can imagine that is a time consuming process as well as a bad end user
> experience.
>
> I got so sick of it that I wrote the code above (well similar to it anyway --
> thanks for the review Randy ;)) to add the module_blacklist parameter to make
> debugging an uninstallable "bricked" system easier.
>
> It's come in handy in some unexpected ways.  We've had situations where modules
> have loaded and corrupted memory and blacklisting them revealed that the modules
> were responsible for the memory corruption.

ok... but this seems a reimplementation of modprobe.blacklist= option
in the kernel command line,
but in kernel space, with no way to remove it after the kernel is booted.

Lucas De Marchi

>
> P.
>
> >
> > For the changes here,
> >
> > Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> >
> > thanks
> > Lucas De Marchi
> >
> >>                 goto free_copy;
> >>         }
> >>
> >> --
> >> 2.27.0
> >>
> >
>
