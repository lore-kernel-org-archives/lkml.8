Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A59C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA71207D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKQz3Imw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgE3HI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgE3HI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:08:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03752C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 00:08:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so6319264wrv.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8BduaMh4UecgYnKme0JNCRgXH5vtivBSGRZ1LWNJ6k=;
        b=YKQz3Imw2HUvSXG0Dil+E+Uao1qIQuKEM9/MoSk0zq1sa5IyZ1GdRra670H2DTOPGl
         mrCaVRK/CG3oRk1JCpQih530qatB9/MMAihyiFbhmZ/YRDg1FjVdHGAsgbq6MonailYA
         /7UXAY8gpublsRUlQpcEwyLMB8Bizd2eYUSTC3s7e+QFb37txYw87tuITFbi7ljlgjfl
         RfTD45Jsqzk1gfGbifOKeCb+hhU4iDcSsfB5eC3jKDumOjbT2/Nm7EAimlGWdl5VHJ0U
         y20OgARcHo5xelhmtXATkXjFKANEwCKgKfD5XyHxYPCLRSyvob7n1rfmYWU5Wmy5fXE8
         EynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8BduaMh4UecgYnKme0JNCRgXH5vtivBSGRZ1LWNJ6k=;
        b=ttpQnniSWc9vEAADsHAmvUnQQTAxM6FRcAjnCtY5x6ZiGtL2X8MJcr1dJ0AnSHEMWy
         W3SPFQdC22nZ+yMFzJ2How7Om4f7Kd7utRFM2R845dAnPTr03v6TFgIdVqurbDPtmwEl
         67NaFoBLivo6/z/N5sA2wmt/XzrO32+Iec4VRkADpMMitNZXU+VK7setYlHqHfE2RdeP
         mKXsSYYD7NvotbaZ0hu23RjFyXUGsJzuUKbv5wxqH+GHpPSAkXZAvPKZP0Oym9fUestN
         rgPIvzlXR1X1R0CkZ2AfcFFlajibAGYyy4hX3guwuAimpYIf4K9pc/mJcrQpao55QlD8
         4ezg==
X-Gm-Message-State: AOAM533ZFeCYKEEHt70nNEgFPJS6LHpiRAuBzPnoVf5fk47GO5B4MQ/x
        xJfD3btBZuTfbezZA7ovBiY8sMZbkjtR4tAfH2yWmCC/OYU=
X-Google-Smtp-Source: ABdhPJyA44wyL2GXsxrDDw/3EXNIzjH9L/hV4blJi+2hohhTdxTOG29oKXHuKMUEGfYehxWHBY91khTZJwOgXF9s0f8=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr12572901wrn.96.1590822534798;
 Sat, 30 May 2020 00:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590817116-21281-1-git-send-email-wetp.zy@linux.alibaba.com>
In-Reply-To: <1590817116-21281-1-git-send-email-wetp.zy@linux.alibaba.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sat, 30 May 2020 09:08:43 +0200
Message-ID: <CAM9Jb+jWnAPUYpJ-QrUR1oBCj+RwdAZMLyO4GCmAq=8V76VQTw@mail.gmail.com>
Subject: Re: [PATCH V2] mm, memory_failure: don't send BUS_MCEERR_AO for
 action required error
To:     Wetp Zhang <wetp.zy@linux.alibaba.com>
Cc:     n-horiguchi@ah.jp.nec.com, naoya.horiguchi@nec.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some processes dont't want to be killed early, but in "Action Required"
> case, those also may be killed by BUS_MCEERR_AO when sharing memory
> with other which is accessing the fail memory.
> And sending SIGBUS with BUS_MCEERR_AO for action required error is
> strange, so ignore the non-current processes here.
>
> Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> ---
>  mm/memory-failure.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a96364be8ab4..dd3862fcf2e9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -210,14 +210,17 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>  {
>         struct task_struct *t = tk->tsk;
>         short addr_lsb = tk->size_shift;
> -       int ret;
> +       int ret = 0;
>
> -       pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> -               pfn, t->comm, t->pid);
> +       if ((t->mm == current->mm) || !(flags & MF_ACTION_REQUIRED))
> +               pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> +                       pfn, t->comm, t->pid);

Maybe we can generalize the message condition for better readability.
Thought a bit but did not get any other idea.
>
> -       if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
> -               ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
> -                                      addr_lsb);
> +       if (flags & MF_ACTION_REQUIRED) {
> +               if (t->mm == current->mm)
> +                       ret = force_sig_mceerr(BUS_MCEERR_AR,
> +                                        (void __user *)tk->addr, addr_lsb);
> +               /* send no signal to non-current processes */
>         } else {
>                 /*
>                  * Don't use force here, it's convenient if the signal
> --

Looks good to me.
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
