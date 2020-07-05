Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5CDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1CE2075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593963346;
	bh=yuJ83TAx2kBYVCOqY8A/Yuic2DP3AIi4WtemVta2NEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mcsd5qcRAUmZz1EmVuY3gNYd3feD70583ZzjabhAqqffaRNVzZpmDhIE5pSUlfzGw
	 IOMgrBL4zaQdGvOIBm41YP1lb2aqe2z0aDBmYNGnc4GV7AWl977Sx6lFJN2f8XUxxD
	 dtsBY19XA9gxeav6M+tm2ESXRgEoiuzgg8UdznZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGEPfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:35:44 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:18038 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgGEPfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:35:44 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 065FZT1p000837
        for <linux-kernel@vger.kernel.org>; Mon, 6 Jul 2020 00:35:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 065FZT1p000837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593963330;
        bh=cXx2QzW32XcBEbFXoqRu+IpnOfIaV0Q73hhkKTlNd+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gAekWdUCiGJCPzvaY9EWP3LqcAMn5TxOZjMDKk6H1v46eAXyGxmxgk462uZuw/OXv
         3sSw6SXKczfbvodI3XAKkf+nhQaj5/Sx+FHcr6cZP6IaSC5ghDB7rgcw101Dw/bYK2
         prkPrIOJNIbCR83BlD+XqWkTu1/HHTcsoQ6l4q8yzV5OW8WHqmvKQwACJxb/tjqqG3
         9ONKWN6EwKOFuBVf9ytlX5kkK4tpakksV/qbkd4EID4qRNnBtTNIVbGyPkbQyLE4Wi
         Tyh0ONeAFPr5k3Z3wdDZt2zQM+hYWH/s4iAEYbBS2vVu1FqGQdelO1GZjJCX5984Nn
         Am2qt8VbCf75g==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id u6so8589773uau.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 08:35:30 -0700 (PDT)
X-Gm-Message-State: AOAM5318UHM5Qq441HVkIiGnl5jxl54BbzyfjdbmlTAwLfUAA33ofjcZ
        QRp8QTByHoZUCWohSDwTNTNpFWKYpzvXFmz6Ww8=
X-Google-Smtp-Source: ABdhPJySZM2RSvi3BXOy/AaF+QGFR5tz7dSQPdNj9q/HhGTTN+CWZQ/F1MU7kyGvE4tDMlU5eusXpcXwSiBF/lFDQBA=
X-Received: by 2002:ab0:5b91:: with SMTP id y17mr33118642uae.95.1593963329071;
 Sun, 05 Jul 2020 08:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200702111200.39997-1-pmenzel@molgen.mpg.de> <CAK7LNAR7=NCsJ5irVUCStkfCLt0d=R5AX6cEwc9z=b_-V=-0Ng@mail.gmail.com>
 <59a4efc5-f6cb-f00a-fa83-bc7658ca1463@molgen.mpg.de>
In-Reply-To: <59a4efc5-f6cb-f00a-fa83-bc7658ca1463@molgen.mpg.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Jul 2020 00:34:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8pTFfhHb_Z+Hh5LWZ2DCCzfGtTq4oizykOYb_QRqgMw@mail.gmail.com>
Message-ID: <CAK7LNAS8pTFfhHb_Z+Hh5LWZ2DCCzfGtTq4oizykOYb_QRqgMw@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: Do not track `defconfig` from `make savedefconfig`
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 4:19 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Masahiro,
>
>
> Am 05.07.20 um 09:14 schrieb Masahiro Yamada:
> > On Thu, Jul 2, 2020 at 8:12 PM Paul Menzel <pmenzel@molgen.mpg.de> wrot=
e:
> >>
> >> Running `make savedefconfig` creates by default `defconfig`, which is,
> >> currently, on git=E2=80=99s radar, for example, `git status` lists thi=
s file as
> >> untracked.
> >>
> >> So, add the file to `.gitignore`, so it=E2=80=99s ignored by git.
> >>
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >> ---
> >>   .gitignore | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/.gitignore b/.gitignore
> >> index 87b9dd8a163b..f07500889fba 100644
> >> --- a/.gitignore
> >> +++ b/.gitignore
> >> @@ -143,6 +143,9 @@ x509.genkey
> >>   /allrandom.config
> >>   /allyes.config
> >>
> >> +# Kconfig presets, default savedefconfg output
> >
> >
> > I just noticed this comment is wrong
> > since 'defconfig' is not a preset.
> >
> > I will change it to 'Kconfig savedefconfig output'.
>
> Thank you for finding my error and correcting it.
>
> I couldn=E2=80=99t find out more about *presets*.
>
>      $ git grep -i preset scripts/kconfig/
>      $
>
> Where can I look, so I won=E2=80=99t repeat the same mistake next time?


You can find 'preset' in
Documentation/kbuild/kconfig.rst
but it does appear in the source files.






--=20
Best Regards
Masahiro Yamada
