Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DF92073E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inEhFPEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgGHAmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgGHAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:42:50 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A4C061755;
        Tue,  7 Jul 2020 17:42:50 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h16so14308915ilj.11;
        Tue, 07 Jul 2020 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue4EIK0VhUIPtRObeZ3zttXF6R0Ao0zF/3q1pqokQPM=;
        b=inEhFPEnStHD/Ywc3gvLNoiHq+XKOlw6RgBQNg06T/GFGXVwaTL3DElg3MctaSyQfM
         6lL/vnfDnogiuVoryb3vftEDddvFbO4/CH3vLBiDa0ehOkN/8edK00DDjyW5cH6zLC8E
         1nKTyNwesdBhHJZb4ReHMkbyrIefPE1UC+6u/XyfJTYOiUPj1gYN0RvjphoGpZbqqptB
         ZNtQafGsg5zOTnpoCifsgTeDv6+2GsdKuFAxx57qq9BXssb5DA2wjgZ9TbdCkHmcnw/n
         n0QZAO9uQwbKHgPVh7eldKClSsQuFAz9x/hKuLGNirnjzavt6HruIx3UXW2iFuoly1hb
         yuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue4EIK0VhUIPtRObeZ3zttXF6R0Ao0zF/3q1pqokQPM=;
        b=XdHqsx563oCRwbV5pr60eSL/nXpAUssri3Xqb1zDI2LkxmGEdtCADHvZIDtpmZMBOb
         s+gqiCKsx72olRad/23r0noyXvRTHmWYeXjFF/bu4B7cPWw7Dd75yXnzJBT+6u5Mw3MT
         IpsMnRggIv66l4LTITLzlkh1ylOCq7GROYRcEiTO+fyc17aeFJjWkJ0GthHTTpM4gxkM
         GceZfUXehAjR6DbX5FEhGHiKkJQEpNbfkGQ9rtezqTCtvp2HzjGb1KHBB2PuqB24ExE+
         WBbHyqDjILhQN3uRIFd1MgqOC3KMAe/tEToRfG/cXYk3uvT5MmUFq0XCKgxtBbeH0VGt
         Zsgg==
X-Gm-Message-State: AOAM531PAEFVVOiX3FkOeGPDcC1Nfhx6tcH6TQj9axKnH9QOUXQEyuBa
        pNiRYIS6T4M9SdKQ2cI7BL2N3+2r3Xht3aA0J7o=
X-Google-Smtp-Source: ABdhPJw89Chg6p49ozpxXXxKixO+Ec9eT77p/qN2LR0pq5SKVnLXCaH6XvOadplfXVQXCE887WnMJ23c22bBOsavkck=
X-Received: by 2002:a92:aa92:: with SMTP id p18mr38384061ill.199.1594168969758;
 Tue, 07 Jul 2020 17:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200708003209.4737-1-cphealy@gmail.com> <CAOMZO5BYDXbVUKad4Cn0fauGMEFu4ZPSOwunrFxMq7+bDYPtMw@mail.gmail.com>
In-Reply-To: <CAOMZO5BYDXbVUKad4Cn0fauGMEFu4ZPSOwunrFxMq7+bDYPtMw@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 7 Jul 2020 17:42:37 -0700
Message-ID: <CAFXsbZqy8jtNbx-0oZQ=v+7ZuQTN6MUZELW5QVayk3xz=wHcCg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: zii-ultra: update MDIO speed and preamble device
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 5:41 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Chris,
>
> On Tue, Jul 7, 2020 at 9:32 PM Chris Healy <cphealy@gmail.com> wrote:
>
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >                 status = "okay";
> > +               suppress-preamble;
> > +               clock-frequency = <12500000>;
>
> Sorry, I missed this in the previous review.
>
> The recommendation is to have status = okay as the last property.
>
> Please move suppress-preamble and clock-frequency = <12500000> prior
> to status = "okay"

Will do in the next version.
