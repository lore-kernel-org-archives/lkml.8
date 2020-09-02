Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F22C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03EC206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PPBmjG4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIBAa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:30:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA71C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 17:30:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a12so3179707eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35zWPSXvIu4DO3Yrnm+LxOfs1qi/PqeeLski48NYjUM=;
        b=PPBmjG4GID7lcGJCvo1vQb4dOUt+krV2oDH2GMnao8CDNnTYAV4j7dJ4lZf2YBB6Qd
         YoqBKE7Ug0i5AbdaipwMRk7u12UFlayygKsBwtycjQ5AGK42v+MgaKEO7GT1oVL2VDaO
         jYlBC7gHz6c0GbALrZV99uBEwJkSxwuTGPIzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35zWPSXvIu4DO3Yrnm+LxOfs1qi/PqeeLski48NYjUM=;
        b=sWSfA1yUGlAmeqGgdWvE493NU09pzCbAwVJNXuUh9dnCelyv3FvH2A2H4PJpYfXJCL
         SGyLaw1oVlAmsjSPvfAjapCJH8dFJivgxvWLeQFW/jm5eUYcSUJ09D+Rc9/T/ZH2UNr6
         QL0o268YkvxeR2QBOp0De81NLwIbyZ56oOfCupOO2MnLsXyk+KGzBwitkjlAmonBS5qc
         UkjeQ6LL3UM+pgvmySJ8D6YuAPHVDe01WJBWTae//M0tr44LrgKd4ybrnCA0h1L1RCg9
         9CZjTIHeF3QM6CJhGMnYR8FnKmYag7ce12PVEPzy9i5s5mrvirw2CAIAMgdKYFDVPn1q
         eILw==
X-Gm-Message-State: AOAM533qXwU1aPxUy+//Fwz+IR2Ar/9gsEtqiKDGczLTdPta5S0FLvc/
        Dnh1aaA1ca9da/6b+ufuTBszENgw6KjMoEZyCF0=
X-Google-Smtp-Source: ABdhPJxYOATn2siAeEZQOP64hyHsL+r9OipZAmIfss+cZLtB/2RnF6cD3xYR5GVNlUtvPOZZ7QUd9vEC1bYb5a3QFs4=
X-Received: by 2002:a50:f403:: with SMTP id r3mr4115825edm.260.1599006621518;
 Tue, 01 Sep 2020 17:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200901120156.140522-1-jingxiangfeng@huawei.com>
In-Reply-To: <20200901120156.140522-1-jingxiangfeng@huawei.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Sep 2020 00:30:09 +0000
Message-ID: <CACPK8Xe7zbYQ7UJOSqBOoj3W9kX9FkutX2H5abXf+ZQv+J+eTA@mail.gmail.com>
Subject: Re: [PATCH] fsi: Fix an IS_ERR() vs NULL check in occ_probe()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Eddie James <eajames@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 12:01, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> The platform_device_register_full() function returns error pointers,
> it never returns NULL.
>
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Thanks for the patch. I already have this change queued up for 5.10.

> ---
>  drivers/fsi/fsi-occ.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index 7da9c81759ac..9eeb856c8905 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -555,7 +555,7 @@ static int occ_probe(struct platform_device *pdev)
>
>         hwmon_dev_info.id = occ->idx;
>         hwmon_dev = platform_device_register_full(&hwmon_dev_info);
> -       if (!hwmon_dev)
> +       if (IS_ERR(hwmon_dev))
>                 dev_warn(dev, "failed to create hwmon device\n");
>
>         return 0;
> --
> 2.17.1
>
