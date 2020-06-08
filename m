Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D56C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BC42078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6g4FgP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbgFHXol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgFHXoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:44:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915CAC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 16:44:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w1so19166202qkw.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gs6xQWOcGcanVIymuBusEerQJN8/eccvFb5JF12HOsY=;
        b=T6g4FgP/EG+S8J0dp+tNKaVDqGkjGRk6p41N/PfIs/f4GlpNxo3c9SbowX+umQuBRN
         eu6h/vMBvNAdoMEJdssQkFJyyPHmHtnBUe9aGjD9uPeTr5tHrpCk6MxLcFFKfRAh/tjM
         PMM5spbgykS+j6ImdKEhx3Lz+Cid2DPS39kVmu9uF3Z6dq6jskzPRztOgbVGzj5NoasH
         tZk5dVSV6iaMAjzy7vrknO5zYs5CuxJZpBVroZyo+egR77R11MzeWPxPYlkIpR3uT4Xg
         mwfc0Gk13EYGK2lh5nOEQLInindjaVSKhUh2uXVK8q8hk+sX/JdeAuPUd4jgSdiQxRLc
         McBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gs6xQWOcGcanVIymuBusEerQJN8/eccvFb5JF12HOsY=;
        b=RJll+z2wd0Wc3YEnjnNMxX5MzjjxZOYctdNKxiAIhm4oFypewJQ7pOGANRWqSXLQbJ
         JMRVRoi9ZxrK/GelkzEVetQ40xb4FrakkAM1qrNwR2j4jAmh4cDeS7qVnTPR7sU9KeAb
         ry+aqraD9nQiKl9mwGvcsJcFVyrnTllnuFieBIf8a7Hu5amAnrFzb1Hn9RdZaIqiVypc
         im4ugiL4eRzsxAF0a7/gz5tWd8V2CklaCHVX59hvsQv7nVuLu2eMrhzM8BlC2M7n8swI
         W5Vmp8vDQBcGiI8Hbf6kIduHPAQ51alXzxploR42YY9OPsLdFLxwmKt+DoQnSSmA6rMk
         RyQw==
X-Gm-Message-State: AOAM533cEx5FwQWpr/DAmZpYo8kYdzNteTat0vHwjmG8vig6JAy82z8X
        zrBaEC7pDpxMO/PCOSL85/GWuvrsnlMUSjR3dP8OVQ==
X-Google-Smtp-Source: ABdhPJxKTLQNJam9JoiPaSDgXVfBJ+DOjhT5E0yiLmJEI1zwOdTGg0siAWIYukyho5a8+cEQtzNUeMwoj2dKza1o4zg=
X-Received: by 2002:a37:ec4:: with SMTP id 187mr23555902qko.124.1591659877470;
 Mon, 08 Jun 2020 16:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200410225208.109717-3-joshdon@google.com> <158835733205.8414.9136130857443620621.tip-bot2@tip-bot2>
 <BL0PR14MB3779C02BB87DC4426C4761639A840@BL0PR14MB3779.namprd14.prod.outlook.com>
 <20200608145304.GA24379@lorien.usersys.redhat.com> <BL0PR14MB3779AD967619031948957C549A850@BL0PR14MB3779.namprd14.prod.outlook.com>
In-Reply-To: <BL0PR14MB3779AD967619031948957C549A850@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 8 Jun 2020 16:44:26 -0700
Message-ID: <CABk29Ns_tziZ_vLzWhq3YDA=LtmCmcacDv+hEUbBVdFVV1w13Q@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/fair: Remove distribute_running from CFS bandwidth
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Phil Auld <pauld@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Mon, Jun 8, 2020 at 4:01 PM Tao Zhou <ouwen210@hotmail.com> wrote:
> After commit ab93a4bc955b, cfs_b->distribute_running is not used and
> removed. The lock/unlock protecting it are not removed and remain in
> the code. One benefit of removing them is that it can elimite the code
> size a little.
>
> Fixes: ab93a4bc955b ("sched/fair: Remove distribute_running from CFS bandwidth")
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 35f4cc024dcf..cc2e1e839e03 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5089,9 +5089,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>                 return;
>
>         distribute_cfs_runtime(cfs_b);
> -
> -       raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -       raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }

Thanks, I missed the now-useless lock acquire in my revert.

s/elimite/eliminate

Reviewed-by: Josh Don <joshdon@google.com>

Best,
Josh
