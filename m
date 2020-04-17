Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB73FC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C8C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmtaKFoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgDQKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728869AbgDQKZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:25:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F3C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:25:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so1400906lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOKegMNJa1QCtjRQnuZ70H+lcPUR+KD7zXTrBiL3Ua0=;
        b=FmtaKFoZylp1HabcjGQEHlttkaNGSk/mjaHNMDQ92Q4trXRLQ9LRUF0WivFLv1wbVJ
         HCcRx93F9lsV1cVqz9Lart2Ye3DP8wjRVFrFRLWgleW/tQAF34iNFM6MQFhX/mdwiqYg
         hnosLSITZoOjm049xElooHW+teGDGkbVe3dTS/bPoRw3bCsoVhiwsiDzGErSRlXQIuro
         vTPehD9wiKYofjjpRVJKBhM8iOwCESyDWdLPzt4gfXu7x94wyKX7c9Yn9VvLz0P49/xj
         TsIeQ7brpgMvLySPHzht9AiCNZ26Qh5beB3AiJquhaO2ITZsFujN8ukcCAo9/jjXc2zi
         OrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOKegMNJa1QCtjRQnuZ70H+lcPUR+KD7zXTrBiL3Ua0=;
        b=BzsCymYWu05BMo8NRvmuQIq9vEvUFSs/1dtonQ/9OcJqV2WBcfBv+Ca9bUi27O5qfC
         fcAwTQo+ZgbmXUfrlmp7mtxwmgHdZJUOpi3oVgm4aCjtBM3bS7mO2ALy1m52iczBZ11U
         wHRK9wWUot2PYa8YO7YEUvCFIzLRvqYGn5k4FSpuTMfBUHm27k8cKhnUioSBcvMYCBUu
         sdTTWjvJTG+qrJj+9eJOUYhfw9qf47J3x1nkTEEJPp1IHleubqtsC/kE+oZ5Dry9BICJ
         Kn7MEwxmOW7ly9lM6P/CsjeKUrajRvyy28ota9ZLd+U+VJwAd8bjNHQITC4i2Cp8bCod
         rsdA==
X-Gm-Message-State: AGi0PuagjD1G5RLZS3Aw1urLPoMMg4rYcCHa0F+RYrrxOorjmt7JN2xo
        vejj4r44Wp/yg6hHvYo1vVhts/fOWzU/vc8G+452Bw==
X-Google-Smtp-Source: APiQypK9rxRI48MUZE5yRDr8HKxW6CS0w0bAmulXSZ/vFHocPw0AYng6iuXDIz/qQgwPG1DZCLKOoBVPflTSN2jjia4=
X-Received: by 2002:a05:6512:52c:: with SMTP id o12mr1566610lfc.217.1587119150339;
 Fri, 17 Apr 2020 03:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200417083035.3c46185a@canb.auug.org.au>
In-Reply-To: <20200417083035.3c46185a@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Apr 2020 12:25:39 +0200
Message-ID: <CACRpkdaxnputiS_QnmijW7nBMYz+R6XWYkK9yLGyFgRGBEeL7Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:30 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> Commit
>
>   eb032d7b146b ("pinctrl: qcom: Remove duplicated include from pinctrl-msm.c")
>
> is missing a Signed-off-by from its committer.

Ooops sorry fixed it up.

Yours,
Linus Walleij
