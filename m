Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462DC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F9624656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgB0Or7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:47:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36408 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgB0Or5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:47:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so3156708otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hx07xUVtiLNFuA+1PzPYK/9ENx9jNADnJPX/dLICnC8=;
        b=lXot71ha2urcEDRxHPtBHaefBgmRMzntRzxE6l5Ds6md0rzSUqRI/6H/ApNFmifuSN
         9lC498PqgOIiGEueKbDq8ac1v4jKA4ac9RkZzN5I1+AfmDOEtOo5DZE+ohNHSL+Xou5B
         m5V74FIWg/uGXpKMvhhtGMoa4MQjZmv38HetA93dLq8lpfB5WG7dZvziCwiF4N2chTxa
         yKLoCajNkQq/Q9j7kS20LJvOM2yYZOe7SLZhn58CYYqQau/fiY/zpYiA/6YMIBatLzhl
         zATALbuG9fu095hQ+sIuuFm3Lp5Rs98Pz0IQUsfzW+3H35gAojENvm98gI7B+VVM4Py7
         9eWw==
X-Gm-Message-State: APjAAAXFW4zHzRIVg/oZc9f2zbg4Uj8YTVH6gP23vXOxPjs2jeAjc7Ly
        yzO3Kx93Bh4m/GpovjcmPHrLZGcWfwMhN6F2KTD30V8b
X-Google-Smtp-Source: APXvYqx+Tk3BPXn2pbxAQxVRNK/Sn8CkdmxpB1+lGOWCIYJv6w3mZHrwCku0J5SBCbXVXhZykFOzpHDF1EFnW2116wg=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr3602134otk.145.1582814876431;
 Thu, 27 Feb 2020 06:47:56 -0800 (PST)
MIME-Version: 1.0
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
 <158220111291.26565.9036889083940367969.stgit@devnote2> <CAMuHMdWEoBrFRhmLEByhDCasuMrbGS4PreRivYRApdsME7x2AA@mail.gmail.com>
 <20200227092732.6a22a71a@gandalf.local.home>
In-Reply-To: <20200227092732.6a22a71a@gandalf.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 15:47:45 +0100
Message-ID: <CAMuHMdX6RpEDpkKcmLeNh4T2o+_HpV3XpYCAWYk0uWYt_bkztw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, Feb 27, 2020 at 3:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 27 Feb 2020 10:22:00 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > +static int __init warn_bootconfig(char *str)
> > > +{
> > > +       pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
> > > +       return 0;
> > > +}
> > > +early_param("bootconfig", warn_bootconfig);
> >
> > Yeah, let's increases kernel size for the people who don't want to jump
> > on the bootconfig wagon :-(
> >
> > Is this really needed?
>
> Yes, because if someone adds bootconfig to the command line they would be
> expecting their bootconfig to be read. If not, we should not fail silently.

If someone adds "ip=on" to the command line, they expect DHCP to work.
Woops, you need CONFIG_IP_PNP for that.
If someone adds "nfsroot=..." to the command line, they expect the NFS
root fielsystem to be mounted.
Guess how many options need to be enabled for that?

Perhaps we need CONFIG_COMMAND_NOT_FOUND?

    Kernel panic - not syncing: option "inspecial" not found.
    Did you mean:

        option "imspecial" from section "mine"
        option "urspecial" from section "yours"

    Try enabling it with "make xconfig".

> Are you really concerned about a tiny __init function that gets freed after
> boot up?

It's still part of the initial kernel image, and thus subject to boot loader and
platform limitations.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
