Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAEDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7420825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDdz9YfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgH0V1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgH0V1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:27:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32CBC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:27:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r13so4667076ljm.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g55UEudSuLNJpqF8hvPsJ8DCaM3U4I3BGVg+2jid6Y0=;
        b=oDdz9YfG2uDIrPcLq/HUuTXO91wu+DwxIVs2k6sE+uCAgzQkUbkmj59Y/kBTbSCZ9l
         CMulUQXb0mO3pmUwDLmjq7Vl8iWp5zuDwAhljEEZBUGEcBfzCU7Q+wVT3tXoik9UVIJQ
         bAXxrxEh5UPGVj8poNUiPAK/EG06ZCqzBmiS3IcU4QepL/27n2Qt4CHV6S1gfoBURUfM
         U9DYPDkFMDiwBSXsfkpGa07UpVGOB8u32GutdtTnv+V6UHGDSHT9TWMvLryUpJisa6eT
         k041GfVhIviI/Vn15qzFbfbJvWW13hrv0KmwqZZomKmxyp6Gvfl1BHLqUumxIP/pOA/n
         eBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g55UEudSuLNJpqF8hvPsJ8DCaM3U4I3BGVg+2jid6Y0=;
        b=g0zBILzR5cLLqxEEkAnHMUoYICF01j/u9xqAIRkVUFArSZzCJVDjUlz4xjpnwJ/T4f
         H5HfulR2ajNg2UPLy+ozujLIeyR3MI3fwG6F9MHkRjYmpOpdaSHRHmkuhwq6FGFTUPKA
         TQIFWgaeM8dQMU7yTy6/WQ2Xbvf7a7iOGnbmuK0xE8Z0GiL/6fB2E+k+D2uQKSFmN9Lq
         qF6orZU7zUWvoZX5YZ6Qno3L5S63pWuJ14pVFHSusYXhGupAdaDUzUpwOwNqoZnRYfG5
         /NKZ8eWtz0QSzBD2keMmMONtlQCVlOI9nB/e2B0/9JdEkjujMzxkWBBESPk/GEiLNV9T
         4gyQ==
X-Gm-Message-State: AOAM533EN2dZ+rfm2POSHr2Pvi9DK3RSq5lyNNZEmRucZBBrZCLk+3m4
        0c9XAAFj9QsdW87QEl+6ieYiDRctNAoNhOi1Izo=
X-Google-Smtp-Source: ABdhPJy4PIBMWtpNTFM4hINb+kNb3GXgxKaBR5DUSvMt/FEvF6eFhtHu7epyzpRyWMC1ExEoleXIZJT4hNfDEcjaHk4=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr10806357ljb.452.1598563639096;
 Thu, 27 Aug 2020 14:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
 <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
 <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
 <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
 <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
 <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
 <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
 <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
 <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
 <CAOMZO5B_Jm8SX9N9V5oq+LAa0Yc4CmrEp2n=2t3XUyBCtnGVTA@mail.gmail.com>
 <d433e8a47d721a65903db68c38eb1c337c81e395.camel@ew.tq-group.com>
 <CAOMZO5AfuPXfOmRSXAmyG-bdqGSzvTRm51NuTJ-B2PzKbLy9mw@mail.gmail.com> <9978aff9c90f5e4aa2049a5c65768b9695a910c5.camel@ew.tq-group.com>
In-Reply-To: <9978aff9c90f5e4aa2049a5c65768b9695a910c5.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 27 Aug 2020 18:27:07 -0300
Message-ID: <CAOMZO5Dp28MSjQugWCwqfor=eEPvy+EfuoVL0y_oirw=G600aA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

(Your mailer is messing the threading.)

On Thu, Aug 27, 2020 at 4:31 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> Ah, I see.
>
> Nevertheless, hardware that uses the native chipselects of newer chips
> exists (for example our TQ-Systems starterkit mainboards, the DTS of
> which we're currently preparing for mainline submission). Shouldn't
> num-cs be set for boards (or SoM DTSI) where not all CS pins of the SoC
> are usable?
>
> In any case, my original question was about the intended logic for
> num_chipselects for SPI drivers. My proposal was:
>
> - If num-cs is set, use that
> - If num-cs is unset, use the number of cs-gpios
> - If num-cs is unset and no cs-gpios are defined, use a driver-provided
> default
>
> How do other SPI controller drivers deal with this?

I think it would be better to discuss this in the spi mailing list
with Mark Brown and the dt maintainer, Rob Herring.
