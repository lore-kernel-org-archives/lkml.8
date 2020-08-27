Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB34C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88322054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjBwiPji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgH0OwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0Ov5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:51:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EDC061264;
        Thu, 27 Aug 2020 07:51:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so6728543ljc.8;
        Thu, 27 Aug 2020 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=txhfrSF9RX3MqxwN9hoW/kar0+P8SVn2XnHOzqJQ9IY=;
        b=gjBwiPji3SaNbCP9jML1HZoNahK/I6qqs0rl0EygcZbZRptYdcMLHdy1mv7UHcaDp0
         +SUHGKslVz5TRz1z7pi7ETrhxoG2F4LiDXmAi5z22/+KyryUnUvOlH3Du1iqooWTAmiI
         gyt4ZHvwYsreEvMfFGES4WdC5hyJ9xDyNT6KxBEdkshROOsM3DbwVyaKf5XqbIzaLCW3
         2lgsa4SeK2WfjzhOr36LgK+d+MnFbnwSH3ryYf8jPNSSscvVS66RS1qRwWmJCTBwaMcE
         NwJdJy/VloyZP1dH0avdKUyPtuRnd6MBdpz+2Rhxdc+62XDR8G5XrE3S0sk3qNda5+Jq
         Uswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txhfrSF9RX3MqxwN9hoW/kar0+P8SVn2XnHOzqJQ9IY=;
        b=sKa358u3eSein4TlZIZqelc63X+gVmMrTUNj3kNmcoAKvaAwrNAFPHDLDrtFXgl3Rw
         ZpN60xPejRg22LG/0cui5K9qny1lEZlCdzzeXN0ZZigK+ZQkGy86e9RlFFeaqWQKscrF
         Gckf/QJDMZ/Cg41NDJV8EuD0GKNTMLlhhEtaKerUDQbQT+pJ2U8QLsRw5yfzFR4iz6Xr
         Ojq01HOWoNOq1dVx2jqklQvLsXJ8YjKp8bMXtiycEaY60NgVHmbNwQ1+/hU6XAZp281t
         Vy0414SUOaUqofwpslwSqa9JNBbGfPQ+TD5rA6BALe73a2/eQQRBP170RSTuTfrX33+a
         qsRA==
X-Gm-Message-State: AOAM533+q8iTBF16hzQs7h9/hOYFyw5HZNC+YlPyHhDpHj5V0i6gXilQ
        K+ouEdqY0voV3VzSy8QHrzGz/+UMRt1NftG7awk=
X-Google-Smtp-Source: ABdhPJxkVhI0j2VsdBWVwc0FSlt/bcCfk71WFFX36z10VABx6cu21rQwkSKWef3JMaP2Bwmgr7KClVB6jt0m6gXA8C8=
X-Received: by 2002:a2e:160d:: with SMTP id w13mr10443684ljd.470.1598539914375;
 Thu, 27 Aug 2020 07:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com> <20200827140001.GE813478@kuha.fi.intel.com>
In-Reply-To: <20200827140001.GE813478@kuha.fi.intel.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 22:51:43 +0800
Message-ID: <CADiBU393V_iQw_8Hx2braL=8QpvQuTY0059C-XkqmjO9W=aBgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com, Guenter Roeck <linux@roeck-us.net>,
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

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2020=E5=B9=B48=
=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:00=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, Aug 27, 2020 at 07:18:55PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > It works with Type-C Port Controller Manager to provide USB PD
> > and USB Type-C functionalities.
> >
> > v1 to v2
> > 1. Add fix to Prevent the race condition from interrupt and tcpci port
> > unregister during module remove.
> >
> > v2 to v3
> > 1. Change comment style for the head of source code.
> > 2. No need to print error for platform_get_irq_byname.
> > 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
> > 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
> > 5. Rename DT binding documents from mt6360 to mt636x.
>
> You don't place additional changelog here...
>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
>
> You put it here, after that '---' marker:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#th=
e-canonical-patch-format
>
HI Hekki:
     after reading the document, I have a little bit confused how to
use diffstat for the changelog.
      Is there any example that make me know to write a clear
description for the changelog?
>
> >  drivers/usb/typec/tcpm/Kconfig        |   8 ++
> >  drivers/usb/typec/tcpm/Makefile       |   1 +
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 221 insertions(+)
> >  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
>
> thanks,
>
> --
> heikki
