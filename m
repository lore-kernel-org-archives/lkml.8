Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A1C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E9824658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582071373;
	bh=QwIOkW+WTgxFcL9LkF3c08cWjtphh8d8ugXkBOTaEjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Gu8XArJQWDoOZtgTOgeGgvAjqeoqFFIU0MFghhucJxBWkv36r+2042O+v5ex6BMa
	 IaN5Mtqvh/5JZ9gYmAjO8RzNiXTz6cncq2LgFNHZkqw4yF35k3uHPwiW00oCZKNRQx
	 DhqLj2THpq01NCnJQwQbMZThP/XrU8o3KJ2pr0Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBSAQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgBSAQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:16:11 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BBA24672
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582071370;
        bh=QwIOkW+WTgxFcL9LkF3c08cWjtphh8d8ugXkBOTaEjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IVK4WrIMWyCYm6xYl3XlhNveydH7xk7Ocv3Flqw/ZA3zCkIM17Ge1RWKz1QVGglBv
         ZgRRbjhHBNmkA6pqVobaSQ4xSxZb6JnJ4etdulB/V1xr+kwKvoDO0porT6Ge2CW56L
         U34QGl1amYBs3QxAmuct/cnXGxbio93Z20121oUA=
Received: by mail-wr1-f49.google.com with SMTP id m16so26083293wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:16:10 -0800 (PST)
X-Gm-Message-State: APjAAAWkvtOaCQzCZuE9CITbr8BkwtMaaQAh0pYyooVEo3cDRHh4CroD
        le3so/utcCgwJPQVCXf4tfAqaoNBxIW7mkTSWWZJfA==
X-Google-Smtp-Source: APXvYqw4flURwIu7AwncaJvXon3ugSEikn8QMROWSSuNrhrJeeZ+3ce3O1cXHQ6xnavfosQtPfs+1xYbERKjQLsEWbw=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr31201138wrm.75.1582071369038;
 Tue, 18 Feb 2020 16:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20200218173150.GK14449@zn.tnic>
In-Reply-To: <20200218173150.GK14449@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 18 Feb 2020 16:15:57 -0800
X-Gmail-Original-Message-ID: <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
Message-ID: <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
Subject: Re: [RFC] #MC mess
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 9:31 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> so Peter raised this question on IRC today, that the #MC handler needs
> to disable all kinds of tracing/kprobing and etc exceptions happening
> while handling an #MC. And I guess we can talk about supporting some
> exceptions but #MC is usually nasty enough to not care about tracing
> when former happens.
>

It's worth noting that MCE is utterly, terminally screwed under high
load.  In particular:

Step 1: NMI (due to perf).

immediately thereafter (before any of the entry asm runs)

Step 2: MCE (due to recoverable memory failure or remote CPU MCE)

Step 3: MCE does its thing and does IRET

Step 4: NMI

We are toast.

Tony, etc, can you ask your Intel contacts who care about this kind of
thing to stop twiddling their thumbs and FIX IT?  The easy fix is
utterly trivial.  Add a new instruction IRET_NON_NMI.  It does
*exactly* the same thing as IRET except that it does not unmask NMIs.
(It also doesn't unmask NMIs if it faults.)  No fancy design work.
Future improvements can still happen on top of this.

(One other improvement that may or may not have happened: the CPU
should be configurable so that it never even sends #MC unless it
literally cannot continue executing without OS help.  No remote MCE
triggering #MC, no notifications of corrected errors, no nothing.  If
the CPU *cannot* continue execution in its current context, for
example because a load could not be satisfied, send #MC.  If a cache
line cannot be written back, then *which* CPU should get the MCE is an
interesting question.)

If Intel cares about memory failure recovery, then this design problem
needs to be fixed.  Without a fix, we're just duct taping little holes
and ignoring the giant gaping hole in front of our faces.
