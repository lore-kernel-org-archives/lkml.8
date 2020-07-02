Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FC6207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0J2CRFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgGBK7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgGBK7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:59:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF6C08C5C1;
        Thu,  2 Jul 2020 03:59:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so1884823pjh.5;
        Thu, 02 Jul 2020 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQfyd1FNaJKu9ASDwUOKz0z9LJlSLAkgJJqmBpYTw9s=;
        b=U0J2CRFa/lwmL2DchR8OjHsqhBV24N+SjcjO+KDTedvIERiHLgnWgmQ04htga5/Ixn
         7uVu9thA4GpArt/jbzpdV+hwdrlpco2wAVOtiXNih3aY99WUDtlSh9mHIUIY2A+qG58G
         /DS/GsCVg+P4aCjExqR+RrXYb9TWuSqGlMf0dZVkV/XX8TajpJ5QZtOkdf3IqM2SOSet
         4Ga/6euvE62eIxfx/iCX64v8IijnQJPS3687H1bXSBnP9hJ7eKc82CWxYrH9Rk4iJ9M5
         DmF8Cu7N0iMHJGLl4VPdq78mCCTgcjmM2QYevVSv8fImAWzroyUfExMSHOnwHlgSzMmK
         M35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQfyd1FNaJKu9ASDwUOKz0z9LJlSLAkgJJqmBpYTw9s=;
        b=Q0gX+8qcyjcxb+Z6EFeMsyoqgojizsglJVPRNlZPVeoIRja3FaCmBXjsxe46OcWve8
         Vgh+ZPPEcl5Y+62JClSZnnb3NC1O5i03Sn4ipRdzwaRJExYtTu/BUe5iHs7Od/Y3m0A3
         KCQjzdaWDZIop/Oj9qn3KNtUR4rU8Px4BKb0/n6/8cTgikGXWdH9dMvESVvmX8KPOiVe
         aCOjXmiredY1fIPKNCbEnoLDT8eenA87npfBEYmvpUedSCXc41xISgpfFqA9iHRM/7Hv
         PMjyaN+H9qMBY2Ja77hpC95e82PKk2PzQHuBjdQYTohlhsGjbpIo9pm0C4o0ucAN8pUY
         tM+Q==
X-Gm-Message-State: AOAM530RFIm/T8XPUOAahWAzAP++wb6RpNIOE8vRvUySSVOnPfuuxZem
        /FUgeS+1TU9Ztv39JlwRPDgkJVeY6xGMrXdzqcpZGFBk
X-Google-Smtp-Source: ABdhPJwwKX0Eq6coYFI7oC6A0cH8iVxxXuJr67Zz2dyeBp+pAptYHXltRPM5+dPgpQAHk06RqMiBOPI/ImL/D6la98E=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr6496916pjb.181.1593687587859;
 Thu, 02 Jul 2020 03:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200702085520.16901-1-aaron.ma@canonical.com>
 <CAHp75VeCHW=GMgyHRswsTrZ7b3TEnFh15F-5fyHcUsqXzoFS_g@mail.gmail.com> <2ecf4032-267c-32c8-361f-2396730aaa65@canonical.com>
In-Reply-To: <2ecf4032-267c-32c8-361f-2396730aaa65@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jul 2020 13:59:31 +0300
Message-ID: <CAHp75Veqp_saX+VsijpLrihKMHiVH1W4o-3CYXNooOCu=YKtjA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: not loading brightness_init
 when _BCL invalid
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     mapengyu@gmail.com,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:51 PM Aaron Ma <aaron.ma@canonical.com> wrote:
> On 7/2/20 5:30 PM, Andy Shevchenko wrote:
> > On Thu, Jul 2, 2020 at 11:55 AM Aaron Ma <aaron.ma@canonical.com> wrote:
> >>
> >> When _BCL invalid, disable thinkpad_acpi backlight brightness control.
> >>
> >> brightness_enable is already checked at the beginning,
> >
> >> Always print notice when enabled brightness control.
> >
> > Why?
> >
>
> Default brightness_enable = 2, so this message will always be printed as before
> Actually no change here.
>
> > ...
> >
> >> +       pr_notice("thinkpad_acpi native brightness control enabled\n");
> >
> > 'notice' level is quite high, why do we spam users with this?
> >
>
> Like above.
>
> Another reason is  most thinkpads are using native gpu driver to control
> brightness, notice when thinkpad_acpi brightness is enabled.

So, based on the above, please elaborate and explain all this in the
commit message of new version, thanks!

-- 
With Best Regards,
Andy Shevchenko
