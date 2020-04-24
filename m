Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CCDC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8194D2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 21:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCBYIFOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDXVUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 17:20:36 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166D2C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:20:36 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so14979669otr.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1y5J+t1rkSodDRL2D6On5fzA32zFL6p5sBHGHG/X4BU=;
        b=LCBYIFOlRnMK2jDl+54oNy6Wv9KmCIa4ziW3YhSidyxuGnOMwqTTw8xE9r3MX6ob9O
         Mmg3nZVUUAVhAIiLTqYCEJ4OWvZ7RefAPNCFjAGHpnj5HdXdeLaEiESinpQoPOoZz+jo
         9JEWZnenjuSTn9A2QvSE0q0+Utt89r26vZng/pW8VKrpzQt+a3vFy+e0bSppa8Y6OmJa
         +7YgPl5AX/QAbFjJbIOIyDj5foGG2i0fNV2Ya36kkwFwYnltYpdZUyVFcau60fEHLbFA
         h+KY/DJ1K0sh5XeYFrbVfqUd9U2XSkDWZBJDKzVQpvUmMoVL1FnwC05UBlU//14agJ2X
         E42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1y5J+t1rkSodDRL2D6On5fzA32zFL6p5sBHGHG/X4BU=;
        b=TE6Yt02LLwBFbvacXCF8H7cbQH1zzcDRyq6hbcPPiwQ4ac4pJrRzFH2VPHiWJzl1GV
         zbjWznldmcRdyImEQVYTD78K7jh9QboOgVnaiIhrTn9qZds7aH2d3rKh2GKltOWeUVO0
         xXO+ZDxPNIJ6PLTbNpFseOu35G/vkOhMEi40H3RKhiyudqNp3lLI70LqhB5EMGdM5+SW
         XakL4P0AEtEEKmBw51Qzq2vG9HVo0hNbW747Az6wgzxmI2tHOS3GLx9pJ1OSK44qc1Iu
         en/huz8ES22rhTQNgFIerzW/DgNrsp0scnZe1m4FZWf4mSha1ji0BC46VtqYzTjFCP4D
         aZag==
X-Gm-Message-State: AGi0PuYdtKGQFn2/09DwHtxuHQwNpYLvG5+fD4aOUlOa6Jz3gi65JsQ4
        GXPhSuViHInhqpYprpkKNWLazC4VkirTDM5E2W8=
X-Google-Smtp-Source: APiQypLhAY65mdyvjHIlIKThskIwVZqz00TDDg6W/dwxpuxHUzESsgwrjvzW3tZQMAZe4fe8HB+Fe3T8pZ71ICgz6wo=
X-Received: by 2002:aca:d844:: with SMTP id p65mr8889936oig.126.1587763235367;
 Fri, 24 Apr 2020 14:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200422042007.4836-1-tony.fischetti@gmail.com> <20200422071100.GS4247@MiWiFi-R3L-srv>
In-Reply-To: <20200422071100.GS4247@MiWiFi-R3L-srv>
From:   Tony Fischetti <tony.fischetti@gmail.com>
Date:   Fri, 24 Apr 2020 17:20:24 -0400
Message-ID: <CAOMV6SXDe+h+H1jm4GOFt2qPC_fvkbTJ0ZQOdCZX0LD9+esKDQ@mail.gmail.com>
Subject: Re: [PATCH] x86/setup: Add boot messages about cmdline builtins
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, dave.hansen@linux.intel.com,
        linux@roeck-us.net, Kees Cook <keescook@chromium.org>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like the idea of printing the original one, printing the information
about the cmdline manipulation, and, then, printing the final one at the
end, too.

The only problem is I don't know what to label the first printk so that it
remains clear that it's not necessarily the _final_ one, yet.

In either case, they should probably be changed to `pr_info`s, right?


On Wed, Apr 22, 2020 at 3:11 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/22/20 at 12:20am, Tony Fischetti wrote:
> > While the ability to override or append to the boot command line has
> > been added, the boot messages contain no information as to whether the
> > cmdline was manipulated by the build-time options. This patch, for x86,
> > adds boot messages specifying whether the cmdline was manipulated and
> > waits for the potential changes to take place before printing the final
> > boot command line.
> >
> > Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
> > ---
> >  arch/x86/kernel/setup.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 4b3fa6cd3106..28d77f01fd0d 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -828,7 +828,6 @@ void __init setup_arch(char **cmdline_p)
> >        */
> >       __flush_tlb_all();
> >  #else
> > -     printk(KERN_INFO "Command line: %s\n", boot_command_line);
> >       boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
> >  #endif
> >
> > @@ -904,10 +903,12 @@ void __init setup_arch(char **cmdline_p)
> >
> >  #ifdef CONFIG_CMDLINE_BOOL
> >  #ifdef CONFIG_CMDLINE_OVERRIDE
> > +     pr_info("Overriding command line with builtin\n");
> >       strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> >  #else
> >       if (builtin_cmdline[0]) {
> >               /* append boot loader cmdline to builtin */
> > +             pr_info("Appending command line to builtin\n");
> >               strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> >               strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> >               strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > @@ -916,6 +917,7 @@ void __init setup_arch(char **cmdline_p)
> >  #endif
> >
> >       strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> > +     pr_info("Command line: %s\n", command_line);
>
> Yeah, adding info to tell there's action on overriding or apending
> command line looks good to me. Maybe keep the printing of the original
> command, we can get the final command line from '/proc/cmdline' after
> system boot, or just get it from the original cmdline + CONFIG_CMDLINE.
> Or print the original cmdline and the final cmdline both.
>
> Personal opinion.
>
> >       *cmdline_p = command_line;
> >
> >       /*
> > --
> > 2.20.1
> >
>


-- 
--
Tony Fischetti
tony.fischetti@gmail.com
(718) 431-4597
