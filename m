Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC02C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8113B2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585066778;
	bh=hL3ffyzHSOOUZkXD8kyHYlYvxw2KQK54jQbVB3X5EnQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ajVeh3bOwa8Q08E/jNwIx0tspmF3Nc3IGe86I629kW7TGRYlD0I3OL1pv6KkqOj+l
	 wDS0Ks22kY9eNUtPvD0sFAgXRJW0E9+qq1/eT6sU0ETFpEgvMcyhvB6NVZPEgRa9Qt
	 EWdczky3cjDTmSo8BOuAQXiFfTGteRlZpTH8bOPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgCXQTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:19:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36149 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgCXQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:19:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id s1so13720821lfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktcswXiT8kMljel+1O1TdiIsPzoYhfgMdTMxEb/ehrE=;
        b=X08XpkjYhFIxfnvGQeWqqzJBD930kTipWU0Ov/aJQ2NkNWeraFQ7aJmqP7ajY2V5ha
         pczfTUOu8SX6mupdjvIe7Dm6FhVgSTb7hAlOnRvf6IOI8AVusX1gn285kru1dP6xiFYo
         sX8rxKmNxaS4+CmqinPGkj6J8pXLr56ExxnPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktcswXiT8kMljel+1O1TdiIsPzoYhfgMdTMxEb/ehrE=;
        b=HhTmSW6Hyf9G1tkxM/7kKS/b5HLfcKxH2WSMlb35PMMI4zA+Aw1aysWQjSyjXtJqEL
         Bz6kYzvRLJigVb1l9GG9B5KIZmiUNW3cqpkg+0MXA1yNLaMN4RrHmLww6i0M8XLcfssY
         280jzxLYYHdoFflHeS37B0XZOfoWloqZ36aNCusPh0G+Fh1ShtZMcldCDEjOxd4tFiOR
         6VMy57ni7NPpq7H4MEHksCycYkBaughOb3/aOd4W9YDJYhksUjsBXGp4s7AxhasEoQgz
         UfeUyBpgdKxkroBjf9uUB94hHgVdCZs8qWa2fGqBi8jzud1Y1n5xcmvIuePIm/zjhPZl
         a2VA==
X-Gm-Message-State: ANhLgQ0O+YniQbJpd3bVxEbMIXM9bxDe8PqqCOOI51eMGyCqDRi18zy8
        N0PeovftVz/OG7jff8X0x2kPsSJf4pY=
X-Google-Smtp-Source: ADFU+vurQDbEBqvjHZltMrrkLnmD6C5B2OgB8ZiviKiPvBWPEp7Lx6AfpNnykz7jFOWpGRnAeo2xRA==
X-Received: by 2002:a19:c102:: with SMTP id r2mr4630514lff.170.1585066774011;
        Tue, 24 Mar 2020 09:19:34 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d20sm10095376lfl.53.2020.03.24.09.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:19:32 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j188so9883408lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:19:31 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr16863883lfk.192.1585066771427;
 Tue, 24 Mar 2020 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200323185057.GE23230@ZenIV.linux.org.uk> <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk> <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk>
In-Reply-To: <20200324020846.GG23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 09:19:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
Message-ID: <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 7:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > And wouldn't it be lovely to get rid of the error return thing, and
> > pass in a label instead, the way "usafe_get/put_user()" works too?
> > That might be a separate patch from the "reorg" thing, though.
>
> OK, ret wouldn't be in the list of outputs that way and
> *uaddr could become an input (we only care about the address,
> same as for put_user), but oldval is a genuine output -

Yes, initially we'd have to do the "jump to label" inside the macro,
because gcc doesn't support asm goto with outputs.

But that's no different from "unsafe_get_user()". We still pass it a
label, even though we can't use it in the inline asm.

Yet.

I have patches to make it work with newer versions of clang, and I
hope that gcc will eventually also accept the semantics of "asm goto
with outputs only has the output on the fallthrough".

So _currently_ it would be only syntactic sugar: moving the error
handling inside the macro, and making it syntactically match
unsafe_get_user().

But long term is would allow us to generate better code too.

                Linus
