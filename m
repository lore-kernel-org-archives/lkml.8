Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4644C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945792071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1hgyTlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgH1JGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1JGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:06:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DAAC061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:06:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d11so520507ejt.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvV7eXBvyQgCBgrsjvWaIv2rEaJefsbSLUIuZLspMEA=;
        b=h1hgyTlR8KltTUDbvjiOZ0FJPdU1qPb2uGFPxuC9WkmLFRhAEyeaFSrZW97ojGNcp0
         ccRdiTageCHFfZJBLuATi1xd0boWZlbxqSGcqSlmEk1SE5ZKwTSi9YCZAIGfUZiNksWn
         mBZgya8M2DBV7E+1WLVtyLXHnyeyR28qvSLsk3mBKW1XGhw+ERe3+pE8Hxv8ePRG2Uc3
         FqDohuRqdAKDiQe60Wp7dd+SAqOlJDTYXWvF5PYjIrtO70S+9wpqgoV0PH57Lti/mkS7
         lkA0rwUzvgBigA19Oou95yEg2rao3yIdKqpkBcEr/hgJpNN9FGAPgr0LiMO2eTLNh9sf
         XsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvV7eXBvyQgCBgrsjvWaIv2rEaJefsbSLUIuZLspMEA=;
        b=Fge027/jEnObOxLT6oauSzDnWZEu23mo3f0YZWR6i0+hOieDafKv9qfYJhrj6YPxlo
         epcoRbq+pqqzz7gMVVGZyAP98HnBqqpgOv1s5QKO2iOY8ZQZ+gWme5f7ZL0mOGiuLGQ1
         hVuDmyBBL9hYQy5CyerA8DnEgg58/TCiwwK4HyJd99BqUXIYeyglZfwp8RHB1fUpWHa8
         02LIG8Pl0AQL/9RbuSf/IGTvbO00nBN2HVyc8Kr9zh8vg60h4ZMu9JeGFfhkPFonr6Wf
         isFo47aeK/pENwnTHN0JBEpXnt3CFW+oddmCKTsq4e7jE6TL6r3bqY2k0qn7oyQUdyRv
         V2Xw==
X-Gm-Message-State: AOAM530mHuqw7A36msQpbJfoCelgYItXz7LsP5WFZ3gHu26E8iOUXNXr
        zchKBfZo6hx3Ggm3H/rOzffYqBxZAEyK77eNRFcGIA==
X-Google-Smtp-Source: ABdhPJzmAhVb+RcSV8T4sZX5/XRKDlKD6uVeC4jK3X8WbHU7aWhc8Y1BK4BLw7LNFeiAVXdSfK9JBKq/4Qwn8LtOpcU=
X-Received: by 2002:a17:906:5f8d:: with SMTP id a13mr767284eju.226.1598605593511;
 Fri, 28 Aug 2020 02:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200814100357.209340-1-thomas.preston@codethink.co.uk> <20200814100357.209340-2-thomas.preston@codethink.co.uk>
In-Reply-To: <20200814100357.209340-2-thomas.preston@codethink.co.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 11:06:21 +0200
Message-ID: <CACRpkdZj-eAz0yse3OcKLiO0sPVHJMmhVZ_yLWFt1YKPe3hkRg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: mcp23s08: Fixup mcp23x17 regmap_config
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Phil Reid <preid@electromag.com.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:04 PM Thomas Preston
<thomas.preston@codethink.co.uk> wrote:

> - Fix a typo where mcp23x17 configs are referred to as mcp23x16.
> - Fix precious range to include INTCAP{A,B}, which clear on read.
> - Fix precious range to include GPIOB, which clears on read.
> - Fix volatile range to include GPIOB, to fix debugfs registers
>   reporting different values than `gpioget gpiochip2 {0..15}`.
>
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>

Since the other two patches seem wrong, please resend this one patch,
also include the people on TO: here: Andy, Phil and Jan, who all use
this chip a lot.

Yours,
Linus Walleij
