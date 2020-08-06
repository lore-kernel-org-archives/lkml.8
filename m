Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3520786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrhVDbNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHFRG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgHFRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1698C0617A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 04:31:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z6so49246431iow.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GBkcW6NgtTDsQc7K+wm9MXLGks5e/hCdXllRiayCbwg=;
        b=KrhVDbNQF8AsaaoIl4UOq09EsyfUznkaVXPCKNK89TXD4Uz95qFlls1Uidq4Vskll9
         zMvwZ2qZED8YOEIFfYZSHnbu0eZf46ZwG2xa9S+vuPklscZyIUL8aITpZ+2i4NmkySdw
         nZdaNIrVnvMY4Tr3C+aZGR98x5SvBijd5poj/LjbLGpkGcm1eouHtZjbWiGLLv3GflxY
         Rns9zkuRpElvyvFXPBEWRYvrKdHPEr/oqAaYL+0dABM42HpcSDxCRi6EYu9dlHzgMsWD
         IVsMY9HkHa66iGKoZTMCpDZ02mbKCnF6o0CyI4jP6zCGVYjYqzuP/LPMMGI4MsfHzMkO
         rtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GBkcW6NgtTDsQc7K+wm9MXLGks5e/hCdXllRiayCbwg=;
        b=QmWMVAaObBTR9+Y2XRMxAqx1EsouqX9D/u/KSI7TlGKG3/A/yh+wcKwxgWpIyRctME
         daoTfcp504igMIWAJlgoxioEI4AWGpGYyFM7Ay7ws8tml3YAuJsPwsabVkAFrqDTXZmP
         zTGwMKgU8ga43hWbuL3cOKVOsmXTyKZaP9VwXAIIg0jhkbuz96Xioau28KuNkVAbsxj0
         ZerHN1NH1FhsZhU+VTAwWwGS/Ow9w/DJrW3ku2PLm2sogaCTgRxr9gn+esyOOUUhplkH
         GD+uFZDIgNmazoqSd4y2DFd320b9DWxD7OqqHw49lO+upV8UcEgh+YvBtBRVqwr/TnZV
         wmrQ==
X-Gm-Message-State: AOAM532202hTS84mHJgSpdCVjoWsUCQRGy11WwNOowyZh8ozdP8XAhTz
        lN/a0It2Zjx8Ulc8z4iFXLOOwv0feQJHmo6tYpr3WQ==
X-Google-Smtp-Source: ABdhPJy7a7Ne0v4q4AEIG4e7TRTRyIROhS0phm/+rD1dY9pUIJCcXadcDhjB/ixMMu7NcRS0NZ+3yYPztVui/apjKL8=
X-Received: by 2002:a05:6638:1b5:: with SMTP id b21mr11426605jaq.125.1596713468774;
 Thu, 06 Aug 2020 04:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
 <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com> <20200805161021.GK5556@sirena.org.uk>
In-Reply-To: <20200805161021.GK5556@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 6 Aug 2020 11:30:56 +0800
Message-ID: <CAE+NS360iKLoGxiiz8NmQqCp2Uge98Eehe4g2sn_N0e-E3DgyQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] mfd: mt6360: Merge different sub-devices I2C read/write
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=886=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Aug 05, 2020 at 12:33:02AM +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Remove unuse register definition.
> > Merge different sub-devices I2C read/write functions into one Regmap,
> > because PMIC and LDO part need CRC bits for access protection.
>
> It's not clear why this isn't just done in the device regmap, there's
> exactly one user?

because I use one regmap to access 4 I2C devices,
I need change the regmap_bus struct to fit I2C read/write with CRC bit
Therefore, MFD reviewer suggests I can move the regmap api to regmap
folder such as regmap-ac97.c

Is it okay to apply this change?
