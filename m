Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F2C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF1C20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp5c5RCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgDIUBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:01:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgDIUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:01:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id f20so30429wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt7MfOcPWNwOUhAt+n186GW5j+dN1ZYZolTB9vhBIyM=;
        b=qp5c5RCFhEC9geh2kh5y63GSRe/Fgd+69KGSaMls3dcJltyClI8Y/Ko3uC9gRT/IQ5
         kQJcBYMWPJJDDB6TUfHynVLMH2TtxZjQwYo0eVkwfDCbZiKOvS7kaUe3XqWwCkoV1KPs
         pM7dfcWgv5Zn/224EeWPScW50zZS+PMMZZScybdJwemz2doChs3tDPV0Eh6f6MCgwXaU
         Q4mWVg8SoW6MTVnF0feLcAEvkA6ia7eFFOOONCsUd+7NIXOjqk1uB/5bsXGvFhAnnua5
         W73PKLyEgRT64SjHA35EyZilfNdvNx2+iTg7Yj4wgSwZt0h2BXEu6sC4cnUMDJCPBSGU
         Pfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt7MfOcPWNwOUhAt+n186GW5j+dN1ZYZolTB9vhBIyM=;
        b=YP6sj+sL/8cIQWGyTCilbhOiUT1N174fjAitCG7P+e6N6geWm7iH1qz41BR+io3Oek
         PFd2C5FP5DlmhDtetdy+MeFrEdfjfTh8kAO+VsPU36AV7naBJEdI6/GxMvU4nhpE2pJG
         6qy3xcrphbQ29uxT30r2gb2piIOmN4MAktwPK6hrwDPPmcxMDCxRv6BRF8Rg1/sU7Ww0
         NAbUz0ulDcrupb3ijQCQZPnIESjclC6Xy+9wvV5BpAgoZ1PFEinIFeE84zHtfBZPwPRk
         qBIgd8zFunBWK21CCG3HOr0oYWtP7bvid8GASn1ARkoEBUo+xuA28vPlLZgSCYZp7TbN
         PeMg==
X-Gm-Message-State: AGi0PuazpQzmsmr293GVRrErwByKfvBGWaRUUw5HOV6weXdP6eI4dzMZ
        CM6/qwLWrR/VQWFdApb7Oa/Qi5cN8f5w2C1/cbc=
X-Google-Smtp-Source: APiQypIRgDGwy8h9WFgdTO9hlP1j+PLidm5+TENx/qWJg5vT1I418LZLeToHEpHyfxgUQLYkITEbtCrbcijXYloHlFI=
X-Received: by 2002:a1c:3589:: with SMTP id c131mr1529468wma.116.1586462498843;
 Thu, 09 Apr 2020 13:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200404153631.103549-1-linux@roeck-us.net> <1671412.OU26QM6KFd@192.168.0.120>
In-Reply-To: <1671412.OU26QM6KFd@192.168.0.120>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 9 Apr 2020 22:01:27 +0200
Message-ID: <CAFLxGvwKuYYA8S+J=CgXniPa2cQJ_vp-0Q_APkxKNPJX_TuWaw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Compile files in controllers/ directory
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     linux-mtd@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 7:31 AM <Tudor.Ambarus@microchip.com> wrote:
>
> On Saturday, April 4, 2020 6:36:31 PM EEST Guenter Roeck wrote:
> > Commit a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code
> > split") moved various files into a new directory, but did not add the new
> > directory to its parent directory Makefile. The moved files no longer
> > build, and affected flash chips no longer instantiate.
> >
> > Adding the new directory to the parent directory Makefile fixes the
> > problem.
> >
> > Fixes: a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code split")
> > Cc: Boris Brezillon <bbrezillon@kernel.org>
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/mtd/spi-nor/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>
> I missed that somehow, sorry. Thank you for the fix, Guenter!

Applied to mtd/fixes, thanks to everyone for addressing this.

-- 
Thanks,
//richard
