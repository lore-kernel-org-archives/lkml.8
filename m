Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A67C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682DC208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saJPBmpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD0S4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgD0S4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:56:24 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8EC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:56:24 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b18so17775637ilf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqkytQuRqbdyIv1fNw/hFQaHmYGu4kuwrAG4aDt0KwY=;
        b=saJPBmpcSFa8Gvk3fcBP7BcUJ0vdCttdE09MxHpW/uEu9CFjYVwWXKpV1EEM1mB0F7
         JFDFlfW7lrpuG4de/SsT3EJ0es11Ti+ZJc0tiVi4/T1IGbRrXFDHmF+ZBdm2NQpDv+l/
         13SOK6VVfaa+9DkL0COKwTrTcbC+UbULtctB/kvHH/4EyfpJ2bzBsFPAfxyKaZPfVVPZ
         99EVOEKR3i+w77aASsepR7u7Nehl5B2fz4pKmrvxFgFGw/sFvtRkOyA1xtQLbHDsVofz
         ZWeEKbLSdxqY4wWZOF9EMA0Xvh1Uls9FM+b+kXBa5SgpwKJun8A+woBS0WAllujr8kAF
         QlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqkytQuRqbdyIv1fNw/hFQaHmYGu4kuwrAG4aDt0KwY=;
        b=fpFjk/1Vz5xzvvb39AjAmxGFTy4JVADBAipCBNi2AROcDIG3Dpg7Ony4AtpavkKtji
         zb+oG1vGIcwXKKKp4GvcquTRAwrPccD/vEleaAQJiL/9CVgciUB/fn/mHIejdsaoLJi2
         CZ0vcu1i8rw1y3K1aktR1nBf+HzDSqjyF9sdL4FJ/MwJCLUJOltrkjvmpVEZJaOVQsXF
         Sw3Wq3k+ZmL2utbceYFL9q+4qSiTEXkWEDNu6z0wPbmKYNpsVVfdNi7kDKZ4s28qxhvh
         x4GY6QeTaz5uIga9LfoeYAVecgBXcn5KwMTsSRV/fdOUE+sB07yKL35RWU372V7/vi+a
         kwYg==
X-Gm-Message-State: AGi0PuZpuJ9X8iTsmrlr6SW9iEwXRThBWPX8If4cvd8h9GCg5XBLntHC
        JYAsvtDN/+cTwZHjR8x9uBtRVcp+kQwNnH3dskTohQ==
X-Google-Smtp-Source: APiQypKSjWUNccvaGaP7GIFyMyjBa2ylFPQ2+a7hXLOAZWmMk7LFoZjV2MZ6L0j5XxwlwKRKShuLGc74DMMUsDsJ/v4=
X-Received: by 2002:a92:8587:: with SMTP id f129mr22745284ilh.75.1588013783349;
 Mon, 27 Apr 2020 11:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1578789410.git.robin.murphy@arm.com> <CANAwSgSFPtdvEvacNf6DhzE2fCabgZSBNnZUf0+nQErDWpErOw@mail.gmail.com>
 <c7345431-7585-6052-835e-d9c292978b6e@web.de>
In-Reply-To: <c7345431-7585-6052-835e-d9c292978b6e@web.de>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 28 Apr 2020 00:26:12 +0530
Message-ID: <CANAwSgQsMnkRyLCbgbWUGnCOzeK+4rucdMCkBGrv=Gp=Etq5JA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mfd: RK8xx tidyup
To:     Soeren Moch <smoch@web.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soeren

On Tue, 28 Apr 2020 at 00:16, Soeren Moch <smoch@web.de> wrote:
>
>
>
> On 27.04.20 20:41, Anand Moon wrote:
> > Hi Robin,
> >
> > On Sun, 12 Jan 2020 at 07:25, Robin Murphy <robin.murphy@arm.com> wrote:
> >> Hi all,
> >>
> >> Here's a second crack at my RK805-inspired cleanup. There was a bit
> >> of debate around v1[1], but it seems like we're now all happy that this
> >> is a reasonable way to go. For clarity I decided to include Soeren's
> >> patch as #1/5, but since I've rewritten most of my patches I've not
> >> included the tested-by tags.
> >>
> >> Robin.
> >>
> > Can you re-spin this series, it seem these patches are lost.
> >
> These patches are already merged as
> d8f083a302f7..42679765faf2
>
> Soeren

Thanks for the input.

-Anand
