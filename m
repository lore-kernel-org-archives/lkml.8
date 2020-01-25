Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54820716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgAYVlN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:41:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAYVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 16:41:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so6364690wrq.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 13:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=4Jsw+sl3rZeed96mR3AsM5sE56n8KXiFC5Ae1nN2OVo=;
        b=nEOv0yqo3AT60r69NkD2W8qNgjemdP5+zy2V3Pymdx2N9mbsoWmQe+KM9KyI8CRoh7
         mVw+SkmVzV3iDqq/zicnMKBNC991p1NV1s3NR66cTpiRx3xCYI9t/88jEejhCW0c6FzD
         GkPwSi63yk9oTiw5N7wbEFZa/xGDTR674vkPi1oCth+q8x72McdEWAasWxzXN+nHZaXY
         TK7T+/PhRM8gMJAeEPR+swLtXvWm60SGEq4zApQ+egt7s697zM0Z+GkP/FXsUXLvTYen
         8zqdKSbQzLlHR6c1uW8Ge3rVCYwEGjz3wb502Ru3WZblZ6oajg24gECAi8E0S6znv2nN
         3Q8Q==
X-Gm-Message-State: APjAAAW2a36eAo7xezvmW3DhY123aKFiRxbmiGwXkRhvgLJS8R34XUkp
        zRrsfr7YvyDGNCldvBCW1+ROsw==
X-Google-Smtp-Source: APXvYqzTlqw+XUJ74D6yIeyAQeh7UV2lyORpCkFnwkDDWbE38nkVreN+6thxGMbX5/U37+CUG7Hiiw==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr11369912wrl.190.1579988471090;
        Sat, 25 Jan 2020 13:41:11 -0800 (PST)
Received: from ?IPv6:2a00:20:4003:d1ed:ce46:92a4:be2:c2c2? ([2a00:20:4003:d1ed:ce46:92a4:be2:c2c2])
        by smtp.gmail.com with ESMTPSA id g79sm11149436wme.17.2020.01.25.13.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 13:41:10 -0800 (PST)
Date:   Sat, 25 Jan 2020 22:41:06 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
To:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com, oleg@redhat.com,
        paulmck@kernel.org
CC:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <37A3FF92-0958-46DD-AFB1-CE72000B153F@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 24, 2020 5:59:08 AM GMT+01:00, madhuparnabhowmik10@gmail.com wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>This patch fixes the following sparse errors by annotating the
>sighand_struct with __rcu
>
>kernel/fork.c:1511:9: error: incompatible types in comparison
>expression
>kernel/exit.c:100:19: error: incompatible types in comparison
>expression
>kernel/signal.c:1370:27: error: incompatible types in comparison
>expression
>
>This fix introduces the following sparse error in signal.c due to
>checking the sighand pointer without rcu primitives:
>
>kernel/signal.c:1386:21: error: incompatible types in comparison
>expression
>
>This new sparse error is also fixed in this patch.
>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>---
> include/linux/sched.h | 2 +-
> kernel/signal.c       | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/sched.h b/include/linux/sched.h
>index b511e178a89f..7a351360ad54 100644
>--- a/include/linux/sched.h
>+++ b/include/linux/sched.h
>@@ -918,7 +918,7 @@ struct task_struct {
> 
> 	/* Signal handlers: */
> 	struct signal_struct		*signal;
>-	struct sighand_struct		*sighand;
>+	struct sighand_struct __rcu		*sighand;
> 	sigset_t			blocked;
> 	sigset_t			real_blocked;
> 	/* Restored if set_restore_sigmask() was used: */
>diff --git a/kernel/signal.c b/kernel/signal.c
>index bcd46f547db3..9ad8dea93dbb 100644
>--- a/kernel/signal.c
>+++ b/kernel/signal.c
>@@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct
>task_struct *tsk,
> 		 * must see ->sighand == NULL.
> 		 */
> 		spin_lock_irqsave(&sighand->siglock, *flags);
>-		if (likely(sighand == tsk->sighand))
>+		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> 			break;
> 		spin_unlock_irqrestore(&sighand->siglock, *flags);
> 	}

If Paul is happy with this and nobody wants to take it I'll pick this up.

Thanks!
Christian
