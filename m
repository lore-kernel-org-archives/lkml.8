Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A66C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BFE215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581444967;
	bh=ZiipSWDzgeHjJz2WH9FL395eNO0cu9ekXYQl99Q8TGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UtCGfflt/YOTphoDoqmKn2ur2E+aMFa8mL/bRJq0vTppeT3TRYoTybVJX1ym4xZYf
	 1//wP1FOEUNDE4vV7w96x40BAfjfCWPDxjPEZszqGZfQlIOJjIQ/g5RvuTZIDGqEIj
	 lSFhE/Uyc1WVDJjhrheoNODls4kb//gbjotpT8bY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgBKSQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgBKSQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:16:06 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7886920708;
        Tue, 11 Feb 2020 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581444965;
        bh=ZiipSWDzgeHjJz2WH9FL395eNO0cu9ekXYQl99Q8TGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYxW6t8G73ZXqPoAZrUSFtPqrtlwKARwA85m1jL6Z3ZedBgHQ3XaEFu2wG412mXbq
         lRdAsBCdeoQ3loqvdpsBxWXv3lKkaB0pTIYA7Y0mE6asS0iRix/G4zEMBB3ACwhKIM
         WfUEr2u4/mD+oq0aX7UbAlLPduKjQYQIC3j5M58w=
Received: by mail-qv1-f41.google.com with SMTP id dc14so5422982qvb.9;
        Tue, 11 Feb 2020 10:16:05 -0800 (PST)
X-Gm-Message-State: APjAAAUxvG7mM9VtV4oWSiXmMgDHXg8mGn8zgl9U+e0yObSYvQswFwwY
        CKnAlkPm7KEJlhuE0ucRdpada54KCqIahwzDjQ==
X-Google-Smtp-Source: APXvYqz7/HTjD/gmg7y3b1mBaiiVOST5LC3rVQ1S5d9nr8xvkVknjzihFw+CABsBG25SKvfgK9kM5f/8APejN+nuOaU=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr3796364qvu.136.1581444964504;
 Tue, 11 Feb 2020 10:16:04 -0800 (PST)
MIME-Version: 1.0
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-2-git-send-email-spujar@nvidia.com> <20200206181045.GA31521@bogus>
 <af58b6b2-25b2-e968-73c9-d87e1a9e2746@nvidia.com>
In-Reply-To: <af58b6b2-25b2-e968-73c9-d87e1a9e2746@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Feb 2020 12:15:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKCzR5DXm_ip-mrrPyeAUcZJRWi_cQEhPd7agp9T_uumA@mail.gmail.com>
Message-ID: <CAL_JsqKCzR5DXm_ip-mrrPyeAUcZJRWi_cQEhPd7agp9T_uumA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: sound: tegra: add DT binding for AHUB
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 5:31 AM Sameer Pujar <spujar@nvidia.com> wrote:
>
>
>
> On 2/6/2020 11:40 PM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Jan 30, 2020 at 04:03:34PM +0530, Sameer Pujar wrote:
> >> Audio Hub (AHUB) comprises a collection of hardware accelerators for audio
> >> pre-processing and post-processing and a programmable full crossbar for
> >> audio routing across these accelerators. This patch adds YAML schema for DT
> >> binding of AHUB and few of its following components. These devices will be
> >> registered as ASoC components.
> >>   * ADMAIF
> >>   * I2S
> >>   * DMIC
> >>   * DSPK
> >>
> >> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> >> ---
> >>   .../bindings/sound/nvidia,tegra186-dspk.yaml       | 105 +++++++++++++
> >>   .../bindings/sound/nvidia,tegra210-admaif.yaml     | 165 +++++++++++++++++++++
> >>   .../bindings/sound/nvidia,tegra210-ahub.yaml       | 130 ++++++++++++++++
> >>   .../bindings/sound/nvidia,tegra210-dmic.yaml       | 105 +++++++++++++
> >>   .../bindings/sound/nvidia,tegra210-i2s.yaml        | 112 ++++++++++++++
> >>   5 files changed, 617 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
> >> new file mode 100644
> >> index 0000000..dc9fef3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
> >> @@ -0,0 +1,105 @@
> >> +# SPDX-License-Identifier: (GPL-2.0)
> . . .
> >> +    items:
> >> +      - description: initial module clock rate
> >> +
> >> +  "#sound-dai-cells":
> >> +    const: 1
> >> +
> >> +  sound-name-prefix:
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    description:
> >> +      Used as prefix for sink/source names of the component. Must be a
> >> +      unique string among multiple instances of the same component.
> >> +      The name can be "DSPK1" or "DSPKx", where x depends on the maximum
> > Sounds like a constraint.
>
> Is there a better way to convey the recommended strings above?

pattern: '^DSPK[1-9]$'

Adjusting the number range regex as you need.

(And $ref will need to be under an 'allOf')

Rob
