Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344B220767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgIBO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:29:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIBOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:23:03 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDTen-0005ou-ND; Wed, 02 Sep 2020 14:22:37 +0000
Date:   Wed, 2 Sep 2020 16:22:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] seccomp: don't leave dangling ->notif if file allocation
 fails
Message-ID: <20200902142237.s5l5pd54nfbjes6p@wittgenstein>
References: <20200902140953.1201956-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902140953.1201956-1-tycho@tycho.pizza>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:09:53AM -0600, Tycho Andersen wrote:
> Christian and Kees both pointed out that this is a bit sloppy to open-code
> both places, and Christian points out that we leave a dangling pointer to
> ->notif if file allocation fails. Since we check ->notif for null in order
> to determine if it's ok to install a filter, this means people won't be
> able to install a filter if the file allocation fails for some reason, even
> if they subsequently should be able to.
> 
> To fix this, let's hoist this free+null into its own little helper and use
> it.
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> ---

Thanks for the patch, Tycho! Looks simple enough to me:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  kernel/seccomp.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index bb0dd9ae699a..676d4af62103 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1109,6 +1109,12 @@ static long seccomp_set_mode_strict(void)
>  }
>  
>  #ifdef CONFIG_SECCOMP_FILTER
> +static void seccomp_notify_free(struct seccomp_filter *filter)

I think an explicit "inline" coldn't hurt but it's fine either way and
no need to resend imho. Probably Kees can just add this when applying if
we reall cared.

> +{
> +	kfree(filter->notif);
> +	filter->notif = NULL;
> +}
> +
>  static void seccomp_notify_detach(struct seccomp_filter *filter)
>  {
>  	struct seccomp_knotif *knotif;
> @@ -1138,8 +1144,7 @@ static void seccomp_notify_detach(struct seccomp_filter *filter)
>  		complete(&knotif->ready);
>  	}
>  
> -	kfree(filter->notif);
> -	filter->notif = NULL;
> +	seccomp_notify_free(filter);
>  	mutex_unlock(&filter->notify_lock);
>  }
>  
> @@ -1494,7 +1499,7 @@ static struct file *init_listener(struct seccomp_filter *filter)
>  
>  out_notif:
>  	if (IS_ERR(ret))
> -		kfree(filter->notif);
> +		seccomp_notify_free(filter);
>  out:
>  	return ret;
>  }
> 
> base-commit: 7b6aa0bb62fd6fd50f2d14136136262d28fb2dfe
> -- 
> 2.25.1
> 
