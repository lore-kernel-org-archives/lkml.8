Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60683C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BD420786
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiAxobyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGIWyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:54:52 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA58BC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 15:54:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so3108217edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3E9CmP5pzqqITk3EJ5pCRFF7120Umpn5DkCt3PZmyI=;
        b=oiAxobyVHtmcT1uDdRMJ5KCPYgiJcvwg0bT1wajNVARoK+DbSmJJH5GxohbU2nIXcM
         Md7jqXoAgG2YNCHynS+jYIxySL/eeY/W5eQ2bBGiSkR9ZLPebSPskM/5ojc9HlENFh7m
         ZY28rYsR19yHA+3606f8FYuhvf0kWd9VKB2VQI5iRidasRanhGt9foQatc3RxeUF2q5n
         1aVv2B23MxyAfxPBr/YN1YDItdj/K45hkyB9lWfpYiZfBSjubtYSnVMNfCi6gSk9ju0P
         r6QBZRTmNEEhhPCz5z7twQtfxrWiWI3qT7jG4ZixRQXIgjBAxm4HLaiX+LX9dutby4d0
         jFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3E9CmP5pzqqITk3EJ5pCRFF7120Umpn5DkCt3PZmyI=;
        b=ApDkusx+93vZN/1Q2Nk0s4mtvTYMRMnF9rRWQFQuV3PrBscGKxmyJ2HguEMKopTlLB
         xUByWtMmX+PNC0t5OJ1+pHygkM30QpzojlOcXNYIxO7kitQIdAbexYgBBac/LazrQAdi
         bK+Mpecm5pZFg4rXw9wuBnJaK9k9dh5FEMTLDwRzxMYZ8IraxtXDKcsYLngJe/wO9Ygy
         V2ykf4p7rJ6FX8gU41fojie4CDBocktRbAw1pcXkk+3asVghnPsi8u7P4dJWmI2QcD/u
         menkhKr7IuSmS0KG9/OhTLhSvNw3sg9OFOrxw5peDXpE9RtDmX6HGE1SzWtIhaPh147j
         op2A==
X-Gm-Message-State: AOAM530MLCPJ8aElHQ/ZEDH1rR5NucFW+S3rKCLUA569JCuc32Qqwf9F
        eFc6nyl38RqZ+DrWTsD9TSIzoeZ/TmfzAR+ryn28ig==
X-Google-Smtp-Source: ABdhPJz9uaSIXcnqe4UJG/4qyWvxlwUPgsKdudNjp8UAkBRNtmqP10AQmMtpHxhnQTomWWTQ1SKnxvYiDJCH0O5UzlM=
X-Received: by 2002:a50:c355:: with SMTP id q21mr71840462edb.121.1594335290245;
 Thu, 09 Jul 2020 15:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200709223948.1051613-1-jannh@google.com>
In-Reply-To: <20200709223948.1051613-1-jannh@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 9 Jul 2020 15:54:38 -0700
Message-ID: <CAHRSSEwAZEgLKCYa-+uOB7xuNKs1z9gkr5PWCHLcKc1mZpcgoQ@mail.gmail.com>
Subject: Re: [PATCH resend] binder: Prevent context manager from incrementing
 ref 0
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Mattias Nissler <mnissler@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 3:40 PM Jann Horn <jannh@google.com> wrote:
>
> Binder is designed such that a binder_proc never has references to
> itself. If this rule is violated, memory corruption can occur when a
> process sends a transaction to itself; see e.g.
> <https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d>.
>
> There is a remaining edgecase through which such a transaction-to-self
> can still occur from the context of a task with BINDER_SET_CONTEXT_MGR
> access:
>
>  - task A opens /dev/binder twice, creating binder_proc instances P1
>    and P2
>  - P1 becomes context manager
>  - P2 calls ACQUIRE on the magic handle 0, allocating index 0 in its
>    handle table
>  - P1 dies (by closing the /dev/binder fd and waiting a bit)
>  - P2 becomes context manager
>  - P2 calls ACQUIRE on the magic handle 0, allocating index 1 in its
>    handle table
>    [this triggers a warning: "binder: 1974:1974 tried to acquire
>    reference to desc 0, got 1 instead"]
>  - task B opens /dev/binder once, creating binder_proc instance P3
>  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
>    transaction)
>  - P2 receives the handle and uses it to call P3 (two-way transaction)
>  - P3 calls P2 (via magic handle 0) (two-way transaction)
>  - P2 calls P2 (via handle 1) (two-way transaction)
>
> And then, if P2 does *NOT* accept the incoming transaction work, but
> instead closes the binder fd, we get a crash.
>
> Solve it by preventing the context manager from using ACQUIRE on ref 0.
> There shouldn't be any legitimate reason for the context manager to do
> that.
>
> Additionally, print a warning if someone manages to find another way to
> trigger a transaction-to-self bug in the future.
>
> Cc: stable@vger.kernel.org
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Jann Horn <jannh@google.com>

Nice catch.

Acked-by: Todd Kjos <tkjos@google.com>

> ---
> sending again because I forgot to CC LKML the first time... sorry about
> the spam.
>
>  drivers/android/binder.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f50c5f182bb5..cac65ff3a257 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2982,6 +2982,12 @@ static void binder_transaction(struct binder_proc *proc,
>                         goto err_dead_binder;
>                 }
>                 e->to_node = target_node->debug_id;
> +               if (WARN_ON(proc == target_proc)) {
> +                       return_error = BR_FAILED_REPLY;
> +                       return_error_param = -EINVAL;
> +                       return_error_line = __LINE__;
> +                       goto err_invalid_target_handle;
> +               }
>                 if (security_binder_transaction(proc->tsk,
>                                                 target_proc->tsk) < 0) {
>                         return_error = BR_FAILED_REPLY;
> @@ -3635,10 +3641,16 @@ static int binder_thread_write(struct binder_proc *proc,
>                                 struct binder_node *ctx_mgr_node;
>                                 mutex_lock(&context->context_mgr_node_lock);
>                                 ctx_mgr_node = context->binder_context_mgr_node;
> -                               if (ctx_mgr_node)
> +                               if (ctx_mgr_node) {
> +                                       if (ctx_mgr_node->proc == proc) {
> +                                               binder_user_error("%d:%d context manager tried to acquire desc 0\n");
> +                                               mutex_unlock(&context->context_mgr_node_lock);
> +                                               return -EINVAL;
> +                                       }
>                                         ret = binder_inc_ref_for_node(
>                                                         proc, ctx_mgr_node,
>                                                         strong, NULL, &rdata);
> +                               }
>                                 mutex_unlock(&context->context_mgr_node_lock);
>                         }
>                         if (ret)
>
> base-commit: 2a89b99f580371b86ae9bafd6cbeccd3bfab524a
> --
> 2.27.0.389.gc38d7665816-goog
>
