Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06398204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7hDNXYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgESIqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:46:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B02C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:46:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z6so1830682ljm.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIpPfUzeki7t2/xOW8D2TwuLm3eUY3xhyGDnwk5Lnu0=;
        b=f7hDNXYiQHSskMCyc0/RCEDU8VzLQOtUQCEKK7X4yLljolNXESh06CRtaosmdsJjMg
         MX89bhm05w2IP6iDp8Zhv8JhB8YKTb2VBgQ26mmkDdbz25KK/PcLzAUkyOWJ4OIiVMbI
         wazGJoU829h1latSrEwsf8EIeuiqqKJBtRhdrg2UEsd97YZjJX3UhtZXNge0uZUx+SrJ
         H1PKlbx5h2OO01B3VProIiBId5oEJxzc+/55C+FxnGVPVAG5VcWu1n3AhCmOjazV4uea
         tnMICKUeCPRVLIQPDFf83zy9+N90igGBK8sZFg0xxlR+yKWVg8FI2bSQHs6P+Dw691Dn
         lqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIpPfUzeki7t2/xOW8D2TwuLm3eUY3xhyGDnwk5Lnu0=;
        b=XkCk3VPK34s3VeiIPWPYhXbomh2qbjPN/y4btJfiiChf4/E7Sj0PX+jhsnW/CP8mjy
         UBrb+Au61M2ouYVF5iydXwDzAhWbnGeZhAiOYwho/rlqZFAZTm0U03opqP/eFJp+wj7e
         EPCA1n01NSzM7eAmZSoDpOpUhF4Z5FU6ZcGWUYha8Ggyj8web6ufFhbXGZbKKlbQ7l9Q
         JAdTg20ir7yxRwTBumGk+pz6FW+D2JFBGBaUFTz0zYlSB68Wk/4NBIByx/XPpmmfpQX0
         5rT4PDPJXwId3WBWftAGqssUx7rizSaErvb/Jk0WjtXPIIvxx0lwkve5q+qqqcZ1W0OA
         Afhg==
X-Gm-Message-State: AOAM530ZBnXLO/azok6kBAgua8kLwuvPQPdXDXhihqStaXcKmx026wKL
        hmt+HofInHxgzKNyqjTZgosmY5dQaqqNW52/hdaANw==
X-Google-Smtp-Source: ABdhPJxxg7dkus/MHWS76IxVh06BJP+0gA2DbuK9i0BMpSDLRuZWDES9DGHBKjU9LMmAdUCXSmLUQqB3/XS9Szv1tXs=
X-Received: by 2002:a2e:b609:: with SMTP id r9mr12750772ljn.125.1589877987494;
 Tue, 19 May 2020 01:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519070240.6510-1-krzk@kernel.org>
In-Reply-To: <20200519070240.6510-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 May 2020 10:46:16 +0200
Message-ID: <CACRpkdZbD2BAAs7RgGC4sqaj=wgtNe0td1JCCSyb_Ld11qSSWg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: Stuff for v5.8
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 9:02 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Minor updates for Samsung pinctrl drivers.

Pulled into my "devel" branch, thanks!

Yours,
Linus Walleij
