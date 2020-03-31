Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15BAC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766412072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbufxDdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgCaC2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:28:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42846 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgCaC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:28:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so17079426qto.9;
        Mon, 30 Mar 2020 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Eswrbi+TW9i4zBrNR421oAkiEgU39P/E20ccg2jKp0=;
        b=XbufxDdyKxF6IxecIKX1ZwR3v13NTl1c0irTPT13iVOAemS1d4QQGPNdE8aX5ZJR7a
         PRYP7DhKw5BCgxY7SGSzYWNZgaGcWWSc6YGqUcJQu60Lfm4Q4OSUxTA+2thEsMP1fxNR
         VJwh3EmB3AOXnRQbyYLd1sv5QNoWFYPHe3e7QaLHgo50B+O0+HGrMpsHrGHsmsEZZO9I
         kg+3wYBZar0w5tO557g0O7FJMVrKJPzT9zL6YdvW2GEVYbw5IdwhUXKbWcQbdUPqfswu
         eBRpuqpc4K2baE54CChc6Yg8aq9BWGgIZ1HFGX7tAWIF3k1mIqsNGhpbsGFO+pMH5Jui
         8/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Eswrbi+TW9i4zBrNR421oAkiEgU39P/E20ccg2jKp0=;
        b=ryP/w4jlxmrFVdcf4c7mKVfT4bIp+qu+sFDAiTybFm2uWVfVbS5ns/dlfi9SeT3GcN
         Xp9LsWDxXN6Hnj4dDWrUzX7wKWjni6XcjvnH7YvoJNJ9aNxzOixtLVhNx+LvRrHZ/lcC
         jrJr8Iv5R6AEFNFH8aqS6/S3bCH4hQscv85OinnLCkF1TM66oIVdzQD/ThjCWu6vCIJB
         E+7q/9SMB9ERSVVBvdhk1SUFzIrhC+sZKlZr8rGikB+ZpIFeSmMr8pc5ShFiPtwUBEEA
         /0XLvUj5lFb8JsVhWMfK/SaOPsAbCWUHTswVLGD79N4v1CoWw4AXcVZhoUJ2L5u0w1Br
         +IJw==
X-Gm-Message-State: ANhLgQ1tDwsrbIgZ/zV5ntzZt+m7TXgtVxsdR59Qoyed11l6G5xsBcID
        OO/9ZAGaKR4BmF73RCMlHtmXypkHoglsSdEvIHw=
X-Google-Smtp-Source: ADFU+vsVu3tV6CH4YdMfKECtdWJWGuZrgZY25WwzSudJxQGrid6FAxBQVVLlDNJ6nM/kHaMida9sj9zwiJxjuWI1mgI=
X-Received: by 2002:ac8:6f4e:: with SMTP id n14mr2947163qtv.121.1585621716954;
 Mon, 30 Mar 2020 19:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583725533.git.shengjiu.wang@nxp.com> <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com> <20200320173213.GA9093@bogus>
 <20200323212038.GA7527@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20200323212038.GA7527@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 31 Mar 2020 10:28:25 +0800
Message-ID: <CAA+D8APu0JYqnUvY+fCYTcZ9U1BCv-zU8J4Zt-5doZcNkgaXFQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Mar 24, 2020 at 5:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Mar 20, 2020 at 11:32:13AM -0600, Rob Herring wrote:
> > On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> > > On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > > > In order to support new EASRC and simplify the code structure,
> > > > We decide to share the common structure between them. This bring
> > > > a problem that EASRC accept format directly from devicetree, but
> > > > ASRC accept width from devicetree.
> > > >
> > > > In order to align with new ESARC, we add new property fsl,asrc-format.
> > > > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > > > can accept format from devicetree, don't need to convert it to
> > > > format through width.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > > index cb9a25165503..780455cf7f71 100644
> > > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > > @@ -51,6 +51,11 @@ Optional properties:
> > > >                     will be in use as default. Otherwise, the big endian
> > > >                     mode will be in use for all the device registers.
> > > >
> > > > +   - fsl,asrc-format     : Defines a mutual sample format used by DPCM Back
> > > > +                   Ends, which can replace the fsl,asrc-width.
> > > > +                   The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > > +                   SNDRV_PCM_FORMAT_S24_LE
> > >
> > > I am still holding the concern at the DT binding of this format,
> > > as it uses values from ASoC header file instead of a dt-binding
> > > header file -- not sure if we can do this. Let's wait for Rob's
> > > comments.
> >
> > I assume those are an ABI as well, so it's okay to copy them unless we
>
> They are defined under include/uapi. So I think we can use them?
>
> > already have some format definitions for DT. But it does need to be copy
> > in a header under include/dt-bindings/.
>
> Shengjiu is actually quoting those integral values, rather than
> those macros, so actually no need copy to include/dt-bindings,
> yet whoever adds this format property to a new DT would need to
> look up the value in a header file under include/uapi. I's just
> wondering if that's okay.
>
> Thanks
Shall I keep this change or drop this change?

best regards
wang shengjiu
