Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA37C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8439206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwdFiFV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBLHHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:07:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41555 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBLHHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:07:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so843374qtr.8;
        Tue, 11 Feb 2020 23:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AxOxOz3N9F0K8mLSxL0hnOp0DZT57bazsTbRp6sLU0=;
        b=jwdFiFV/SfJKDeMxz405XK6dPGTtFwNKTaHgkG0RaH9AAZhyLyb3UYl8lLUBbog+un
         Bxr9qpp0GK52dG6zRcljoyLZac2+nISQ7dsMOoR11skKDkTia4fZdTVXnT2ojDov7f3a
         qDHqO5YuQsucYHMro4CDzLMC624oWN53GIS3OnjhbJqV8sSdmKXvxrTsIVI+tX6Sc2t3
         AgqJxatpZIQVkjXV5PGTTL6g3jUSHqt4xa2Dvu+9sPdyDu8Ay82093uv13ND0BFsBiyO
         VaEv96dr4ZagKvEQxY9Y6mHLYXAm5qMMKrElRAOWBfEp/l7IFg5VDrP+vHA1e5CGcOsC
         TXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AxOxOz3N9F0K8mLSxL0hnOp0DZT57bazsTbRp6sLU0=;
        b=Ohmv/WZYtrXmDbA++3UJwQw5FB8tmO6Z/ddRwBjLcP2LhukJeZucoW+cZ6QUta6cKy
         80vCgHJGL3IfZ1Fp6+nF15joXye6/eRj+1boJPJWTjiz9NolJqoxL8ww/M6HbTB1UpKm
         IOuTgcwroI44uOKurErYlHMwZOXcg5EtoTZdqaG0/Yk7FAHrrQ7tolARc1KooO4Hsih5
         MCrkWzxcUBANIRBH+HF8WHEguguIjja9Ek3q2wBJ89sYH/sSHwtMX259HWjEWwEEstk5
         8FPXeAjfsl8nsluY+kAzXUWA3N67Ibbr+NzzXmHGlBqKHNOGq5NfX+3jctioVFxEvhHF
         2uzw==
X-Gm-Message-State: APjAAAXA6FK92u8RFwgyMzj7GrRJcFV8A52LAXyV68IX3//YV0xN+XD1
        MRreuUCL7fJDZn01J1bMTWc3NLQ7v0ms5fxtubQ=
X-Google-Smtp-Source: APXvYqzFAhN/zmGH/qPNyu/UPaVQNVYCHk9/jtr+7frBaquyjhJMAItJOS022rDz7+Fs6rLuRzdouhsz6E39O1t+j3E=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr18086333qte.204.1581491224261;
 Tue, 11 Feb 2020 23:07:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581475981.git.shengjiu.wang@nxp.com> <2ab5cc65-026a-10fd-1216-b0d83baf37a6@infradead.org>
In-Reply-To: <2ab5cc65-026a-10fd-1216-b0d83baf37a6@infradead.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 12 Feb 2020 15:06:52 +0800
Message-ID: <CAA+D8ANsA4kaT_48F=3Jey-NjJd5HO+XD38TnQD3XBu9bg2WFQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/3] Add new module driver for new ASRC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 1:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/11/20 8:30 PM, Shengjiu Wang wrote:
> > Add new module driver for new ASRC in i.MX815/865
> >
> > Shengjiu Wang (3):
> >   ASoC: fsl_asrc: Move common definition to fsl_asrc_common
> >   ASoC: dt-bindings: fsl_easrc: Add document for EASRC
> >   ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers
> >
> >  .../devicetree/bindings/sound/fsl,easrc.txt   |   57 +
> >  sound/soc/fsl/fsl_asrc.h                      |   11 +-
> >  sound/soc/fsl/fsl_asrc_common.h               |   22 +
> >  sound/soc/fsl/fsl_easrc.c                     | 2265 +++++++++++++++++
> >  sound/soc/fsl/fsl_easrc.h                     |  668 +++++
> >  sound/soc/fsl/fsl_easrc_dma.c                 |  440 ++++
> >  6 files changed, 3453 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
> >  create mode 100644 sound/soc/fsl/fsl_asrc_common.h
> >  create mode 100644 sound/soc/fsl/fsl_easrc.c
> >  create mode 100644 sound/soc/fsl/fsl_easrc.h
> >  create mode 100644 sound/soc/fsl/fsl_easrc_dma.c
> >
>
> Hi,
>
> Is this patch series missing Kconfig, Makefile, and possibly
> MAINTAINERS patches?
>
yes, Kconfig, Makefile is missed, will add in next version, and
no maintainers patch.

best regards
wang shengjiu
