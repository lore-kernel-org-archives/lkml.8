Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17CE22C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0FdBC7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgGTOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:16:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14972C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:16:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so20395487ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfVCU5mHCDeITY1rM//7ZpN//MVZr1rSQIhyKmVtOzg=;
        b=D0FdBC7SOJT1hoV2IiUH6Eaq72kKwsLCWcjJhyuRbRsxO7Rst9US5bLsUu/uswLx+r
         BA1JKJ1DqJJKTxfUSkxYMzWt9tGuNubOZLSnCwjmfEF4p5x5NMDCBGPR99F6nqtqMqTX
         0pHVdSY91l8NVK16xRWRY4o0e6C5N8l10mAfQENoAyqsEIy3VgCGQWKE9iqfk5g7xOEb
         GqXf2mNYaeQDmxtXnxtxkRzJ0POTkULXYoC7/WMpjOfeWOy1J11ZCm9SgY/Jn6hnZtRu
         hkb3o2K9e4NAg1UMqo4+dj3I8NIpxw5ZPF5/u/yM7oW/U42AJe1vE4pE+hE4Pm5Hk7GO
         82WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfVCU5mHCDeITY1rM//7ZpN//MVZr1rSQIhyKmVtOzg=;
        b=jbOdGDNQcA7v122DQk0DaNsZOnPiApUrc42QxiY1ujqP5K4aJ66osVsNJsSNgmMAQU
         ia/RUkJdpIluXxFBsN8qZeR6Ob6yB3cwrNopkt8xvSLVrvLtE9MsggudP9EMLJr4NN5q
         6p9eOOEx7yxb2We3QGnEnRvP4+FxN3Ab1kuuDjaM4d30vSqF7tFc/aHAr3SsnXZBiEjN
         ry99eD1eijxu/k3k3bUUzeX1F52WSR060Hgi4I7QRZgd40kITC8GVIuSX0Gwu/Er/wW2
         HheliSYOlU9FDeu7EHfzOSa+1QHL94PJeNjxq9A6HlsZDFLYaRIYkfQjjn3xvc2QP87s
         pXcg==
X-Gm-Message-State: AOAM533pPETFl3KnKPhXwZj07A+itJv+InT3z+Gb25oEYvn6ds2QO8ae
        irI/AO0YXk0nidrHgqzAtz9OXS3o4U/7uS508gbR/JB/hYc=
X-Google-Smtp-Source: ABdhPJxCdtE5WzgJ33QEckSvFwyWtiAS2vzwpoohX8wqofbxOOkD2khe7ZOVTsb84s/0pYwurWaEsvPkRPvE3gGmlv4=
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr11280888ljc.286.1595254600586;
 Mon, 20 Jul 2020 07:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200718120807.19714-1-grandmaster@al2klimov.de>
In-Reply-To: <20200718120807.19714-1-grandmaster@al2klimov.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 16:16:29 +0200
Message-ID: <CACRpkdYXS09FNE3k9e2rc36zcPrpJTBiptVTe35R+_efNZ0VNw@mail.gmail.com>
Subject: Re: [PATCH] pinctl: ti: iodelay: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Colin King <colin.king@canonical.com>,
        ext Tony Lindgren <tony@atomide.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 2:08 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Patch applied as uncontroversial.

Yours,
Linus Walleij
