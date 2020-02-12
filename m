Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DBC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8652073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgBLJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:32:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37052 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgBLJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:32:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so1407554oic.4;
        Wed, 12 Feb 2020 01:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbl16QLWOk16BbpGJnBM6ITNh/OXaqd9qdxwFkNXjtY=;
        b=JvhsPYEUaeeK7KbUnv7HXvNL2DqGDkkKcSFQurlaubDp0i4OUymw+p/npEtcoaWB7S
         aiVyvhtXfRwKL9vFcCI641secM3Q5pP4/c2cMthfvTdhJow3dwuz1BDay3nH7PR9f4AQ
         qs1zm1HKcZ6pOfXiTtLsHmvzhccnlQpceR6bhnCzFQCanL0v3Q1cxydvqWyDcZFAYRI3
         EyXi7htNo/acu0CupQhih1qmFiGqBwqcXs3BBGCq9Vge+Gd7CKXiHRz/w/QiW+v0UIja
         C//psjZdR5eIy3NW8CSTji+By/l/ctSmwyVXfx+9we4brR5KqJQyfA1LSMQ6HcVpTDcG
         F+UQ==
X-Gm-Message-State: APjAAAUQSlYw2r07G2XgRxnPrYE14q1hn8VANcensh+zCHpPmgRgd6gH
        G5C/Z9zj+Srh6goR8N237Dl4QJbV1MhuE8AhTEg=
X-Google-Smtp-Source: APXvYqw2r8z8Vc2w1tJlwrxGXuJOMY7YWRpy7v7NNenZTHTtUJxjFWBwZTlQgI0gtLqTBX6zyCXSm2/SjWcl6JKwack=
X-Received: by 2002:aca:c4d2:: with SMTP id u201mr5697570oif.54.1581499958571;
 Wed, 12 Feb 2020 01:32:38 -0800 (PST)
MIME-Version: 1.0
References: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
 <CAMo8BfLYM-_SbqmMUCVjwqL7MpA2W7toTg_F6HTY4Sg5QxGzfw@mail.gmail.com>
 <CAMuHMdUZ_e9JsF0fuLxBwdoy7YVLarH6E98z5nKUZ2CccSkV-Q@mail.gmail.com> <6128aa3a-a99c-2ab0-82d1-d5c419e4f5b9@xilinx.com>
In-Reply-To: <6128aa3a-a99c-2ab0-82d1-d5c419e4f5b9@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Feb 2020 10:32:27 +0100
Message-ID: <CAMuHMdX3O6aL_yGSfqrbdfPf-HHqqdkMwPHS=Y0WxMRTYOtJ4w@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matt Turner <mattst88@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Feb 12, 2020 at 10:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
> On 12. 02. 20 10:25, Geert Uytterhoeven wrote:
> > On Wed, Feb 12, 2020 at 10:23 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> >> On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>>
> >>> Generated files are also checked by sparse that's why add newline
> >>> to remove sparse (C=1) warning.
> >>>
> >>> The issue was found on Microblaze and reported like this:
> >>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
> >>> warning: no newline at end of file
> >>>
> >>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> >
> >>> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
> >>> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> >>> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> >>>         printf "#endif\n"
> >>>         printf "\n"
> >>>         printf "#endif /* %s */\n" "${fileguard}"
> >>
> >> Here there's already \n at the end, so no need for another one?
> >
> > Thanks! I completely missed that.
> > So I did fix the original while applying ;-)
>
> I can drop m68k or align with with others. I would prefer to have the
> same solution in all these scripts.

Yeah, it makes sense to align as much as possible.
IIRC, the original plan was to consolidate more later.

Note that all other lines are terminated with a "\n" at the end.
The separate 'printf "\n"' is an extra blank line, not the terminator for the
previous line.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
