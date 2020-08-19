Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C310C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C91D206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHECsKjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHSKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHSKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:01:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FD8C061757;
        Wed, 19 Aug 2020 03:01:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so24716193ljn.2;
        Wed, 19 Aug 2020 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sQDKTE/Nz4WEhS9Fa2pyUugVDwsfCPrw0tdUrr5Zp5g=;
        b=jHECsKjIw+tx7Wr+WDaBV99aduF3sQ9B6agAyxteRQwRRXAZHVQ21Ua1yxmUezLytH
         CcwBqt7PEI0dyOw5iXCkKiknURmmf0y/nXqHedvqnN5UfeT2s72PZtnuVAFskURPOLFb
         M9moqGDQPsu3NKjQ90KOW/ylDFtJwkGJHmgb1Uu2lFA8yQ12QZcJAg1pqrWuYY9qzfeX
         mZET1Ad4KaH2eRBbS4Xqy6bRc7BQVRUZ6xfjFOTaeokTs5F0hYlhhK2DHL/oZfF8TAsq
         qAx2ulFFqb44DKb7v5GbMS0RTUoyRafHVUMRvitHbVnUgexaVRZ6Y3ZJaRyRQBjtN4Cl
         CpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sQDKTE/Nz4WEhS9Fa2pyUugVDwsfCPrw0tdUrr5Zp5g=;
        b=pNg9MoIrDmQ5sNBfGwYkWnMTeot+b66fhkwlfPK72Zlp6vyWkcYoZX+Xy/h8kbIIO0
         KH/SXP7pNW1A3OfKpco0bOO1NXjedIK/GREH0vfNMBr6swdq9D5LRGtapU7QjyYmySuZ
         4hzd9xMRp23Zqb35bwNl2O4B6S1z2cf/ebFHXl7y2pjWkgUlZd6WrMoiXALsU/aIs/CN
         AX5PgJOKwNybuUVU2Coildp6dCukQiNeHMKe68Srn3JY8OL6T6PMziCDd+zPx3Q/5cMK
         pO9RedhW2sB0l9ld0nejBwFZNXjq2626gb0iXYsZXpZ/GqhZJNmo78QkrRq2vYegWppN
         bHWQ==
X-Gm-Message-State: AOAM533PDZtLeNWfbfJ+wwUZiLwaBDVyKhO9lBNk/+MwFBOEMbLM/USZ
        +8rmxCnqvKUV2q1m/KQ9qBR8gsi/cwT17LYXXFI=
X-Google-Smtp-Source: ABdhPJxjYBFNhpF22ClmBNTISHG3m2+1dC7F3jcxlxyNsMHe+zRmyGe2c4IrTBXNaOCF2j0z9Cl2lmffpaATx36J1/0=
X-Received: by 2002:a2e:9b08:: with SMTP id u8mr11205523lji.208.1597831302269;
 Wed, 19 Aug 2020 03:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <1597418824-15906-1-git-send-email-u0084500@gmail.com> <159776976828.56451.5989906126815444846.b4-ty@kernel.org>
In-Reply-To: <159776976828.56451.5989906126815444846.b4-ty@kernel.org>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Wed, 19 Aug 2020 18:01:30 +0800
Message-ID: <CADiBU382qDg8sA7t1QEqY5jGr1F1VqpWN5VH6Tm6wZw3jKd0LQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: rt4801: Add support for RT4801 Display
 Bias regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 14 Aug 2020 23:27:03 +0800, cy_huang wrote:
> > Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with
> > an I2C interface. DSVP/DSVN can provide the display panel module for th=
e
> > positive/negative voltage range from (+/-)4V to (+/-)6V.
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git =
for-next
>
> Thanks!
>
> [1/2] regulator: rt4801: Add support for RT4801 Display Bias regulator dr=
iver
>       commit: 5bbbfc7f7f0a44b7a85ab3872dd2ccce7019f7b1
> [2/2] regulator: rt4801: Add DT binding documentation
>       commit: fd6b928db8a05fcd8629320c52eae214a8615aae
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
Thx.
Add u0084500@gmail.com into cc list for the future maintenance.
>
> Thanks,
> Mark
