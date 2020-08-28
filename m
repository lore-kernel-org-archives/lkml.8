Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D36BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377BE20639
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwrWOh5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgH1ObW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgH1ObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:31:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B271C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:31:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so1549314ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uulk0f5tN77Sy8VPiV8bfXz3aXrvD+qaFtC9g5b1o5k=;
        b=mwrWOh5FW8SYexG7nJkfBA7ExLj9HY/yJCs1pbJkRP8mjO0Vm5IuQRxOn3jCFPiDKy
         TPp+apvkl1PFKQVmrFtao9K39ss3eGRv32OCkcTWEOPpv2wCCHIBlvSdYZeBo7OIy/wy
         H1/Y3pj9oqdxvILjV0gQEGtanA2tWIxfIoVdkHTS3Jf7wwRA+BTeO1VteJUNf+0SHF+5
         kRy8mUoXzqx0+JiIzqfnMWbxCFCsNUJuFpV7P7HNQmdck+EjmpePdcrD/sxzJA2FX2aq
         nFdUSMCJlK9hheCrVt7Dr2ioHkVb4f521szLVOXf77uzgGVqIRDOQGTblZMiHusdXfv5
         WsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uulk0f5tN77Sy8VPiV8bfXz3aXrvD+qaFtC9g5b1o5k=;
        b=sxsm67Yj9nUm9QlJRGeX+dv+BgyNFzBUTI40FpF3ERdGhsb/Lv4qGSNrHmTsawjBoQ
         kO0fzmS7cAENi8OnkJruX7tc/kj12F3VGRA82OC2x8j4QOMVN8Qp5+ar/I3upn5kTSCF
         akjhOgtAhMI5jvlguBLEPqk8TBMGZ5A0e+yFgv1p3oIJ7ojPRPmdWCCAIBix52lnzpdB
         eOfS/yPV8D8YWWnYzmj701DzHAriAGN243iAdnOzQLLX/PA0yoOmRuNgc66yUW/dZgv6
         c5sQon8UIrJGCJB7dedZdWiBRZTLibW0AwpEcRxh09PNDwlHpUXe3sP9HvJxoND+nk03
         9GgA==
X-Gm-Message-State: AOAM5338fOEW3V3+qKTkqcoj6Nxb6PSqr+7pAn8lv30X0Qu1smTUYLfZ
        rDyDYvl1zKBHdwP3283uxqJFWeGpcYhb/+Y4P5KQIg==
X-Google-Smtp-Source: ABdhPJzZo9V8yKD7QGeGDGdwGYh46SecHaHj/YVK7pilBfuxI7RKFuaeR5C1/8xhA/6gVBQXQ3zGwVDH9/8XRxPY9Rc=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr989729ljj.144.1598625076956;
 Fri, 28 Aug 2020 07:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200827185829.30096-1-krzk@kernel.org> <20200827185829.30096-25-krzk@kernel.org>
In-Reply-To: <20200827185829.30096-25-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:31:06 +0200
Message-ID: <CACRpkdZNS6TTpUDEiezORKXu-h0Sdz_dPcCxmR+UbT_Rc+oMpw@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] gpio: Add devm_fwnode_gpiod_get_optional() helpers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 9:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Add devm_fwnode_gpiod_get_optional() and
> devm_fwnode_gpiod_get_index_optional() helpers, similar to regular
> devm_gpiod optional versions.  Drivers getting GPIOs from a firmware
> node might use it to remove some boilerplate code.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

OK then, I suppose this gets merged with the rest?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
