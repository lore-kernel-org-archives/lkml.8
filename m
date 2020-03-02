Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCDAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0779420842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583176056;
	bh=QGcsFJqfxX2CH6Jn461c3OOCYIcfNyPBNlEZzre/Bs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eNSwNDucE9YpOnzrJk8ACu4J5WajqAMAjwjohNkDcIxbqHaKkAWQ/ZgCjrEqRfzju
	 DFrUb3eqT6+DnOAn6skQzm02BHm6noQ3GTCtjIkKj3w68HwBrlYpb2okIOxWL0jVd0
	 9XHxBWP/4mdctJxLEZiodCS6FoPeETcgxkQlp+/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgCBTHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgCBTHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:07:34 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864A42166E;
        Mon,  2 Mar 2020 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583176053;
        bh=QGcsFJqfxX2CH6Jn461c3OOCYIcfNyPBNlEZzre/Bs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ykR8CdMFysZ8qQKYbVC0iSlyGhLnHUned5fbfqhUuTRZtoSA1q2vlelSnA8KQ9mUq
         e9Ci76+mzNKMuVuYs6OGGFhlCSN4w1+vJcuAghJn21a95hoO9FvfZWjCw/vzxqJvkh
         8RN7sgPrYXUROt8gz0e9vLVnhyCMLGkSgzsZPLaU=
Received: by mail-qv1-f46.google.com with SMTP id r15so434470qve.3;
        Mon, 02 Mar 2020 11:07:33 -0800 (PST)
X-Gm-Message-State: ANhLgQ3Zasxy8E0hxwCYSAlCu0CkI0CdautPsV4etk35g+vvSRqSNQGR
        wKYZ3MRnR4+I9G24C2idblr7cUPVF+Nun3i39A==
X-Google-Smtp-Source: ADFU+vvCdpNqkg16UxszbJIrHJ1wuxjnyVExPclx0f5KeRY5ngJkUGlO8evCVafaGIBFxh51ZQLB+9Wh+KhHUfvbs1Y=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr776291qvn.79.1583176052684;
 Mon, 02 Mar 2020 11:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20200301174636.63446-1-paul@crapouillou.net> <20200301174636.63446-2-paul@crapouillou.net>
 <CAL_JsqKGzxdMj4_+i4ycKj6ZjiuGMY8F+yBzVPt_b2CLhrcdKg@mail.gmail.com> <1583173481.3.0@crapouillou.net>
In-Reply-To: <1583173481.3.0@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Mar 2020 13:07:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7b8mwtg3XyNS2fdA4fxaFdUpsfqTPx521pW5xqSPneg@mail.gmail.com>
Message-ID: <CAL_JsqL7b8mwtg3XyNS2fdA4fxaFdUpsfqTPx521pW5xqSPneg@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 12:25 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
>
> Le lun., mars 2, 2020 at 11:06, Rob Herring <robh+dt@kernel.org> a
> =C3=A9crit :
> > On Sun, Mar 1, 2020 at 11:47 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >
> > Well, this flew into linux-next quickly and breaks 'make
> > dt_binding_check'... Please drop, revert or fix quickly.
>
> For my defense I said to merge "provided Rob acks it" ;)
>
> >>  Convert the ingenic,tcu.txt file to YAML.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ----------
> >>   .../bindings/timer/ingenic,tcu.yaml           | 235
> >> ++++++++++++++++++
> >>   2 files changed, 235 insertions(+), 138 deletions(-)
> >>   delete mode 100644
> >> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> >>   create mode 100644
> >> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> >
> >
> >>  diff --git
> >> a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> >> b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> >>  new file mode 100644
> >>  index 000000000000..1ded3b4762bb
> >>  --- /dev/null
> >>  +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> >>  @@ -0,0 +1,235 @@
> >>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>  +%YAML 1.2
> >>  +---
> >>  +$id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
> >>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>  +
> >>  +title: Ingenic SoCs Timer/Counter Unit (TCU) devicetree bindings
> >>  +
> >>  +description: |
> >>  +  For a description of the TCU hardware and drivers, have a look at
> >>  +  Documentation/mips/ingenic-tcu.rst.
> >>  +
> >>  +maintainers:
> >>  +  - Paul Cercueil <paul@crapouillou.net>
> >>  +
> >>  +properties:
> >>  +  $nodename:
> >>  +    pattern: "^timer@.*"
> >
> > '.*' is redundant.
> >
> >>  +
> >>  +  "#address-cells":
> >>  +    const: 1
> >>  +
> >>  +  "#size-cells":
> >>  +    const: 1
> >>  +
> >>  +  "#clock-cells":
> >>  +    const: 1
> >>  +
> >>  +  "#interrupt-cells":
> >>  +    const: 1
> >>  +
> >>  +  interrupt-controller: true
> >>  +
> >>  +  ranges: true
> >>  +
> >>  +  compatible:
> >>  +    items:
> >>  +      - enum:
> >>  +        - ingenic,jz4740-tcu
> >>  +        - ingenic,jz4725b-tcu
> >>  +        - ingenic,jz4770-tcu
> >>  +        - ingenic,x1000-tcu
> >>  +      - const: simple-mfd
> >
> > This breaks several examples in dt_binding_check because this schema
> > will be applied to every 'simple-mfd' node. You need a custom select
> > entry that excludes 'simple-mfd'. There should be several examples in
> > tree to copy.
>
> Why would it be applied to all 'single-mfd' nodes?

single-mfd?

The way the tool decides to apply a schema or not is my matching on
any of the compatible strings (or node name if no compatible
specified). You can override this with 'select'.

> Doesn't what I wrote
> specify that it needs one of ingenic,*-tcu _and_ simple-mfd?

Yes, but matching is on any of them. You need to add:

select:
  properties:
    compatible:
      contains:
        enum:
          - ingenic,jz4740-tcu
          - ingenic,jz4725b-tcu
          - ingenic,jz4770-tcu
          - ingenic,x1000-tcu
  required:
    - compatible

> I'm not sure I understand what you mean.
>
> I did grep for 'single-mfd' in all YAML files in Documentation/ and
> nothing really stands out.

I guess even without the typo it was harder to find an example than I thoug=
ht.

Note that I think I'll make the tool exclude 'simple-mfd', but it will
take some time for users to update so you still need to fix this.

Rob
