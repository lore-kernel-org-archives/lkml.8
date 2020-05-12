Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C7C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9420736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHrNZT7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgELMCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:02:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84646C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:02:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so5716818lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lext7JJwzoW0/UxTIqMqP+ZnyTLemfiC1Guac74bUBk=;
        b=AHrNZT7U55JnEquIWVWAKVppYEhj8DWQlg7uan0Bvf1x9FZvHjyBdNOstxxKt6dayw
         SqZmVtuFoz/wSHPPx+LNTF9urxI1jVFxkJBvMz04nRJDTbR6RTE66SYBN13Z8sy/7Eay
         hQkb/9m62+XIRpvLYRN/3blwEK6zSN5Q9UBJxBina607c/OZMn1qARID//pXiqgsIe6u
         HEnymo3TUXFPTd94Sp6d17U8Ub3PQQrS965KF33RLItN4mRAw1Cu0BmkEJQ1WHidx22s
         HbbqQungotmuSWQ96p1UW/jpgpk7/hgw2tzIJHpWhLkaf77ei1w3p4bpD0XV4BQ/VxEa
         pzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lext7JJwzoW0/UxTIqMqP+ZnyTLemfiC1Guac74bUBk=;
        b=MoXG+iRmJ4AzdrgQBzhqc8wyBqNrlunTupMLjeBdfgPM1l0Lg560IEVFe3T1CEOtMT
         qmMW1nW3arDV9VcQpmGFA0HtwRJy9bkpzjI84A36l0WhzYBN5Wzngf0yShwr/xv2m+CT
         thwTK8am/bxWi7IQcFGaM/Qh2BVhxj7YAjgYM/H/3uFBGpcCtczYC0TuVnAT/1ABww7M
         0ge1af8/KC9GVINp8ci3yGYCpOw4P8XC8VuGzfq1aBUYvCh6b3hSkN/NacSnvNockXA2
         txI/cCnb3DNSiuae6yiNTp47zafBxTqDfNnzqeOx/V9AzzKMCe4+LLwA3+YxIyxOusKH
         8Qag==
X-Gm-Message-State: AOAM530vCcJzD7az0N1WmN6+YXmKHWWjYbP77joD8wWzC/MQ0+NXO8iW
        SR8jXyjKImsC2IMS9EqTOgSEkHh6wBtyXPwXcHRGfA==
X-Google-Smtp-Source: ABdhPJzo7NWlWIkZPrVRUnHMxtPzZnHYqSFfMyggszoIWIf5ZsymS3tqfDN91Hsnym3QaEEpGy9pwTuwELKGkE4bNtM=
X-Received: by 2002:ac2:414c:: with SMTP id c12mr14173516lfi.47.1589284967861;
 Tue, 12 May 2020 05:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <85b8dc9e6288270bbfdf55f1c156dba160293f01.1588239081.git.michal.simek@xilinx.com>
In-Reply-To: <85b8dc9e6288270bbfdf55f1c156dba160293f01.1588239081.git.michal.simek@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:02:36 +0200
Message-ID: <CACRpkdZzTgkeqGdBbUW4XrH_q9DAG_uaOQ5icRtmzinN7oEzUg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add U-Boot bootloader prefix
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:31 AM Michal Simek <michal.simek@xilinx.com> wrote:

> List U-Boot project in vendor prefixes.
>
> For more information take a look at:
> https://en.wikipedia.org/wiki/Das_U-Boot
> Source code is available here:
> https://gitlab.denx.de/u-boot/u-boot
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> The patch was created based on discussion with Rob
> https://lore.kernel.org/linux-devicetree/CAL_Jsq+ehJSK7sjqmKtWOVjr-QZ3LDB+ywCO85uF8WJ+cB=AAw@mail.gmail.com/

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
