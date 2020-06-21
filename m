Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D61C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2BD22DD3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 11:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="O+Jx4fyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgFULQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgFULQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 07:16:13 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58364C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 04:16:13 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id m62so174904vsd.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7IGlXjZmN0ziDIc700872+Y5GvhCReSWI64jiCe63KQ=;
        b=O+Jx4fyFtrXcAorukY+FbjNGcFZAXcICVq4oTMFKdOuyHnBKRK2BYafSHDa19kKFm/
         +t10/IyQENAjeIa3HViS1N0Rx9knyyxX/34H+A7EKbP3zyWrLcUKunxemf+Zba9SNnZX
         krOj8ijk9R//Vbn64js5cRw7vKC+4akMhrj1V7oioQP7XQ775l4Ku0fZq4SK5Aie996j
         8Vb6OzKFWvNudR1yDEb/4BdLSs2M4kHyIhU+t8cV44SRP/qO27FY1uKCE5kGwfc/e0xD
         s8j5/Lx8LOg1Syom8248+wfga/nf4XMhG0+Z24KHWmJIHUcYNLaxb/CmH3HS1UAj5One
         rwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7IGlXjZmN0ziDIc700872+Y5GvhCReSWI64jiCe63KQ=;
        b=J6Rr9mRvF5pAFFlqMAyrfLJF5STON+Pl9uO/bCtoEmN0NMYf58TdN3T96HMTDplxO3
         X7W7aG827pz1794YJ1FrKpOw9VDVxtDSWn7Edqy4g3nyWeBr4t+P7eL7XqWMu8f7ZOiv
         lrZXzJIQzAnGWr0vOgu+DConKlGPWhLPn5Wf11GfNm904WM6TnlbuE36AzOwikLNVBgT
         HDQ2TyIJjDF8oTcCz7yn3+OvrVP981iT29QrlGLUSVX/T1odOMOP99Wb4nI3XVlj8f+q
         jXL+Pcb2J36OlKBthR5teRwshc8YPSXdqfK8wdR+JeNjUwuLdzW4dNGa5etqBxV09qtZ
         T+Qg==
X-Gm-Message-State: AOAM533TuvwDDj2WW7yTSHZvy/qM6CnWzhWpUwlA0/lhXQ4iVsfsz221
        Ma6p+OkDP18RcjGJlP17PF9urdi0zWvELC1QTgf9Xw==
X-Google-Smtp-Source: ABdhPJzSoPnlO2m8ILQz1XD/pQLW3wC9AI9023XKmwGPujQ8e9a7jU10WwQqxebple3Bvmit1XApYsC9AieQKxaeZgg=
X-Received: by 2002:a67:fb8e:: with SMTP id n14mr13084952vsr.136.1592738172377;
 Sun, 21 Jun 2020 04:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <0a8aabe8-26c4-d530-9ba0-f7f177ba0afa@web.de>
In-Reply-To: <0a8aabe8-26c4-d530-9ba0-f7f177ba0afa@web.de>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 21 Jun 2020 14:16:01 +0300
Message-ID: <CAOtvUMcC9CP+NXG5MGM=-C5hS6WWbCEH6S207=i+0uL55cDZFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto: ccree: adapt ccree essiv support to kcapi
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Libo Wang <libo.wang@arm.com>, Ofir Drang <ofir.drang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Sun, Jun 21, 2020 at 1:11 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> I propose to avoid a typo in the previous patch subject.
>
>
> > This patch brings the ccree essiv interface into
> > compliance with kernel crypto api one.
>
> Can an imperative wording be nicer for the commit message?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3D64677779e8962c20b580b47179=
0fe42367750599#n151
>

Thank you for the review and comments for this and the previous patch.

I have taken all your suggestions  into consideration and will include
them in the next revision of the patch set.

Thanks again,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
