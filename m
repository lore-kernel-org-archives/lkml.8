Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A4EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D212E20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUOlKfKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMIKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:10:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52438C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:10:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so5180172ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWfpK7kOep961U553Ob0abtIu10zqSqu+hl33W9w0r8=;
        b=aUOlKfKn+grUFrxeu6XjIFchGrXEV2HHw6muKa4eBopMq8SE+G+Kit7fJKRiU6mgkG
         5nmT0VPb400wV9pef15BMlgnl2BASE3WBNTrb9X1JmHS61lNpcR3FSaW9r60QiIIoJBM
         aNnRVtkU4+9COuruzFoLd6Sl8PpuXHDwUIVvCXXiJR3yocBxLqQIZqg8f+JGPG+Mpzlt
         AqbpmUDLJonmdI8gUxImZQ1WnmegtFqZv7KayHKIwWPMkzWB4NF52II/jNHhuU5xpluH
         Nvdlfv3Mpz4bZ++7QkSd04+wp/G9nYtyIhymbuxPiFA7f3n4SgsFUlNW4s+Lj/thHO+4
         p0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWfpK7kOep961U553Ob0abtIu10zqSqu+hl33W9w0r8=;
        b=mOxnn86A87o0YZEJrMnPmzS2yJ2OtFYgXcxkjHL+N71wPmOgWprxCWSH3188Z4OiQA
         DmDSUkYCidiXLxEUXJJKuBMlU0cAxL4w6sOCm/Xfudu/0haKhIgcO5ytIJaJ3LG8rZWX
         WSawWJOnLsDvjr5qjN/0MiXCBfLa5eeYSRLdA4ZlE/C+jg14nKFC/28WUXRmzCn9Btf3
         hT081yWS1Jep8XTnKBagoNK2ptIlAD/e9eJPNrGupwNjou5jse2arp6jy7wv9s82iDG2
         VRMMetLiJiyHJHzHz7vl/nNDOoz2A49qOBkIcBiJrU5wJZlIlnfabaEGV7fmh1XPy+Cv
         GM9g==
X-Gm-Message-State: AOAM532UbsRgmgLDAdJQdsT1tcsziJC6DqhGrssl+1uiZLVoD80Na9Vi
        x6KBA2dZoJyosoQh4XxruvWhH5TRR5JdQlb2ZeJQ3A==
X-Google-Smtp-Source: ABdhPJzjtNMiz4ncOKRG1mKwXggE8jWaEL1RoSHQGTbQB6kJXCPvWdLbpxyUtJOjdYptn6GlVL8tCjvfyQUUjbv/+Pw=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr1510700ljb.283.1597306220097;
 Thu, 13 Aug 2020 01:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-3-krzk@kernel.org>
In-Reply-To: <20200806182059.2431-3-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Aug 2020 10:10:09 +0200
Message-ID: <CACRpkdZNWtLwjqe0qpeyrGf-=9DJNLf8MdZ=BB67Lp9pqmq1+g@mail.gmail.com>
Subject: Re: [PATCH v2 03/41] ARM: s3c24xx: fix mmc gpio lookup tables
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 8:21 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The gpio controller names differ between s3c24xx and s3c64xx,
> and it seems that these all got the wrong names, using GPx instead
> of GPIOx.
>
> Fixes: d2951dfa070d ("mmc: s3cmci: Use the slot GPIO descriptor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

My mistake :( sorry.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
