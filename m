Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67478C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2986420735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceHY7FSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEET5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEET5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:57:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA7C061A0F;
        Tue,  5 May 2020 12:57:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j14so2398771lfg.9;
        Tue, 05 May 2020 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8xNbatZYDJg5E4K6HPS1HOygBlr1yXucatKboZeD4o=;
        b=ceHY7FSRl6wIu6JczPxHSQFgLm7A3fIwfXdWA4b98i21Na3SxLCM78w8cZbXwqCwDX
         1+mithseYDnTLdOTiQRboJ6mX0y50GjkmiCQWGuh26rxcNc6sNguiGzXViZTlpfBeE8h
         U4WGHF/UREMm/mJ9qxetY/wue82ZkBJRdz1JbU/vwESaGIEgUwK5gqpJONks077me7dz
         LVrs0rOr+OBxxyQ3zKM8gBjoJ6aMAXB+fRWKz/U+NXOJrmGl/qNU5lJRPj9A1etD7zuz
         9E1ylz7uzJBqQ+xqijrPDJM7EFoQ1ew80/yG4OuaXFfyYmmvppBuKp9b/Babf2Q8T/iO
         IUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8xNbatZYDJg5E4K6HPS1HOygBlr1yXucatKboZeD4o=;
        b=coekYnXzkmhaCLd/Ls/aVFiah5LzVrZ1x6tTg5p5D8tvihg0zwx95cJ5is1T6NyzhS
         WzFQtYAsUNvb3SU3hzGhScfp88wRPJ9Ho2XCVLdGf1K+bIf/daAiItkzqdWRwrleusCv
         bzuo5bqsTi1WSDKwl6Li5/DQZt9W67ql5Z/+r850XWj3NajkKHTYfzWfWz5MFXng0G0p
         46t95qtxsCTQlgW9shzsJOITTFWXRhtLc5ie8OLCEa5k/2+DAm86UdOH6sEDibYm/UTU
         rc3+kEhlqaUasEGfXXMMQDbpk7qxGpJhEqMKy+E7iQQSFh59CQUEHfFobjXuleriQkxZ
         iXyw==
X-Gm-Message-State: AGi0PubjmYwobRi4/KL1YhXEAMadf8fEi/eUI/RCZgg+3GP6+NR+MCt3
        n6S0IuXXaBPVesgnTj9pVoU29dhjsKppn76GVmY=
X-Google-Smtp-Source: APiQypLM6WUeEOST02t3M86IqCwu+plzoI77TF8QVnk5/olRMs4ioXXFDolNkp2s9YiGvHKreQc2WhFDSNRqbwwVYPw=
X-Received: by 2002:a19:7f17:: with SMTP id a23mr980350lfd.38.1588708627914;
 Tue, 05 May 2020 12:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200505100049.191351-1-yuehaibing@huawei.com>
In-Reply-To: <20200505100049.191351-1-yuehaibing@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 6 May 2020 01:35:03 +0530
Message-ID: <CAFqt6zYfX68YBjtErDEC35Y-SSsGS1Sy=9Yz35h8-pOztq+5HA@mail.gmail.com>
Subject: Re: [PATCH -next] mm: remove duplicated include from madvise.c
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 3:26 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Tested-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/madvise.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 8fec261457a6..f8be54dd92d3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -29,7 +29,6 @@
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/mmu_notifier.h>
> -#include <linux/sched/mm.h>
>  #include <linux/uio.h>
>
>  #include <asm/tlb.h>
>
>
>
>
>
>
