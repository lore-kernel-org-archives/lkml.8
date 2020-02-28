Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC25C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3109D246B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgn/BGOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1WNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:13:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51143 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1WNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:13:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so4998807wmb.0;
        Fri, 28 Feb 2020 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vEgSlwH75ppaka6b+eKVprx44dYfhzjy3hFcJ1TMew=;
        b=Pgn/BGOmhwNTEW9jt9xY95LAAaP/UusK+8Su8i9f6r3ojI8KeWFQuDqpmJ1FzAhokR
         tT8tcCFvUGmp/p70sk2gIiHpRUeylLGWL0bpUAO6Kdp85WvIFX6wGSHzmFI8l2B2gSvu
         Qih+FYevFdaaedcaR0c6dFEw1RyExACbuXfv2iztndTNz8vDErMsRdzdevj4nTsTGOJ6
         NTOLrb6stEwM/3MZb6szs7jgOysv2cZhuMjBdrdu1GiSbYicm/kFRAECfyHxazTcRyzX
         785Z5a5QtAxxXzKU7+F7y4UVszryTRBQEdSvu2ZvpQmESl7UJRqRq5NbryYs4ZUr0G46
         PJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vEgSlwH75ppaka6b+eKVprx44dYfhzjy3hFcJ1TMew=;
        b=ohLTXiU4QI8eWvtuOjgrzO3ckH0Hctwc6AteKzs2XD2uR2OkspLo2c5oHT/a3Xp3M+
         mpeW8oWAUqzWQfO8H7bnjsyeTcm5KnObF3CwgUBZENHf0HWUJLZ3l3FLIKvmdRxvVClz
         t+7bUwMDUpMjvGEGR/rCiXcviYII+Lb+tbwfkIkO5TTiHmpwvHOoXw6UFWJYFaNZqe7r
         F4Pa45KfZkEaEyA4OcPa1QvZUHk8f3eWhtkmd/Ac0oaFZjg4WoW8jlYwn3ofDrGAeAmK
         Mz3lM4bdpdsSr35PC7afCBpNB+KJbza8GjcFN/AHjo9N/LeoxX1ljVLxLzcbqBpcBhIJ
         NL2w==
X-Gm-Message-State: APjAAAWdsvXRtaVrW/0LL/e8+Q6G/CeCCTplUbgm6tzF2PM0cpmTsvYD
        8r1orSzHNXyurzFQbuWlfLDPHcJ+f5mz6/mqPXQ=
X-Google-Smtp-Source: APXvYqyg3Su2Vwre81Y3TJjLjQDh/KfhxYi5ii+aVVnW0os7zljNoaDM0iXi4ScsRG1uz0qAapyLHxVvt9Xn+3EXPl0=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr6528043wmj.70.1582927977310;
 Fri, 28 Feb 2020 14:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20200228130821.64695-1-colin.king@canonical.com>
In-Reply-To: <20200228130821.64695-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Feb 2020 17:12:45 -0500
Message-ID: <CADnq5_NU-GFbj0pTkzjGeMh_J5KM_mNV_NJ_gMFsjt0-Xi=vZw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdkfd: fix indentation issue
To:     Colin King <colin.king@canonical.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Feb 28, 2020 at 8:08 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a statement that is indented with spaces instead of a tab.
> Replace spaces with a tab.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index f547e4769831..5db42814dd51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -490,7 +490,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>                         dev->node_props.num_sdma_queues_per_engine);
>         sysfs_show_32bit_prop(buffer, "num_cp_queues",
>                         dev->node_props.num_cp_queues);
> -    sysfs_show_64bit_prop(buffer, "unique_id",
> +       sysfs_show_64bit_prop(buffer, "unique_id",
>                         dev->node_props.unique_id);
>
>         if (dev->gpu) {
> --
> 2.25.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
