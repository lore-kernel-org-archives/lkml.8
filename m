Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CC4207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K6fYhbLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgE1OtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgE1OtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:49:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E75C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:49:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b27so3318227qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7bgiq+hLHRX0DJp5HGAPibY152zraWoS1bf1ZUi8yr0=;
        b=K6fYhbLNN80hW3Pf3S2Qo3jCZMiRm8Yyt2Z0WsGO9l1UOg9rbBt4EhiCgeduYh9v2J
         Cu+K0SqzPmLZEo0x+tipWKiL/HHRuemXF65qU7QlS++2O92h6Rtz1FBrTLKpQxSF65dv
         yiRzSumOTtlF5dDuF9zxCbR1UIzy1aAXD1FkiNwIYn2Wm0PiF4uKafoFpnA6QtXtWbyQ
         Lvs6IVTwvtYeO96emfrhmenqmqgc1PdidYI3hbgg1K3+lk99R+yYx2lFOhs45rHz9LTf
         jR/cMidGMOI0O4ABpSJmCcDzcW6V1cd69mNF9Unv6ByQxucGJBA1oELurTpg3ZrLS6xa
         qT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7bgiq+hLHRX0DJp5HGAPibY152zraWoS1bf1ZUi8yr0=;
        b=sGUQjxXFwd92eWwC3RGuzVeIbCRKKUR6tv9O182knrhU/I4xuhuyOgliOD9/aQfYIl
         RVFLtrLSWLgUYP/jV7IMep8aIGDgrHLm6SVLQJpwUhcX98JXxDjF9NyJzA3e1+5kK2hW
         kZSyGJodDEcoTgNl9yWDFY0sodMLZZ7/mbrqoZNMu5vYjhzDAqyAM1q7KAforE+lO1cM
         cYZe8sIfyG7BmCulxDdPh3GJwptTE7HsVGEMTF/yXijfx32KAB5KGrQcGLH49qHcBeAI
         KVdar0wzdIkBx3EypAnP8HylxWxfzeGKEOc2wHVJpj/FXTojircvL5KNvK9Odm1hb/qH
         fYbA==
X-Gm-Message-State: AOAM532tzunQ134cog8iyFNwd8yJjTxHRlGu6YAo3tk0F+bB+2BdN/LH
        mD6RVzUWP8mj8IQfoZrTypVApZfdmpViIRo1/xnY6g==
X-Google-Smtp-Source: ABdhPJwMqRBjwPsgwb2FUKECIe64ZjaPiVPeaWousPYaYOHlGL5MTRIVN7nLAwXJjVoc8/Otc86MvbDhvL+AxdAQhlE=
X-Received: by 2002:a37:dd6:: with SMTP id 205mr2993984qkn.323.1590677357382;
 Thu, 28 May 2020 07:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200528142241.20466-1-brgl@bgdev.pl> <20200528142241.20466-2-brgl@bgdev.pl>
 <20200528144456.GG3606@sirena.org.uk>
In-Reply-To: <20200528144456.GG3606@sirena.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 28 May 2020 16:49:06 +0200
Message-ID: <CAMpxmJVB_L+otX2u80qwGjw4TXCJtwOXe=t11O4Daq3miMVk6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regmap: provide helpers for simple bit operations
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 maj 2020 o 16:45 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Thu, May 28, 2020 at 04:22:40PM +0200, Bartosz Golaszewski wrote:
>
> > +     return (val & bits) =3D=3D bits ? 1 : 0;
>
> The tenery here is redundant, it's converting a boolean value into a
> boolean value.  Otherwise this looks good.

Do you mind if I respin it right away? I don't want to spam the list.

Bartosz
