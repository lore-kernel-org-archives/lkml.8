Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93FEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23A420716
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTVHpbRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCMCTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:19:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33313 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMCTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:19:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id p62so10077126qkb.0;
        Thu, 12 Mar 2020 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pktZUkJhZ989W+vJIraSaCZ1FCtyBz516+gaNJ90Vgs=;
        b=jTVHpbRoj6btsip1/T8KXdZbo5gKq4gzME+ntCVbqmvcInzGNiW53fmLzwm2XkxRaO
         KOwN+i9La1jPNywjDdWVchmnjqCTfr7OM/l39xDrNHMYOYbbAX1gBTC9E8y4OSP/iQiE
         mtGsTQjv/wUV5NtR8LIEPRnccTllHMBhCYsefg3izwHPaWeTDZn2Rk/sOdLYly3UOc/c
         b6VzcqTQOsF/FLX6Zy09BD6hKMHEFDLvbrI9ILdq8klobIZBbkGwTnXlX2u7aRmqELQy
         DMFTil5s5fKtJw79AiDs5rU65enLZIAvf/tEQKExMCuIoqBP1byi9B+/qRsxbm/58Jd7
         xgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pktZUkJhZ989W+vJIraSaCZ1FCtyBz516+gaNJ90Vgs=;
        b=Txduk106H9dMDonKd3LEfq9we8pZB7zeKZiPbozLaeuo0Uoo3nvJOnX03dQ3o9/J66
         zSsa189DcYVHkr8PJyb68s9ArewcNl44r4/6jkBTJtHAOFh50CiKuL4roQt8H0l9Kzxi
         bl5ExE/Kq6DSr2cdIXKd0L/f5XJtG54oBeMDzHc6RvORlwgCutmUyQrgqDSRaZ59S0wK
         MrR69TxZG70VQpkBUUFfMTcIGjDF2J5M30vP5WU4hB3YzjM6IvkkQfntl6Gt+G0Q92Pu
         23N4L0qnG7eLxNJLqoTdKUyy7wB+BhCOvmhYHa6MLtCG3FfSLMT8/DcCcDhMayZu9U7U
         fdBQ==
X-Gm-Message-State: ANhLgQ34WF4fiGmPkQIP+LZaZL3p52ABmq72Gbw3Q8PdhvLoyywCM6Ux
        ixPDG7czoqPEKoKO9i4YcS7qZpOIKpL95jvk4OQ=
X-Google-Smtp-Source: ADFU+vtodrMhsnbgv1DLR4VQsEBdTtkVF8ZTLE1OXuNkcbtF3C7RnOKjx77zI5S8mvl36ghHLA3xzg/bHHw/B0DVzlQ=
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr4196246qkh.395.1584065989504;
 Thu, 12 Mar 2020 19:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <9bc2631ff3ab60fc607a5215e561aace83c0e8ca.1583464821.git.baolin.wang7@gmail.com>
 <20200312191616.GA9697@bogus>
In-Reply-To: <20200312191616.GA9697@bogus>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 13 Mar 2020 10:19:38 +0800
Message-ID: <CADBw62r6xvRW6i3f8NDf-OWTNimE_B8ewoFuOfcMgRUkM8B7gA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
To:     Rob Herring <robh@kernel.org>
Cc:     mark.rutland@arm.com, jassisinghbrar@gmail.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Mar 13, 2020 at 3:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Mar 06, 2020 at 02:07:21PM +0800, Baolin Wang wrote:
> > From: Baolin Wang <baolin.wang@unisoc.com>
> >
> > Add the Spreadtrum mailbox documentation.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > new file mode 100644
> > index 0000000..2f2fdcf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Spreadtrum mailbox controller bindings
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,sc9860-mailbox
> > +
> > +  reg:
> > +    minItems: 2
>
> Need to define what each entry is.

Sure

>
> > +
> > +  interrupts:
> > +    minItems: 2
> > +    description:
> > +      Contains the inbox and outbox interrupt information.
>
> The description should be split to define each entry:
>
> items:
>   - description: inbox interrupt
>   - description: outbox interrupt

Sure.

>
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: enable
> > +
> > +  "#mbox-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#mbox-cells"
> > +  - clocks
> > +  - clock-names
>
> Add:
>
> additionalProperties: false

OK. Thanks for your comments.

-- 
Baolin Wang
