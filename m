Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096BBC43333
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12C42077D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQ6VVng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVIDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:03:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46103 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCVIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:03:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id u4so95431qkj.13;
        Sun, 22 Mar 2020 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXVv3O+6eypP6m1WWp+RaUMVY3oNb3TdV/pq+HroePk=;
        b=aaQ6VVngPHL4EX4wx6NHsYw7h7DHQ+Co8ZaQT3+ricC2dvlwjh+yjYyPlppiu5w/2k
         tgkrJS24DpcYVsN2SpS/m73nsrtXWgQIGP7QgVvGNH4yAQ2CJE9QjUVZJ1VfIBICkwH0
         qvjOKpniEAAWaNNgl1uYm8KivgOm5uRZc3en9aqZAAXmjfpsLdzzCP8ek3KY89OLurBW
         p8wpNTqbZFt4IZED75rsXMFWhez2a+r2ZHH7FKSFRHG8M5QY8gx/87zDOMkj8C1jj4EB
         9HF/lMB0LHe6RNVgiVSRzidRYxSbSPJc6tZgDTmiQKo3kSc125VgkAv7i4O5/7LQZ10t
         gVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXVv3O+6eypP6m1WWp+RaUMVY3oNb3TdV/pq+HroePk=;
        b=QaMdhgIpXsfwD1p9iov8o1WfyQJcCLzrE7ccyn1l3Q++jivgfTNsUSBn4R3qULXDub
         EX9i0tI0De8z0gAyZelTokh9I3pdzV1Ohi8tEpLAglRTGDBc1ERqAgJk0HFTcrLydVBi
         +f8icksWOEQsYJ03mgJthjToBqrealGDlbPsz5qfbhar0fTLi0O3DzsTmxXZi87akclE
         d99aoQIfHA8HHAsLkvFvJS4udgtdsvHQqGVRHlyJsVCQzD2Ho4MqW9Zo/LgwaUgFriju
         j90tux1wzTeQIUr1cVePDDONshLXbUJmavGeu6aH9pIT6aD4kuJp4CfimsWKTfOZETVm
         R8fQ==
X-Gm-Message-State: ANhLgQ2VBoWTEilmti0E7euFAOTTWBX3X4PKOeTwBSuo4/wAguV1eOa3
        zPnqkloOCW4X7E7IBmtkSqUezl+Jj6QtwoRj7Ho=
X-Google-Smtp-Source: ADFU+vv15vjlLfsa664H8VI+98Ko/0kGJBPM66yGAqwLj6B2pgF+uXCCQ0y20KBRdMdMu0RQlW+glQ8BaD4Y4HxhOxA=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr16083800qka.152.1584864189047;
 Sun, 22 Mar 2020 01:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583725533.git.shengjiu.wang@nxp.com> <71b6ad3d0ea79076fded2373490ec1eb8c418d21.1583725533.git.shengjiu.wang@nxp.com>
 <20200320174812.GA27070@bogus>
In-Reply-To: <20200320174812.GA27070@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 22 Mar 2020 16:02:57 +0800
Message-ID: <CAA+D8AMC0fuTxDiWEjOVx11eDuGb9WeMhFTzxFx-3fYKvf=-jw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
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

On Sat, Mar 21, 2020 at 1:50 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 11:58:33AM +0800, Shengjiu Wang wrote:
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
> > index 000000000000..ff22f8056a63
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
> > +  fsl,easrc-ram-script-name:
>
> 'firmware-name' is the established property name for this.

will use "firmware-name"

>
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/string
> > +      - const: imx/easrc/easrc-imx8mn.bin
>
> Though if there's only 1 possible value, why does this need to be in DT?
>
> > +    description: The coefficient table for the filters
>
> If the firmware is only 1 thing, then perhaps this should just be a DT
> property rather than a separate file. It depends on who owns/creates
> this file. If fixed for the platform, then DT is a good fit. If updated
> separately from DT and boot firmware, then keeping it separate makes
> sense.
>
The firmware is not fixed for the platform, it is updated separately from
DT.  So we can keep it separately.

best regards
wang shengjiu
