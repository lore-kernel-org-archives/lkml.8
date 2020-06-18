Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB8820773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbgW/1mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgFRLia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgFRLi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:38:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:38:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b5so5423756iln.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HnqZ825QaUjHcFcUoPVeekIL3cloh6uSJswdCHcGNMU=;
        b=XbgW/1mXE4RlRrvQUAPe6piL/vvN9pMY8TMFHLIfTTurGrvqjI7qc00i30vHQLli1M
         OGqVPPM3Bo/wUZ51cib1et1xvfLqpJePfWs6ULwM7yUhrWpn8C7Sac8BAMpXhofGttKG
         Y95mEIZ2YSDycjFQJ74N0d76rpEVaUYI/EY2uB8A5dYu9ESLVf+txrJJWMU6LuUZtCQI
         Z8jHEAo1nZ2VxW46rH5fBN+YuoGUgGb3KCzBbqMqL8EOF5vtWajx0+Z653kWkLAHd7VT
         vc77SbsNaeagrUdkcUWyF3dv85R1qPMtVwc7YkUwJwkzmo11StWyebx5iSysmHeKqFOp
         Sseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HnqZ825QaUjHcFcUoPVeekIL3cloh6uSJswdCHcGNMU=;
        b=tOKuuVNvh7ooV7uJuydJdUTSgE4GRLzNmLqE+Vyv4I7rOhtX5+vV8gT2UcMfR4N9vE
         hSLPGl6T4GMCyZe4rcZOFGIrXAm9AAr898vJu7Qv5vEUx2p/tM+qpY8gB7hW8TgpAv66
         PLxUvsupIsEx/r35SGtmJfOV5LRsPgH8eA3265EzS939GiltgIuHFSL8WBKf9HkSRAK8
         KxFcbqM0+Cew5PoraAziIV15OuVh8tErjTxTa9aW+pYeOGutmqfH6G2Z/Hb6hf5lG510
         ZwKeU1dUzMAI5IUSDZryWWMVRFmAh2MgYt47ai8JoRAItkFuBzkLIlQRw9tAGEhyiw3D
         h6ZQ==
X-Gm-Message-State: AOAM531JFC00wMZ5W/WPFJkK3I2yoLKtDAP9mTkYYxaePp+N9RpB/OQC
        RwKQj/qcNs9SjQtBxiEM+YYYZInBQ5DkSw461lk=
X-Google-Smtp-Source: ABdhPJxcR9iEAJokjPMB/KxunZWalwUdWYUL4oPT1aiima67yngP6LTlhi+OnZVtLJNI8vSsb2FTq1BpSc6gS0vdZiI=
X-Received: by 2002:a05:6e02:92:: with SMTP id l18mr1254204ilm.212.1592480306512;
 Thu, 18 Jun 2020 04:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com> <4135d264-6758-301a-0f19-ba2f229301c3@infradead.org>
In-Reply-To: <4135d264-6758-301a-0f19-ba2f229301c3@infradead.org>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 18 Jun 2020 19:38:14 +0800
Message-ID: <CAE+NS360B8S6sDNPSwEOFWoEDLwtYKxf96M5wdu1brKtMD-Nvg@mail.gmail.com>
Subject: Re: [PATCH] regulator: mt6360: Add support for MT6360 regulator
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=884=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:06=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 6/4/20 12:06 AM, Gene Chen wrote:
> > diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> > index f4b72cb..05a3b14 100644
> > --- a/drivers/regulator/Kconfig
> > +++ b/drivers/regulator/Kconfig
> > @@ -680,6 +680,16 @@ config REGULATOR_MT6358
> >         This driver supports the control of different power rails of de=
vice
> >         through regulator interface.
> >
> > +config REGULATOR_MT6360
> > +     tristate "MT6360 SubPMIC Regulator"
> > +     depends on MFD_MT6360
> > +     select CRC8
> > +     help
> > +       Say Y here to enable MT6360 regulator support.
> > +       This is support MT6360 PMIC/LDO part include
>
>           This supports the MT6300 PMIC/LDO part, which includes
>
> > +       2-channel buck with Thermal Shutdown and Overlord Protection
>
>                                       is that      Overload  ?
> Yes, it could be Overlord.
>

typo, overload is suitable, thanks

> > +       6-channel High PSRR and Low Dropout LDO.
> > +
> >  config REGULATOR_MT6380
> >       tristate "MediaTek MT6380 PMIC"
> >       depends on MTK_PMIC_WRAP
>
>
> --
> ~Randy
>
