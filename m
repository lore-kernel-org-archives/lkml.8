Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB655C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950F120717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="io6q2W3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgGUVWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgGUVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:22:23 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC25C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:22:23 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id n4so6704969uae.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ti/LYNMV4Io9WHvJwi/sVnT0KR0RLJ+cynlnt8AzAKs=;
        b=io6q2W3OR7PHrPE78QkYmRtAy6IqueGeMnDtZTV/5G/M+ILV9XZoF02ypfJE/FonaG
         sxLZ4bhJlH+ObUJiUko5OSW9ebedFdRmmuMWKmJ2LkGkmz96A7Nievs/m4oaYkCW6gmQ
         KfNqnVzaDRtPVMd7GBdcBuskQOYb/xXc40byA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ti/LYNMV4Io9WHvJwi/sVnT0KR0RLJ+cynlnt8AzAKs=;
        b=rIr+MjQgZyi0tGERMAGV7f2s8Z+AZ2z3Ti7PaCGPWCi58l1y1eSSDiQvriqu7kf1hG
         teIZm9zSwS9hcZrIrBdG7uoYWiKnxWZI8qF5JsnZBXoHaqxcrNnvQGVc2YTra2K0ujcB
         phObUTX6mck0eQFqSh60AQQ7JdKbB6LSJFhdXOu3uxlG2nz3txtfWT8y1TJDEFRaZN+U
         qUgaX1taVJSkBBqxTIGsFfXMYdklVdOWt8DS452jyHbKpJ3+TYf6Z3APhRFvje1v+S2P
         lKZ+m6vFcFd8mOc0pfKvmptxKJ7T8FE3S65SZwpIgiSPmeEQR8j2glXQQOryzjSdaH6g
         EELg==
X-Gm-Message-State: AOAM532JwmMpOws6ju5ZTKJuB1U5yGU38UyEX71F8rjrqZ5Yhdna8eWJ
        fHrlxQwvCEOwzmuROWfpjwfpXsUPF/A=
X-Google-Smtp-Source: ABdhPJzQ21o6neskmlBTC614RzGbubEagmjEcdnmcYz2HL6ln9Kiam7qZymBirWHF2dMTw4fmmG81A==
X-Received: by 2002:ab0:4a86:: with SMTP id s6mr20032350uae.92.1595366542284;
        Tue, 21 Jul 2020 14:22:22 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id q134sm3560097vkb.18.2020.07.21.14.22.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:22:21 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id h18so6700574uao.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:22:20 -0700 (PDT)
X-Received: by 2002:ab0:150c:: with SMTP id o12mr21597172uae.90.1595366540167;
 Tue, 21 Jul 2020 14:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
 <20200716151943.2167652-4-daniel.thompson@linaro.org> <CAD=FV=UBMa4pt7Xg2sKXHdjo6tVaQWBQFtT_aoDJ+Xt1HrPD+Q@mail.gmail.com>
 <20200720081323.5f3xojhu6v23jgqi@holly.lan>
In-Reply-To: <20200720081323.5f3xojhu6v23jgqi@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jul 2020 14:22:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VipxFspgHJZ0uKURyfE4e3GB-w3gyJZdRn5CF9aLT8fg@mail.gmail.com>
Message-ID: <CAD=FV=VipxFspgHJZ0uKURyfE4e3GB-w3gyJZdRn5CF9aLT8fg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kgdb: Add NOKPROBE labels on the trap handler functions
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 20, 2020 at 1:13 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jul 17, 2020 at 03:39:58PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > Currently kgdb honours the kprobe blocklist but doesn't place its own
> > > trap handling code on the list. Add labels to discourage attempting to
> > > use kgdb to debug itself.
> > >
> > > These changes do not make it impossible to provoke recursive trapping
> > > since they do not cover all the calls that can be made on kgdb's entry
> > > logic. However going much further whilst we are sharing the kprobe
> > > blocklist risks reducing the capabilities of kprobe and this would be a
> > > bad trade off (especially so given kgdb's users are currently conditioned
> > > to avoid recursive traps).
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >  kernel/debug/debug_core.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> >
> > I could just be missing something, but...
> >
> > I understand not adding "NOKPROBE_SYMBOL" to generic kernel functions
> > that kgdb happens to call, but I'm not quite sure I understand why all
> > of the kdb / kgdb code itself shouldn't be in the blocklist.  I
> > certainly don't object to the functions you added to the blocklist, I
> > guess I'm must trying to understand why it's a bad idea to add more or
> > how you came up with the list of functions that you did.
>
> Relatively early in the trap handler execution (just after we bring the
> other CPUs to a halt) all breakpoints are replaced with the original
> opcodes. Therefore I only marked up functions that run between the trap
> firing and the breakpoints being removed (and also between the
> breakpoints being reinstated and trap exit).

Ah, OK!  Could that be added to the commit message?

Also, shouldn't you mark kgdb_arch_set_breakpoint()?  What about
dbg_activate_sw_breakpoints()?  I haven't gone and extensively
searched, but those two jump out to me as ones that were missed.

I suppose that means that if someone tried to set a breakpoint on a
kgdb function that wasn't one of the ones that you listed then the
system would happily report that the breakpoint has been set (no error
given) but that the breakpoint would just have no effect?  It wouldn't
crash (which is good), it just wouldn't detect that the breakpoint was
useless.  However, if these were in the NOKPROBE_SYMBOL then you'd get
a nice error message.  Is there no way we could use a linker script to
just mark everything using a linker script or somesuch?

-Doug
