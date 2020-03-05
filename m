Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED35C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBC9207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcAAzWY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgCEQWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:22:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34988 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:22:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so6411707wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEvgQVZavtTsnR3H4wayPtk/nZQ+Zm47QLXTHSzN7fo=;
        b=GcAAzWY1RcrrmwdnC52Rlub3aR8//mgYvQ9FmOS++fuNEZoR8Rlkaj/Z1BRuuybFA0
         uMHBNEOfUefPRil4g2NixlSsSkl8in3cEnm9Mc1ocdM/8SFn2GNnB/QfmtaelLsczEt0
         XY/4MAu0ZTNZZCjzbYc0+4sWwqTPwaWT2A2xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEvgQVZavtTsnR3H4wayPtk/nZQ+Zm47QLXTHSzN7fo=;
        b=QDN4arZWx2ODRwjxq9bluZAaidSZTNODHa79H98akOUQBJZtwnoShUqIJLn9uP58uu
         9/tYTPCeFknBJvAPNxStIw7UsjdRW1LBlkckA/5mTenBatckEEqhZzP5lYLjq+m2cqcR
         HrEJg1Ev7E9pERwRR+Sv8C1k8MED3oVqCPguP971/4MyW5LM9tBCJLxBSJKG5oIMqhop
         HLGkIGZ/g6CgGVrIIHndN6bDUoyfvOsREoFKTjUC3hXGRpcduErIc1pn8a/Uc9xPDXMJ
         WP1G3ckvTjshzxgiiZPESIx7Hjhzr5O7dmOGUj0EXADUGw8RiF+SGBZJgydpt89hFkgP
         F3lw==
X-Gm-Message-State: ANhLgQ0sZedUwpoZFmebUvKEa9VL5A1RNBIGA726t2PzWQxEeoOaBa0L
        ZEcyCzigEYM7VYZv4jV53XwMZ90N7NtRiQL6yGRP5Q==
X-Google-Smtp-Source: ADFU+vvBj+1xJThqxd5rF87Tunq26QxaCiqKxwYjHudkZ0a9XD8NqOyNXEkTlJ26vyLocVjmpuu2PlqvdYuTfnFNgbU=
X-Received: by 2002:a1c:2504:: with SMTP id l4mr10601800wml.72.1583425364775;
 Thu, 05 Mar 2020 08:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20200305175528.5b3ccc09@canb.auug.org.au> <715919f5-e256-fbd1-44ff-8934bda78a71@infradead.org>
 <CAADnVQ+TYiVu+Ksstj4LmYa=+UPwbv-dv-tscRaKn_0FcpstBg@mail.gmail.com>
In-Reply-To: <CAADnVQ+TYiVu+Ksstj4LmYa=+UPwbv-dv-tscRaKn_0FcpstBg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 5 Mar 2020 17:22:34 +0100
Message-ID: <CACYkzJ4ks6VgxeGpJApvqJdx6Q-8PZwk-r=q4ySWsDBDy1jp+g@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 5 (bpf_trace)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 5:18 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 8:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 3/4/20 10:55 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20200304:
> > >
> >
> > on i386:
> >
> > ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to `bpf_prog_test_run_tracing'
>
> KP,
> Please take a look.

Sure. Taking a look.

- KP
