Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A5DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B8420734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ginlMGio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgFJJmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFJJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:42:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1011C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:42:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 9so1631045ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6IM8HZkBTsTCtJCNJrWL83PXKs3jC9VH6grLKGicZQ=;
        b=ginlMGioWdNyYUtlQPRf2HXg4R51WjeoOdKcIOGEPmCEun2SAlBkFK4AvudGvS5dtu
         mcU5Gu9F4mr+CXgz/+DtawHStRUwOEmLfddyQ/M0fQPRfHBXO9tWXYKcXduraDiP2GHf
         nNOoWY6woHlbOLUe8vm1k/8QE/vWRMC11ai2WkEdy20sTcJGNr+0V/Gk7AKs2LWVnFS8
         cIl4apzdWwWmENuaX/JnjnNG7Ww7lU2KDI2ZZqA2aHiP9YyvB2rGB/k8JFeZ+DKElbAo
         jYe9F97RvJXV44rhQSSPcpcuYxCKDSSBO5FOc76iWb0cM1dPtuPACPo+QJL+w4n9iZp5
         duSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6IM8HZkBTsTCtJCNJrWL83PXKs3jC9VH6grLKGicZQ=;
        b=FeATN5tatWbzQ18SCSpAObcRhCseIhC6k1uDjvIxbVtRyp9QdICrHaLt6bWOcxdftK
         2/HUK9IxGSoKi792l50uOFiWvOkFXI9xWIj3nxP9QXRxta4bX7D3aDRgaQ0+Ip6PMEJ5
         mQZCgQQSdsviZB0/m/Oam1RkxDpi7tWv0ddam8vMVvlnjgpW8cUM48En9LHM7bZ3kBNr
         fIpzoC8kaWMj1almN4AU6qKFRezX8BVehtgXWhTejbwpsZLUTxCK6LKc0R4oQ0Z4ya5l
         5w7Xd3BRl+GXIo0CeSXtRP4N/i+Up+P/6YAAw0gqIkPfbL1zO/7ViBuckbWllQMnK9b7
         fdeA==
X-Gm-Message-State: AOAM531YYb3zWiD4Ycyo4gkQU4EJqh9WsK2eCl7R1fNRZI7i4EHHytY6
        6VR6abVeLqPx71ceCaT9vw2k+4Rr4JBcQAszNMZZ0Q==
X-Google-Smtp-Source: ABdhPJxoXuTFk1is/RO31yyyl5TxCVVZ0c+U2ViqAP54c/q3iqGbZn3p/7J7Ck85VUJCcikAOmvYyaaUzgoVKURdnk4=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr1341404ljj.283.1591782129924;
 Wed, 10 Jun 2020 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-2-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-2-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:41:59 +0200
Message-ID: <CACRpkdbx2kRjxhWzfFDHKojY0Yyour2+BCSVeqWHyoT5LhAwtw@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] dt-bindings: power: supply: gpio-charger: convert
 to yaml
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Convert the gpio-charger bindings from text format to
> new YAML based representation.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Looks good to me, if it passes the checks:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
