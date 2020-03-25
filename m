Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09076C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27DE20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx4zznov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCYCfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:35:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46153 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgCYCfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:35:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so279581pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 19:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCruq4yToUqxgi9otmka3R7GLNMHRYxm71De4g72dIE=;
        b=jx4zznovkVe6XCYL16ne29yitgzvHvZ3wp/VniEpCswbagD3W2AoeE1MOXgpzOx7N8
         XFIk69jjrSVZ4PwdB3sRyk4uCWw6L6xOdXQBCT/luaJa1bAYhaEhLo4iFZM8EPeMDPuS
         EELCJXRdIICqaVkyHduO5Toie/9MNcDWref2p5Hh/JlNMmcm6ezHts2wONoIbJ2gl2U8
         AslSM1Yy/pl6VukIPDvRQvQWKH8FTKGFSkXhkRVRPuMZ4c+CTPeCwU3D3k2HoWPPw0D7
         ttdJk19L8qTikFSi5lYJaJHuBcEK0E9rgDfVH/vvd//b/6Ioubyw5AJUZCMA0Z5tstOo
         vGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCruq4yToUqxgi9otmka3R7GLNMHRYxm71De4g72dIE=;
        b=GsEdECVkuaRqi7qy299TFg748hcIAO9bpwD08eHDGGdblu33rXuaFjgTgkz5GGhP0o
         JewqZYAb9oMrfTJCEq5cLaPhb6Hlhx4bUXmZ7p37GQwiv9T9ZOYOfNtnxN8lTYpI0Bx0
         sCn6FfIKsSDG4UE+qUB9rPZS30S4RlCAevT5uG6kQpQqBINnz9fzjoMa4ee5iD+TnNH3
         g+yZt+4lwsRBmugKolJZzreSwtvhp+Sff3PEr8vgXYQtJoRwsE92iBCi/XUX8vyzFjpH
         t9ZX4jzZIFSptModmLPu2CV7b4aoGEmIiJIYA1cDmr6YkmWo44CdP1LlmuR46vSmcaF6
         w3tA==
X-Gm-Message-State: ANhLgQ1/SB7/ZHHQFlu7p6cZREciVTe015f5o5yPyURAdScLTbPdiVGZ
        okuUcUZCT3/UvLc/nwY3Zgg=
X-Google-Smtp-Source: ADFU+vs7kd3EyY7fKPHuBdrX5g5pI/Ybft6HW4aFtGtcppaEVj9FPnWCiFFs5Fjuo2+92wn9FEcJvA==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr1028465pfc.132.1585103709526;
        Tue, 24 Mar 2020 19:35:09 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id z17sm17198052pff.12.2020.03.24.19.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 19:35:08 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:35:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Zygo Blaxell <uixjjji1@umail.furryterror.org>
Cc:     Qian Cai <cai@lca.pw>, tytso@mit.edu, arnd@arndb.de,
        gregkh@linuxfoundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, catalin.marinas@arm.com,
        will@kernel.org, dan.j.williams@intel.com, peterz@infradead.org,
        longman@redhat.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dmesg -w regression in v5.4.22, bisected, was: Re: [PATCH]
 char/random: silence a lockdep splat with printk()
Message-ID: <20200325023506.GB241329@google.com>
References: <1573679785-21068-1-git-send-email-cai@lca.pw>
 <20200324151359.GF2693@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324151359.GF2693@hungrycats.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/24 11:13), Zygo Blaxell wrote:
> On Wed, Nov 13, 2019 at 04:16:25PM -0500, Qian Cai wrote:
> > From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > 
> > Sergey didn't like the locking order,
> > 
> > uart_port->lock  ->  tty_port->lock
> > 
> > uart_write (uart_port->lock)
> >   __uart_start
> >     pl011_start_tx
> >       pl011_tx_chars
> >         uart_write_wakeup
> >           tty_port_tty_wakeup
> >             tty_port_default
> >               tty_port_tty_get (tty_port->lock)
> > 
> > but those code is so old, and I have no clue how to de-couple it after
> > checking other locks in the splat. There is an onging effort to make all
> > printk() as deferred, so until that happens, workaround it for now as a
> > short-term fix.
> 
> Starting with v5.4.22 I noticed 'dmesg -w' stopped working on some
> machines.  dmesg will follow console output for a few seconds, then it
> stops.  strace indicates dmesg is blocked in read() on the /dev/kmsg fd.
> If a new dmesg process starts, it gives messages for a few seconds,
> then also stops.  rsyslog's kernel logging is similarly affected.
> 
> Bisection points to this patch (now known as
> 1b710b1b10eff9d46666064ea25f079f70bc67a8 upstream).  I can't reproduce
> the problem on a test VM, and some machines are running v5.4.22..v5.4.26
> with no dmesg problems.  It seems there is some magic in the startup
> sequence of affected machines.  This code isn't executed after RNG is
> seeded, so it would have to get its bad stuff done before that happens.
> 
> Reverting commit 1b710b1b10eff9d46666064ea25f079f70bc67a8 fixes the
> dmesg regression on 5.4.26.  It might put the original lockdep bug back,
> but on machines running stable kernels, I prefer randomly broken lockdep
> over repeatably broken dmesg.

This should fix the problem

https://lore.kernel.org/lkml/20200303113002.63089-1-sergey.senozhatsky@gmail.com

	-ss
