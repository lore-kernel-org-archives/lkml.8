Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2772C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67B524691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814833;
	bh=UFk4DKDT/RavUVjsZH/Q78QOV9roAST50YZBqSmnO2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h+NOEkg26rEmGaKD1mwLgMKpdY7lqPym9KbkF0Or5MDueO5hhpKp3drfiRK0rS/EF
	 mVmL44+7Lsdy5dhG4gRyFbimSXa91+JRLP7OFeDH5dJ6zSGTwVpLnqEiXWjsQAMwvl
	 4/JFhJF1er6rS9bUbZvMDJSyLSKWFAKoB23i8m54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgB0OrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgB0Non (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:44:43 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C46246AF;
        Thu, 27 Feb 2020 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811082;
        bh=UFk4DKDT/RavUVjsZH/Q78QOV9roAST50YZBqSmnO2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n4oGvOmwC99Lmi5J+GMCuRBByRgoeP0UELiYzDqyAxyrgXLKSlmUYurL8CUziHp/g
         7oaLvWk/URj2xARQ6zQr+kZDgtfUmsR6JI5EdXIHj8BGK8DP7xIFiJSs4q8Y1xjmtp
         Bqpeh4X7pTULE1qoDzvp+wnP0IKWvL/BlppoM/dc=
Received: by mail-qk1-f170.google.com with SMTP id h4so3157497qkm.0;
        Thu, 27 Feb 2020 05:44:42 -0800 (PST)
X-Gm-Message-State: APjAAAXyJP5ruvMaxmAhwdOrXAGRrCHo/0NxFy/yO3GQgm5xRnkOCYx/
        MH7O8f7Tm/wwQIdIYpqoIrMPkpSb7EipTRfk4g==
X-Google-Smtp-Source: APXvYqxJt8vQFSvhhMBaDRNc9+rWFwZOnJGWrPvzbGPu2EaTUhy2OiKjS2GBDVr9kzPAE6HvyHbvr3auJoAsonMv+HE=
X-Received: by 2002:a05:620a:1237:: with SMTP id v23mr5784092qkj.223.1582811081310;
 Thu, 27 Feb 2020 05:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20200222141927.3868-1-yamada.masahiro@socionext.com> <CAK7LNAQmzYzK_A4iF6b-LxTT-o5Ut2=TyBeRQPSfCdj7FHhgBQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQmzYzK_A4iF6b-LxTT-o5Ut2=TyBeRQPSfCdj7FHhgBQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Feb 2020 07:44:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1Je+Tmwrb2vX=0c+FKSk19qKFWg1Au=k35AZKL=R1Pg@mail.gmail.com>
Message-ID: <CAL_JsqJ1Je+Tmwrb2vX=0c+FKSk19qKFWg1Au=k35AZKL=R1Pg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Convert Denali NAND controller to json-schema
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 7:59 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> This was applied, but I just noticed one stupid mistake.
>
>
>
> On Sat, Feb 22, 2020 at 11:20 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Convert the Denali NAND controller binding to DT schema format.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  .../devicetree/bindings/mtd/denali,nand.yaml  | 149 ++++++++++++++++++
> >  .../devicetree/bindings/mtd/denali-nand.txt   |  61 -------
> >  2 files changed, 149 insertions(+), 61 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/denali,nand.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/denali-nand.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/denali,nand.yaml b/Documentation/devicetree/bindings/mtd/denali,nand.yaml
> > new file mode 100644
> > index 000000000000..b41b7e4bfe78
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/denali,nand.yaml
> > @@ -0,0 +1,149 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/denali,nand.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Denali NAND controller
> > +
> > +maintainers:
> > +  - Masahiro Yamada <yamada.masahiro@socionext.com>
> > +
> > +properties:
> > +  compatible:
> > +    description: version 2.91, 3.1, 3.1.1, respectively
>
>
> Please delete this description.
>
> This is a copy-paste mistake, which
> came from my other patch
> "dt-bindings: mmc: Convert UniPhier SD controller to json-schema"

Done.

Rob
