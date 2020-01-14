Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62888C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3076D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQTf3sEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgANI52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:57:28 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35982 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:57:28 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so10835827iln.3;
        Tue, 14 Jan 2020 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tLJRdOhrpRuZLt75MI5obWTF6EcjzoGZuRIS5Hzxcs=;
        b=aQTf3sEn9a0g2FxG5v0LVpqc58XSbGWNhATPrWkhBednuc/CyIE1RtYBVyLSlXWth9
         ou6Ym1tDAikDfkjZJr8myF2Qs39VPN1Bw6D3lDqamHm8YF3dIBLPuZ7vbteaDASG6XGK
         S/KitbEo7bRMwMJNVpBi6pKrCHSTZJ7+odCi+DW7Wd3GiRuZQs6NyUQ8b7TzfSfP301h
         aVHmNBvop3ndYUvYWeU0SrilMcBszdMVdMrb9WL4sK2n6oyIaoUUXxOtrhVx9Ke7/ndV
         kjefa9lojQzn53re4iusfuGbH+xFI2oKiYlr8qU/ixC5jGhgzAU06iv1waTYmnLP5hrI
         0JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tLJRdOhrpRuZLt75MI5obWTF6EcjzoGZuRIS5Hzxcs=;
        b=un+rC/9tZAIb2PMyRE1gLTH9WJ2/eaHosKXOEdx3N80DBRqkMTlcIndHXP5llUGMAB
         /t2GmauDXuhBUP6z7euJ1rYU7nUJCB4pYlGHRGUy5MtX+nksiX0BTeW/Lfx3DA9v9OAw
         87Ed6WjPybHIYMFo9BQsPE3I4ZjKdsFecSCfgW/el5NUMkFXe4s8fWbWqyzASVeBIiFa
         9BzHxG4MkJ9Icn/auCnylY1ygN2iyw0gSWxXhDTn/mEMtNU1mcyoxYO7zZ89iZtuj2WQ
         glvxwyyZluqTGT51ZX9mb3wiIG3ACX8P+phhNYHEfJn45PwERnUvj6SHoaYAcVrhMLc3
         IQ+A==
X-Gm-Message-State: APjAAAV+BjpGdh0xTZBOx4bwxUpBhPcmhTxLw4JtXp+3Hr9Vltz6KyD/
        x5NloKmrGGA0CaONGXxRDrHgRpHhmbn5koMIpi0=
X-Google-Smtp-Source: APXvYqyVec6v6hJouPfOSiTNhYY92qh0MJoQ4kjIp+7oXZYlk8mkFQvVqO4pI3zA3PRg0Tx+oxovxBS4uJpppm7o0Fs=
X-Received: by 2002:a92:c111:: with SMTP id p17mr2648717ile.204.1578992247189;
 Tue, 14 Jan 2020 00:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20200108113719.21551-1-pawell@cadence.com> <20200108142829.GB2383861@kroah.com>
 <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20200109063841.GA2579094@kroah.com> <BYAPR07MB4709AA109700B4BCAD1C1ED8DD390@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20200109093812.GC44349@kroah.com>
In-Reply-To: <20200109093812.GC44349@kroah.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Tue, 14 Jan 2020 16:57:15 +0800
Message-ID: <CAL411-pE7QheAEQf+ki8auChWP6MOWxaaAA3xkkdweWn=q_0wA@mail.gmail.com>
Subject: Re: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect operation.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 5:39 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 09, 2020 at 08:34:12AM +0000, Pawel Laszczak wrote:
> > >
> > >On Thu, Jan 09, 2020 at 06:27:02AM +0000, Pawel Laszczak wrote:
> > >> >> +       writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> > >> >> +
> > >> >> +       ret = readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> > >> >> +                                       !(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
> > >> >> +                                       1, 1000);
> > >> >> +
> > >> >> +       if (unlikely(ret))
> > >> >
> > >> >Unless you can measure the difference of using/not using a
> > >> >unlikely/likely mark, NEVER use it.  The compiler and cpu can almost
> > >> >always do better than you can, we have the tests to prove it.
> > >> >
> > >>
> > >> The both of the above timeout should never occur. If they occurred it would be a
> > >> critical controller bug. In this case driver can only inform  about this event.
> > >
> > >"Should never occur" is a fun thing to say :)
> > >
> > >If it can never occur, then don't even check for it.
> >
> > Yes, on existing platforms it can never occur.
> >
> > >
> > >If it can, then check for it and handle it properly.
> > >
> > >What about this controller in systems with removable busses (like PCI?)
> > >What happens then (hint, I bet this could occur...)
> >
> > It's good question.  Nobody from our customer currently use such system.
> > The only platform with PCI is used by me for testing purpose.
>
> So if you do have a PCI device, then you need to handle PCI reads
> failing and returning all 1s.  Hopefully you can gracefully handle this :)
>
> Adding timeout handling here, where it is totally obvious to do so,
> would be a good thing.
>
> thanks,
>
> greg k-h

Hi Pawel,

My email is: peter.chen@nxp.com, please change it when your send next version.

Peter
