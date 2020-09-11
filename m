Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B87C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AACB20731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhEUrtgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgIKQLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIKQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:10:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:10:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so5298255wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbxEUQps6vESScXmyaIzM2lV4nvnmCDf4+bKC4mI+8E=;
        b=QhEUrtgWKj+fZDMyKLwE/BKdNRzvaTQpARmk62ty0kGcVZPcAPywlm22mc9BY1YG2B
         naOPmTBAF/1xl/fT0oV4GdOE67fzk7jmY3lvaE51nNC69qu9CLGLN8DA8nnA+9ifurXo
         geXkXHDs/iwILRS0Lzr1OIGz/k1sFbuM45shEKHEjPHiKkhzKj0a53sglfQ+fKH1kjpv
         4AHTDdt/P4cydao/Lj/hy09u8HvDO982rfjxJfMS54mW6LG4WyGuwx618Hx/kR61E+z1
         ba7Mbo+1qhX1OOYxxWYCefHJwf71oQXGwvjanwXQajdTADvqIc4Q8XCkOpxDlJcgDxUZ
         JvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbxEUQps6vESScXmyaIzM2lV4nvnmCDf4+bKC4mI+8E=;
        b=cvBWuFJzFkHB85tDJWb51Rl03gpXQ3DMKIOvbQw7dBUi+NbROhuslHJICFkj8zV5wL
         MKvx1brWi+hJ7NnovL7pT4dYyUodEBB7SdZyKpPm1lZOnIDDl1NxKrKr+zHA2RaMUiiC
         Sw0n8n3yGXFJViYA+VLruu2wuqhI97BgCBbFHIhrmH712vND+6MZ9qj7mkFbUZhw/r7X
         biLFv+JHyz8AcZIFHSJ7u5vT+Jy/REO9pVlG3TXw+TvJA10zf2mDplSqI0a3es25GU0R
         tN/bT3rj+rD/XkTEk4FYNZZTvtzE1Elk4V6UZoHGMJgE7C0WRkIjRLcXKC5rfUbvlx5m
         5LJQ==
X-Gm-Message-State: AOAM533Qjwh06lzHmdIgKdqn8SjQQGjG6Cg2alh2g6QHlrEdt0jy/ze4
        h24ykkcJZf1obBvOxu1R4yzDMFk0q6M6DY4tHGTR2w==
X-Google-Smtp-Source: ABdhPJwpsy55MicdcbSdsk7lZoPbb7vZsk90rfIo7W28Aj3HC04QgM46znERfjCsfJQ+KWY8OwY9zlQuMuRiAaiBGyc=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr2898135wmh.152.1599840652329;
 Fri, 11 Sep 2020 09:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 11 Sep 2020 21:40:16 +0530
Message-ID: <CAMi1Hd2CFjQLoXTSuo9wUWWO-hNvuvZr_PffS1NfgP-6agWDOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader mappings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 at 21:25, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
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

Boot tested the series on Xiaomi Poco F1 phone (sdm845)

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Bjorn Andersson (8):
>   iommu/arm-smmu: Refactor context bank allocation
>   iommu/arm-smmu: Delay modifying domain during init
>   iommu/arm-smmu: Consult context bank allocator for identify domains
>   iommu/arm-smmu-qcom: Emulate bypass by using context banks
>   iommu/arm-smmu-qcom: Consistently initialize stream mappings
>   iommu/arm-smmu: Add impl hook for inherit boot mappings
>   iommu/arm-smmu: Provide helper for allocating identity domain
>   iommu/arm-smmu-qcom: Setup identity domain for boot mappings
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 111 ++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 122 ++++++++++++++-------
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  14 ++-
>  3 files changed, 205 insertions(+), 42 deletions(-)
>
> --
> 2.28.0
>
