Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D26C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0B21744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgG0NkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:40:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42396 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgG0Njy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:39:54 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k03M7-0007og-DE; Mon, 27 Jul 2020 13:39:51 +0000
Date:   Mon, 27 Jul 2020 15:39:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Yadav Lamichhane <tuxomega1@gmail.com>
Cc:     serge@hallyn.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: Fix a kernel coding style issue
Message-ID: <20200727133949.fh6htr4zff3uwm5p@wittgenstein>
References: <20200727113323.79720-1-tuxomega1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727113323.79720-1-tuxomega1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 05:18:23PM +0545, Yadav Lamichhane wrote:
> fix a brace around if-else statement and for loop.
> 
> Signed-off-by: Yadav Lamichhane <tuxomega1@gmail.com>
> ---
>  kernel/user_namespace.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 87804e0371fe..7703753cac97 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -118,9 +118,8 @@ int create_user_ns(struct cred *new)
>  	ns->owner = owner;
>  	ns->group = group;
>  	INIT_WORK(&ns->work, free_user_ns);
> -	for (i = 0; i < UCOUNT_COUNTS; i++) {
> +	for (i = 0; i < UCOUNT_COUNTS; i++)
>  		ns->ucount_max[i] = INT_MAX;
> -	}
>  	ns->ucounts = ucounts;
> 
>  	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
> @@ -1156,12 +1155,10 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>  	if (strncmp(pos, "allow", 5) == 0) {
>  		pos += 5;
>  		setgroups_allowed = true;
> -	}
> -	else if (strncmp(pos, "deny", 4) == 0) {
> +	} else if (strncmp(pos, "deny", 4) == 0) {
>  		pos += 4;
>  		setgroups_allowed = false;
> -	}
> -	else
> +	} else
>  		goto out;

Kernel coding style would mandate that the else be enclosed in {} as well.

Christian
