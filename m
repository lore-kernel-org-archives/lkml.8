Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2945FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF342068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG3Tybci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgEZI4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:56:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B0C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:56:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r2so10800869ioo.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpC6wQa+3nn2p30Dg1MgpCojCHVIqTnInsGu1hHkL8A=;
        b=OG3Tybci+L7xL4PK9VpbrN/D3ssqr0aJI8hirryGZM+ead9UU/LMgU2o+ofj/XLIBA
         iEadT8GgcXevPZxnbDj56DFqF6t8XHXmhSRaG0c6nQlJuylchJy3VAH077psts6jIBsC
         0u1aPeqk5GgT6pJR1ykT3yeNnTUdUvwS0FXOaaCo+yI6nltoN9gC4ltXtt8f2Qy06y8E
         Gg+UkWEmzIomrgceIEaQRcB2wMQUqV+5Ji1lxDSeMttCfzs2E83WnsGx7qzauZvIwMH/
         8YA/arDraFwjpoz2H8XZ2mKlIQCpJn1l9xRB1nQujJSNlLovJSYQV4172WW3IFqwtYRC
         47+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpC6wQa+3nn2p30Dg1MgpCojCHVIqTnInsGu1hHkL8A=;
        b=SQo8aJyRsSSG4Dgv79HVlvfxMZRcyVPxNkSO1RD8s/dB7p/61ttAHoPNtCiyXV22ih
         6TJiq7gFH/SJ0CciP17qZIxf3XDdIu/Qmu4Zv+gVJJNTatD6Lu3kWcUT+xeNWA6SblrR
         KTHmygu843Tz45it8gNzF7Olet3eza3Qh7qc8+nvOFpn84mDngv6j1/u8mrh7yfxPXFR
         Mn1BtRW+EGuLjGCAcpwYr/cH/hWSF8iyvzF2a+z5qyfUWtcWwkxLnvpZaj+5dW9HJCrg
         0FuyE2IN7FL8AybZ4Dr+x1b7/9t6kPJm3nAKIzh5JBEvfQJ0wDLvVyKFm8mJe7HJKrtM
         tsZg==
X-Gm-Message-State: AOAM530JfiSWc/C6S/DiSarqQ3KII6gY4ogMqTG7hc9fw+tL97ZNxQyG
        +uYmlsB/GjVWHPitf3ZEhkzSKD3vsZba7aYtSyM=
X-Google-Smtp-Source: ABdhPJw4+o6ye0ZJzbeBhZAzodiCF9v7cvLYTcOBGOxwD/Au+5BXkkXnghz9mBLrFO+VvRT+DSXaJGIoee46qPB6RPQ=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr16574413iol.105.1590483390851;
 Tue, 26 May 2020 01:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200525093019.2253-1-qiang.zhang@windriver.com>
In-Reply-To: <20200525093019.2253-1-qiang.zhang@windriver.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 26 May 2020 16:56:19 +0800
Message-ID: <CAJhGHyC4XcNL8yzWZKZ=73wZJej4JwCaAHGV8qjYn-AqcEAEjQ@mail.gmail.com>
Subject: Re: [PATCH v3] workqueue: Fix double kfree for rescuer
To:     qiang.zhang@windriver.com
Cc:     Tejun Heo <tj@kernel.org>, markus.elfring@web.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 5:22 PM <qiang.zhang@windriver.com> wrote:
>
> From: Zhang Qiang <qiang.zhang@windriver.com>
>
> The callback function "rcu_free_wq" could be called after memory
> was released for "rescuer" already, Thus delete a misplaced call
> of the function "kfree".

Hello

wq->rescuer is guaranteed to be NULL in rcu_free_wq()
since def98c84b6cd
("workqueue: Fix spurious sanity check failures in destroy_workqueue()")

And the resucer is already free in destroy_workqueue()
since 8efe1223d73c
("workqueue: Fix missing kfree(rescuer) in destroy_workqueue()")

The patch is a cleanup to remove a "kfree(NULL);".
But the changelog is misleading.

>
> Fixes: 6ba94429c8e7 ("workqueue: Reorder sysfs code")

It is totally unrelated.

> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
> ---
>  v1->v2->v3:
>  Only commit information modification.
>  kernel/workqueue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 891ccad5f271..a2451cdcd503 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3491,7 +3491,6 @@ static void rcu_free_wq(struct rcu_head *rcu)
>         else
>                 free_workqueue_attrs(wq->unbound_attrs);
>
> -       kfree(wq->rescuer);
>         kfree(wq);
>  }
>
> --
> 2.24.1
>
