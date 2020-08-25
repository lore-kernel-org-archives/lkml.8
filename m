Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD1C2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMm7sBzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgHYKCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgHYKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:01:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481FC061574;
        Tue, 25 Aug 2020 03:01:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s2so11858276ioo.2;
        Tue, 25 Aug 2020 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cdXOSaIFKvjsoYRk7r3Xc53JhhLYHxWYCI7Z/n8m81k=;
        b=IMm7sBzV5X4zwHRscPuoC3u9UZqt64hd8sserQGXxqI6mbxEAT5Ms9HrY+73TDaR9X
         hssRtyidc1rNEIWFRnnPUI8DpBEQrN/tb7Xv/0hzfkC+HPdeVpoJcP/C34djpr2BOoQm
         AtWheKvk4bAllhjI0NxhEAOMQunK5VwKRfKd2b3EH57VD00UNQ+ReJxKWe4aBV0Tr+eX
         nZhtemUUyga8ZwenQ/ktaRhJCt3HwXkCDpOS4eFv7Xwtb3Ppefq/4m95ohaW2gWW/luY
         clmlgEXY6U5luciZ3tHnvcw5IKpvvPm3i1UqZr+d2hDUemTdh1T+zo0jnSf0Juu6TXjM
         8SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cdXOSaIFKvjsoYRk7r3Xc53JhhLYHxWYCI7Z/n8m81k=;
        b=lVy0GrVKiOTaSNPLQP35WG0UImNLNB6Tj4XKnr1UXfwPXiVLBuQBvMgfJJQi3xo6iv
         qmFkyd5B0ymAVJ/10CQH3CY8V0jGwZ4TE8vHb3eyrq3wRaRqP3/HfcbSCH03SyveF2Hi
         w294d6XBlXtuzmFLRH59XieGh1PimDrsuS/r24TnK2r8XuXOXp5hciQDUT7xcty6F+wH
         TEHfE0LZr5wNANf5jDQiwW8nf9DxdppO1mlNzSkYLTA/q69ov668T3HDwH6R8GscWoDq
         cK1sAWDSjNBLecSAR+jgcmphQEB3/1QAliIXr/nAhQTvJB5H/kpP5+/xKaPsazJ7pX5S
         09Sg==
X-Gm-Message-State: AOAM532SdvYoBsNaamU7jHytzgl6uqvDMoYlIsNfeFR9266Eo+cHPhN8
        0+dBRmv2WYBOxdyk51v8UrmxGIdWJxyTgl2IMpIfz6QM
X-Google-Smtp-Source: ABdhPJzDO96H7XqMQSuPKRRm7Xpb0ASLiPOw/vsNFPklO/wlYprIV8dh62cilZJfg4HxBBtKiJJpZmTY1PLmOH2OeX8=
X-Received: by 2002:a6b:dc0e:: with SMTP id s14mr2679164ioc.8.1598349717314;
 Tue, 25 Aug 2020 03:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200820113015.GB5854@sirena.org.uk> <CAE+NS36C0AwbrFJdYGY6_n_g3DVitp_e1GfZUxjMbKu1bJ_t4w@mail.gmail.com>
 <20200824194840.GF4676@sirena.org.uk> <CAE+NS37p38dAN1bAi_VvEYYGNiWDVFKrdHL-hTgi2nim_7Zvqw@mail.gmail.com>
 <20200825093404.GB5379@sirena.org.uk>
In-Reply-To: <20200825093404.GB5379@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 25 Aug 2020 18:01:46 +0800
Message-ID: <CAE+NS35eh9PhRA1M2f2med52WhRsEfWp=zWUfgETq4odHouxDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Aug 25, 2020 at 05:21:06PM +0800, Gene Chen wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > So shouldn't there be a documented LDO_VIN1/2 then?
>
> > LDO_VINx is HW design layout, so actually it can't be changed by device=
 tree.
> > LDO_VIN1/LDO_VIN2 supply from VSYS, not regulator, so I think usually
> > not to show the supply from in device tree.
> > or I should declare a dummy reference to system power like "*-supply =
=3D
> > <&system_power>;"?
>
> When you say it's from the hardware design do you mean it's fixed by the
> silicon or is this something that's fixed in the board?

fixed in the board, not silicon.
