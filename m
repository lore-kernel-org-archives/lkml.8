Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDFE20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="P2vHa+pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbgEXXz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbgEXXzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:55:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:55:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h7so12657627otr.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8MyH6nzIQlYiHdNnVdBythLxUHVp7f9RRgFEbcuoxFU=;
        b=P2vHa+peapcgr3/0nquOLdtPXs2xHl3E9BUXZfbBpN0vJc0S9TsHiKdDK7Ji2fGNfe
         5WsNc6p5054tND/KkIB3Rx+dCI+mjwytZv2u+bel7HjKFgH8Yq5tXDNC4lX0iuyVP/8p
         JcFi488CmAKxohubrNAty48AFmrcXvEw5AZ43eu5RZeM9akjUAkPjiBxtHedRIdIHNgX
         EfyELME4YGM307rEqIk5rk9TaV+gF2XDHgdZCgo2aPKFa/ofh1v/gF8DMx4XmuYme5og
         qFhR5qc7O/bUpptKzPwmGfqNYkoBotWZCKCV0K++HdQQFoU5PPRWpRakH+pllH+moYg6
         nQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MyH6nzIQlYiHdNnVdBythLxUHVp7f9RRgFEbcuoxFU=;
        b=eObe7kSdZW6+iHOMy/aCDnm5e9zmSfb+55zYPlYlW2qW9xrpirOVE2GyK09S2XoegG
         TophwvAgeD9gOksZFQJeoS6eCatJrPIR6ci58k6WJKcnp86QiURhOSklcEEJ6C66ql5w
         uCzM+dY4UhpN+D1PzqoWui/go/5CAldksHl17Y/Qb/fDLYfBazEgnBxjWiTcJZKtONRE
         N1REpi8a9Yz7G9wUkSxTR1mqWh0YTTdhv6nSKatKNxq3f/FFTBYYDAm965yeQiEL+dMp
         hmiOrdfutRA4uorwddlkpDF49kcUUfs0k5Qi7vVKs8ShNlHfwsbIuT4FwWR3zCoWJlfX
         qRRg==
X-Gm-Message-State: AOAM531tUsrOyA1a7wbh8ZFkJO1ytcFZgmPAesYFUiii7EICBfISfgxl
        vojrbC55non156GaSbGxpKltGA2pI+mPxg==
X-Google-Smtp-Source: ABdhPJxD1Z1rx73XoSeCiDK+gRfaLVQ7JbSgF4B7fwPmv+QDjYFBVv64rOZxyTLCxxAQKsi8d4TUBQ==
X-Received: by 2002:a9d:6c56:: with SMTP id g22mr20019187otq.311.1590364524067;
        Sun, 24 May 2020 16:55:24 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id l26sm4622765oos.43.2020.05.24.16.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:55:23 -0700 (PDT)
Date:   Sun, 24 May 2020 17:55:25 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, keescook@chromium.org,
        cyphar@cyphar.com, Jeffrey Vander Stoep <jeffv@google.com>,
        jannh@google.com, rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 1/5] seccomp: Add find_notification helper
Message-ID: <20200524235525.GH2605652@cisco>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524233942.8702-2-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 04:39:38PM -0700, Sargun Dhillon wrote:
> This adds a helper which can iterate through a seccomp_filter to
> find a notification matching an ID. It removes several replicated
> chunks of code.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Tycho Andersen <tycho@tycho.ws>
> ---
>  kernel/seccomp.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 55a6184f5990..f6ce94b7a167 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1021,10 +1021,25 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +/* must be called with notif_lock held */
> +static inline struct seccomp_knotif *
> +find_notification(struct seccomp_filter *filter, u64 id)
> +{
> +	struct seccomp_knotif *cur;
> +
> +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> +		if (cur->id == id)
> +			return cur;
> +	}
> +
> +	return NULL;
> +}

I think there's also an instance of this in _send() that we can change
to use find_notification() as well.

Tycho
