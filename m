Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1AAC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199C82075B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4RkzO8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgHYLHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHYLHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:07:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2457C061574;
        Tue, 25 Aug 2020 04:07:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s1so11997276iot.10;
        Tue, 25 Aug 2020 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HMkRJoEoEUn21NqqHhnIEKN+rPcZDLWWdRs/dAC79mk=;
        b=M4RkzO8Socq4fG14EpJvwtPBIk+Ptg612O6PKzybgDovHsa/iAeKhnoOPL23WiVTjw
         ABXef7F2fStb2STNKWVKzH3yX9XyXY3m6tB/74La4hi5iLDrFnELJ5UshGHSCy6yaH1l
         kvkTy8k2S/U1doagAha+TiEUwXnYEsHGyPsgaadbjQOdau4vrE+KNTZPFhTFurdr5ar0
         jzr3S5NDTfRG6TUTvmTDJRvxvWnnmXSqviY28l7sfJdCO0fOTYriAdgu3Mgv1ecMkUh3
         PnaA4lAm4/eG1oDZQIavREQa3tCy5fcqjt86jFgu7C+UxS/hBZDrPRoUls9kCvdmmbVk
         d5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HMkRJoEoEUn21NqqHhnIEKN+rPcZDLWWdRs/dAC79mk=;
        b=VjqTOUaRwLC8Vo5n+pP0cTASh8pG87wgbATjZ43DLhkzbs68ihSPWccFMx8DJbjwax
         9xR80JCs2OI9oQRwpuSI2TeMSh/0ChsVCmSDCBYh+q55MGyWvi3Q8PhUFbp0buo5Zf2w
         Z/g7zCuqKgOVdoYL+Kci0FvfXtdL2105kLkulLwe2rdIVNs9pcWv1ON1TxThR0Ux0Qm3
         Fjl+Z9weK8gUeSvvwD+xI02+uE6c+w8TGJGFqZZ68EaVD3UezV0W1E6mtkgsX8Ue5/EZ
         xrARF237LHtUPof6FqZo7965XfciEvszdAOtEOT89z32NMN6rqJT6qCgQIO1dhUkq3PQ
         jQVQ==
X-Gm-Message-State: AOAM531xYZAh2CzWoaqsLjzqilwdG5br0kLNBPhqLwrVHuabVBwJlvgT
        BAP97hnGfPFEvfA9liGNeTLrOHxUuOUltCHoJS8=
X-Google-Smtp-Source: ABdhPJyjCL5MWKrkK6LZVA0FEUJuMqi3HTst3sxJ022Y6tIPShnYoH25nJYtY0lkWRabwgUMnf/2K9Rdq7wgtUvvN8k=
X-Received: by 2002:a05:6638:1489:: with SMTP id j9mr10160242jak.22.1598353652285;
 Tue, 25 Aug 2020 04:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200820113015.GB5854@sirena.org.uk> <CAE+NS36C0AwbrFJdYGY6_n_g3DVitp_e1GfZUxjMbKu1bJ_t4w@mail.gmail.com>
 <20200824194840.GF4676@sirena.org.uk> <CAE+NS37p38dAN1bAi_VvEYYGNiWDVFKrdHL-hTgi2nim_7Zvqw@mail.gmail.com>
 <20200825093404.GB5379@sirena.org.uk> <CAE+NS35eh9PhRA1M2f2med52WhRsEfWp=zWUfgETq4odHouxDg@mail.gmail.com>
 <20200825100804.GD5379@sirena.org.uk>
In-Reply-To: <20200825100804.GD5379@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 25 Aug 2020 19:07:21 +0800
Message-ID: <CAE+NS36VX0FosRZ8xs-RTMCcEuMERvoERx2yT0as5wsSRS0+=w@mail.gmail.com>
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
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Aug 25, 2020 at 06:01:46PM +0800, Gene Chen wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > > LDO_VINx is HW design layout, so actually it can't be changed by de=
vice tree.
> > > > LDO_VIN1/LDO_VIN2 supply from VSYS, not regulator, so I think usual=
ly
> > > > not to show the supply from in device tree.
> > > > or I should declare a dummy reference to system power like "*-suppl=
y =3D
> > > > <&system_power>;"?
>
> > > When you say it's from the hardware design do you mean it's fixed by =
the
> > > silicon or is this something that's fixed in the board?
>
> > fixed in the board, not silicon.
>
> Ah, if it's fixed by the board that's exactly the sort of thing that
> should be in DT - the DT describes the board so if some other system has
> a different configuration then it will have a different DT.  With supply
> properties you can just leave them missing in the DT, you're not
> supposed to but so many systems do it that the framework will handle it.
> Otherwise if you want to represent VSYS you can have a fixed voltage
> regulator with no control and hook them up to it.

ok, I think I will follow the framework to handle it.
I will add supply description in devicetree
  LDO_VIN1-supply:
    description: Input supply phandle(s) for LDO1/2/3 which is supply from =
VSYS
  LDO_VIN2-supply:
    description: Input supply phandle(s) for LDO5 which is supply from
VSYS
  LDO_VIN3-supply:
    description: Input supply phandle(s) for LDO6/7
