Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882CEC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28620753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="QZr448e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCRIgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:36:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40478 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCRIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:36:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so25951723ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPBJn2ynYA8FJEh8jEBQDW67obM5EQ6JxVESIr5G6yA=;
        b=QZr448e03X1SLqCc4Dnk4uM0I3ixSAV5zIkNiw1rz87pIUY6oRIMRNV9PqrljcXj9a
         4fyIpf2y4kGj8zX247H4hg3Ol9suRDrX/YKmGSN/KRW7dlOypGjZ2M2eiSzYUG4USk+F
         PcJGvdV0uzHelwz6P2df1ZSSuNcRGXy9oh+GXj6qDAbG3GDL6GsEwIKFHyUKS9PJikSb
         OXKSr0x94bDktZolTFej6YovTmzcwb4/XjkG/cVhyhAPyqvlE1spQq4oJN1SlmIPUVhj
         pL1VPknjBRO5XFAx5/LnsUa7p+N4JFhnq4Q1s99C2eHk4o3ObRkbGkVl/oTGDfe0H/uY
         JBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPBJn2ynYA8FJEh8jEBQDW67obM5EQ6JxVESIr5G6yA=;
        b=eg8i1nSkXM70W8lDy4A1pLMU1lvuBPO7ydIrKjeSYURR1xhn0kCAH+Ybv3d0LwSlGt
         tq2PSrO6obrV7XbDaEpNVMYOgFbUqLQHkihRbppj3VAKtxHr8bHbtFpVdn+HeCngnyea
         OEHpY+7GQmrpPgktKf6pysQYS1W+9WdGKvmOXlkxjz+lDKQ7hb4sxDQbuYOEaD81c5mK
         8eVhStu5fvIT92MN1fKRd+LaNsYNt6qvWfHAFnjxir5EZF/YOqwzpPMMMGO9XCjc5Eiw
         +cCwSqVbH+GRRpiii362SnXPle9mffHVPr78TfxDUvz83w4wDf55SDC0udUujNFf+q3p
         BycA==
X-Gm-Message-State: ANhLgQ2FD0ZZWN7xJ8IDnXNo9G7wa9PzAIIXQWC0rEsuqV4FRdLDX2bK
        BFxzuWzc0Lza+c6Y4m7aUBQlh2DI8YraaR0pj24M0w==
X-Google-Smtp-Source: ADFU+vtiUorwgV4PFpNYqYoopqpRkCfZjSt9PPkm/PAS/NdlKM7bdkwklNxYBg0is2VnuB7B8PaXEZ7DimvmfvvZWO4=
X-Received: by 2002:a2e:b0f7:: with SMTP id h23mr1695669ljl.56.1584520560877;
 Wed, 18 Mar 2020 01:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
 <1584463806-15788-2-git-send-email-martin.fuzzey@flowbird.group> <VI1PR0402MB3600396A11D0AB39FBF9C54AFFF70@VI1PR0402MB3600.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB3600396A11D0AB39FBF9C54AFFF70@VI1PR0402MB3600.eurprd04.prod.outlook.com>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 18 Mar 2020 09:35:49 +0100
Message-ID: <CANh8QzxNYzLL8sAXwYEnic2-o-3xzyQaUZZ3LmaRO7fCfgoLQg@mail.gmail.com>
Subject: Re: [EXT] [PATCH 1/4] net: fec: set GPR bit on suspend by DT connfiguration.
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 at 07:26, Andy Duan <fugang.duan@nxp.com> wrote:
>
> From: Martin Fuzzey <martin.fuzzey@flowbird.group> Sent: Wednesday, March 18, 2020 12:50 AM
> > +static int fec_enet_of_parse_stop_mode(struct fec_enet_private *fep,
> > +                                      struct device_node *np) {
> > +       static const char prop[] = "fsl,stop-mode";
> > +       struct of_phandle_args args;
> > +       int ret;
> > +
> > +       ret = of_parse_phandle_with_fixed_args(np, prop, 2, 0, &args);
> To save memory:
>
>                  ret = of_parse_phandle_with_fixed_args(np, "fsl,stop-mode", 2, 0, &args);
>

Why would this save memory?
prop is defined static const char[] (and not char *) so there will no
be extra pointers.

I haven't checked the generated assembler but this should generate the
same code as a string litteral I think.

It is also reused later in the function in a debug (which is the
reason I did it this way to ensure the property name is unique and
consistent.

Regards,

Martin

--
