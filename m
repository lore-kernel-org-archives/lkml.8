Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6879C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B414206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cytAt91q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgHPPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgHPPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:36:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08CCC061385
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:36:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 62so12879264qkj.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b56DIDSCCqSDUz/uzUz7lQYGowdXao8cMoz74W2Vp+A=;
        b=cytAt91qfvsIIqALSY3Sq5YGJQwUDZMHl9xJVy+aR1chYbKLhVlEW5gMww8Fsj7Pe9
         dT+CA74v1O8uVX6jNfYxokzIGWMIlW5OwmI8BtTxc4XioKRsimjC1Rb3wluruytRpAUV
         nNSK4NTEEqRAsH+CQL+q9qSaBTdRHlCtel9EoxD+mifQp6iXO6JhebQlKwKdWsbnUGQK
         cptb0E44J9/vqQsRG5NtUDtCl7gYfAt0PJyV+hNv5QIimFALo/sbsuteTOKCkt7iJgEq
         LJre5aMgClBqTOifHMpD9Z3NUhhFzTT/3vqjXHBI8Qec7vx8eBfQ5yruuS8Aa/5Dy535
         s6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b56DIDSCCqSDUz/uzUz7lQYGowdXao8cMoz74W2Vp+A=;
        b=Cx9OwHl2LIRD/XFVpsL7PPdlY4VdBPA43NbeGk2xKdMxT1S7eLMnb1Es0muMGgu7Z6
         HqeNLUX6y+SCultFDwvX2M+ihW2gLAzq49CKLnwkwpzJl2SZSz5Bhhi0Q0Stj3Hhubey
         gCxDyhBi2NkZqVfin4TZaaxZriQO+9f9gB7XUY2VidCqe98vAgvXlSpt9Gn6QnnJxdnM
         ihTAsPGN2ma+d8Pi/TR5NKEAGd1PPt0210HUW+6gVgEMWHbrxzqPo/Cz37DxRMTY6W2y
         cjqe8bmJVEMAgNwiPnFnS6UDdL044qbmo3mC7OFGUOHffi2sxHdKH9jBshmD38cMiTKN
         yLKA==
X-Gm-Message-State: AOAM532+rPvTDh2AAnGL8FwUzrDd6ty9XJeHys1NtN7jD/lfV4qm7VhZ
        Dnii+KNWmbrEBwJYTKHFgUGfbJUoeQzNAc44sD0pww==
X-Google-Smtp-Source: ABdhPJzTk2OH/pkDHhLZH40+pQBa5PfUAJJf6R0K8mEMsjxwcxzX/ayZtBEiRsA/49DNSAy2Pf87K3S0lRVyVixwW7U=
X-Received: by 2002:a05:620a:c07:: with SMTP id l7mr9799747qki.250.1597592171145;
 Sun, 16 Aug 2020 08:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200814101000.2463612-1-fazilyildiran@gmail.com> <20200814.135526.430805159179452727.davem@davemloft.net>
In-Reply-To: <20200814.135526.430805159179452727.davem@davemloft.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 16 Aug 2020 17:36:00 +0200
Message-ID: <CACT4Y+aTaB5YVYjMXSnonLmocO1FWs06DaOwHCiuweGD93M0kA@mail.gmail.com>
Subject: Re: [PATCH] net: qrtr: fix usage of idr in port assignment to socket
To:     David Miller <davem@davemloft.net>
Cc:     =?UTF-8?B?TmVjaXAgRi4gWcSxbGTEsXJhbg==?= <fazilyildiran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        courtney.cavin@sonymobile.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Necip Fazil Yildiran <necip@google.com>,
        syzbot+f31428628ef672716ea8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:55 PM David Miller <davem@davemloft.net> wrote:
>
> From: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> Date: Fri, 14 Aug 2020 10:10:00 +0000
>
> > diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
> > index b4c0db0b7d31..52d0707df776 100644
> > --- a/net/qrtr/qrtr.c
> > +++ b/net/qrtr/qrtr.c
> > @@ -693,22 +693,24 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
> >  static int qrtr_port_assign(struct qrtr_sock *ipc, int *port)
> >  {
> >       int rc;
> > +     u32 min_port;
>
> Please use reverse christmas tree ordering for local variables.

If Dave's comment is fixed:

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

(add this tag to the v2 of this patch).

Just in case: "reverse christmas tree" is when variable declarations
are sorted by line length (longest first).
