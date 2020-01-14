Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6733C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5682467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579012772;
	bh=DkkSSSCcpDI9HeBQHY1IX3M01OsOOAVdyk5wwFtEJpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XLa+gDGfFWLVpqEKYZpqK5qGlvwvGWYGzgzgzTQf7EKmaT5HSa691YAsRkgkcoTnG
	 bMydCvpeA+ThzftsA1ToJuZu4Lmg/tBIXQaB/CxygyC1sFd3tjPi0CzxpSRbys8PGO
	 6srUH0YqKCpA6c2tvykNrL5lHJZ/BUKYWncfMHLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgANOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgANOjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:39:31 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318B824685;
        Tue, 14 Jan 2020 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579012771;
        bh=DkkSSSCcpDI9HeBQHY1IX3M01OsOOAVdyk5wwFtEJpg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2U3xxpKjVAikQnGWGZrNjaxs5Apbhn+ojqeT82/Vl3Q+wQDgqLlpmDMTKg9pEShuB
         Pz8Zq2N3d+npGfUnohK9Rz+K8OHbYApz8F2lodPqA3EoKHPg5s0qzC6VBOmoJX0UvE
         a+wZ37ge2JeKn1i4pujDAY5uE6WaQDtsu30JQgRY=
Received: by mail-qt1-f182.google.com with SMTP id 5so12646014qtz.1;
        Tue, 14 Jan 2020 06:39:31 -0800 (PST)
X-Gm-Message-State: APjAAAVGPYbmZzjfBG1e69ix8GyFdn8TqS5lSmCpp+uWp+XtZpmY+ZMs
        BnCnJqJDWQmQG7HXfrIZjIT8wWWy0xx43Q7r5Q==
X-Google-Smtp-Source: APXvYqyyZlLy3kbLcDFKfECxJkAxHjCNepUAq3Vqf3Zhjrwf3ciIqlftYUmPRgi34c5gRrNnNETWFPxp2qXg/nkzX24=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr3886974qtp.224.1579012770304;
 Tue, 14 Jan 2020 06:39:30 -0800 (PST)
MIME-Version: 1.0
References: <1577696078-21720-1-git-send-email-peng.fan@nxp.com>
 <20200104003634.GA6058@bogus> <AM0PR04MB4481917D6A969053CB85276F883C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481917D6A969053CB85276F883C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jan 2020 08:39:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsQmvM0Qsspj5n+1iy5X0TXaULonGtjKRkdOoSQVQmzw@mail.gmail.com>
Message-ID: <CAL_JsqLsQmvM0Qsspj5n+1iy5X0TXaULonGtjKRkdOoSQVQmzw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 5, 2020 at 8:38 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Rob,
>
> > Subject: Re: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
> >
> > On Mon, Dec 30, 2019 at 08:58:05AM +0000, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > There is no binding doc for "fsl,aips-bus", "simple-bus" is enough for
> > > aips usage, so drop it.
> >
> > NAK. The AIPS bus has registers, so 'simple-bus' alone is not enough.
>
> You mean the "reg" property below, right?
>                 aips-bus@2000000 { /* AIPS1 */
> -                       compatible = "fsl,aips-bus", "simple-bus";
> +                       compatible = "simple-bus";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         reg = <0x02000000 0x100000>;
>
> But the reg property is not required, I think it could be removed.
> There is no binding doc and driver for "fsl,aips-bus", so I think
> It not make sense to have that compatible in dts.

Well, there should be a binding doc, but whether or not there's a
driver is irrelevant.

From what I remember, either AIPS or SPBA bus has registers to allow
user mode access or not. Something may need to configure those and it
may want to use DT info to do that. It's not just Linux that you need
to think about.

Rob
