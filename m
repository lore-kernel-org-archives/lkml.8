Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9DC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D0820801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kjx/NQD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBTKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:19:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35174 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgBTKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:19:51 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so4080722iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSkbSzQFKatU/Nz6Rp1qN4oZDs3Z4cqqLDqeNH59guo=;
        b=kjx/NQD3Qkv7NEGn91Aip3DxCh0RzZJcTTt9NwWOHCsAWQNvUymY9dING/uKp/aVKr
         KgtgJ1CuKzOKuDTIOpGaRkU72UbdoxkTu1xBJvqRNVZVri3z57K4b/U2qzKIEsSBxNM3
         Tj/qsWPVDJ/iAgbmCT9bYofBhYuVfArqA6HCazLUG9qOh25w15ZaIqoEGVdjdQP5bg61
         lWKfIsAJ1imAovRwKhLEOmoucpqbb1JW6b+KcBR920s3mE8iqm10nb7v1KKUTGGEBI5B
         gf6RKfExxQP9GtgK3nZygOhUUlYmfISApi5Q36/QiQffRZSq/FNe/XQlxddBdM94kCf4
         HrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSkbSzQFKatU/Nz6Rp1qN4oZDs3Z4cqqLDqeNH59guo=;
        b=AC3lI2hTQaeIrBsVtmpdkBXceDc3LRsjFm+m8S7ioDyOWv0TbCW7eiL6EFPrSjUsUE
         QPbMyDXPj40G2L4s4sUMH+YFg5R94FB2+VQlJnWObAC5Pi0KYPv47RVx+/Mf9/GeTjd6
         XuD/3P4rO+291egWrUbtxp6cNmycEteSuKeXbgCwoyppNsjp5AmSZ2KPzC0hjpDOYZzW
         tni1v+K+JduG+4uy/yVwwqJoruEUi4QtocBpb6hOGVXJUQgKFaDjlCeWQP9APNafRHIP
         WhpWLqtVu1dHv8hfYXzQu9EiGnaeKo1K/qOP/Bo9tGSaVaycZjGdQz19jAuL3rXgNElv
         kVow==
X-Gm-Message-State: APjAAAVAvbwyJ28kLses9Dr8Sj5LUmAY5VmLw7F3W2voCO6OBNhOQiP0
        8NEz5XTWtKb0wKKdG0Dkf804QKGuC16IaJSWocrKkomVi48=
X-Google-Smtp-Source: APXvYqw+HHFsilzmJ9kYjMOEhixSgKp9xidKItJIJp7tFe6MHgufzszPMPZkLQ/3nwhIOZxGa/3LzjfqS5zzHNYui/I=
X-Received: by 2002:a05:6638:5b1:: with SMTP id b17mr24498386jar.66.1582193989361;
 Thu, 20 Feb 2020 02:19:49 -0800 (PST)
MIME-Version: 1.0
References: <1582018657-5720-1-git-send-email-nbelin@baylibre.com> <04642127-0e68-43b1-9b6c-0dbb56dc9bfe@ti.com>
In-Reply-To: <04642127-0e68-43b1-9b6c-0dbb56dc9bfe@ti.com>
From:   Nicolas Belin <nbelin@baylibre.com>
Date:   Thu, 20 Feb 2020 11:19:38 +0100
Message-ID: <CAJZgTGGREREnozgwsm26EwSoM6hXawNfOK7hF0soOkKzMqwD7Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] leds: add support for apa102c leds
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Le mar. 18 f=C3=A9vr. 2020 =C3=A0 13:47, Dan Murphy <dmurphy@ti.com> a =C3=
=A9crit :
>
> Hellp
>
> On 2/18/20 3:37 AM, Nicolas Belin wrote:
> > This patch series adds the driver and its related documentation
> > for the APA102C RGB Leds.
> >
> > Patch 1 adds the APA102C led manufacturer to the vendor-prefixes list.
> >
> > Patch 2 Documents the APA102C led driver.
> >
> > Patch 3 contains the actual driver code and modifications in the Kconfi=
g
> > and the Makefile.
>
> Is this something that can benefit from the Multicolor framework patches?
>
> https://lore.kernel.org/patchwork/project/lkml/list/?series=3D427513
>
> Can you RFC the APA102C driver on top of the Multicolor FW to see how it
> blends?

Sure, the Multicolor framework will probably improve my driver !
I'll send you a new version once I have tested it.

>
> Dan
>

Thanks,

Nicolas
