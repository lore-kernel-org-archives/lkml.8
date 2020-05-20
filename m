Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC352C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AEA20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDYEU8Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETLiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:38:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE0C061A0E;
        Wed, 20 May 2020 04:38:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y17so531431ilg.0;
        Wed, 20 May 2020 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5gCsCCg2ZktsI6WZTvCyt/N51Rkad6rw/S1dWQ5wyk=;
        b=FDYEU8Kf25iQOG7H8v613iXDN7QVeKL+0wv2HcOeF3sRFNk3N1B5Cj24Fdas4AojmV
         83ap1eulAyUn1LZ5nsiDzO+e3qjZQ72rCeWIvmDI8e5NrJ3A2s04Hn0hMfPzG09/LjfE
         gczizyQkl0jM38snWj1UiWDG8IJXx9A2WNViJ/tBAAhg7tjx/0FpNTEctqnmSk6zURU6
         lwIcIdDyV7ZfwERvH29YUZeFXb+ypnDYTR/m27s3oA27eDWbIVi6ClpiQ5sCMDwDERnq
         QfoXC+QUT+qIwn70lhjesnxV5QsDVWCLDIFh2jw5OirunO2h65o6ZOLB53sqQKhDKGQJ
         reVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5gCsCCg2ZktsI6WZTvCyt/N51Rkad6rw/S1dWQ5wyk=;
        b=oIjCT0xr9tkZydAhR+x/ioOgig/3rq3fm5QTNdJGyknY4DjkXCnIQGSWUNCSuYwPUU
         KZt98LlH9tbD/eDco2TwDjMX/5iKIj9IYsirubmjJEhK7VCtyfuV2f4hBjGXxjPNXSKN
         vSilUlpDXYtjVDykvK7mZU/M/U3/zrxTUvF4LGnI8+Au3vx6ykuaAMG7bxFCY3L7h9cg
         q+Mm8dnlMUBlHUPTQ2wptUpBZvBXmFXB9z1ZJh3KZQ0EkcZOQCgeKgv1u9IJaYbncQAt
         ZcIk7/dVLVl+fmXMezrrMKyBAm/bub+tgm4PnaH7Zaa/eR8/5ke4MXLqtxlz5qpdb9TF
         pgmg==
X-Gm-Message-State: AOAM531Q9VkwIsxR5XslQ3Ekga6sK3u8YSijFIztzPMelKr95yo1QkbO
        AH7bDs55kcurITeEZyoYCH81ihEmqJJ1TMo7FA==
X-Google-Smtp-Source: ABdhPJzKJP/cGNNac1kUPgTwPlLIWOHe6TrixFNrwaMIGkK58srY1G5ZeYUEIcAgtqSbV0sC4psNaRowIFiZqCXO4ME=
X-Received: by 2002:a92:8c8a:: with SMTP id s10mr3283841ill.220.1589974696422;
 Wed, 20 May 2020 04:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200520095113.185414-1-tali.perry1@gmail.com>
 <20200520095113.185414-3-tali.perry1@gmail.com> <20200520102452.GP1634618@smile.fi.intel.com>
In-Reply-To: <20200520102452.GP1634618@smile.fi.intel.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Wed, 20 May 2020 14:37:13 +0300
Message-ID: <CAKKbWA5L_n7iC6-d22Am62SOoDBwNWO87+sXtRbwxwuVdjmRYA@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] i2c: npcm7xx: Add Nuvoton NPCM I2C controller driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tali Perry <tali.perry1@gmail.com>, ofery@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>, kfting@nuvoton.com,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>, wsa@the-dreams.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy,
Question below:

On Wed, May 20, 2020 at 1:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 20, 2020 at 12:51:12PM +0300, Tali Perry wrote:
> > Add Nuvoton NPCM BMC I2C controller driver.
>
> ...
>
> > +#ifdef CONFIG_DEBUG_FS
>
> Why?!

It is made to save code size if CONFIG_DEBUG_FS is not defined?
We see a lot of kernel code that is doing it.
So could you elaborate what is the problem?

>
> > +#include <linux/debugfs.h>
> > +#endif
>
