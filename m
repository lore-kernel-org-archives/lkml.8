Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692D6C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D1B20736
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZYGP6Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgEIFPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:15:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D20C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:15:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so5250479pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTxB7TBhsdShdMgjzI9wbmAEL1VN9eGtCUOLpw0Dhqo=;
        b=EZYGP6IlZ48o0TQdSs6Rjb7rstE0z1btnrdJwP1ASjQuWWwN6dEFHb6yilUPeejzxz
         rhuwaxho4siY7FArIroEkqBIyXBAl++Hyx511EtIGoHsdQt+xbbRHtVkyBz7dTxFwdqX
         ojevI5WbAgRXwgB13i1uiQOLG4uc4wDw7IGdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XTxB7TBhsdShdMgjzI9wbmAEL1VN9eGtCUOLpw0Dhqo=;
        b=pVPwWTa71uwZnMCa+L4AA4mw/RyC7XtDqOrPP/eAcRbZnH3G96ZM1+kJxikUGYvee1
         9qhv3pNKB1+wNFMBsqoLSrTL7NfLsOsMBC6/eC45e80uV00LvbzKvhdufIh1Tjy/SBiy
         X99+TeXJotm7Gvzl2Ox91Byc0c/LtoLyq2rZ4T98x2Oy7uFSaB39REP2o+N1ajVm3iG9
         6gkGJcMr2E8yiWnkA2hk5iXRSD8o2L/Y0JjDI2EL6zrp3DTk/6AcUTvncBbavrKTBJVh
         PGX8gDm7tyotKnMT2xFvFHfO2ZSQiwSU8D1Vp6VI8rN7TH3oJQRKd23ZZOMCm57GA8Jy
         D/gw==
X-Gm-Message-State: AGi0PuaHFkyFMUPcXlbatScUiyrsl6ukWbP9Mu/nizU7uJz8oUp2tJai
        i1XKnMedcsC56SF6kOxa6H0FlA==
X-Google-Smtp-Source: APiQypK6wLtLdxZAif3gmVAMTp7xe+iZZJ4zwls4FEvEiEtFuQFuOD+9KWmYvNRLQSK/BppSvDffFg==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11mr5553423plo.208.1589001344731;
        Fri, 08 May 2020 22:15:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20sm3429761pfx.116.2020.05.08.22.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:15:43 -0700 (PDT)
Date:   Fri, 8 May 2020 22:15:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/6] exec: Run sync_mm_rss before taking exec_update_mutex
Message-ID: <202005082213.8BDD4AC0CC@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <875zd66za3.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zd66za3.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:45:56PM -0500, Eric W. Biederman wrote:
> Like exec_mm_release sync_mm_rss is about flushing out the state of
> the old_mm, which does not need to happen under exec_update_mutex.
> 
> Make this explicit by moving sync_mm_rss outside of exec_update_mutex.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Additional thoughts below...

> ---
>  fs/exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 11a5c073aa35..15682a1dfee9 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1051,13 +1051,14 @@ static int exec_mmap(struct mm_struct *mm)
>  	tsk = current;
>  	old_mm = current->mm;
>  	exec_mm_release(tsk, old_mm);
> +	if (old_mm)
> +		sync_mm_rss(old_mm);
>  
>  	ret = mutex_lock_killable(&tsk->signal->exec_update_mutex);
>  	if (ret)
>  		return ret;
>  
>  	if (old_mm) {
> -		sync_mm_rss(old_mm);
>  		/*
>  		 * Make sure that if there is a core dump in progress
>  		 * for the old mm, we get out and die instead of going

$ git grep exec_mm_release
fs/exec.c:      exec_mm_release(tsk, old_mm);
include/linux/sched/mm.h:extern void exec_mm_release(struct task_struct *, struct mm_struct *);
kernel/fork.c:void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)

kernel/fork.c:

void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
{
        futex_exit_release(tsk);
        mm_release(tsk, mm);
}

void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
{
        futex_exec_release(tsk);
        mm_release(tsk, mm);
}

$ git grep exit_mm_release
include/linux/sched/mm.h:extern void exit_mm_release(struct task_struct *, struct mm_struct *);
kernel/exit.c:  exit_mm_release(current, mm);
kernel/fork.c:void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)

kernel/exit.c:

        exit_mm_release(current, mm);
        if (!mm)
                return;
        sync_mm_rss(mm);

It looks to me like both exec_mm_release() and exit_mm_release() could
easily have the sync_mm_rss(...) folded into their function bodies and
removed from the callers. *shrug*

-- 
Kees Cook
