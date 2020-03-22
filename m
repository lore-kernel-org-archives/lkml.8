Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECACC54FCE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435A720753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri+n76E+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCVLBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:01:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCVLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:01:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so12932550wrm.4;
        Sun, 22 Mar 2020 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSNfn1lOuwrdFcFfi180EAlddz36torDoaIxoG4z+2U=;
        b=ri+n76E+3tHH8Z3EWDRFGOg52UBOIuh1YosaBsija/90WTG2WKxKUOKBNnnIgYpa8S
         nF74tppOl3nSTC3mw4dszoys9PPkIVRdh0Q+VdMkWH4m6paGT6MXie2jmJdN/lV6csja
         M+azlwzV3XG6UXsH9A2zeIhdLKLwTzuNWJUSIicFwQkaujfbYmbYTQVC2EDx0rL7e25G
         jdZotnUuiVBz5dYL9dPzD7i4Eb3RwTRILrRr1aGOUlBc5SLWJXy0zhibuRPYoKC+x6NS
         PXU6j4zMCJuIAJfVZVlF1NNxta4AbY6x7iEEa5PWsZ92iDwjT18ANYK/HD5EnapZ4YkI
         lVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSNfn1lOuwrdFcFfi180EAlddz36torDoaIxoG4z+2U=;
        b=IfMoWI7I43U6K8xuMdIPJAlVtRKC+lIWVKdnV+Ffy6b4CFZa6hVwUP+bP6VcqDO6H+
         Im4B5ssBN6MM1W6bPyHIZNoGwpnQpOtMH7XRJRtbdcEde58IePBfqrNNATSXFwkqGFhi
         UB6yblt9O8VoxPBdunHtmFAkcWNLeuRYf4eBcKKxSgJNxmz4WG98MUBUzzlyVUqr6Oe9
         BEALv6ntRmjX+eHJLad/YlCVtcd2iRflqBsJKQX4YjhTeK5xxMSq9X8/A4YY2lrr1KkY
         XUj9s1j9+ppec3DCZWV+dVcD2+R5sMTZhjf/9sIKzFYm57dmNZY22s3FGEWJ3sbLT1rt
         XDmw==
X-Gm-Message-State: ANhLgQ0HNU4pjZ3ngL5U3uJl63P2GDxEcLVrJ91GiVvohNXFXz6KQkec
        h4B1KN+nh0ww4ZCDSO1Phyo/fr561wcOknIB85k=
X-Google-Smtp-Source: ADFU+vsSBXMut+ZcU1fczh3pG4r8yPPPXaEt73HpCzUdEb+UaS8v/m5UKZuNuctmlE8iRS0oXgF7Gx/RJiLBK6bCOdc=
X-Received: by 2002:a5d:674f:: with SMTP id l15mr4404734wrw.196.1584874876241;
 Sun, 22 Mar 2020 04:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072730.9193-1-zhang.lyra@gmail.com> <20200304072730.9193-4-zhang.lyra@gmail.com>
 <158475317083.125146.1467485980949213245@swboyd.mtv.corp.google.com>
In-Reply-To: <158475317083.125146.1467485980949213245@swboyd.mtv.corp.google.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Sun, 22 Mar 2020 19:00:39 +0800
Message-ID: <CAAfSe-sQnZLn8J7Ct5OES=2PmT-nGT-_0zXxRaO=mcHVtgTcnQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sat, 21 Mar 2020 at 09:12, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chunyan Zhang (2020-03-03 23:27:26)
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > add a new bindings to describe sc9863a clock compatible string.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> [...]
> > +examples:
> > +  - |
> > +    ap_clk: clock-controller@21500000 {
> > +      compatible = "sprd,sc9863a-ap-clk";
> > +      reg = <0 0x21500000 0 0x1000>;
> > +      clocks = <&ext_26m>, <&ext_32k>;
> > +      clock-names = "ext-26m", "ext-32k";
> > +      #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      ap_ahb_regs: syscon@20e00000 {
> > +        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> > +        reg = <0 0x20e00000 0 0x4000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges = <0 0 0x20e00000 0x4000>;
> > +
> > +        apahb_gate: apahb-gate@0 {
>
> Why do we need a node per "clk type" in the simple-mfd syscon? Can't we
> register clks from the driver that matches the parent node and have that
> driver know what sorts of clks are where? Sorry I haven't read the rest
> of the patch series and I'm not aware if this came up before. If so,
> please put details about this in the commit text.

Please see the change logs after v2 in cover-letter.

Rob suggested us to put some clocks under syscon nodes, since these
clocks have the same
physical address base with the syscon;

Thanks,
Chunyan

>
> > +          compatible = "sprd,sc9863a-apahb-gate";
> > +          reg = <0x0 0x1020>;
> > +          #clock-cells = <1>;
