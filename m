Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ACAC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E484520578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBXHWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:22:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36628 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:22:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so9047051wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 23:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uWqpH0FizNQxnodtS0BMO7C44y4V2HGUhMB2HUYwPs=;
        b=l36brtc6N6grQqiI/XIhTNCTkjvrohQdVQZ4U4Nt/Sc3i/qX9xbXbkkm5epeSq4szh
         a6ZDIParg6uHmSwMEZGeNvO2Zb6Q1ev9L8cP5lrvaVRf6ff7BaUuYH9Ksr5spVCzeF4M
         FdUXrNoTyzZvAGXAfryBQ2o+dlBwnZk47EJCboMyFyRkKTSgfYQEi9E8XIHiDSQ18Jlc
         gSgJy9TNhkyNpiFInUhX33shINgCLNYHaydJu5fLKJs0WAXA8DbVX0fuOaskYMM9Kqoz
         zaUwKXAIMSQl7sC8PNIx8++HwxgnETYopSxzoh2TMt4c+tV6UN842wlNYiQbtPX++OWG
         Qzug==
X-Gm-Message-State: APjAAAXkimYavSUNCy5ALndlwFrNIQvR/7TvjtoN7GSvoeOrifIr0qqD
        I3HCLgFUs6tMS4FccDxcdO9F4rx9uf0hcrQFLrY=
X-Google-Smtp-Source: APXvYqxdjZnbif7bpRaQNJiBwyEsuJs/aB/6ns4Tb7r8+8Jic7+2DM/05pAk/J8TW1lgRsRDnMiyVJDa+sjcJk6tMd4=
X-Received: by 2002:adf:eec3:: with SMTP id a3mr61552115wrp.337.1582528970137;
 Sun, 23 Feb 2020 23:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20200212202236.13095-1-robh@kernel.org>
In-Reply-To: <20200212202236.13095-1-robh@kernel.org>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Mon, 24 Feb 2020 08:22:38 +0100
Message-ID: <CAAObsKB8e2MN-VJKYSeX1iibmA4d4i+GL+SWYiLHpg3g_Qby7g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panfrost: Don't try to map on error faults
To:     Rob Herring <robh@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 21:22, Rob Herring <robh@kernel.org> wrote:
>
> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> If the exception type isn't a translation fault, don't try to map and
> instead go straight to a terminal fault.
>
> Otherwise, we can get flooded by kernel warnings and further faults.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I rewrote this some simplifying the code and somewhat following Steven's
> suggested. Still not using defines though. No defines here was good
> enough before IMO.
>
> Only compile tested.

Looks good, I also tested it on RK3399.

Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks,

Tomeu

>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 44 +++++++++++--------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 763cfca886a7..4f2836bd9215 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -596,33 +596,27 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
>                 source_id = (fault_status >> 16);
>
>                 /* Page fault only */
> -               if ((status & mask) == BIT(i)) {
> -                       WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
> -
> +               ret = -1;
> +               if ((status & mask) == BIT(i) && (exception_type & 0xF8) == 0xC0)
>                         ret = panfrost_mmu_map_fault_addr(pfdev, i, addr);
> -                       if (!ret) {
> -                               mmu_write(pfdev, MMU_INT_CLEAR, BIT(i));
> -                               status &= ~mask;
> -                               continue;
> -                       }
> -               }
>
> -               /* terminal fault, print info about the fault */
> -               dev_err(pfdev->dev,
> -                       "Unhandled Page fault in AS%d at VA 0x%016llX\n"
> -                       "Reason: %s\n"
> -                       "raw fault status: 0x%X\n"
> -                       "decoded fault status: %s\n"
> -                       "exception type 0x%X: %s\n"
> -                       "access type 0x%X: %s\n"
> -                       "source id 0x%X\n",
> -                       i, addr,
> -                       "TODO",
> -                       fault_status,
> -                       (fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> -                       exception_type, panfrost_exception_name(pfdev, exception_type),
> -                       access_type, access_type_name(pfdev, fault_status),
> -                       source_id);
> +               if (ret)
> +                       /* terminal fault, print info about the fault */
> +                       dev_err(pfdev->dev,
> +                               "Unhandled Page fault in AS%d at VA 0x%016llX\n"
> +                               "Reason: %s\n"
> +                               "raw fault status: 0x%X\n"
> +                               "decoded fault status: %s\n"
> +                               "exception type 0x%X: %s\n"
> +                               "access type 0x%X: %s\n"
> +                               "source id 0x%X\n",
> +                               i, addr,
> +                               "TODO",
> +                               fault_status,
> +                               (fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> +                               exception_type, panfrost_exception_name(pfdev, exception_type),
> +                               access_type, access_type_name(pfdev, fault_status),
> +                               source_id);
>
>                 mmu_write(pfdev, MMU_INT_CLEAR, mask);
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
