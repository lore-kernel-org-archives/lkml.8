Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD2522B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsfTh8Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHDV40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHDV4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:56:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DBAC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:56:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so23204233qtn.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UccPpGQ4uKB6WoZTJl1MuCD8hOajsEsC2QDYvhe7OlI=;
        b=RsfTh8KikBVqMMDscItiDVRzYzoyVI57OTTnIWzu8W2gMV2GTU7IFKjy65O4wutBgV
         xvCN/mshX97he/qdqN0r+aelpgxZmMzVa6faS+xe3OSsiv8Dph55Zzz0WpEazdM31ZgI
         i2J39gbosT7a1R3NfV630dSc4+sy+kmAI2Bj/jcMwi/Xx5KjBNUK4EAlnw4ToTHR3djN
         NSRF6a3NHZCsHyGifrlUhxJtoUAaKOeQ9/enFzrkY4pah1bNPNcGu3G4Vbt5CXFCUFWD
         jdiG1rYBJgrI9TzlS5VnB9bkvg8VNpgDCIPm/XqNU/ovg9tRF6J6ot1Dj1JaulfVjZke
         pdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UccPpGQ4uKB6WoZTJl1MuCD8hOajsEsC2QDYvhe7OlI=;
        b=XqpEl0CEFkhydfa+H5UlBF0ssusnQSFFQXadZUX76mXvUZyhYJ7Sl/vf0+ZWsAS1fn
         TFnVsvJNpADQXPt9H6JyeI/1M79LwRdqx7N96+qFGnoevNnjoIPwK1EvlUjeOr9s3e/n
         1PKgrOQ1DTqJ3o2glHx8sSwQWq6VPmRchAeACPV49r7m8//LWWk+alf/UhPWO2gmvB60
         /bjqvVHZXgajSg4ONnFbDoV4OAsDm6L9vVqwX2HXQa3nOvcv0Vld3ryiy/CJW0pl1BD2
         V27WzSpPadP8wSp5ZluOlbS5c6+JMqMBDA9uK/TBeadBMFERggA93DtX9ITIRle/sMiw
         kl/g==
X-Gm-Message-State: AOAM5331hC+/xsh78VlESbgocOf3rKI7bKLpkjbPrdpQ+zEU95Bx0Z40
        CodSwH/F0E/K/8uEhQObLZ/kwl2OBQ9KNDB2ACtN86lQ
X-Google-Smtp-Source: ABdhPJx2MqaXC6314A1gSPMasWpsFVff5bIebJciZadSY5fZ1AG7ilqKRqlUiQPkNcU6k97spzJ9jL5jjULnOV/rMAI=
X-Received: by 2002:ac8:67da:: with SMTP id r26mr180090qtp.332.1596578184361;
 Tue, 04 Aug 2020 14:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
 <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com> <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
 <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com>
In-Reply-To: <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 4 Aug 2020 23:56:13 +0200
Message-ID: <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
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

On Tue, Aug 4, 2020 at 4:58 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> Oh, you're thinking about influence by schedule(), I get it. But I think
> it still works. Because the ubi_thread is still on runqueue, it will be
> scheduled to execute later anyway.

It will not get woken. This is the problem.

>
> op                                                    state of
> ubi_thread           on runqueue
> set_current_state(TASK_INTERRUPTIBLE) TASK_INTERRUPTIBLE              Yes
> if (kthread_should_stop()) // not satisfy
> TASK_INTERRUPTIBLE              Yes
> kthread_stop:
>    wake_up_process
>      ttwu_queue
>        ttwu_do_activate
>          ttwu_do_wakeup TASK_RUNNING                       Yes
> schedule
>    __schedule(false)
>
>   // prev->state is TASK_RUNNING, so we cannot move it from runqueue by
> deactivate_task(). So just pick next task to execute, ubi_thread is
> still on runqueue and will be scheduled to execute later.

It will be in state TASK_RUNNING only if your check is reached.

If kthread_stop() is called *before* your code:
+                       if (kthread_should_stop()) {
+                               set_current_state(TASK_RUNNING);
+                               break;
+                       }

...everything is fine.
But there is still a race window between your if
(kthread_should_stop()) and schedule() in the next line.
So if kthread_stop() is called right *after* the if and *before*
schedule(), the task state is still TASK_INTERRUPTIBLE
--> schedule() will not return unless the task is explicitly woken,
which does not happen.

Before your patch, the race window was much larger, I fully agree, but
your patch does not cure the problem
it just makes it harder to hit.

And using mdelay() to verify such a thing is also tricky because
mdelay() will influence the task state.

-- 
Thanks,
//richard
