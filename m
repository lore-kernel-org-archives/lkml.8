Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6B6208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6iZdECV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgH1Fyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1Fyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:54:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1EC061264;
        Thu, 27 Aug 2020 22:54:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e11so1006273ljn.6;
        Thu, 27 Aug 2020 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M5X//ZshFwH0KFUFC07IKRMrNcpHsYLBwYNF7u93/jc=;
        b=F6iZdECVa/kC5OREMqVO4E3qSsVlgWKNDTK8rq46y6mvBT8n0W1NYWRQqb7du7Fx9M
         yDeuyYdz9peRTfxLOYbdSOOavxmHIQ3JYtMqq9N9xSGpdEPGNePDNHLxxaW79jOPw9rW
         K+wQIWujkdKVzKm4QfKadr8CH79KcuM4+JFbt78igw+vbjzjO8rqaiGLfwDwPDhSLjUZ
         DZfZmjj5SdRzzc17r3iHwjEKCP/Hjo87fElmJj5jFSL100xIAflQklK9F92nlrEk7+KE
         EwriOUxhqRtsk0tPr+eAsnJe3TFJxj+IL/SNDq05FL9lLIa8PHYgBYx1NbI8UTVi715N
         EhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M5X//ZshFwH0KFUFC07IKRMrNcpHsYLBwYNF7u93/jc=;
        b=Jde+IinPG4arEy1VMXqj00YuQ2tEUtf+cfE0yhCFPfCWQsIBhNtS91fhmWGnlMrijO
         or4GInDuhQgrjOelcb+5PbQwO8UDrGZmDXDmSA0W741+T8++NSgB4qjIvmr7vNY8VChN
         DjHHXJEVcH0Qjo5F96pKWISUySnRihx/gXzjz+Zuy6jo37Uu/AbzzF3z/z8v5l7RaEO1
         Gt+KWolyB6BtwGrrbWc9Sa/KktEttWxxFQj2n1q+r/u4AK3zUI3PNXA6Xis1TMr813As
         yLcMAeJR6XA8Hv2GMMv7iE8Rn31V4/Mks09vQ1xJNHEYZRWLvneI4Xe/guINhyuiXEIo
         /L5g==
X-Gm-Message-State: AOAM532GIHFT0HBxSTXiYhQ0g3vOv8ZNxUkIp9D6CVUQXswxyQrKZZbK
        vDuowGALj9BCQTvsNU+ZrZYHjbxc8CPo2Sk+4Hw=
X-Google-Smtp-Source: ABdhPJwyIjGEyHiu5PklJExnAu2irMyZy92E3HWunXZk6nTyo4YZk5QUP6tuzmB3qWO18Rd/8O81zM+WhqbVxbAaCsI=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr96315ljn.356.1598594068735;
 Thu, 27 Aug 2020 22:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
 <1598527137-6915-2-git-send-email-u0084500@gmail.com> <20200827164131.GA86149@roeck-us.net>
In-Reply-To: <20200827164131.GA86149@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 28 Aug 2020 13:54:16 +0800
Message-ID: <CADiBU38oTZLR=EPSW=ANGZn8074FyQqb=WS5kyMvu_8_Ua=XaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb typec: mt6360: Rename driver/Kconfig/Makefile
 from mt6360 to mt636x
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B48=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, Aug 27, 2020 at 07:18:56PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > 1. Rename file form tcpci_mt6360.c to tcpci_mt636x.c
> > 2. Rename internal function from mt6360 to mt636x, except the register
> > definition.
> > 3. Change Kconfig/Makefile from MT6360 to MT636X.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/usb/typec/tcpm/Kconfig        |   6 +-
> >  drivers/usb/typec/tcpm/Makefile       |   2 +-
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 --------------------------=
--------
> >  drivers/usb/typec/tcpm/tcpci_mt636x.c | 212 ++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 216 insertions(+), 216 deletions(-)
> >  delete mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
> >  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt636x.c
>
> Maybe Heikki is ok with this change, but I am not, for the reasons
> mentioned before. So I won't approve this patch. Note that, either
> case, it should be merged with the first patch.

Yes, I agree with you opinion. use 636x,  the range is too large from
0 to 9, it may not all be compatible.
Even though it's also possible that the part number don't have the
same function.
So I'm going to remove the rename patch.
Do I need to add a patch named "revert"? Or just remove it. I'm not
sure which way is better.

It seems you all want the code change to be squashed into the first
code. And the second one is the DT binding. Right?


>
> Guenter
