Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE0C20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592230693;
	bh=GGb+Dx/tJI94m9zQ401+irOkM2NY57EhT25IIa/tCMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XHfAGSi/kNSllrK2oQzT7sMkBQW3hQeZ0GG9MxK26fr/XaFXI6PG1OepmHAbfFhYR
	 gL+4oOjC19huAaZWyXnH8UQpKm3kxvSKGKh2qm2myWA72kWFHsaJAG0qHK5G882cqM
	 RZUTPXUGCI+DTWmbKLc+87+92hq5ortNrNjd7mmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgFOOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbgFOOSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:18:10 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8782920679;
        Mon, 15 Jun 2020 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592230689;
        bh=GGb+Dx/tJI94m9zQ401+irOkM2NY57EhT25IIa/tCMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uaAV7IuwQ34HoYIAx5BZcuWwIWgq0jgztdVTR6yyhn+XfMLHV9baFVrVvFSB5iqY5
         mLMoqmnjwIJmScjRPwDh2GcKnfGrvtA9yB3GYyFWy3WJWcaP/wmYnc+rEW1USDpEKr
         p1HId3fpeLS4Mf2bRJUaxVTrSbTKYOxiHZz9/hPI=
Received: by mail-ot1-f54.google.com with SMTP id 69so13225981otv.2;
        Mon, 15 Jun 2020 07:18:09 -0700 (PDT)
X-Gm-Message-State: AOAM531z5+Vrz6qsVlF6iAc5DQexH18ODSWTAV9xjn38MPbPT/n/7nQ8
        sywWKcuQ8lQHhiJ/y1cXo64soWqtFKpyQLlLXg==
X-Google-Smtp-Source: ABdhPJz1IjNEKxP7jSTLRYA9q0U4lfKjyD3CCYKwpWr4PNdh0TU0xzMG77XmvS9auFcM6aqGhXY94PoGlNxJEXEUXkk=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr22033388ots.192.1592230688819;
 Mon, 15 Jun 2020 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-2-git-send-email-rbokka@codeaurora.org> <CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com>
 <0ee1d7fa-0520-a347-6a55-6ab646284b1a@linaro.org>
In-Reply-To: <0ee1d7fa-0520-a347-6a55-6ab646284b1a@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Jun 2020 08:17:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLe=g6RsF7VdziB1HQ4SDNFL0uZjwTG0o3nbmVg8rMX3Q@mail.gmail.com>
Message-ID: <CAL_JsqLe=g6RsF7VdziB1HQ4SDNFL0uZjwTG0o3nbmVg8rMX3Q@mail.gmail.com>
Subject: Re: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 4:44 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 12/06/2020 22:59, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jun 11, 2020 at 2:49 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
> >>
> >> This patch adds dt-bindings document for qfprom-efuse controller.
> >>
> >> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> >> ---
> >>   .../devicetree/bindings/nvmem/qfprom.yaml          | 52 ++++++++++++++++++++++
> >>   1 file changed, 52 insertions(+)
> >
> > Overall comment: I reviewed your v1 series and so I'm obviously
> > interested in your series.  Please CC me on future versions.
> >
> > I would also note that, since this is relevant to Qualcomm SoCs that
> > you probably should be CCing "linux-arm-msm@vger.kernel.org" on your
> > series.
> >
> >
> >>   create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
> >> new file mode 100644
> >> index 0000000..7c8fc31
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
> >> @@ -0,0 +1,52 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/nvmem/qfprom.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Qualcomm Technologies Inc, QFPROM Efuse bindings
> >> +
> >> +maintainers:
> >> +  - Ravi Kumar Bokka <rbokka@codeaurora.org>
> >> +
> >> +allOf:
> >> +  - $ref: "nvmem.yaml#"
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - qcom,qfprom
> >
> > As per discussion in patch #1, I believe SoC compatible should be here
> > too in case it is ever needed.  This is standard practice for dts
> > files for IP blocks embedded in an SoC.  AKA, this should be:
> >
> >      items:
> >        - enum:
> >            - qcom,apq8064-qfprom
> >            - qcom,apq8084-qfprom
> >            - qcom,msm8974-qfprom
> >            - qcom,msm8916-qfprom
> >            - qcom,msm8996-qfprom
> >            - qcom,msm8998-qfprom
> >            - qcom,qcs404-qfprom
> >            - qcom,sc7180-qfprom
> >            - qcom,sdm845-qfprom
>
>
> Above is not required for now in this patchset, as we can attach data at
> runtime specific to version of the qfprom.
>
> This can be added when required!
>
> >        - const: qcom,qfprom
> >
> > NOTE: old SoCs won't have both of these and thus they will get flagged
> > with "dtbs_check", but I believe that's fine (Rob can correct me if
> > I'm wrong).  The code should still work OK if the SoC isn't there but
> > it would be good to fix old dts files to have the SoC specific string
> > too.
> >
> >
> >> +
> >> +  reg:
> >> +    maxItems: 3
> >
> > Please address feedback feedback on v1.  If you disagree with my
> > feedback it's OK to say so (I make no claims of being always right),
> > but silently ignoring my feedback and sending the next version doesn't
> > make me feel like it's a good use of my time to keep reviewing your
> > series.  Specifically I suggested that you actually add descriptions
> > rather than just putting "maxItems: 3".
> >
> > With all that has been discussed, I think the current best thing to
> > put there is:
> >
> >      # If the QFPROM is read-only OS image then only the corrected region
> >      # needs to be provided.  If the QFPROM is writable then all 3 regions
> >      # must be provided.
> >      oneOf:
> >        - items:
> >            - description: The start of the corrected region.
> >        - items:
> >            - description: The start of the raw region.
> >            - description: The start of the config region.
> >            - description: The start of the corrected region.
> >
> >> +
> >
> > You missed a bunch of things that you should document:
> >
> >    # Clocks must be provided if QFPROM is writable from the OS image.
> >    clocks:
> >      maxItems: 1
> >    clock-names:
> >      const: sec
> >
> >    # Supply reference must be provided if QFPROM is writable from the OS image.
> >    vcc-supply:
> >      description: Our power supply.
> >
> >    # Needed if any child nodes are present.
> >    "#address-cells":
> >      const: 1
> >    "#size-cells":
> >      const: 1
> >
> >> +required:
> >> +   - compatible
> >> +   - reg
> >> +   - reg-names
> >
> > reg-names is discouraged.  Please remove.  I always point people here
> > as a reference:
> >
> > https://lore.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/
> >
> > You can just figure out whether there are 3 register fields or 1 register field.
>
> Am not sure if I understand this correctly, reg-names are very useful in
> this particular case as we are dealing with multiple memory ranges with
> holes. I agree with not having this for cases where we have only one
> resource.

1 or 3 doesn't sound like a case with holes.

> But having the ordering in DT without proper names associated with it
> seems fragile to me! And it makes very difficult to debug issues with
> wrong resource ordering in DT.
>
> Rob, Is this the guidance for new bindings?

This has *always* been the guidance since *-names were added.

> I have not seen any strong suggestion or guidance either in
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/resource-names.txt?h=v5.8-rc1

The key word is 'supplemental'. Perhaps that could be clearer, but DT
always required a defined order and the supplemental information
doesn't throw that out.

>   Or in ./drivers/of/address.c

How could it? Order is defined by the specific binding.

>
> Am I missing anything here?
