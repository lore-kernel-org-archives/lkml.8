Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19852C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54B21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtjKVeNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAUL6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:58:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33500 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAUL6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:58:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so2497287lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK6Wv16544idpmucsyNkFh0MEnk+AES/sRmYGtwTMac=;
        b=HtjKVeNBHMzntMzRTKTW5zX9VZ5Jysv0yL5TQV/ecnddcDIMP+DeViKx2a4zyoE6q+
         R1V4gFHLvwAg582p1yD34/b+HoYZEcoB0WOLo2GUL8ybsXA9djDpXAYj64cLLQ6JPkX9
         rJRNaBl5KIndnONLgF5ZSYTtKOv4HzZBoN9RGrE7RGWaekAraUtnlYmAwcsROvQtAnLt
         xGEO5CdfWaCAmTsC9rL/I4Fa+ez/EmKP/+eqTcy2b+2kf7BqgxZEBEC1d0R7w40fcr4Z
         9Q2JkNyoqBq8INb9aqtSsExMeiDaENKN7ihlNUhUaV9ocVjYPqRsZ0wXmh9UPOO/c9qT
         dyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK6Wv16544idpmucsyNkFh0MEnk+AES/sRmYGtwTMac=;
        b=R2SgPmcOC6Q+wuVZ5OsQ7B3MvpsT+51W2RJdSgRMwGxPhep/kqS6CZgvfwjEVH1Lwv
         3DeyR5Vpks/cvNUDboeDc3y7CTHSVbq4wN3URvDTb2qlalDy0yXNusDCZU4DB3oLZE/j
         ra7jbZg8tcHdAPys3uC7csJNObx+0odbe6yo2mCqv8HhkAJv7aL+V8QiRamps0eQiNLa
         kqTVAN9jmCCs6JfasndZcGCT4OVUQArYeH+0tAYWj/kEde2F4fCIfQ+YS0gw5m/OdNYq
         xdYNOJt0oFvb+5HuwT+0YCtltygGcZGHmH5golmf+NiOJwk3lxAnIbZh77GbrJzxHZB5
         s/eQ==
X-Gm-Message-State: APjAAAVps55Iw8YF2SAsf0iGv2Cf57SKfONKlzoMUvvD/6g4NRyDMsg3
        qAQ1p/yTaYL7rv9+bc5XfKtutiR978GmTIcIgtz5
X-Google-Smtp-Source: APXvYqzGtG9yox48VD6bwUpH7datQT8qTc/Ybs7NvLQFSgjrOQrCPubmeSj/S16LLDK8wDjCsbYsO29KA7aMCpInQfw=
X-Received: by 2002:a2e:809a:: with SMTP id i26mr16460465ljg.108.1579607881701;
 Tue, 21 Jan 2020 03:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20191229164830.62144-1-asteinhauser@google.com> <20200121113317.GH7808@zn.tnic>
In-Reply-To: <20200121113317.GH7808@zn.tnic>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Tue, 21 Jan 2020 03:57:50 -0800
Message-ID: <CAN_oZf1bGgXB2fNh8aAJybtPf2ajCGFSzP+7at87X-iW2kq3Hg@mail.gmail.com>
Subject: Re: [PATCH] Return ENXIO instead of EPERM when speculation control is unimplemented
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your change seems to remove exactly the distinction which Thomas
pointed out because SPECTRE_V2_USER_UNAVAILABLE would not
differentiate between STIBP mitigation not available and STIBP not
used because SMT is not possible. Otherwise your modification looks
fine to me.

On Tue, Jan 21, 2020 at 3:33 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Dec 29, 2019 at 08:48:30AM -0800, Anthony Steinhauser wrote:
> > @@ -602,7 +603,7 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
> >  static void __init
> >  spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
> >  {
> > -     enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
> > +     enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_UNAVAILABLE;
> >       bool smt_possible = IS_ENABLED(CONFIG_SMP);
> >       enum spectre_v2_user_cmd cmd;
>
> So here in the code, right under this line we check IBPB and STIBP and
> whether SMT is force_disabled/possible and set smt_possible if not. We
> parse cmdline, pick apart selection, etc...
>
> > @@ -616,6 +617,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
> >       cmd = spectre_v2_parse_user_cmdline(v2_cmd);
> >       switch (cmd) {
> >       case SPECTRE_V2_USER_CMD_NONE:
> > +             mode = SPECTRE_V2_USER_DISABLED;
> >               goto set_mode;
> >       case SPECTRE_V2_USER_CMD_FORCE:
> >               mode = SPECTRE_V2_USER_STRICT;
> > @@ -676,7 +678,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
> >        * mode.
> >        */
> >       if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
> > -             mode = SPECTRE_V2_USER_NONE;
> > +             mode = SPECTRE_V2_USER_UNAVAILABLE;
>
> ... but here we do that evaluation again. But I think that *if* the
> required hw support is not there - either SMT is not possible or STIBP
> not present - then there's no real need to parse the cmdline and do all
> that.
>
> IOW, the filtering out of the cases where the user can't do any changes
> due to not present hw should be concentrated at the function entry and
> mode left at SPECTRE_V2_USER_UNAVAILABLE.
>
> IOW 2, unless I'm not missing some of the gazillion use cases with this
> ;-\ I think that check needs to be moved up and integrated into the
> entry checks. I.e., this ontop or a separate patch...:
>
> ---
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 2e9299816530..ffe5e4fa4611 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -618,8 +618,10 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
>                 return;
>
>         if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
> -           cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
> +           cpu_smt_control == CPU_SMT_NOT_SUPPORTED) {
>                 smt_possible = false;
> +               return;
> +       }
>
>         cmd = spectre_v2_parse_user_cmdline(v2_cmd);
>         switch (cmd) {
> @@ -679,13 +681,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
>         /* If enhanced IBRS is enabled no STIBP required */
>         if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
>                 return;
> -
> -       /*
> -        * If SMT is not possible or STIBP is not available clear the STIBP
> -        * mode.
> -        */
> -       if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
> -               mode = SPECTRE_V2_USER_UNAVAILABLE;
>  set_mode:
>         spectre_v2_user = mode;
>         /* Only print the STIBP mode when SMT possible */
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
