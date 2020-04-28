Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADEC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8A2206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfxPovGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgD1HGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgD1HGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:06:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D971C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:06:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so20303941ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f8dcXHpZYKAipoXZGyaEz/tWNqY1LAbrIqWxYKIaqms=;
        b=RfxPovGhXqLMR84oBjNHQnl7m08K/jrND9sk0zk7DoGrMWX+qWHr43W16a8/Ob00dF
         ecgyq1eDECALCl0Jymc6gxk8+vpNgufOKcSPfdDGa2LIkiRhm1zJ3yajX0ffjNFLCVXn
         iuCTAmoT/unRNx/pQPXpUYo8NVf6DW0QTDCyvV+MJ1qsyggUfuZmmj1WFydd+cztcHCB
         bB+MIJNVQgT7elVp6TcK9tsksxpZfc/wrlPPMC0cyhM2xQrPpryf/G3xIwktqaQ3ZSch
         1IqfUOc8o4KwbCpRU1oHNX89FEj4+oVS3EOtdwxukmxmD/MOG2cNF0P4F9H2vWfoPjVQ
         eJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f8dcXHpZYKAipoXZGyaEz/tWNqY1LAbrIqWxYKIaqms=;
        b=Nel/LSmy8n0pHu8ohYOUIMGkq17fqy9EgKR+DdrGMER8BmfoRYyb0QadatPJofFsxc
         C19Gfv74jjcLpQPXEMUoIV0VY+IxCXJ1Or6mc+noN7H2KkNmjF4ls83mKNAEsRG3lN6L
         iE/cI+BxZtPr0/ryRTvJ0fZiWOOAbyloNS+jM4iEkSai1IFdq7HwG+R10w7fwgUQk+tE
         vDgScPaY3moBNRi8kPK3fmJUcG3JnMGk2R10O81a9XMpjHxoeND4lbM5c7gmGcPQvyFi
         paTv/ucUFb2uisjqi6/ZEjPBJGTMUVcYhDJbgf8K4YGsVw2pakgIq/f6HSrXnuzvFTFj
         Yj3g==
X-Gm-Message-State: AGi0PuaajGn8z/zNIvE3BiF6GcHDGEpIbcDLJhtB0VdBgJofX3ToV0Be
        iqpW2fUMq3KXDfomzQX2qKKvd3BS+icYhi/Q3DU=
X-Google-Smtp-Source: APiQypL4UAbd+qjCfVTQrqkGfDjaDSsoYzHp/cmLfa4egSjfV+eVrKQDQym88AGDAGfZKFjRAZlE4FiwBBuyLYRiAC8=
X-Received: by 2002:a2e:9818:: with SMTP id a24mr16591112ljj.126.1588057592851;
 Tue, 28 Apr 2020 00:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com> <20200427090518.GG3559@dell>
In-Reply-To: <20200427090518.GG3559@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 28 Apr 2020 15:06:21 +0800
Message-ID: <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 27 Apr 2020, Baolin Wang wrote:
>
> > Hi Arnd and Lee,
> >
> > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> w=
rote:
> > >
> > > Some platforms such as Spreadtrum platform, define a special method t=
o
> > > update bits of the registers instead of read-modify-write, which mean=
s
> > > we should use a physical regmap bus to define the reg_update_bits()
> > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > physical regmap bus into syscon core to support this.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> > Do you have any comments for this patch? Thanks.
>
> Yes.  I'm not accepting it, sorry.
>
> I'd rather you duplicate the things you need from of_syscon_register()
> in your own driver than taint this one.

Thanks for your comments and I can understand your concern. But we
still want to use the standard syscon APIs in syscon.c, which means we
still need insert an callback or registration or other similar methods
to support vendor specific regmap bus. Otherwise we should invent some
similar syscon APIs in our vendor syscon driver, like
sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatibl=
e.

Arnd, what do you think? Thanks.

> > > ---
> > > Changes from v2:
> > >  - Fix building errors without enabling CONFIG_ARCH_SPRD.
> > >
> > > Changes from v1:
> > >  - Add WARN_ONCE() for seting bits and clearing bits at the same time=
.
> > >  - Remove the Spreadtrum SoC syscon driver, instead moving the regmap=
_bus
> > >  instance into syscon.c driver.
> > >
> > > Changes from RFC v2:
> > >  - Drop regmap change, which was applied by Mark.
> > >  - Add more information about how to use set/clear.
> > >  - Add checking to ensure the platform is compatible with
> > >  using a new physical regmap bus.
> > >
> > > Changes from RFC v1:
> > >  - Add new helper to registers a physical regmap bus instead of
> > >  using the MMIO bus.
> > > ---
> > >  drivers/mfd/syscon.c | 83 ++++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 81 insertions(+), 2 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Baolin Wang
