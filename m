Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46647C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1417E20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz2yOEz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBFHxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:53:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40777 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgBFHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:53:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so4621184otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzW6dHQjSfGvyhr9jvkDeTU/fqID38DqFrV0O6n8BYI=;
        b=fz2yOEz39A46Nic9NDCQj8Ps0Alpb0HcDMSfX5hQP1amWqxUYeh52V8Ip8OfX597wW
         olh+MYnyXbImoLPyztSyR9kjRId73OUVDCq7KtM2HpBYUtXaEE47uRrUbEeVafIC4R7n
         MwFzDKwSBnTaB7Xr6t8hk03Ep0IqfTwDwa0PXljXjx1UTYzxb5YH23r54J8T1N7thOEU
         iPdDNoa19HDYHosEWWCV/1FAnNmOj/6LgMhq5arvwfBgjk9exsfBrTFpVTfJJtAhc8QK
         6zsQoCVsFH+0frbgFhTLqU0vkocPisG/v55PQz4SF8UVak1uiIYDxFBhB7KR568sGT6c
         K1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzW6dHQjSfGvyhr9jvkDeTU/fqID38DqFrV0O6n8BYI=;
        b=Y5rssSJN8YIJzZIGaLc9gtLuoffXYRhDDhaj7qHbprbfcajG2gcQGkqTCYXFZqfUMI
         5ZnpjCDszO5AEEeDhMcG67OoqNeHTviDYDdymqMlue7Q3Tf67BI+5f3fJdpFpGhHIba5
         eu8jPn/cpp1d4IuDuPasiv2LNirGb+HUtWglIGCmZh3OeqWth/1R2b4Xckv/WqrrXfRL
         9CVTIznesXRHI8T8uhlLuVPRNx1PWRL7HhKiV4eIjD1LnvyugRWZHNu6211WkpIWMRJE
         Zx8BJ9CirKFNiwj2AH1jbYq2zVNFmkzUzqFjs4uJeLlsgf+JQipyt9WIHi9XVyoeJRp1
         Hm1A==
X-Gm-Message-State: APjAAAUBsqwUiXuTOP1ZI9oxboOGDSEGGihuG8+W1hxPKqR2L0EFXyjK
        3heJae35mV0Nj3dhflpuj5Oi6v4j/1ulQj95s5o=
X-Google-Smtp-Source: APXvYqx9glLF1qZqDriJ3CVIwTku2+BXSPCnAZ0pW0nTinxUEWmlDrIKG9QaBGHVyfCOXQhHe7ezJr0WzBnnQ4yDkJ0=
X-Received: by 2002:a9d:4c92:: with SMTP id m18mr28265420otf.168.1580975592187;
 Wed, 05 Feb 2020 23:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20200204090022.123261-1-gch981213@gmail.com> <20200204094647.GS1778@kadam>
 <CAJsYDV+b1bqc3b87Amo8p2UzVi4fpbRv6ytus8A5Y0r4K-X0hw@mail.gmail.com> <20200204103456.GO11068@kadam>
In-Reply-To: <20200204103456.GO11068@kadam>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 6 Feb 2020 15:53:01 +0800
Message-ID: <CAJsYDVKQFB-X-mMRCZ44ypGyoWOQdSsYpfVsCPkg+TYDSw=4KQ@mail.gmail.com>
Subject: Are people from linux-mediatek also interested in Mediatek MIPS SoCs?
 [Was: [PATCH] staging: mt7621-dts: add dt node for 2nd/3rd uart on mt7621]
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 6:37 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Feb 04, 2020 at 05:59:21PM +0800, Chuanhong Guo wrote:
> > Hi!
> >
> > On Tue, Feb 4, 2020 at 5:47 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > Please use ./scripts/get_maintainer.pl to pick the CC list and resend.
> > >
> > > The MAINTAINERS file says Matthias Brugger is supposed to be CC'd and
> > > a couple other email lists.
> >
> > According to get_maintainer.pl,  Matthias Brugger is the maintainer of
> > Mediatek ARM SoC:
> >
> > Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
> > linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
> > linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
> >
> > I specifically removed the above 3 addresses because they are all for
> > Mediatek ARM chips
> > while mt7621 is a mips chip and belongs to ralink target under
> > /arch/mips/mach-ralink.
> > Code contribution for mt7621 goes through linux-mips instead of
> > linux-arm or linux-mediatek,
>
> I would have thought that we would still CC linux-mediatek?
>
> >
> > I thinks this is an incorrect setup of get_maintainer.pl and should be
> > corrected.
>
> We could ask him...
>
> It's always easiest to fix MAINTAINERS instead of remembering all the
> exceptions and rules.

Hi Matthias and other folks on linux-mediatek:

I noticed that get_maintainers.pl reports "ARM/Mediatek SoC support"
e-mail addreses for MTK MIPS SoCs (mt7620/mt7621/mt76x8) because of
"mt[678]" name match in MAINTAINERS file.
This is confusing because these MIPS SoCs clearly don't fall into
"ARM" category. Is this an incorrect match or is it intentional? If
it's intentional I think we should remove the confusing ARM prefix,
and if it's incorrect we may need to figure out how to exclude
mt7620/mt7621/mt76x8 from "ARM/Mediatek SoC support".

Regards,
Chuanhong Guo
