Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB4AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565F4208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPFeFxv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgIBQZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgIBQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:25:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01992C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:25:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w11so140760lfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+VjSP7tWh9A7Uo1/vh88a9JUwYsjFZ9oMpqJyM2gdY=;
        b=MPFeFxv4rz28exekZb65X+RzUZbSJI6wj3xc5X+1ubXwzX2F32DFftTcr+fFuEvoHn
         3h3ncpRSXJUD9WxPpbJs29Zh2PBe9OGw4RV80EEL4sJsfWNjwnrM80cUbv4MXaEt+yLn
         +/arP/dsNH9bw+n5vMFzeXJsdQBr+gJdw7KZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+VjSP7tWh9A7Uo1/vh88a9JUwYsjFZ9oMpqJyM2gdY=;
        b=e+YkntI77JnErC9lY4SBlrQXj8CGmOojfXAkEs1JIfzRgID3MZtCetdB1Sy8OUPaSU
         5wEcjMikzn2nTAODWhddNFUCBUM0Iy2ty5XoyFaQBS8nM4t5r6KLmIR/RJ7+hnmthUOv
         qyDbtJ8JOK9DMeUdnG0AB0EfdTdj6M8qiyU2Vh/oOOgBqp7ErbaA/ynWtEFTlIMswKt0
         k10QAq+D0myvh9idKjU45G9qsi7lKoxlA6O15uKHWmiaJ7lOexDzdPkIS7IOo9dHSoAb
         1TtPZR0Sy+1e/VOWSAnd+ygfsPaqvmLbs6HeUtdVuyGhYK6PU8ZvrLtWbF3dyeZUsz0d
         agVw==
X-Gm-Message-State: AOAM532u/M1SmXV3aVR6LMYIwOEKeJ0gwdFdjHj+HT6PlcwzBL+RNfLs
        9gzgfB27ebQZ2sG4YOzs3A9U5GFTokKU2Q==
X-Google-Smtp-Source: ABdhPJxM7kti4+8R8ABR5jiDlR0WH54FFzm3nrzV6i8gWd1Fezy6Ok7ZtgSz+mByB19GJfVuPvPUfQ==
X-Received: by 2002:a19:c157:: with SMTP id r84mr3747804lff.34.1599063904930;
        Wed, 02 Sep 2020 09:25:04 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z24sm1217145lfe.54.2020.09.02.09.25.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 09:25:04 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v23so6685010ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:25:04 -0700 (PDT)
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr6506581wrh.192.1599063439238;
 Wed, 02 Sep 2020 09:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <1597380295-6297-1-git-send-email-wuxy@bitland.com.cn>
 <20200831180211.GQ31019@paasikivi.fi.intel.com> <tencent_0189E021005C2124231E353A@qq.com>
In-Reply-To: <tencent_0189E021005C2124231E353A@qq.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 2 Sep 2020 18:17:00 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AQ7nmOqTrGOtmqAk9PHGdypzBb3woG1QS45bO8yfaVJQ@mail.gmail.com>
Message-ID: <CAAFQd5AQ7nmOqTrGOtmqAk9PHGdypzBb3woG1QS45bO8yfaVJQ@mail.gmail.com>
Subject: Re: [PATCH V3] Add GalaxyCore image sensor driver
To:     =?UTF-8?B?5ZC05YW06IKyQjAxNzc5?= <wuxy@bitland.com.cn>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        mchehab <mchehab@kernel.org>, "robh+dt" <robh+dt@kernel.org>,
        davem <davem@davemloft.net>, "shawnx.tu" <shawnx.tu@intel.com>,
        hverkuil-cisco <hverkuil-cisco@xs4all.nl>,
        "dave.stevenson" <dave.stevenson@raspberrypi.com>,
        "manivannan.sadhasivam" <manivannan.sadhasivam@linaro.org>,
        "bingbu.cao" <bingbu.cao@intel.com>,
        drinkcat <drinkcat@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "dongchun.zhu" <dongchun.zhu@mediatek.com>,
        "sj.huang" <sj.huang@mediatek.com>,
        darfur_liu <darfur_liu@gcoreinc.com>,
        "hao.he7" <hao.he7@gmail.com>, "hao.he" <hao.he@bitland.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Tue, Sep 1, 2020 at 7:19 AM =E5=90=B4=E5=85=B4=E8=82=B2B01779 <wuxy@bitl=
and.com.cn> wrote:
>
> Hi Sakari,
>
> It seems the e-mails you're sending do not end up to LMML nor kernel.org
> Patchwork.
>  =3D=3D=3D>It looks like we need to fix this before patch can land in pat=
chwork.
>

FYI, I'll take care of addressing the comments to v3 and posting v4 to the =
list.

PS. Please use plain text only messages when communicating with the
mailing lists as HTML emails are often blocked. Please also use bottom
posting. More guidance can be found at [1] (the specific question the
link points to and other questions too).

[1] http://vger.kernel.org/lkml/#s3-9

Best regards,
Tomasz

> Thanks.
>
> ------------------ Original ------------------
> From:  "Sakari Ailus"<sakari.ailus@linux.intel.com>;
> Date:  Tue, Sep 1, 2020 02:02 AM
> To:  "Xingyu Wu"<wuxy@bitland.com.cn>;
> Cc:  "mchehab"<mchehab@kernel.org>; "robh+dt"<robh+dt@kernel.org>; "davem=
"<davem@davemloft.net>; "shawnx.tu"<shawnx.tu@intel.com>; "hverkuil-cisco"<=
hverkuil-cisco@xs4all.nl>; "dave.stevenson"<dave.stevenson@raspberrypi.com>=
; "manivannan.sadhasivam"<manivannan.sadhasivam@linaro.org>; "bingbu.cao"<b=
ingbu.cao@intel.com>; "tfiga"<tfiga@chromium.org>; "drinkcat"<drinkcat@chro=
mium.org>; "linux-media"<linux-media@vger.kernel.org>; "linux-kernel"<linux=
-kernel@vger.kernel.org>; "devicetree"<devicetree@vger.kernel.org>; "dongch=
un.zhu"<dongchun.zhu@mediatek.com>; "sj.huang"<sj.huang@mediatek.com>; "dar=
fur_liu"<darfur_liu@gcoreinc.com>; "hao.he7"<hao.he7@gmail.com>; "hao.he"<h=
ao.he@bitland.com.cn>;
> Subject:  Re: [PATCH V3] Add GalaxyCore image sensor driver
>
> Hi Xingyu,
>
> On Fri, Aug 14, 2020 at 12:44:51PM +0800, Xingyu Wu wrote:
> > This patch series add GalaxyCore GC5035 image sensor driver.
> >
> > Change in v3:
> > 1.Optimize gc5035 driver.
> > 2.Redescibe reset-gpio in documentation.
>
> It seems the e-mails you're sending do not end up to LMML nor kernel.org
> Patchwork.
>
> I'm not sure why, but that needs to be fixed.
>
> --
> Kind regards,
>
> Sakari Ailus
