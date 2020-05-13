Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F3C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A320020657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgEMNmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:42:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38225 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:42:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id r66so21437312oie.5;
        Wed, 13 May 2020 06:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AJqwk7cM9EuyVKFIeU+8pHEwO2wGhZt8sZ99CVUFbw=;
        b=uLRBaohPqmwWeI/3K+lkCuAa2l9ABROedS9C1Vkdt6WdqAQFsyaAbcWLyhLj5/VSq1
         57h8UU4EfhPjtnJljr9UgLPmVmpXtgo17dL+mq3TjkcttOr86JVMO4Gqr/G48+4zM6HJ
         OMxShXtXYjsbvIWzUTkSgoEQ0UGan8hylyzAzvM2B1UEu20wtiqT8EfuxzWnje9dkK3b
         JwHLR6TJ0rn0m6RNxDfn4BsIF/9dNByQH3kOa3rZFe4mOgV7IrLpIDBnWwx22fKQW11+
         +1j2MhkM0z0KyLLyXdovph6KsJxe1EWKX20++NGQ8+SgZtDwgcWTdfuq60SyC19diNuw
         TvYw==
X-Gm-Message-State: AGi0Pua01bm5aNaDwlOByROJxvt8dAy2K3Fhm7v+W9fMgQ+9mZo1T6bI
        LbAHxv4dbynAVUyBr/xdaRSQSl7qfN8e46ZMibI=
X-Google-Smtp-Source: APiQypKM3qNMrM7Mr8xKsVEdw0prpk+GU776ZUdk9Tin4YaeuL5902yDkTymzSQYsbtZg2ReeJKhdXpNMrDE4SOePgI=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr4637006oig.148.1589377366271;
 Wed, 13 May 2020 06:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200507075503.32291-1-geert+renesas@glider.be>
In-Reply-To: <20200507075503.32291-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 May 2020 15:42:35 +0200
Message-ID: <CAMuHMdVyFW-oWsDsOAC+H4f3oQZpwH=dPQHy3djgHnEJ-81+ug@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: irqchip: renesas-intc-irqpin: Convert to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:55 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>
> Convert the Renesas Interrupt Controller (INTC) for external pins Device
> Tree binding documentation to json-schema.
>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> Co-developed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml

> +  sense-bitfield-width:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [2, 4]
> +        default: 4

The "allOf" is no longer needed.  Will remove for v4.

> +    description:
> +      Width of a single sense bitfield in the SENSE register, if different from the
> +      default.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
