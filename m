Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED8C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E049B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586959996;
	bh=g9zc9gWFrZts6nCro79E4zNLwGrqjr25+7GmsmkzvQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V3Fc6MzW0syCz9KZ/Ya3IWFvQ75XeoJDFrO0+PfhQxsu7UuejG/w2edJQQAIuv3pA
	 a6Tu8lgR1ZVYm68pMfzrdTMoay4vGHx/mSGgrjrHF4mg81MXXEbqTmINQj9nl++M6c
	 32AWfc8RZxSuEXiQ6GVg2WxofO/VVDXUw42tUiFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636489AbgDOONE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636464AbgDOOMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:12:13 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B722078B;
        Wed, 15 Apr 2020 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586959932;
        bh=g9zc9gWFrZts6nCro79E4zNLwGrqjr25+7GmsmkzvQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZdESDpha5XBMMH2NumasO7B5X8dXw9HFSztHTSiLifxEnAtw7voFnYGdpI6EuoHdU
         /ExqpEmsqp0/LnjQX+zOXaD6GTUv5AQ5l84baZvQtB4517udMY6ZG9NdsAZfO/Opr3
         DN9/nwsr2l7i0O6illGKVq5zZAke9OzzviJ626A8=
Received: by mail-qt1-f178.google.com with SMTP id x2so13298084qtr.0;
        Wed, 15 Apr 2020 07:12:12 -0700 (PDT)
X-Gm-Message-State: AGi0PuagO850FeY1scw2rjKb/80hAINyNkQzSXYbA7vSp8oIqAtX4fkq
        04+/o0Tmt1IH7xGdoChOGMlis7ngC7L0MLWCJw==
X-Google-Smtp-Source: APiQypKpcfRLgsq5L44xqX/Nd5yT1RL98k+9haGwOML5QU4TMV8UysP823kpICcUXqUoiZVvAG/C9S9NizqCtatbW/E=
X-Received: by 2002:ac8:6695:: with SMTP id d21mr21432863qtp.110.1586959931603;
 Wed, 15 Apr 2020 07:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585726761.git.shengjiu.wang@nxp.com> <68208297b49e85adfddf843bc205d154790a49de.1585726761.git.shengjiu.wang@nxp.com>
 <20200414154643.GA29098@bogus> <CAA+D8AP2CiRT7qkNa7yBDH0Dbd=i1eyqL4g4zobRmR-vEx4VBQ@mail.gmail.com>
In-Reply-To: <CAA+D8AP2CiRT7qkNa7yBDH0Dbd=i1eyqL4g4zobRmR-vEx4VBQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Apr 2020 09:11:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Uk1zPT=JyZczH5WRWP617Mqhaur+LwbKKYDBGBhd-cQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Uk1zPT=JyZczH5WRWP617Mqhaur+LwbKKYDBGBhd-cQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
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

On Tue, Apr 14, 2020 at 9:56 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> Hi Rob
>
> On Tue, Apr 14, 2020 at 11:49 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Apr 01, 2020 at 04:45:39PM +0800, Shengjiu Wang wrote:
> > > EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> > > IP module found on i.MX8MN.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > > new file mode 100644
> > > index 000000000000..14ea60084420
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > > @@ -0,0 +1,101 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/sound/fsl,easrc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP Asynchronous Sample Rate Converter (ASRC) Controller
> > > +
> > > +maintainers:
> > > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^easrc@.*"
> > > +
> > > +  compatible:
> > > +    const: fsl,imx8mn-easrc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Peripheral clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: mem
> > > +
> > > +  dmas:
> > > +    maxItems: 8
> > > +
> > > +  dma-names:
> > > +    items:
> > > +      - const: ctx0_rx
> > > +      - const: ctx0_tx
> > > +      - const: ctx1_rx
> > > +      - const: ctx1_tx
> > > +      - const: ctx2_rx
> > > +      - const: ctx2_tx
> > > +      - const: ctx3_rx
> > > +      - const: ctx3_tx
> > > +
> > > +  firmware-name:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/string
> > > +      - const: imx/easrc/easrc-imx8mn.bin
> > > +    description: The coefficient table for the filters
> > > +
> > > +  fsl,asrc-rate:
> >
> > fsl,asrc-rate-hz
>
> Can we keep "fsl,asrc-rate", because I want this property
> align with the one in fsl,asrc.txt.  These two asrc modules
> can share same property name.

Oh, yes.

So with the example fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
