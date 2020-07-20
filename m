Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A49D207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ZX29C3B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGTFRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGTFRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:17:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC72C0619D2;
        Sun, 19 Jul 2020 22:17:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so16688614ejg.12;
        Sun, 19 Jul 2020 22:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llO+ezp5UKjLN/4gUejpSAhuVodWUX2y6389WRqS3iI=;
        b=ZX29C3B+wKSyXH6qh6h2OQMPBvc7mbMG5X/UR2UuQXvAgFOicmmaxwsCKGcCnxwKYe
         rXuQ5ux7nyoURyNOenbjNs20MnYYvt5zr7+kEHNf9KvFallYm1cDMWfRHAyBuCPIGIVf
         Fa8q1yS98mCPS11Xro+fNzIK0lhjFClox23i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llO+ezp5UKjLN/4gUejpSAhuVodWUX2y6389WRqS3iI=;
        b=QjKvfIB9Sct61sMQNal5yEOueX6sp4hnSP5DwcLI9tb7jgOYjoe0G+QCjBnuFbwnXi
         28RH25DtddhldCfVzOk3eVXNlTKV/Cr8nEVDKYyBhL9AjMU0V9mSuseAxTRPWf6i+SlQ
         guz1BTTRttATILKJVvM+x/gVVuzGk8wZZBIw8OKXrF5nMgx5GeZS1b6CKMjcQI5TizFL
         gN6BMpz8zm9HSExDnFd/zXUYcXsQlTDZ8xR2f6Y/Bf8ex4/kUTyjRVYcQwublHQCi1qZ
         K7swhoWWRLhGWuALFP8M6kJKjoWMWYj+PgmdHse+vLoAOgWzR1w7wTxoHfmMGCq2IFU6
         P5PA==
X-Gm-Message-State: AOAM53242qZAlQMXPs2b8cst3yg9AMCoiOu3JseAVz+ZHJrtNeoS23xo
        Oco4TzAa0kSYZwQsMe69KWfVuxy6/S6qiC5wjCQ=
X-Google-Smtp-Source: ABdhPJxHbh0zsBjNwGBxeo6ofITTeEAy4QXJqem9C7oZ5JanrL5g4ZqyppdG1I4ujvUydlfaNgWLQ+TNQONWUwZtbG4=
X-Received: by 2002:a17:906:c187:: with SMTP id g7mr17678183ejz.108.1595222235025;
 Sun, 19 Jul 2020 22:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200719173447.60603-1-grandmaster@al2klimov.de>
In-Reply-To: <20200719173447.60603-1-grandmaster@al2klimov.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 20 Jul 2020 05:17:02 +0000
Message-ID: <CACPK8Xc_iwvRtUVjY8G8rS8UbZf6-Q6FTGaNweJXk06A=Y459Q@mail.gmail.com>
Subject: Re: [PATCH for v5.9] dt-bindings: aspeed-lpc: Replace HTTP links with
 HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 at 17:34, Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:

> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 86446074e206..4f3cf91b3b7f 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -35,9 +35,9 @@ Additionally the state of the LPC controller influences the pinmux
>  configuration, therefore the host portion of the controller is exposed as a
>  syscon as a means to arbitrate access.
>
> -[0] http://www.intel.com/design/chipsets/industry/25128901.pdf
> +[0] https://www.intel.com/design/chipsets/industry/25128901.pdf

This URL redirects to a landing page. We should update it to this:

https://www.intel.com/content/dam/www/program/design/us/en/documents/low-pin-count-interface-specification.pdf'

or this:

https://www.intel.com/content/www/us/en/design/technologies-and-topics/low-pin-count-interface-specification.html


>  [1] https://www.renesas.com/en-sg/doc/products/mpumcu/001/rej09b0078_h8s2168.pdf?key=7c88837454702128622bee53acbda8f4
> -[2] http://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf
> +[2] https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf

For this change:

Acked-by: Joel Stanley <joel@jms.id.au>

>  [3] https://en.wikipedia.org/wiki/Super_I/O
>
>  Required properties
> --
> 2.27.0
>
