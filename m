Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD81C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ECC2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxz381Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGWIoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGWIoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:44:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB5C0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:44:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so5479541ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkH2cH1tSHkiWUdx4NYvU3H/EJsQDUARMZQ26FKEGq4=;
        b=kxz381FsxyT6cNf9sYuimdhuIrl8nxWcoY7uM46nPmZffugo6no1qzJr5aIXrKo7h2
         5/8PKpg8A61z+wAa44SJdBgFVJmKEebebfWSTexkPuGPVtDBC+M8W2EETKfrxS/ajZbu
         jrLJqSTpXgSXiW+U+t9OKLEoilfVGq/LOzePAnPruqfi0mbPianEerwMGFitwc7Zj1Ix
         jwx6dUtf//RZoU+1i1gpp60/9sLPr1XTolu2Q1iQAAuEoUllIQ192rjwvvpx08okrahQ
         YV0s8XPRp2ObxIqNjdJ3SXyRjL2Ip5CA52ocGM7KqHgdPd90tsqQTO0UAmjRMnGvGkwb
         Q1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkH2cH1tSHkiWUdx4NYvU3H/EJsQDUARMZQ26FKEGq4=;
        b=CnWC8pQ1ALK12EtyZOcgFjOgO1Jk4sV22z/3pSIkzAqg6Lf6PeO8fpYyJvuCVAFfqK
         /STkh77vDJin/dnQG4koKx617S4OWQgcBvImgCaGe32Y++P8I3NTnz49+c9/YObU061y
         N3J/POmXJcI8c1OkMeEfLQYbXOcxK1zdsaXir6AYr5KyEYT83YJv6KitUk4i+y0E1HNI
         y+FsrlU5QC7spUH7C6if2uLMHnWxfIyL8WqbQ5z/Mk/TCUn9BF5akYAghxRH+AMd053R
         IuCMhao4YzYjo3soDqA3mQ6yd+c9Iz6pX2tnB79KXw3xHvmXe72kULsnRMwkewwYfpXR
         MDcg==
X-Gm-Message-State: AOAM5319TgsQxl0rtBRTtCNoJ2KcvzbCp3lbnYGYfkbHiV/KA9Nv1/4i
        Nv1NrOIgKf6P8VflJFnuTcrGS5gyj2+IkAlqTB4BXg==
X-Google-Smtp-Source: ABdhPJy9FYQzEz5+a+xAYCl+rAh2wms4y8ztY1F8hFb6jAnV1ZJBUBI6y73dlz37/bChnljh88y3BVK9wCTiobiTO6M=
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr1628930ljc.286.1595493846705;
 Thu, 23 Jul 2020 01:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-7-lee.jones@linaro.org> <20200720142714.GA6747@kozik-lap>
 <20200720144955.GD3368211@dell> <20200720145219.GA23990@kozik-lap>
In-Reply-To: <20200720145219.GA23990@kozik-lap>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jul 2020 10:43:55 +0200
Message-ID: <CACRpkdaYQ3PEh838Qoxig4n1iNFp8AOj_Wk9jdvB-qMy0PBRKw@mail.gmail.com>
Subject: Re: [PATCH 06/25] pinctrl: samsung: pinctrl-samsung: Demote obvious
 misuse of kerneldoc to standard comment blocks
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thomas Abraham <thomas.ab@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 4:52 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Jul 20, 2020 at 03:49:55PM +0100, Lee Jones wrote:

> > > Thanks, applied.
> >
> > Same as the others.  Already in -next.
>
> Thanks for letting me know. I dropped all of them.

It's a bit tricky at times with clean-up topics, I want submaintainers to pick
it up if possible so sorry about this, it's just too much to coordinate
sometimes.

Yours,
Linus Walleij
