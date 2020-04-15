Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72765C352BE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5202F2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyBX2dum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438565AbgDOC4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732779AbgDOC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:56:00 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1BC061A0C;
        Tue, 14 Apr 2020 19:56:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di6so994937qvb.10;
        Tue, 14 Apr 2020 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+pk54KXVRCt6mCeYfu6u1hgghJvTphtuH45b199eug=;
        b=dyBX2dumBT3DX60HltmnArMIt6VdxDUSG499ZJ+SRAW1GNYbaDK0TUKMeEq/aSkESG
         ChLKmTo6et7e8BsIPVwRNLLNO9n/dw8bpcW9L9WweiHlT8y42jKTCt+AeIllZGKe76jU
         RCJUyCb3E7/1slLwAqTMTggJnLfQCt+1pYkAtHgsu7uB3FhuoZHhbfYnkQ+I6xm8NEE6
         FnY3Z833zX6HWbAH1HxGSB0Bo9GqexomPFByl1c6UoTg01cXsev+ZUKRSoBVimBuYroh
         m71L7+eFHi5pdsEosfQhCxZfgq5510wDXejkW+/+V2tIAXptyqXdWbIIQX8BclLlyFL4
         l+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+pk54KXVRCt6mCeYfu6u1hgghJvTphtuH45b199eug=;
        b=L+rRD0Dq3VkaVXRQ/V715wmOJNkExUXD9o2sJ+130wiHNEAasW2XckEdAWka+5KTkc
         XXwPuKdVeM7VbAh7odPA25Yzb6KzUlwaDdv/wi0a/PVvlAnHN2I/F+Bn8co9hxeu1Gm3
         arkGTu2FmKs7PiSFXYOCeX+3v5GBJP0ladIWYV28vV/yz97pb9SFBzetfvWx+tSARXx1
         ma/yaOJ+ekz8Aj5QZsOZ1+2BFeHlkX5SxiB3IcqOvwSMjuQU92yfV3Wygkikki1HNEDc
         B8kv3+5xVWraT4WlnWiYpUeSxWG8tr9xtuv+iUL6BZ1MRiuFzOvCpHwLVedxdz+E7HWU
         +elQ==
X-Gm-Message-State: AGi0Puag2m/kldNPsIgjAZIqXvnm+Yj+1ZdYCQhTBi2uYJmw7/40IFvg
        1cDbyFud9LPazS0I87ESXIMMPIN/JhDo7ekcq38=
X-Google-Smtp-Source: APiQypL6fx5Jo66bviF7emrcPPuSgkq+sExxjq0BShhEl+ej8+MVt0ZP8mIC/3uoA9xgoayPyN+s0Rj7dR5hh4U60L4=
X-Received: by 2002:ad4:46e3:: with SMTP id h3mr3036173qvw.14.1586919359561;
 Tue, 14 Apr 2020 19:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585726761.git.shengjiu.wang@nxp.com> <68208297b49e85adfddf843bc205d154790a49de.1585726761.git.shengjiu.wang@nxp.com>
 <20200414154643.GA29098@bogus>
In-Reply-To: <20200414154643.GA29098@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 15 Apr 2020 10:55:47 +0800
Message-ID: <CAA+D8AP2CiRT7qkNa7yBDH0Dbd=i1eyqL4g4zobRmR-vEx4VBQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Tue, Apr 14, 2020 at 11:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 01, 2020 at 04:45:39PM +0800, Shengjiu Wang wrote:
> > EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> > IP module found on i.MX8MN.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > new file mode 100644
> > index 000000000000..14ea60084420
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,easrc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP Asynchronous Sample Rate Converter (ASRC) Controller
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^easrc@.*"
> > +
> > +  compatible:
> > +    const: fsl,imx8mn-easrc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Peripheral clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: mem
> > +
> > +  dmas:
> > +    maxItems: 8
> > +
> > +  dma-names:
> > +    items:
> > +      - const: ctx0_rx
> > +      - const: ctx0_tx
> > +      - const: ctx1_rx
> > +      - const: ctx1_tx
> > +      - const: ctx2_rx
> > +      - const: ctx2_tx
> > +      - const: ctx3_rx
> > +      - const: ctx3_tx
> > +
> > +  firmware-name:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/string
> > +      - const: imx/easrc/easrc-imx8mn.bin
> > +    description: The coefficient table for the filters
> > +
> > +  fsl,asrc-rate:
>
> fsl,asrc-rate-hz

Can we keep "fsl,asrc-rate", because I want this property
align with the one in fsl,asrc.txt.  These two asrc modules
can share same property name.

best regards
wang shengjiu
