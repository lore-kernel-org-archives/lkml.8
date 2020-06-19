Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C16C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF6D208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AdMIDDOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgFSNRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFSNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:17:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA56C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:17:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so10193253ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wOjmdghDgCr0CVW/w+ANaHsM9R02N+bI2f+Qakkg04=;
        b=AdMIDDOm48JzlgAbMfmdT7CMIHIeIBvHJyz7mPGtN6zJk4LwqgxpN/hZGdVo0VASAt
         Lyw5m3PubCEZ+10hrq5KRfJX+fVs3MMW8GT4hHjcTe00VvX7WXAvB/G5cJfB+LXHAIGd
         3122mSxKPYSxh37gtVhMYpuVAfPn6lcGEM2sgOE9gdVa0zSKXwwbwypwKkFYGd38UjIL
         fg4a0/oV1LuvsP4jJwib7V3BXTCwIsOP2GvedZQw10ii3DEtcC/andJeIqgYz9O+nbah
         mqJ0BBHzsja5eM9n1nypxvL8hTTxM4/cJRLCCvUeVE8VfFnEJ5rnD/4xpsZXAptDK1aI
         W0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wOjmdghDgCr0CVW/w+ANaHsM9R02N+bI2f+Qakkg04=;
        b=VN0AJtr14sJYfxtARxgkhpm8o4DTsVOr9gpmk5sFsj88ARQ3M+BbhQ9EWTiSRtwoY2
         2QL4Vu3meunyp13Jvqm1SUlNRScyWq1l+Zfs6Y9q3T3FqCrHaWJgYdxcCrWZh+29vAIo
         0tSzAeMKcHJb2NH3V1PwFoFj7f4kJ1pombIhfL3V/62+n3Pp3DbrZLqi5AC/y+yyRvF5
         bG4/CWtps6DGBl0rO7ZuTVeuMRX4cpvau0GX1PC8d1/CzNhTNfnWrHFsyJ9dxwluatGQ
         v+ynQ9p0tvmQr9Ajfry40m51wSa79pseMT10l1Q//jVwx0bdeafvsZdywT4lAznGBN+V
         Z3/w==
X-Gm-Message-State: AOAM532EnwlttH9dtvA9t4e5yfzpszgT5YuFcuCberoGNKLR22akb27l
        u9KOwIF7s/bUqoxj/GJw4dqpKsTw8baAyC9U+kAr+A==
X-Google-Smtp-Source: ABdhPJxcJ/168e4c4toRNAYbOlSZtqzl1xPYGZjvMPOjLLgjxFymZskBfiH8Awgduu4mn5iXcuuVMzfkSuTwlK9Vlgw=
X-Received: by 2002:a17:906:fc13:: with SMTP id ov19mr3575299ejb.212.1592572627815;
 Fri, 19 Jun 2020 06:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
In-Reply-To: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 19 Jun 2020 15:16:57 +0200
Message-ID: <CAMGffEntL4XkF6bCuhUDP+AOBO4mpKK1pTe3NgPUW86ySyy7Wg@mail.gmail.com>
Subject: Re: [PATCH -next] RDMA/rtrs: fix potential resources leaks
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>, ledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo,
On Fri, Jun 19, 2020 at 3:10 PM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Dev is returned from allocation function kzalloc but it does not
> free it in out_err path.
If allocation failed, kzalloc return NULL, nothing to free.
>
> Detected by CoverityScan, CID# 1464569: (Resource leak)
>
> Fixes: c0894b3ea69d3("RDMA/rtrs: core: lib functions shared between client and server modules")
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index ff1093d6e4bc..03bdab92fa49 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -607,6 +607,7 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
>         else
>                 kfree(dev);
>  out_err:
> +       kfree(dev);
>         return NULL;
>  }
>  EXPORT_SYMBOL(rtrs_ib_dev_find_or_add);
> --
> 2.11.0
>
