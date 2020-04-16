Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB68C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB524206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpXBeRuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgDPOzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387683AbgDPOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:55:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4303C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:55:13 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m14so16792680oic.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApXDAryjVZ1NhYOMhZ0mJPFGTTxjNrpKZ3hMH5Wk1rI=;
        b=kpXBeRuMgKb9LePzXmq5+Q2/HlepHeCz+xauCU2QEg6c2e/xDJcEUohgjmYjscEq1J
         XKWfkcaXqYCvVdTswUZjrfdAcu8Kcxm7Hpgxdwuw+TsstUrs8lJHeSWA1OvS6ZGmMueo
         WHEia2smDdJ3WMRRjy0tsJP47OYlOKiFxEPNMJOoKKOifDUiB7fT72vxt9O8YR2W4sxL
         2YpZhvGh+Gu1yJXf9iA1Oj2Z4Ethgac1sdAND647J6BbqvIwoACZQDi9IKZkhRLblixF
         XfiFDU6+x3BDGPfNrEjWEXBOZ+ndTFzmE0U5E9NQl+TosuHwYdlqAFg/+rII+3Qs1M4Y
         NMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApXDAryjVZ1NhYOMhZ0mJPFGTTxjNrpKZ3hMH5Wk1rI=;
        b=fVfXiSSHyTyaYFZj7cahdQEY4T5ytm73dK3bgXjKpQ8HTQf/KCG9SS3fx3s+3Fm0Q7
         opbUeWJpril9kBot1Lyzbveybg9cNVgx8230lac3yW3To5QxGV2xvQrYgxN3VAeNukY2
         ZKxu07ZhoJV8D1th04Se/NSd0bDeD0pha1DF8QeEFZTkvxFYNM7q0n0pDIMXNqCOzZpC
         rahPPrRMrxic0uW44qxZ1EkY2E81jthTbQX3xhzcFTwNCLxjd3q0QjgSF1uQTqxOe+G+
         dGhc/1Bg9B/6MWx5ysynUZSyLYrVVj22gjhEq4RsupU0vht2DkXdP4gO6kNaSDV1ydSV
         fcCg==
X-Gm-Message-State: AGi0PuavwkTcY1rJVZAPbJqk05m7GrkYYKCGsOQv667k/UdCyC1MZ0Lw
        RPN6qoWBcALutjjcHhxNasEPWD6OdokRayP8/cg=
X-Google-Smtp-Source: APiQypLCtSncMsxPH2cCTJRXm5LeJw8H8IJylLVXO7vXh/4Tfb4DcpcxBoTRyE5JutCoMEGfnxOSoxdCQWnhPttFh2I=
X-Received: by 2002:aca:f1c6:: with SMTP id p189mr3237696oih.5.1587048913230;
 Thu, 16 Apr 2020 07:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200406160914.14698-1-rminnich@google.com> <CACRpkdYVwFiCf5MJGLEyhxL8omxr9Tav=8Le_zEX-D89SXjV1Q@mail.gmail.com>
In-Reply-To: <CACRpkdYVwFiCf5MJGLEyhxL8omxr9Tav=8Le_zEX-D89SXjV1Q@mail.gmail.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Thu, 16 Apr 2020 07:55:01 -0700
Message-ID: <CAP6exY+pDg8rAi4RZw5s5jZh1awtWg6_Q5=tm6RYC4c+XZz+cQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: parsers: Support '[]' for id in mtdparts
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Ronald Minnich <rminnich@google.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:51 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> I suppose the use case is using PCI-based MTD devices for testing
> something android images on desktops? I'm surprised it didn't
> come up earlier.

Thanks. In this case it's for systems that companies are deploying
into their data centers, using linuxboot (linuxboot.org) and Intel
chipsets. On Intel  chipsets, there is a 64 MiB SPI part, but only 16
MiB is directly addressable.

Linux goes in the memory-addressable part of the SPI, and UEFI loads
it into RAM, since to UEFI the kernel is just another UEFI driver --
in fact in most cases we replace the UEFI shell with Linux.

But we need a file system, and with the huge amount of drivers that
come with UEFI there's not much room in the top 16M. (we're working to
fix that glitch, a process we call DXE-ectomy, but it takes time).

We wish to place a file system in the low 48 MiB -- lots of room there.

So what one can do is put a squashfs-formatted file system in that low
part of SPI, and, using this mtdparts capability, point the kernel at
it ("root=/dev/mtd1 mtdparts=[a:b.c]etc.etc"). It's a lifesaver for
those of us using u-root for our userland.

ron
