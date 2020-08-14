Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F496C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7728620B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpZwP2g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgHNNTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgHNNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:19:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56777C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:19:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so8329289wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyacguIGHHXsED289fd39lR1bWbtVfQPtH3fTepckZY=;
        b=cpZwP2g/7XZePuqzXyIT+2dWS2vatxuYvpS40kBioWQMZ54CsBv4sHxJuWQwK6YamD
         6+58laePhHIUrnObzWrJ5p89hNnDfHxQ3dyOLaPJ+xCRzg1YMRDWqjA0rJJ4cbtyWWE9
         bmgXfUsCj8+xTBU6Wr5iKXtvh81gkZI4rf8PqE2j5lZtcWwN8g9Mevd6/IXyyobmsR54
         nMSaZFb+mWB5HUejbbZKThI/vCt+0XwU3riqdJpswvU9Sa4vq6C+C1JNXTR057dk7osL
         YnuQoAGsKoPPhvcphq3K+VH9ZvFJ+bIiFCtftVAbPKCcQK46KZEZA51HoKyuJqEbpiUr
         uZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyacguIGHHXsED289fd39lR1bWbtVfQPtH3fTepckZY=;
        b=E0J8ZSc5s8mMGzY6fgPNB0Dh6Jz+G14A2uaGCkvy+oGZDKYuz8rsnzad1RPafbWkAV
         piEbfrWyAhvpG9eSe1cAXmhBK509h28eamorvArSxLdsYv554e8D/BsdF05ne7l9eyhP
         zYNpiefqiR2RNfoMCMso+D633CavUS93hH9rIKoFi7ZjzvhssDuXDDSlKvuAniDiflSR
         nM0LtRpUrM6oHsn1BjKVnoxmnxQiVllrxccLPf3l5ZR5jRsQP1kP5J5TBecOU061HWNi
         2ckoYdiJYNqe3INap2INoOjPZJmFDYJjarHLKZEK+cL52YQelbgmzEKTUK4NnqmXJ5yk
         In3A==
X-Gm-Message-State: AOAM530Co2+5dml/XgyLQmmENGFz88bs6kgRFag48s8GapLGozmW0zA3
        rJKq1vCld8tMmONjXH/ZkJNujKWHv6nDLCZNkmvsMw==
X-Google-Smtp-Source: ABdhPJw5Yy1Vffms01Njx5oCbd4CYLl2ai89zPD4KhUODy+zk//A9mZYsRdg5wgrh0cBp+Jjn1J3NcPEufy4cQQGF9s=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr2603518wrl.176.1597411152041;
 Fri, 14 Aug 2020 06:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200814102625.25599-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200814102625.25599-1-nsaenzjulienne@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 14 Aug 2020 18:48:35 +0530
Message-ID: <CAMi1Hd1DzJmqehvxkJ91vr_M_kzdujiHmgyuwUgQYei7VocgZg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dma-pool fixes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        lkml <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>, jeremy.linton@arm.com,
        linux-rpi-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 15:56, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Now that we have an explanation to Amir's issue, we can re-spin this
> series.

Hi, Smoke tested (boots AOSP to UI with Touch/WiFi/BT working) on my
Poco F1 phone, with upstream commit 00e4db51259a (+ 30 odd out of
tree patches [1]) and I see no obvious regressions.

For both the patches in the series:

Tested-by: Amit Pundir <amit.pundir@linaro.org>

[1] https://github.com/pundiramit/linux/commits/beryllium-mainline-display


>
> ---
> Changes since v3:
>  - Do not use memblock_start_of_DRAM()
>
> Changes since v2:
>  - Go back to v1's behavior for patch #2
>
> Changes since v1:
>  - Make cma_in_zone() more strict, GFP_KERNEL doesn't default to true
>    now
>
>  - Check if phys_addr_ok() exists prior calling it
>
> Christoph Hellwig (1):
>   dma-pool: fix coherent pool allocations for IOMMU mappings
>
> Nicolas Saenz Julienne (1):
>   dma-pool: Only allocate from CMA when in same memory zone
>
>  drivers/iommu/dma-iommu.c   |   4 +-
>  include/linux/dma-direct.h  |   3 -
>  include/linux/dma-mapping.h |   5 +-
>  kernel/dma/direct.c         |  13 +++-
>  kernel/dma/pool.c           | 145 +++++++++++++++++++-----------------
>  5 files changed, 92 insertions(+), 78 deletions(-)
>
> --
> 2.28.0
>
