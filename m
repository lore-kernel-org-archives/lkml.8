Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15149C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE832085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYSOGOcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBJRqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:46:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46571 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgBJRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:46:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so8173349ljd.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4z8BRuWcC+QkJYDhpaWFFyqDv+1mRelBaa/f8a991E=;
        b=pYSOGOcQ9uaCsYbmN/IxKPKn96NbhXp5GsbvrbC8v3ZglBigQQfx4O5Ykr9Ydkbanl
         rB0Z0x54vjW7H6Rj1oSZ9ZKVc2VY+SVWK/nIRP0Je91bvW93u+g4tZFywYAHcShIevJx
         jrm8aNTaklNHe6xjHpiDgolC8z9hlxwIGLjJ9gSGzhI2zKIbiCOitK+NZ8+pRUgLtJVA
         yrrXxDotNYtv64nQnxo0OJFylJsGgbc1TZx66YsVtPQClqed85pG8bueHS9XNpoSk7CZ
         LsljRi0F/4hDnXUsAZrHAc+hHdL72jRdALRs1FldhkqtD+Sq3ACaavMcv0Gt3mfWAd6V
         xMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4z8BRuWcC+QkJYDhpaWFFyqDv+1mRelBaa/f8a991E=;
        b=QvpxwP0ObyR93yLWap1s1K9y+bEO2QcYWk9mdi7FDmmbJdJUK68NXC7BqIgeT3hm/j
         5AH4iJoZPYIu6WJOgOPRunnT/OiCyM/kZ0AlWCVL9Xo+wsApQxnI1J7kJXWH3MKimvGK
         ZCzpaJp4LV9iSOsVqu8+8z7KnnbTo55IB8bwR2lDWckXmzwuH7WGaOsquWG2Mw4ih44+
         uVKR9xh2v1ZfW9xkpOfJL+0GR6a1mtG10maNB5q9h9SCdxHrNmebUXi6DI6Sxikxit5+
         yPRpU/pr1L4wYdoSeT02takIj4qNHbLFuSXfPbGSHfnNhu6+L9pjG8Cog77gVUIqqen9
         5APg==
X-Gm-Message-State: APjAAAV01CGsaY9q/UjF8JvJ1ijhfCESrbf6dZDiTM+RUwE57jv9LK0r
        X44w8WWFS0WkYh/GMnc7A4oo6BweORXcUTvXuGg2KA==
X-Google-Smtp-Source: APXvYqwvwdxKcgfSobDtIom2b5AmerOMretDeCPOWFtP3z5u0bdI8BjifSOAfOQTNB8RrifO7KUHOQ8u72a5FCwc6qo=
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr1651834ljh.138.1581356770206;
 Mon, 10 Feb 2020 09:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20200210122423.695146547@linuxfoundation.org> <20200210122450.176337512@linuxfoundation.org>
 <CA+G9fYu4pDFaG-dA2KbVp61HGNzA1R3F_=Z5isC8_ammG4iZkQ@mail.gmail.com> <CAK8P3a0iq1fj7iVuYMYczbg2ij-x5b0D5OeKiy_2Pebk+ucMeA@mail.gmail.com>
In-Reply-To: <CAK8P3a0iq1fj7iVuYMYczbg2ij-x5b0D5OeKiy_2Pebk+ucMeA@mail.gmail.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 10 Feb 2020 11:45:58 -0600
Message-ID: <CAEUSe787_LxgSWmo4cxU52Ti3mq3ydtco5J7A87Eec7HeLMCNQ@mail.gmail.com>
Subject: Re: [PATCH 5.5 284/367] compat: scsi: sg: fix v3 compat read/write interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org,
        Basil Eljuse <Basil.Eljuse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helo!

On Mon, 10 Feb 2020 at 09:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Feb 10, 2020 at 4:41 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > The arm64 architecture 64k page size enabled build failed on stable rc =
5.5
> > CONFIG_ARM64_64K_PAGES=3Dy
> > CROSS_COMPILE=3Daarch64-linux-gnu-
> > Toolchain gcc-9
> >
> > In file included from ../block/scsi_ioctl.c:23:
> >  ../include/scsi/sg.h:75:2: error: unknown type name =E2=80=98compat_in=
t_t=E2=80=99
> >   compat_int_t interface_id; /* [i] 'S' for SCSI generic (required) */
> >   ^~~~~~~~~~~~
> >  ../include/scsi/sg.h:76:2: error: unknown type name =E2=80=98compat_in=
t_t=E2=80=99
> >   compat_int_t dxfer_direction; /* [i] data transfer direction  */
> >   ^~~~~~~~~~~~
> >
> > ...
> >  ../include/scsi/sg.h:97:2: error: unknown type name =E2=80=98compat_ui=
nt_t=E2=80=99
> >   compat_uint_t info;  /* [o] auxiliary information */
>
> Hi Naresh,
>
> Does it work if you backport 071aaa43513a ("compat: ARM64: always include
> asm-generic/compat.h")?

Yes, cherry-picking 556d687a4ccd ("compat: ARM64: always include
asm-generic/compat.h") gets it back on track.

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
