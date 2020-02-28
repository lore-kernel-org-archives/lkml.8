Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E43246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDe1ajsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgB1Te4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:34:56 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46748 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Te4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:34:56 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so3694834ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17XG1LK9a/nSJjEWbs0F5bJvFWVmmZgYl1lDakBKzp8=;
        b=cDe1ajsEpaa5yX4viE/vaEEEt3AHZ2DoFHxaZxX+sYNnBrSlU3a9bLy19sPYRsiXTl
         L41muiufsI13WkuRDqQQXnKw+FA2ulMzW6Dl1O3uJLKX22aey7q0BrXfmoSBKLSNrfOX
         HbrdiQqzcQR1of1/PBF3CDf/z46C/9tif040Zl+pFQF3ToCmBb0x/ziMxfVlnkgG/KUq
         E9w2pFbeZKl6MlbzYrnxpJMOQZHXxLhyjxYLSSgdDRv4Wf9UB07w9/BEc1JTAoDcYovd
         AAc3yY4Z953DR8XTtb5hPJ5ydnIeCw2NySzhZwY2RhzAL56p7ns+9d/nSD9YQVcLEb7b
         Wm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17XG1LK9a/nSJjEWbs0F5bJvFWVmmZgYl1lDakBKzp8=;
        b=I1wlDGomGVKt1LmC9aCWAvA/+8o6h6bg7mxfxnmP9aMcomFoDnI2qSiHv6TBtISUEf
         E6qghK4z1G5LMC/4ayMxt4bDh7kTqO/XCU+p8kwyCJrMka9+5mDJ0lU6AUEyxcHCOOu0
         8Qr1FzW9GxjgMXwWwzUgPVzBBiZ0vM3N/Uws98ukmhefusMesYq7r4i+Rc385xvL2r/4
         HKpKnvCRb8PdHZSINNftLq5IZFh9Rd2eP+0/9bw0AbXz+CBIOaEyu2jcPKvlIetwT0Os
         idNmUrgObY3+7b70yGt57Eljom0KpycEUoxDbhgV3esJuOuHD7FItK42LlBFWpMZefJH
         J2ig==
X-Gm-Message-State: APjAAAW5CLVDw9oSd8Tx9/Ll4yb3gXuqlIYtZxVz9VMlwfqtKHPJDOBD
        zRggLC/qC3B3M1U6jQMSYTLpY3xSnz8m1tvghdb+
X-Google-Smtp-Source: APXvYqyMqlHSrd3VbRdMXlcczeVTrPbM3/CCOq+QVFKW55+u3/oEkWgIRDKuVnBOVdxzdTt+GCedU4No5/mTK2qPT/4=
X-Received: by 2002:a92:9a02:: with SMTP id t2mr5532571ili.11.1582918495364;
 Fri, 28 Feb 2020 11:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-2-brgerst@gmail.com>
 <CALCETrWqmpChXCs0b-rO4X-yKKy0Afy3ioaK01ZmeiCvsN=3+Q@mail.gmail.com>
In-Reply-To: <CALCETrWqmpChXCs0b-rO4X-yKKy0Afy3ioaK01ZmeiCvsN=3+Q@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 28 Feb 2020 14:34:44 -0500
Message-ID: <CAMzpN2hwvAzMYrem7rN7nKs991qp_UwAtt5Nfw5RmVCm3abTuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] x86, syscalls: Refactor SYSCALL_DEFINEx macros
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:33 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Pull the common code out from the SYSCALL_DEFINEx macros into a new
> > __SYS_STUBx macro.  Also conditionalize the X64 version in preparation for
> > enabling syscall wrappers on 32-bit native kernels.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
>
>
>
> > -#define COMPAT_SYSCALL_DEFINEx(x, name, ...)                                   \
> > -       static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));      \
> > -       static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
> > -       __IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                           \
> > -       __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                            \
> > -       static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))       \
> > -       {                                                                       \
> > -               return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
> > -       }                                                                       \
> > -       static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> > +#define COMPAT_SYSCALL_DEFINEx(x, name, ...)                           \
> > +       static long                                                     \
> > +       __se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__));        \
> > +       static inline long                                              \
> > +       __do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__));        \
> > +       __IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                   \
> > +       __X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)                    \
> > +       static long                                                     \
> > +       __se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__))         \
> > +       {                                                               \
> > +               return __do_compat_sys##name(                           \
> > +                       __MAP(x, __SC_DELOUSE, __VA_ARGS__));           \
> > +       }                                                               \
> > +       static inline long                                              \
> > +       __do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
> >
>
> This hunk looks like a pure anti-cleanup.  I much prefer slightly long
> lines over messy excessively multi-line macros.

Yeah, after several iterations this ended up back in it's original
form other than whitespace changes.  Personally I think the 80-column
hard limit is silly in this age of 4k widescreen monitors, and can
lead to some weird line breaks in certain cases, but that's still the
rule.

--
Brian Gerst
