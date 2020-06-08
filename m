Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9A5206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgFHOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:44:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgFHOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:44:15 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MjSHc-1jFJlk16yI-00kzmJ for <linux-kernel@vger.kernel.org>; Mon, 08 Jun
 2020 16:44:14 +0200
Received: by mail-qk1-f171.google.com with SMTP id v79so17404303qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 07:44:14 -0700 (PDT)
X-Gm-Message-State: AOAM532U2llpL9aAPRwOs7t05WTwRQU88NcyH4Z8gpK2CEyhwx1k8ylx
        cDG8XLrYhN9Yi5I0mCVE3CbL7zcBRh5CbkN95bQ=
X-Google-Smtp-Source: ABdhPJwK0DNjprGGWKE4jZbk/yfV4VjjjLxDUBlzD4JFgL+XYq9hUtWK9vhHfAEzQRES0o12IPdLhkDerNtBKiemf0o=
X-Received: by 2002:a37:554:: with SMTP id 81mr22887416qkf.394.1591627453055;
 Mon, 08 Jun 2020 07:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc> <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc> <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc> <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
 <20200608111834.GB5736@afzalpc>
In-Reply-To: <20200608111834.GB5736@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jun 2020 16:43:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1q51=_DUS1A8k67c3TyQ+7LTpeo98LmzoFK=qg+8Fktw@mail.gmail.com>
Message-ID: <CAK8P3a1q51=_DUS1A8k67c3TyQ+7LTpeo98LmzoFK=qg+8Fktw@mail.gmail.com>
Subject: Re: ARM: vmsplit 4g/4g
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pLOr8E34PhMBWIruIET3MTJmtrBR7gXmJjyCbfiX6H7tO0cA6FV
 fct9opuT862nXZ6XmoZmEJT7Mgr02xtIPLzWaoD0mHWPdNifQ0RGi6FyTAfoiqyBwad15By
 FFnSh7P/R619FgRq3QezZ3Y0njoYflPDmASK8Yamszt12YbRRo2I0cmSBECnISZRzssQTwg
 6J7oFifFy2Yocj9QYxoMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hr2EawWA/dY=:fVIb/fXFFbJ5vKkAog3hMK
 fYtZNJ3yXNd1VlCMhs206PaS5hUXll3Cknd0jRineG2ZtdqH0V/5II2tp5K4bcvJUWP1Il8MZ
 u+rqbb+7l0KLMa31zMaDHSdQIqh7SD+Jcljx+SIkD4dyxFp8vulFZJQTz3MDnaJSbrgJxRkZF
 NQ3HeGfnpxogWZGV4gbStvflzF3fSTSyEnmyl7rBGby1Q3nudIqTbmz45dptYvwX+aReIDLz8
 2lDiOsSwqaeYr5jhSOc3exNNB9/3mxhglCcSJGgGWBnHl9aRQO9RgLmlV+p6Jg7YSKb1a98pY
 bGboW3Y8VOiqdU+HjybscLkFgCDuSXs7/H0LCS4gT33xwFGK65OYqaDvcVpyrVo2S1qCeZj4b
 oxN+wGf27JP0KpOCd5jL5+LB6CWFe8wCTLy4ums+w2NgNSjSLj3uzZgXTsQV3jDeDRbNgZll3
 Dt+tAMj+ThBDFx7Z5ShFsfLgcQ4GcCUYBiu9IJrbPdkuvp4wWjMQJbVX6snmUsJaMv5vh6mf7
 VvmotD9i+3z3BJoG+1njxFIfjV6jhbUu+4WXSbKGE1a6gULc3rbl0Vx00oDz4cVALm0RYwPQv
 GpurnFYEe4318OBLheXXFYchXXBNEnTgKFBqaharLrhF/X2TAAR1wc5fouYXq1NJMbi4rnysj
 3aC/KRC2WsUDZkwwL/3IaCcnrdK5qmhu9EQb4IENMS/4ZLoa7REMOMDRk0ZBxc8WYltLItc+Y
 wALZYt4uhKTdy5/8m7ohXhX32bC05ain+daN+Sdb5Map7WP5qTOPTMp7i6paIlTkT1naJ3uZ+
 gi0kadxNJojhZ1vsM56U3E+8WBIJLwANv5dYeqh4IzIpGK+ttI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Sun, Jun 07, 2020 at 09:26:26PM +0200, Arnd Bergmann wrote:
>
> > I think you have to use get_user_pages() though instead of
> > get_user_pages_fast(),
> > in order to be able to check the permission bits to prevent doing a
> > copy_to_user()
> > into read-only mappings.
>
> i was not aware of this, is it documented somewhere ?, afaiu,
> difference b/n get_user_pages_fast() & get_user_pages() is that fast
> version will try to pin pages w/o acquiring mmap_sem if possible.

There is another difference: get_user_pages_fast() does not return
a  vm_area_struct pointer, which is where you would check the access
permissions. I suppose those pointers could not be returned to callers
that don't already hold the mmap_sem.

> > Do you want me to review the uaccess patch to look for any missing
> > corner cases, or do you want to do the whole set of user access helpers
> > first?
>
> i will cleanup and probably post RFC initially for the changes
> handling copy_{from,to}_user() to get feedback.

Ok.

      Arnd
