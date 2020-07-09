Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78775C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42920775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzP+fhFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGITaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGITaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:30:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7091C08C5CE;
        Thu,  9 Jul 2020 12:30:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id i14so1418708pfu.13;
        Thu, 09 Jul 2020 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SfPnUrCLC8MoE50iZXFPXzREUXXMlurx/d7NT2/fQso=;
        b=WzP+fhFv9UUOahYFPaOY0+wWb+9ZizDO45DPXrYXqJgMWOsq2VMrYB0imu1nhHckQf
         X+pIA/XzRXdcAgozk+d2f8N/ymexlvIbVkRg23Y60Iqk7EBv9fIaCZDEELfs9twmu1Eb
         B9N/xG46OpI4/NwKwsQ05fH9yjNON5oBBKI9N0ai2VtIFxsOye+Uf2cQ2X6UAMn2eYfX
         BWEPOSiaQUTVJwWHRlLRoUSRrRMeAcQRvJiAM1xHwENGd9Nn2EyULtisoXTH02dfRmnT
         OHBTHStr/hKawJgt8/kDOV/wJfvfHvCffbNzNiJSMkA7Fzo4d9HlaSevD6XvUerQKE2E
         O76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SfPnUrCLC8MoE50iZXFPXzREUXXMlurx/d7NT2/fQso=;
        b=LnfTgvJAp9cbuGZfaYlibEk8Yq8Mn01Gljw/ZDgyP7qhF/Ri0nrpFovuyLdfLaJpnS
         fxa/iDpdoDPgaJnpnM6GhOPC5hyYURKt85vsuQzDOlNMdPM1rPVWcFGDH6zqZjaYoCkl
         XQPH2mD3E1xj0l/1AHLTGKyrwODwXQdPNdK7Ha5J9eIba1M8HdKRc7dWNxIv1eFi7cc7
         TPa4TnKbZnIt8Yc8XBKHaEQHtiQ/obriqPiyg0+qrn2A2E6tAViTghBBiNmWOvfljKSv
         MtOvChKWM5khc4wt839onb9HQu6TaHmBU7Rp0tjeZeonDtQ8GMV2s1XjD6+C3S1b//8N
         evmg==
X-Gm-Message-State: AOAM531+IV9Dq72q223RBu+wp1r68R2+2joF/wWuusT4ilANgcKPnOMt
        XqPEOQUE1/gKpv4xofqLg1hfhRMf1KuCkhhoPqU=
X-Google-Smtp-Source: ABdhPJzC3Ft5wsmSKHLS7XSGFi9+4k7/M8CqYWia+iuaFVIVXnBNaQBqSGPaHjfW2eyaPKMcPyhNDeoZHc4gcbp6UFY=
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr23919062pfu.36.1594322998724;
 Thu, 09 Jul 2020 12:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591811549.git.y.linux@paritcher.com>
 <7fb650f568b44eb78e37aa8a534a69d7@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <7fb650f568b44eb78e37aa8a534a69d7@AUSX13MPC105.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 22:29:42 +0300
Message-ID: <CAHp75VdEtHfGavFBaC9Y2=bzX5pAeLqnssBE1owudRv9pKDAXw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>, y.linux@paritcher.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:23 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Y Paritcher <y.linux@paritcher.com>
> > Sent: Wednesday, June 10, 2020 12:57 PM
> > To: Pali Roh=C3=A1r
> > Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> > Matthew Garrett; Limonciello, Mario
> > Subject: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
> >
> >
> > [EXTERNAL EMAIL]
> >
> > change since v3:
> >     No code changes.
> >     Update commit message to reflect info given by Mario at dell.
> >
> > Is there anything more i have to do for the patches that were reviewed
> > or will they be picked up by the maintainers?
> > Thanks
> >
> > Y Paritcher (3):
> >   platform/x86: dell-wmi: add new backlight events
> >   platform/x86: dell-wmi: add new keymap type 0x0012
> >   platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff
> >
> >  drivers/platform/x86/dell-wmi.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > --
> > 2.27.0
>
> Andy,
>
> The whole series looks good to me now.  You can put this on the patches
> when they're swooped up.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
>
> However I would like to note there was a comment that you had a direct qu=
estion
> asked by Pali that probably got lost in the thread.  This was on patch 3/=
3 on v3.
> I think it's worth answering as it could dictate a follow up patch to cha=
nge behavior.
>
> The summary of my argument which led to his is nested somewhere in the th=
read was that
> to most users this isn't useful since they can't act on it.  IE they can'=
t use something
> like setkeycodes and go on their merry way.  The user who could act on it=
 by coming
> to upstream and submitting questions and patches is more technical and ha=
ving them
> use dyndbg to turn on the messages about unknown shouldn't be a big deal.
>
> > I'm not sure, but I thought that
> > throwing warning or info message is the correct solution. Driver cannot
> > handle something, so it inform about it, instead of silently dropping
> > event. Same behavior I'm seeing in other kernel drivers.
>
> > But looks like that you and Mario have opposite opinion, that kernel
> > should not log unknown events and rather should drop them.
>
> > I would like to have behavior of dell-wmi same as in other drivers for
> > consistency, so the best would be to ask WMI/platform maintainers. They
> > could have opinion how to handle these problem globally.
>
> > ...
>
> > Darren & Andy, could you please say something to this, what do you thin=
k
> > about silently dropping events/actions which are currently unknown for
> > dell-wmi driver? It is better to log them or not? Currently we are
> > logging them.
>
> Can you please advise which way you would rather have the subsystem go?

Seems Pali is okay with this version, so everything is settled I suppose.
I will add it to my queue, thanks!


--=20
With Best Regards,
Andy Shevchenko
