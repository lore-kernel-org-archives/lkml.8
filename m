Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB1FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0FB2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irqR//17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgHCHs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHCHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:48:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 00:48:57 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so22349762iow.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inxNDZ+mTq6xKm6K/Ve4xxqkuXqLFSeNnyy3ksyv6PY=;
        b=irqR//17lYjljop24c9AGd+O/wT8XTcXjRr8qSpHplVc5MjMEHQ++7lBiitQZ3Hk9d
         /XJA/DG3DUOtmsdO9DIGCr+MAM+Y9e5McmZXjNIIjvIikroeJsvjYp6bm9HB474Geb7n
         CERdc5hqohMFwcwB3C8C5VA5IjZtbiLdLqmRI/pa91JqNywLi5bYAc0pwTiEGGkWmueC
         WKE5NoDAonooaKKXg2yyI2TzaexvcvCTxRHQtE5cFGGNs0A8VKqiFHId8lv58hKoXcAJ
         6nMde7j4wzmrRV6Z10PnE9WEG9jCPs4YESBJP6YKNXhJeTTCFP/7HzwlK7ISPeJroO51
         XDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inxNDZ+mTq6xKm6K/Ve4xxqkuXqLFSeNnyy3ksyv6PY=;
        b=aC3TdztsodvkDRkE5XhuCb9acf2KlswzIO48znDPYhfkt+3qgJISptnFp2e2dImG0l
         Q/1LsFDBIJNTFmnAZ6eNLyi1/KRo+ydtWIYinXVFY/u9VFMipQvKuLvghYC0uLugkR0B
         oHIkw0eJ6ftYudlN/pKWPiMxhY+Te9ST8bdTUnRVmy5JtmLhVxftpAaxOGY4s8g+k5u+
         enHt+wUZV4DLrDeLDnHUquXDr1KjWqMYXKyGgdyWket7uiiF6DmJ2vx54ewyddpQOdbE
         S+DNRkC6vwRxFpJOmiFAXiNpDJTqIVTPZE9jPamlfZ47RU4QDHX5nCT8P3dtWqGIEDW4
         AXDQ==
X-Gm-Message-State: AOAM532Ai+cwk0Gl66l+1W7APhPpqlGot7kOnpXiSepXICmwi9kHAss7
        IPQZCCV/UqoOq7vwnUyioQY52Kpt4jWB3NMddoI=
X-Google-Smtp-Source: ABdhPJwqhJSdyNEVBzEB3Peb6dEqbzVhHsuFppJkabdqV68WNCwGfSpkDehI4Sc1rYudbfFPVzae5sHMhEkzFe8QNHg=
X-Received: by 2002:a6b:b2cb:: with SMTP id b194mr4324951iof.105.1596440936530;
 Mon, 03 Aug 2020 00:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <1595852969-21049-1-git-send-email-linmiaohe@huawei.com>
In-Reply-To: <1595852969-21049-1-git-send-email-linmiaohe@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 3 Aug 2020 15:48:45 +0800
Message-ID: <CAJhGHyCQFosRzBLRgHGehsAyoEsCo3BiR96CQtA_EwnQqnVzvg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Use wake_up_worker() to wake up first idle worker
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 8:27 PM linmiaohe <linmiaohe@huawei.com> wrote:
>
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Use wrapper function wake_up_worker() to wake up first idle worker.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> ---
>  kernel/workqueue.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c41c3c17b86a..5302f227f38f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -864,7 +864,7 @@ void wq_worker_running(struct task_struct *task)
>   */
>  void wq_worker_sleeping(struct task_struct *task)
>  {
> -       struct worker *next, *worker = kthread_data(task);
> +       struct worker *worker = kthread_data(task);
>         struct worker_pool *pool;
>
>         /*
> @@ -896,11 +896,9 @@ void wq_worker_sleeping(struct task_struct *task)
>          * lock is safe.
>          */
>         if (atomic_dec_and_test(&pool->nr_running) &&
> -           !list_empty(&pool->worklist)) {
> -               next = first_idle_worker(pool);
> -               if (next)
> -                       wake_up_process(next->task);
> -       }
> +           !list_empty(&pool->worklist))
> +               wake_up_worker(pool);
> +
>         raw_spin_unlock_irq(&pool->lock);
>  }
>
> --
> 2.19.1
>
