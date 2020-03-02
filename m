Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8B21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="g09F7/at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgCBTfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:35:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48898 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgCBTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583177736; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGfSMIikOY3kreg6w/PuWqLAcsa2i58iD5RE/ITwXCY=;
        b=g09F7/at4RhFLxEG/sswSLYFCPUn929KYVnYN8sQRSeEB0Pdtvcon4Ttu3ACgx7WFWbv84
        ibS5uRHTmcIoVZ7kOPe1LZVUAKR5NxNKUaaDPU7xtMpX7+Z0LUOXn5HOmX4hxHmPV42byW
        jkOTjhHZ8kYe5bKuVTU7tcx7T8WL3Gg=
Date:   Mon, 02 Mar 2020 16:35:20 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/1] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <1583177720.3.6@crapouillou.net>
In-Reply-To: <CAL_JsqL7b8mwtg3XyNS2fdA4fxaFdUpsfqTPx521pW5xqSPneg@mail.gmail.com>
References: <20200301174636.63446-1-paul@crapouillou.net>
        <20200301174636.63446-2-paul@crapouillou.net>
        <CAL_JsqKGzxdMj4_+i4ycKj6ZjiuGMY8F+yBzVPt_b2CLhrcdKg@mail.gmail.com>
        <1583173481.3.0@crapouillou.net>
        <CAL_JsqL7b8mwtg3XyNS2fdA4fxaFdUpsfqTPx521pW5xqSPneg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun., mars 2, 2020 at 13:07, Rob Herring <robh+dt@kernel.org> a=20
=E9crit :
> On Mon, Mar 2, 2020 at 12:25 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi Rob,
>>=20
>>=20
>>  Le lun., mars 2, 2020 at 11:06, Rob Herring <robh+dt@kernel.org> a
>>  =E9crit :
>>  > On Sun, Mar 1, 2020 at 11:47 AM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>
>>  >
>>  > Well, this flew into linux-next quickly and breaks 'make
>>  > dt_binding_check'... Please drop, revert or fix quickly.
>>=20
>>  For my defense I said to merge "provided Rob acks it" ;)
>>=20
>>  >>  Convert the ingenic,tcu.txt file to YAML.
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >>   .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ----------
>>  >>   .../bindings/timer/ingenic,tcu.yaml           | 235
>>  >> ++++++++++++++++++
>>  >>   2 files changed, 235 insertions(+), 138 deletions(-)
>>  >>   delete mode 100644
>>  >> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  >>   create mode 100644
>>  >> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>  >
>>  >
>>  >>  diff --git
>>  >> a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>  >> b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>  >>  new file mode 100644
>>  >>  index 000000000000..1ded3b4762bb
>>  >>  --- /dev/null
>>  >>  +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>  >>  @@ -0,0 +1,235 @@
>>  >>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  >>  +%YAML 1.2
>>  >>  +---
>>  >>  +$id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
>>  >>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  >>  +
>>  >>  +title: Ingenic SoCs Timer/Counter Unit (TCU) devicetree=20
>> bindings
>>  >>  +
>>  >>  +description: |
>>  >>  +  For a description of the TCU hardware and drivers, have a=20
>> look at
>>  >>  +  Documentation/mips/ingenic-tcu.rst.
>>  >>  +
>>  >>  +maintainers:
>>  >>  +  - Paul Cercueil <paul@crapouillou.net>
>>  >>  +
>>  >>  +properties:
>>  >>  +  $nodename:
>>  >>  +    pattern: "^timer@.*"
>>  >
>>  > '.*' is redundant.
>>  >
>>  >>  +
>>  >>  +  "#address-cells":
>>  >>  +    const: 1
>>  >>  +
>>  >>  +  "#size-cells":
>>  >>  +    const: 1
>>  >>  +
>>  >>  +  "#clock-cells":
>>  >>  +    const: 1
>>  >>  +
>>  >>  +  "#interrupt-cells":
>>  >>  +    const: 1
>>  >>  +
>>  >>  +  interrupt-controller: true
>>  >>  +
>>  >>  +  ranges: true
>>  >>  +
>>  >>  +  compatible:
>>  >>  +    items:
>>  >>  +      - enum:
>>  >>  +        - ingenic,jz4740-tcu
>>  >>  +        - ingenic,jz4725b-tcu
>>  >>  +        - ingenic,jz4770-tcu
>>  >>  +        - ingenic,x1000-tcu
>>  >>  +      - const: simple-mfd
>>  >
>>  > This breaks several examples in dt_binding_check because this=20
>> schema
>>  > will be applied to every 'simple-mfd' node. You need a custom=20
>> select
>>  > entry that excludes 'simple-mfd'. There should be several=20
>> examples in
>>  > tree to copy.
>>=20
>>  Why would it be applied to all 'single-mfd' nodes?
>=20
> single-mfd?

simple-mfd* of course, sorry.

> The way the tool decides to apply a schema or not is my matching on
> any of the compatible strings (or node name if no compatible
> specified). You can override this with 'select'.
>=20
>>  Doesn't what I wrote
>>  specify that it needs one of ingenic,*-tcu _and_ simple-mfd?
>=20
> Yes, but matching is on any of them. You need to add:

Alright, will do. Is there a reason why it's done that way? It sounds a=20
bit counter-intuitive.

> select:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - ingenic,jz4740-tcu
>           - ingenic,jz4725b-tcu
>           - ingenic,jz4770-tcu
>           - ingenic,x1000-tcu
>   required:
>     - compatible
>=20
>>  I'm not sure I understand what you mean.
>>=20
>>  I did grep for 'single-mfd' in all YAML files in Documentation/ and
>>  nothing really stands out.
>=20
> I guess even without the typo it was harder to find an example than I=20
> thought.
>=20
> Note that I think I'll make the tool exclude 'simple-mfd', but it will
> take some time for users to update so you still need to fix this.

Alright, thanks for the help.

-Paul

=

