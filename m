Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126192075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594411280;
	bh=uxSaA+fCdlWn4qcPwLruiKx79jbqmYw66ELH749IiaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cOk1MUMgCoL2oTjO7W3g4DesAemGGpCM7F9zHy4YYlBSFCrhkrY4q4FDFlvNVUvTS
	 wW/6694PMYARx1AHIeWePtdU+VKuwV7tKVzRFJodFoS6UT8gb6B++L6n0HonaBv+sc
	 Jp71srWCFen7Gmxc0dpup20zN11MIyckcbTPXGdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgGJUBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgGJUBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:01:15 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448CE2075D;
        Fri, 10 Jul 2020 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594411275;
        bh=uxSaA+fCdlWn4qcPwLruiKx79jbqmYw66ELH749IiaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1wPkaE20z7plsMQiJwhVZ0+paqUwAPcL9GsKXf1XrgHsHp6QKFd3U0qwNQj1wVKw6
         oFM2bYRdanLlb02iDrG6quyLCCI8fDqDyAlcxJYyq5iMV0fXlzOygHrhBaOBnc10fv
         qOZWzZ3l5FqPvoVBsTQgTCr2YMgP9r32B1WtrAIw=
Received: by mail-oi1-f174.google.com with SMTP id k6so5733973oij.11;
        Fri, 10 Jul 2020 13:01:15 -0700 (PDT)
X-Gm-Message-State: AOAM5302QEB6q2hQdZ1j4ExEPq/yphh+1JBvgadblNSxBqEwzmamzPv1
        dz1hv0Vu/h27fovdMNl7OjJT0MCJeS8wNqhTaw==
X-Google-Smtp-Source: ABdhPJwp+smXE3Nydu1By4o0JE3KuEQE3LX21t7xmomGltsl4AiTMSJDziZ1tEKIqsf+vYtAAi8lMSlSyNN6DaD306U=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr5612171oif.106.1594411274634;
 Fri, 10 Jul 2020 13:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200701130129.30961-1-benjamin.gaignard@st.com>
 <20200701130129.30961-2-benjamin.gaignard@st.com> <20200709203718.GA837160@bogus>
 <20e4907a-f218-3e43-1111-7d4b9ee6d945@st.com>
In-Reply-To: <20e4907a-f218-3e43-1111-7d4b9ee6d945@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Jul 2020 14:01:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VgXTJy1SQr6B63kLZ3wcRMe4YfYiRNCT6s=gUO_tmTw@mail.gmail.com>
Message-ID: <CAL_Jsq+VgXTJy1SQr6B63kLZ3wcRMe4YfYiRNCT6s=gUO_tmTw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: media: stm32-dcmi: Add DCMI min
 frequency property
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 1:33 AM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
>
> On 7/9/20 10:37 PM, Rob Herring wrote:
> > On Wed, Jul 01, 2020 at 03:01:27PM +0200, Benjamin Gaignard wrote:
> >> Document st,stm32-dcmi-min-frequency property which is used to
> >> request CPUs minimum frequency when streaming frames.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>   Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> >> index 3fe778cb5cc3..05ca85a2411a 100644
> >> --- a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> >> +++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> >> @@ -44,6 +44,13 @@ properties:
> >>         bindings defined in
> >>         Documentation/devicetree/bindings/media/video-interfaces.txt.
> >>
> >> +  st,stm32-dcmi-min-frequency:
> >> +    description: DCMI minimum CPUs frequency requirement (in KHz).
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +      - minimum: 0
> >> +      - default: 0
> > I think this is questionable to be in DT and if it is, it's something
> > that's hardly specific to ST or this block. IIRC, we already have a way
> > to specify minimum OPPs.
> This binding is only needed on some STM32 SoC when DVFS is activated
> with low frequency setting in opp. The value also depends of the targeted
> video format and framerate.

As those 2 things are not in the DT, then neither should this value be.

> It is not an opp because it doesn't define a voltage-current-frequency
> combination
> but only set a minimum target for the CPUs frequency to guaranty a good
> reaction
> time when handling IRQs for the sensor.

OPPs can be frequency only. This is pretty clearly defining the CPU
must Operate at a certain minimum Performance Point.

Rob
