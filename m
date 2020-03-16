Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434DFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135962076A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgbPfftO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgCPNBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:01:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41826 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgCPNBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:01:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id f11so4323149wrp.8;
        Mon, 16 Mar 2020 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lPqGQkzYXIZixlU4/SVfz2TE5wMXf/RCUgZUuhdULg=;
        b=IgbPfftONkRv6WPIreACR2bk+m/5ncOUmuYz1FvSoWv3IFdKPqesEQtF3AmjfufF3v
         KDUos8UEtbyvmGiS+cg/wZW122KWo6t3aEyEbZbOg80r5i9QxXQgIeFuGjEeuy4gpGms
         dWOw6VercaCWMVyoQNGqkBHFe/UcmN0Jdues4qJGMUXR1FtbnT04eOQ32HKU0a3zsHyg
         KsxUfEDHHsSQANoDRP55V6A508zSugh+ch0LAFVdXPjSeB4kH86f0BC+JCQEHPdlIhM1
         wl/k5D6tS4AslEHtrweKPBrYsJjykMZR6KyJnkiFqsGBMIMtDyoNHuNiC0jkSKshEXmi
         nJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lPqGQkzYXIZixlU4/SVfz2TE5wMXf/RCUgZUuhdULg=;
        b=pssrTURjgpfo64BKyuQAur7XJhSNgaUMEHtlsqGTuHFJ1rbLqrPw4pse7hMQoTHwG6
         jBU9QocR6sAQvnQurKfd36W6laIxVrFYBrgRupqtWfUo5GHQCe1GjeLiynDVljxILEkm
         ULNZwNW1pKV5agHOEaGJ0RImrMEtiZHsbmfi1k1OS/vDUtWlLQKc6Pq5bABl5Emo35mI
         5JKNySGNezzjUT8CnWjykLKZqqhmVuxF5zjx0yjd5eETr/hRR87j/ze7/VlnAdOlLykW
         SiwMVLjXlbZ0iC2R/ztXJiFOaXfgiBHoT8pEJFpf8GUzQD8I46Z0NfUTFy2OVpbMWi3c
         /LwQ==
X-Gm-Message-State: ANhLgQ2zdwiunTjXSDnQSOvn7bgXsjjgZHrmNwOye3efnzOVgN48tsza
        CkfGnom9oQjUxsVC5vtJGzdTzc1zPizaUclacC0=
X-Google-Smtp-Source: ADFU+vv3todfLH0S9K1XiDE5C05k1QyRLPyjalBazFAliB47u26zAl+u/TDY/X5WKA04HAeVbCo967LdsqPd6PTKHdA=
X-Received: by 2002:adf:de84:: with SMTP id w4mr36663540wrl.350.1584363712015;
 Mon, 16 Mar 2020 06:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200306111353.12906-1-daniel.baluta@oss.nxp.com>
 <20200306111353.12906-2-daniel.baluta@oss.nxp.com> <20200312202306.GA18767@bogus>
In-Reply-To: <20200312202306.GA18767@bogus>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 16 Mar 2020 15:01:40 +0200
Message-ID: <CAEnQRZCLa+NAk=3M84MxjgOzYQdJXGY9S84dU6HO8GG64Lm_mQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Add FSL CPU DAI bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob for review. See my comments inline:

<snip>

> > +# SPDX-License-Identifier: GPL-2.0
>
> Dual license new bindings please:
>
> (GPL-2.0-only OR BSD-2-Clause)

Ok, will do.

>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,dai.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic CPU FSL DAI driver for resource management
>
> Bindings are for h/w devices, not drivers.

Indeed. I think I will change it to something like this.

title: 'FSL CPU DAI for resource management'

The explanation are already in patch 2/2 of this series but let e
explain again what I'm
trying to do here and let me know if this makes sense to you.

Digital Audio Interface device (DAI) are configured by the firmware
running on the DSP. The only
trouble we have is that we cannot easily handle 'resources' like:
clocks, pinctrl, power domains from
firmware.

This is because our architecture is like this:

M core [running System Controller Firmware]
            |
            |
A core [Linux]<----> DSP core [SOF firmware]

In theory, it is possible for DSP core to communicate with M core, but
this needs a huge
amount of work in order to make it work. We have this on our plans for
the future,
but we are now trying to do resource management from A core because
the infrastructure is already in place.

So, the curent driver introduced in this series acts like a Generic
resource driver for DAI device. We can
have multiple types of DAIs but most of them need the same types of
resources (clocks, pinctrl, pm) sof
for this reason I made it generic.


>
> > +
> > +maintainers:
> > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > +
> > +description: |
> > +  On platforms with a DSP we need to split the resource handling between
> > +  Application Processor (AP) and DSP. On platforms where the DSP doesn't
> > +  have an easy access to resources, the AP will take care of
> > +  configuring them. Resources handled by this generic driver are: clocks,
> > +  power domains, pinctrl.
>
> The DT should define a DSP node with resources that are part of the
> DSP. What setup the AP has to do should be implied by the compatible
> string and possibly what resources are described.

We already have a DSP node: Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
but I thought that the resources attached to DAIs are separated from
the resources
attached to the DSP device.

In the great scheme of ALSA we usually have things like this:

FE         <----->       BE

In the SOF world FE are defined by topology framework. Back ends are
defined by the machine driver:

On the BE side we have:
- codec  -> this is the specific code
- platform -> this is the DSP
- cpu -> this is our Generic DAI device

Now, I'm wondering if we can get rid of cpu here and make platform
node (dsp) take care of every
resource (this looks not natural).

Perhaps Mark, Liam or Pierre can help me with this.


>
> Or maybe the audio portion of the DSP is a child node...
>
> > +
> > +properties:
> > +  '#sound-dai-cells':
> > +    const: 0
> > +
> > +  compatible:
> > +    enum:
> > +      - fsl,esai-dai
> > +      - fsl,sai-dai
>
> Not very specific. There's only 2 versions of the DSP and ways it is
> integrated?

As I said above this is not about the DSP, but about the Digital Audio
Intraface. On i.MX
NXP boards we have two types of DAIs: SAI and ESAI.

<snip>

> > +  pinctrl-0:
> > +    description: Should specify pin control groups used for this controller.
> > +
> > +  pinctrl-names:
> > +    const: default
>
> pinctrl properties are implicitly allowed an don't have to be listed
> here.

Great.

>
> > +
> > +  power-domains:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
>
> Don't need a type.
>
> > +    description:
> > +      List of phandles and PM domain specifiers, as defined by bindings of the
> > +      PM domain provider.
>
> Don't need to re-define common properties.
>
> You do need to say how many power domains (maxItems: 1?).

We support multiple power domains, so technically there is no upper
limit. What should I put here in this case?
>
> > +
> > +  fsl,dai-index:
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    description: Physical DAI index, must match the index from topology file
>
> Sorry, we don't do indexes in DT.
>
> What's a topology file?

Topology files are binary blobs that contain the description of an
audio pipeline. They are built
are written in a specific format and compiled with alsa-tplg tools in userspace.

Then loaded via firmware interface inside the kernel.

https://www.alsa-project.org/wiki/ALSA_topology


thanks,
Daniel.
