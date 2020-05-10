Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9068C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1D420644
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/pp2I92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgEJKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726630AbgEJKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 06:33:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018BC061A0C;
        Sun, 10 May 2020 03:33:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v10so2378513ilq.8;
        Sun, 10 May 2020 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MhU1qxBhHgVGXr08PP5FOxyGrOpVSZlL9oot8vd0Tk=;
        b=S/pp2I92VN17TuNxdZ0OCTbEMUiZiu6Z6FsHV0W+uy6p41FMXHsZ724v1HIr1Y3t/3
         PSGUhe4fuHIf5Z3uCINKpDTAeNhp3K+IbJDLwSC32ZKGD2IN5U2iLQ1IRsJSWqiJlhGL
         vVIFgk8CBnf+Rbh5ML577bbcvPU+k3UtY4IgJvx1n4d/qHPboDMZkFoM/Cnnjb4c3SiV
         TID0Vp9hlmXslxDoWVIVub74vnDhgl6h/NXh3LQ/k3LllzP1L6lmzemg3zhWGm8FVe2E
         5hY7UpXEkh+KBqMVLGkSFeMZnQ1LARWvwBhAjP4KmZchwYu0SbbHU4pvul0qg6XHDET8
         JVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MhU1qxBhHgVGXr08PP5FOxyGrOpVSZlL9oot8vd0Tk=;
        b=DFPHp9EKeqTbj9+usPK83ZCT1kqZe83Q9Lbw4gc5RbUNP4iTW9G8bK78Y4JYo+nlLA
         YPWcmkgcGDn1Nc6I0ovakrpHyuzA3POKPMkLMLH09GbpNb7wzNr2EPLxxGzx+GywpFBa
         wzZYWurXqlMoe1t7pbr+qGfiVrWhrnE6sD3KRafBZxgI3nwmyqdH9AXoQS7c872FICPN
         n/mTuHogdROGxNBB7gEdXus9DfVOwK4axydgXN2e7n7T0IDyvzfJDVrYKGVoONr5dzLH
         Ty/xTNJinZMtGXrwc6sd65yj2LZn2C/agUFiDOBwS1XxPUOi3LYG1xIyuovwvZam/DE5
         qTQw==
X-Gm-Message-State: AGi0PuY4XEGbXwbZGcak3mQ1j/sDXV402a7EAjmnmjUwkPK9ZzpfL7HC
        5ckDjKoiOweOnvDo08zPL3Xm8FbiTwk41YsUljVgetSh
X-Google-Smtp-Source: APiQypJujdQpJU4zFu1TcCMDwR8LGjZxvj1n+h7Wtb2/p0xaTZ/uB4wEbCDUk4amEeAk5bQirurBQBV1W3culaiCL+s=
X-Received: by 2002:a05:6e02:973:: with SMTP id q19mr3087421ilt.164.1589106817201;
 Sun, 10 May 2020 03:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200508150740.GA415175@mwanda>
In-Reply-To: <20200508150740.GA415175@mwanda>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 10 May 2020 18:33:26 +0800
Message-ID: <CAJhGHyCC+oLV3iqP7ZEU+x0BRcQiKYm6sYmAFTmOemJOJubayg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix an use after free in init_rescuer()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Sean Fu <fxinrong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

On Fri, May 8, 2020 at 11:07 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We need to preserve error code before freeing "rescuer".
>
> Fixes: f187b6974f6df ("workqueue: Use IS_ERR and PTR_ERR instead of PTR_ERR_OR_ZERO.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Another option would be to just revert the original commit.
>
>  kernel/workqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index ddf0537dce140..10ed8d761e0b7 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4197,6 +4197,7 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
>  static int init_rescuer(struct workqueue_struct *wq)
>  {
>         struct worker *rescuer;
> +       int ret;
>
>         if (!(wq->flags & WQ_MEM_RECLAIM))
>                 return 0;
> @@ -4208,8 +4209,9 @@ static int init_rescuer(struct workqueue_struct *wq)
>         rescuer->rescue_wq = wq;
>         rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
>         if (IS_ERR(rescuer->task)) {
> +               ret = PTR_ERR(rescuer->task);
>                 kfree(rescuer);
> -               return PTR_ERR(rescuer->task);
> +               return ret;
>         }
>
>         wq->rescuer = rescuer;
> --
> 2.26.2
>
