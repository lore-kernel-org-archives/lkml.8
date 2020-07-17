Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB37C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7697B20691
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kniTdr5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgGQUqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgGQUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:46:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFDC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:46:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so11773803ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=U+J3EopZN4dih53CPall4bhLcq0C6XuRdNf/0j0h6RE=;
        b=kniTdr5Ivtw6PhIr6zqaVqDfaftQODVhpvCoYqo11WLWFxBNn984FSQ/4uUeRIU3DZ
         UXV7+BlJ/vX6Y87Uosm5D6Y6bJoXu/St2ubyyoofx4zD+pV3ac1Xb/Y7Prz5aMlblUOc
         rs9KaW7vR/mwwqnLbYY9NYHFvwjx25CC4gL/EIM1+Cte1GvukG7jCstBCrhMuPheI6b6
         qZXoqcJKYgK9EEbp/xbEaFcMkSIUDqNuzRLY/xGdDbEKRPWuRpt2QmMAXVeJ7wH3hdx/
         V65P7wB8iX2E8yiesItHK8txkqlwRUbfJCGobEWSlJNiJJyR2pgY09pBE0zKgYOyUT1H
         MLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=U+J3EopZN4dih53CPall4bhLcq0C6XuRdNf/0j0h6RE=;
        b=ePyh1zVr1jn9b3eGARRUHSbceXB8Bs2dqJtXx2HafTvhHFsp847ROKntXGRYN0caIU
         hlvR9c4jvU5Qm8uyktWsvFAWNVBOP0ZSjRvFJksRGpLTQqj9P3bYJGpc/n+cOElYj87c
         6xLfJvNsxx6iO1IAXrnqmC75V+YTFXdayqzZSLxsFjRgqc8V8SAL3lWVsSCZrplaqkKY
         VBfCa5RFbozVB46Wyd/D/5uPHi4uF7aKyZ6jvi7T66SMb8WoLvh7ww2X8ro3yyqmuf4V
         XtPrS7iZRRUD6dIPDfA7C6Vf8EdDC7KX+6oZjyAqZ0Qex3pTtaBr3EE6ENbYxUmfNywO
         h9wg==
X-Gm-Message-State: AOAM530LvxVDA1qHnv4wC/GeqY2JqLHWIEuYK1tbE4oJKFOyF9JBreK0
        Pn7r5Nl9BdrFjHay1VQAPrZlVmLVeAjFJAATusN7AUWa
X-Google-Smtp-Source: ABdhPJzzHlkgo8ZPDBS7ofOr/8awjFe7WeN/HD2kVWn9XaBH+PU4i8cXAMzXhF26gHqMHOyGLhzQuIuiZOUwm3bLo3w=
X-Received: by 2002:a05:6638:1442:: with SMTP id l2mr13090221jad.132.1595018790761;
 Fri, 17 Jul 2020 13:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msW7s-5dphNrvGCEqOGQ6tO=K5_aDVbw4ZS995oDk2Agw@mail.gmail.com>
In-Reply-To: <CAH2r5msW7s-5dphNrvGCEqOGQ6tO=K5_aDVbw4ZS995oDk2Agw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 17 Jul 2020 15:46:19 -0500
Message-ID: <CAH2r5mvp0wD_3Rdhm9x4S1E9ewQvG7YoaPQPcoikxewcpA1jTw@mail.gmail.com>
Subject: Re: 5.8-rc1 and later breaks chrome browser
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been fixed in 5.8-rc5.   Chrome now works again (failed on
rc1, rc2 and rc4, worked on 5.7 and before as well)

On Sat, Jul 4, 2020 at 3:29 PM Steve French <smfrench@gmail.com> wrote:
>
> I noticed that chrome crashes immediately on startup  on my desktop
> booting to 5.8-rc2 or later kernels (whether I build the kernel or
> using the prebuilt weekly Ubuntu mainline kernel downloads).  Works
> fine with default kernels or 5.7 or 5.7.7 stable kernel etc. - just
> breaks if I boot 5.8-rc2 or later.  I even tried building with today's
> mainline kernel and same thing.  Any ideas how to work around this.
>
> Message logged to dmesg is:
>
> [  131.366543] ThreadPoolServi[2526]: segfault at 415048 ip
> 00005652def3370d sp 00007fcdc3b37df0 error 6 in
> chrome[5652daa7e000+785b000]
> [  131.366546] Code: Bad RIP value.
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
