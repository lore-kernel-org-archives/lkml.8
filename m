Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F49DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009CD20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8sYgo1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgGONRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgGONRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:17:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F5C061755;
        Wed, 15 Jul 2020 06:17:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so2581197ljm.1;
        Wed, 15 Jul 2020 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEwgMBO4CkCRyPxAj0lTdV+4ATE/erDN2sSnoSXTtQw=;
        b=m8sYgo1TlWX73BM93okyH8xj7WUttmC11x9qEIUo/zibifo1nh5ZcQsERHeJaJewjW
         tcgNo3ORhZc2suTAPZcukRdt1TnTSw4IiTQtgZvuVd+pc66IdMGJs3IdJOqgmgA5e6cx
         SY7KgjSV2aEuDXsg7mCElRk+6SK+oYJ6k78rICT7lf+B5CxV6mduxkT2xJ9Ni+bLUOnp
         e876KK6GVcetbSKDa31pyoOvNYomMm9ob6arRuwqLB2rXer9C32yuTqIcdhXdT73fU1x
         S8bVioJjWZAFx+j+Hcd32CZJiOtff5yUY5apMLajgSvXpiKFEi5lhvPcFNghv/Eatan2
         8ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEwgMBO4CkCRyPxAj0lTdV+4ATE/erDN2sSnoSXTtQw=;
        b=GVB3TNVvWyKUcDzAtEUm2DmS0pUMNht6dnblSRFE7liqwvEuchU0n882x9XkRvV55F
         qxmeo+5YZ8JCEHmcr7E/zERj7Ohzo5dQP01AV0r9RfG3qBfkdMqwijLar+kPXJq2Kijb
         9xLkZ5H8E6RwKg/ebgDSmMGhvZVqFfbZ98tTQdG8njbQHpFoG+SdmA4h+3a1ut3OOYeZ
         XTwHYJECswjRx1U31Igzkl1p7t2H1wTFyCjMdrfQm7rcpSxqKYej1uC67yjAjBvTmnMZ
         WL5nT7okdXZ6/DT9sa6ai598BH0DBLvsOjRGA0bFbUFhtDovtD/kMuJbZ86t9U8JXS7o
         Swew==
X-Gm-Message-State: AOAM530aqUf+rXvTmZ+UDpn2FlhPvfcHnlm+ySNg6tOzIDNelm23sSIH
        r5F1t+EjyYNtWuN/jyv0hkMULIsVpWB7yv/zXPx0RaIvCmw=
X-Google-Smtp-Source: ABdhPJx4jWJ6/8Zsae7+H8le5CB8WlKJdlAF874+/MJXg1hFkx4IQSi6sMt//gt8ycigBncbc7AhHnUCB18TyxVQu5U=
X-Received: by 2002:a2e:808d:: with SMTP id i13mr4926068ljg.452.1594819029474;
 Wed, 15 Jul 2020 06:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200715130122.39873-1-vkoul@kernel.org>
In-Reply-To: <20200715130122.39873-1-vkoul@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 15 Jul 2020 10:16:57 -0300
Message-ID: <CAOMZO5AYWKw2RBjt+sEveejzwmD1o0768FiCfa9ObHupENsweQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: remove always true comparisons
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Jul 15, 2020 at 10:01 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> sdmac->event_id0 is of type unsigned int and hence can never be less
> than zero. Driver compares this at couple of places with greater than or
> equal to zero, these are always true so should be dropped
>
> drivers/dma/imx-sdma.c:1336:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> drivers/dma/imx-sdma.c:1637:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

I have already fixed this problem and you have already applied my patch:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=next&id=2f57b8d57673af2c2caf8c2c7bef01be940a5c2c
