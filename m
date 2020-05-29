Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4287FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBFC207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTOw0dCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgE2UPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgE2UPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:15:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF65C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:14:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so1686817plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=43C+pRXNPgAMVhwiYz5UucFsjABxpoowLodbLHMi21k=;
        b=aTOw0dCAP9TME+W+TRoQL9YN6hlr+OudY32PgYQij21goUWVujpoJSdGyYQ2kyfXS+
         K+q0YyKlvL/XkAkGMI5cr510tpa9WL2c1mUlF9MDv92RyRJHQEiSa56RQ7GDzwUt0rQ1
         Uy8zXnbc6tLhqq80hAPAhNq8pY/LCfCFYH8yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=43C+pRXNPgAMVhwiYz5UucFsjABxpoowLodbLHMi21k=;
        b=XaMcIa9qXXHPONt2M6JL6GqVk9m1V9jcZlHS+PlaNDG18gK23RkZoz19n8+7uvsLui
         KIx3dCDwt+VcljtwOyk6hclV+PqMW5qnBwJie4ocq4BxFqcaHguBkxxKsOjHxJ89zTg4
         yA8ZdADR+ZACtNS6lCbvo47XrJrPhqJhSMAm33Ix+MA3B8Uzgn/UJWVlL8LqX9VS8qzg
         gykXvksTc2RJpW1ijOC6C3ez79/NZ3QqgW1lwjIicQM0KRbH6ywdHQKqLUPLRvwIVCx2
         fgDPAaqBqab7h3C6sc85/bp+sZeURoDrtfOm6DCVIPI0MY09sWNxNDwv7KbZfJQuorIG
         OQjw==
X-Gm-Message-State: AOAM531aEw3DWRP1f7ZHCXd7riXo4iyTVGvm/oi35BBeALaOPJ1brRPa
        pIx7kFPRUmC1JVONID2Mr+ZRoWrh/4Htwg==
X-Google-Smtp-Source: ABdhPJyukKn4U/p75qp2C5HMUUWtzzkP26zk+6iOa2JKVkpgy2boV7h+dizljyFUZyW8FK/Ohy8bjQ==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr10342437plr.257.1590783298799;
        Fri, 29 May 2020 13:14:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bu7sm261872pjb.41.2020.05.29.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:14:57 -0700 (PDT)
Date:   Fri, 29 May 2020 13:14:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 1/3] seccomp: Add find_notification helper
Message-ID: <202005291309.6183EC0604@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-2-sargun@sargun.me>
 <202005282319.2BA6AD88@keescook>
 <20200529174037.GA11153@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529174037.GA11153@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 05:40:38PM +0000, Sargun Dhillon wrote:
> > 
> > While the comment is good, let's actually enforce this with:
> > 
> > if (WARN_ON(!mutex_is_locked(&filter->notif_lock)))
> > 	return NULL;
> > 
> I don't see much use of lockdep in seccomp (well, any), but
> wouldn't a stronger statement be to use lockdep, and just have:
> 
> lockdep_assert_held(&filter->notify_lock);
> 
> As that checks that the lock is held by the current task.

/me slaps his forehead

Yes. I need more coffee or something. Yes, I meant
lockdep_assert_held(), and now I need to go fix my pstore series since I
confused myself into the wrong function and using it so many times in
pstore overwrote the correct function in my head. Thank you!

> Although, that does put this check behind lockdep, which means
> that running in "normal" circumstances is less safe (but faster?).

Now, that's fine. The check needs to be "am *I* holding this mutex?" and
I don't think anything except lockdep can do that.

-- 
Kees Cook
