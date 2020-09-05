Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79546C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F7220797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc7Ywq7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgIEW0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIEW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:26:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EED2C061244;
        Sat,  5 Sep 2020 15:26:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o21so9896337wmc.0;
        Sat, 05 Sep 2020 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kO4SU6/nW/siFVjam2OIPJSAFbObCvonF2HPGFhSHaM=;
        b=Tc7Ywq7Bfefla4wdZkAi4wzRtTHA3HZUo4yG10hl3Ve8gqdwLwePdy2g+5uZZOyLQ+
         H9nqqKVopB43C5zDytiFXIINTJwIbwOicfW9vNOZO0vgzeRzgzGqpaSrRECaj+ZMX4oy
         q4bPV5MgL5qFWx8UMO8/ayIus6y68lpXUhGi7JYEOKOHaoI1i5pU7uNirFdQ7v/3hcHJ
         HYnQKYASgQdDUpkx6yPxYFlhKC4W5vk6PfRqBe5DtZOi5Z6BzyC7LPxwevz4l3sYKHTP
         NWFnldyRzysAPx8WshWYSkfs2QPTMldmCVx+ylf/JskXeQCiqGbQryyQz2KrpaPLj+BY
         Xg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kO4SU6/nW/siFVjam2OIPJSAFbObCvonF2HPGFhSHaM=;
        b=B5F6KfW4fNqIQkDaNrgrpeq/3BJfwWtTq8/iLRq9Yxc8YlwiTUBfk0qHSgiCdS5fB5
         pFcdxQidihB0lY7vmudb+Rp7d5BfsoGGTmuJ4jN9BjNgRLkoSy1kx0hAwMXB+DDLmVxt
         QI0HHh1LOF1jHnYm1vWhlKUR9M6HxMm9WrXQBq63w1M+17d5husrCvV9pAlfBaOeimYz
         JI3pL88yUPGi3R/vT/aiIk9dXNpL+z3mrbdilLwDu6GeekDNmjE5NpE5ykolWiakAqFg
         /uSIFWVShSKNDe3JSMrG39aojqkpRAbb/UTpVauPc1CAnF9wUbSgwubKK+5m0ogJSRVo
         soOw==
X-Gm-Message-State: AOAM533QfVpPHvSw9/a5eQ2Pb1UvWTGRXAMI/XI5FjmVQd6DS2xDXMb0
        GUnA70/wHf/k/JeUsNz0YTogBXvmBBer2sSMnQcRPpy1EL4=
X-Google-Smtp-Source: ABdhPJyIvQBjARmaml3HdYHp3K3skBZfLZ/a5IEU5bZh9cOSWS4faIxFjRpnaNu/Ls10Q59QEyZ1Zdl8lMeKtjk49KU=
X-Received: by 2002:a1c:105:: with SMTP id 5mr13507006wmb.175.1599344778745;
 Sat, 05 Sep 2020 15:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 5 Sep 2020 15:27:14 -0700
Message-ID: <CAF6AEGvxcYKOgZ2HFdJod4q=jS27TpR28727FzbdJD4gOTYOVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader mappings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 8:55 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Based on previous attempts and discussions this is the latest attempt at
> inheriting stream mappings set up by the bootloader, for e.g. boot splash or
> efifb.
>
> Per Will's request this builds on the work by Jordan and Rob for the Adreno
> SMMU support. It applies cleanly ontop of v16 of their series, which can be
> found at
> https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/
>
> Bjorn Andersson (8):
>   iommu/arm-smmu: Refactor context bank allocation
>   iommu/arm-smmu: Delay modifying domain during init
>   iommu/arm-smmu: Consult context bank allocator for identify domains
>   iommu/arm-smmu-qcom: Emulate bypass by using context banks
>   iommu/arm-smmu-qcom: Consistently initialize stream mappings
>   iommu/arm-smmu: Add impl hook for inherit boot mappings
>   iommu/arm-smmu: Provide helper for allocating identity domain
>   iommu/arm-smmu-qcom: Setup identity domain for boot mappings

I have squashed 1/8 into v17 of the adreno-smmu series as suggested by
Bjorn, the remainder are:

Reviewed-by: Rob Clark <robdclark@gmail.com>

and on the lenovo c630,

Tested-by: Rob Clark <robdclark@gmail.com>

>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 111 ++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 122 ++++++++++++++-------
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  14 ++-
>  3 files changed, 205 insertions(+), 42 deletions(-)
>
> --
> 2.28.0
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
