Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97F7206D4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5BNbEYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHBVZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHBVZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:25:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2DAC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 14:25:34 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so11602875qvw.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vPBcIAaDQT1fIr7QHvmC5z6P2qSBTffqgMpR1sAJ18=;
        b=H5BNbEYwlq1eaQkM03llB+jv8CkBc+J5Zgu7JNzbHTkmruj9rx4ybP++eTVD8DoAsN
         902r8DaB52xvylcxNmAUm22FWb/LRd2fxdc4Tu6JhF4/ZT9TeT9GXP6GWxO1M1QEgl3r
         kIFO71kTZ23lj3v8hlQmrwteLSbleHC/jNtXVcdAUVQYuvegY0HiwMZ43cErM2M2iWhV
         wk0h9mbN1hESKLNRsuMc40JUWR1z4pnQboCTZAeAgsAvPBD5ewobcDceLhTUXts9Yv0X
         xTjqzLpm0efT8C9qRM1T8wmCI384Q675QPcgK3w0C0iWkppUJco9aSGa5C6pDFhxvWW4
         jEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vPBcIAaDQT1fIr7QHvmC5z6P2qSBTffqgMpR1sAJ18=;
        b=pzS2uSV9uH96fF0o2qSUbDzFy7qVgew3EpUoQOC7OjwC9go0mqGIlloHdPNZUjla89
         7UajVJk6a8JZR5hV2Ujh8qyYXn5dlAOjfXqGpChu4wRZVU+qqGTI/lUTk1LPMHwafIWK
         5ZCNsdrf1OVM+fAC6DneSMualCyA9nx4RAcGiTdKPaRY+aHHIFm6OcdDCvcrvFZNftbC
         TJUYrqYrAipaTChk025OJe67mFJPTTuVbWkPGOFPj2NyUMypP6W1GiD2ZfCB41MbYlsf
         k/nu6SGBlB3+jtJozmI195pylWjnmh0btVMPMXYOqdycMRs4JCocZOtBxgqwdkE9aZnY
         QadQ==
X-Gm-Message-State: AOAM532UZ0wdIU+yFkLiuGuh6OCOQXgYEBOabN9D94/Hnm0dzglhpd2i
        XaYnjBeUpkPPKNVTNtf4/XP0XqToBnfrqxo6azgSsd/P
X-Google-Smtp-Source: ABdhPJy/D57l4PxXsvtNghGpZYYWxtQzGKIP9nS2mWv50e3fWXnuy/WrDD7ylBIgT36e7fl/UU0Xpv5GyujUEEZZD90=
X-Received: by 2002:a0c:e9c7:: with SMTP id q7mr14265761qvo.195.1596403532995;
 Sun, 02 Aug 2020 14:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
In-Reply-To: <20200601091231.3794350-1-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 2 Aug 2020 23:25:21 +0200
Message-ID: <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:13 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> A detach hung is possible when a race occurs between the detach process
> and the ubi background thread. The following sequences outline the race:
>
>   ubi thread: if (list_empty(&ubi->works)...
>
>   ubi detach: set_bit(KTHREAD_SHOULD_STOP, &kthread->flags)
>               => by kthread_stop()
>               wake_up_process()
>               => ubi thread is still running, so 0 is returned
>
>   ubi thread: set_current_state(TASK_INTERRUPTIBLE)
>               schedule()
>               => ubi thread will never be scheduled again
>
>   ubi detach: wait_for_completion()
>               => hung task!
>
> To fix that, we need to check kthread_should_stop() after we set the
> task state, so the ubi thread will either see the stop bit and exit or
> the task state is reset to runnable such that it isn't scheduled out
> indefinitely.
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: <Stable@vger.kernel.org>
> Fixes: 801c135ce73d5df1ca ("UBI: Unsorted Block Images")
> Reported-by: syzbot+853639d0cb16c31c7a14@syzkaller.appspotmail.com
> ---
>  drivers/mtd/ubi/wl.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 5146cce5fe32..a4d4343053d7 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -1628,6 +1628,19 @@ int ubi_thread(void *u)
>                     !ubi->thread_enabled || ubi_dbg_is_bgt_disabled(ubi)) {
>                         set_current_state(TASK_INTERRUPTIBLE);
>                         spin_unlock(&ubi->wl_lock);
> +
> +                       /*
> +                        * Check kthread_should_stop() after we set the task
> +                        * state to guarantee that we either see the stop bit
> +                        * and exit or the task state is reset to runnable such
> +                        * that it's not scheduled out indefinitely and detects
> +                        * the stop bit at kthread_should_stop().
> +                        */
> +                       if (kthread_should_stop()) {
> +                               set_current_state(TASK_RUNNING);
> +                               break;
> +                       }
> +

Hmm, I see the problem but I fear this patch does not cure the race completely.
It just lowers the chance to hit it.
What if KTHREAD_SHOULD_STOP is set right after you checked for it?

>                         schedule();
>                         continue;
>                 }


-- 
Thanks,
//richard
