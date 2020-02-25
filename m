Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D3CC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFA9222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582626376;
	bh=tsHmP0fWLGpKEusGC+Namhfpp6ZeCtBgPrPkaJzeBm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BQCo6e1tOT9lMEyfb5Grst2tt1rYvDjlSY6yoTkFn7BEr2Fbc6S5DbCQ0DFC3H1ly
	 YXfbAHQublefR5UfTTW+o2s7xKsJBzJgekex9A9nIPbRQo14sk/R2Iz0udYjzZ5JkM
	 G4pXpwsCpkzX/oNjaJXUgvBjl5AniHx9H28+F89g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgBYK0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgBYK0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:26:14 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03346218AC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582626374;
        bh=tsHmP0fWLGpKEusGC+Namhfpp6ZeCtBgPrPkaJzeBm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vTn2zhVTTNRaUNn0THqocaqzF6G6ff1IXQ1Esvfo+HlsHgy8RBBTy9YpY6eylYyGg
         1J56Qonf4Nhnmb5u65I+gMj6uAdQrc9CG38E9viTnUJ/nYuams71k0aMH7CA72JVcf
         r90q8tEjYHiGXhzYPztWyDNmkzCjdmoandoxxstQ=
Received: by mail-wm1-f45.google.com with SMTP id z12so2392099wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 02:26:13 -0800 (PST)
X-Gm-Message-State: APjAAAXmrRa3obg+oi64tDnLz0aa7TeidCrxfak3d+aJ6RY2RnQrqutW
        9mK/zxBnT2u0nkcNG21T1OsGu1Yc3MBJ0zegDkXw3w==
X-Google-Smtp-Source: APXvYqyeTgElbhVTNH+euGmtzAmuqWi406sfvmadlTk1C1Bko4b+id7BA1YKyd1PTSJ5Ugs12TOBNtUwVG9exr4LIZY=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr4756121wmf.133.1582626372415;
 Tue, 25 Feb 2020 02:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20200221035832.144960-1-xypron.glpk@gmx.de> <20200225032500.5b6be465@lwn.net>
In-Reply-To: <20200225032500.5b6be465@lwn.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 11:26:01 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9sjOS7S+T42UcdnA2JCwgKawRJAdKHcwXWQXQaHSPZDQ@mail.gmail.com>
Message-ID: <CAKv+Gu9sjOS7S+T42UcdnA2JCwgKawRJAdKHcwXWQXQaHSPZDQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: add libstub/mem.c to documentation tree
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 11:25, Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Fri, 21 Feb 2020 04:58:32 +0100
> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> > Let the description of the efi/libstub/mem.c functions appear in the Ke=
rnel
> > API documentation in chapter
> >
> >     The Linux driver implementer=E2=80=99s API guide
> >         Linux Firmware API
> >             UEFI Support
> >                 UEFI stub library functions
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> > The corresponding source patches are still in efi/next.
> >
> > https://lkml.org/lkml/2020/2/20/115
> > https://lkml.org/lkml/2020/2/18/37
> > https://lkml.org/lkml/2020/2/16/154
>
> Given that this patch depends on work in the efi tree, I'm assuming that
> the docs changes will go in via that path as well.
>

Can I take that as an acked-by?
