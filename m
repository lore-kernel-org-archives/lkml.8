Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1EEC34053
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274B92067D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBSVx+8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBSQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:18:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42048 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBSQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:18:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so955526ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNIeeJsk5kS+/MNQiQBqWzPS8Hc6Zxgn+ktiCE+t/lw=;
        b=aBSVx+8CRkbeLq8O0iXiBkO3p/l/2sIBUrlpB4EZuNuT794r8Cky2bj3/mLP0o7NIS
         t/GNOUwYKG7SQqJfmMyOIODB4SVZwBWdaW9mb3hZ6Srj/mWOGa/M76b219nt+ofWdnnz
         l8YoS6J9OAzKBUPte8XoLiVAUwfYiH/Ybme6CmKM/fQloZCg1BCBSS1hxbo5vt94wYDF
         wi0lsZTkHc4CxlUSjQEAAHGk4WXxigdfP+E8YPreaG8pIZD1OgoOeZ6z+OFiOUIlR2sq
         aKrNjvjgJmzQgu652ErrkkNmpNN4hy84IYrGAJbCTvvw7HmFg55X4aNgWUq3fQSVFT5l
         NHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNIeeJsk5kS+/MNQiQBqWzPS8Hc6Zxgn+ktiCE+t/lw=;
        b=c8FF7ay7CEWbuh9LeNceGvXmwK24kbrlpQaFOHv90CmN/iz8pTEFSfzpuyiL9lu2st
         l7rLO6L6J+zeRMh6zkTb8vrqdwPo9MOIK61xcf/dNKzm95lFHGoITjbeseSicRpXx+YF
         JPXs+dSZQYiGFEhfanBzfZJUoWgeH0ReBwPcuk3w2HPS7VtCmqIvrh4couZsTqintfWU
         0/ysHLHd3esMKoo7XfkIFzbYOJ51wD6y6kFrCUvUzoYjQI5wCOuY92Vl00ayk9HCQbug
         6dZB1llJpt8ju9v0hwipyDp1NYTcD5p2UpNp3TNJwGD+BECNcSMMl6thpsd/VHQhLgZD
         SH8w==
X-Gm-Message-State: APjAAAUXCja33ZOJ4OPlPTYGROVK3h55wHtczccBwnuE8DnKQPyr1vJr
        O813/PNkbi8FsCqgsllvgCvYOIEBHgpU+LFbI0IuHw==
X-Google-Smtp-Source: APXvYqz5+N8/IcBMuJha1sjwR5W6tlYYD0yG0sdk9Zg5a202hQT2/SIsxkI/6w5AHuyFS6gous52gqNq9cvuBXJcR+0=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr17031085ljc.39.1582129086032;
 Wed, 19 Feb 2020 08:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20200108104746.1765-1-m.felsch@pengutronix.de>
 <20200108104746.1765-4-m.felsch@pengutronix.de> <AM6PR10MB2263733CA8E02F39A647258D80310@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200218110712.7wllleu2w5myphyb@pengutronix.de>
In-Reply-To: <20200218110712.7wllleu2w5myphyb@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Feb 2020 17:17:55 +0100
Message-ID: <CACRpkda94cDdDuuJE+j6-d=TcwyqQV6Ey+26oHM2TT06Rhxj8Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] pinctrl: da9062: add driver support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:07 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> gentle ping. The mfd-code and the dt-bindings are landed in 5.6-rc1 but
> this patch is missing.

Patch applied for v5.7.

Yours,
Linus Walleij
