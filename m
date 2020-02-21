Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7860C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7F02068F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582329392;
	bh=UPrXw0TWfDKVMYB6aEkOfkJfzbcFcZ+UVoqrbMHJ4ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jd4aKNIfcLZQcRTGDJAsvbAgzlJYd58ZvcpHdj0Rq37hLfesdBcxDR3hxaCAB67UK
	 DHDxbhiCumkz2NDTwN2BEnU2lbRVlRAWuPZdikbUFjne+UQAbk2Ip7ghYA2QXnltQE
	 GhzIycA8LL+fMCZB3UAoKyQ4iM9QjY/k/7/G8Tao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgBUX4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:56:31 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46179 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUX4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:56:31 -0500
Received: by mail-qv1-f65.google.com with SMTP id y2so1735469qvu.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAn9r0dyXNqEajiUKkhhIZJ15iGkDwS6O3yo74a0yZs=;
        b=SHQ2ERJ6RmCOgsUTQn82gnSvL0VCirvt9BO8bbvliENCqe05IJiYaPUOqSSpObW/V6
         dETFLhGbEFLb+ImeTn7k9uhxuAh4bofyNvHgfUmtYO5BNYtbvKG/hTcjx2rTB8sOtpx1
         Pppxh82WMM5/xF2a7hloRK+5R72D1Vo9eMVhLUQBXVBHKh77X2rQMHQykJbXSEPmk8Rp
         DWnhHwLjWnmZ7sHGIW9SJ5uaOIabE4DNw6ALAPklEz51z2NWEQjdORQe3aRyXpuXsjfB
         Jjx1AXsBhtR7t1Le0WtCk2XmpZwFRFWmb8oC03oK3YdwYfK53GJIsYeIL4eNiU4c9fTR
         Uqpw==
X-Gm-Message-State: APjAAAWOw2bF3nqrV+aPvYsLf4bSCJdfK3tDy8fxaUl/cou3W7H04P7y
        /BrsxJpXXziZ+xaALBUKU5c=
X-Google-Smtp-Source: APXvYqx+8Ud4nuzmViCe4DOFp/68mxpyjQvmB6EsMhSNWi0pfrg8LsW03EP/fJx/3pJUZYSr8fkOMg==
X-Received: by 2002:a05:6214:1634:: with SMTP id e20mr32658741qvw.205.1582329389941;
        Fri, 21 Feb 2020 15:56:29 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::dcfd])
        by smtp.gmail.com with ESMTPSA id g11sm2346901qtc.48.2020.02.21.15.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 15:56:29 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:56:27 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roman Gushchin <guro@fb.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RESEND PATCH] percpu_ref: Fix comment regarding percpu_ref_init
 flags
Message-ID: <20200221235627.GA59628@dennisz-mbp.dhcp.thefacebook.com>
References: <20200221231607.12782-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221231607.12782-1-ira.weiny@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Fri, Feb 21, 2020 at 03:16:07PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The comment for percpu_ref_init() implies that using
> PERCPU_REF_ALLOW_REINIT will cause the refcount to start at 0.  But
> this is not true.  PERCPU_REF_ALLOW_REINIT starts the count at 1 as
> if the flags were zero.  Add this fact to the kernel doc comment.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> RESEND:
> 	Add more people on the CC list to see if I'm wrong here.
> 	https://lore.kernel.org/lkml/20200206042810.GA29917@iweiny-DESK2.sc.intel.com/
> ---
> 
>  lib/percpu-refcount.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index 4f6c6ebbbbde..48d7fcff70b6 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
>   * @flags: PERCPU_REF_INIT_* flags
>   * @gfp: allocation mask to use
>   *
> - * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
> - * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
> - * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> + * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
> + * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
> + * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.

Yeah. Prior we had both PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD
with the latter implying the former. So 0 meant percpu and the others
meant atomic. With PERCPU_REF_ALLOW_REINIT, it's probably easier to
understand by saying if neither PERCPU_REF_INIT_ATOMIC or
PERCPU_REF_INIT_DEAD is set, it starts out in percpu mode which is
mentioned in the comments where the flags are defined.  It's not great
having implied flags, but it's worked so far.

Also, it's not quite analagous to atomic_long_set(ref, 1) as there is a
bias to prevent prematurely hitting 0.

I can take this and massage the wording a bit.

>   *
>   * Note that @release must not sleep - it may potentially be called from RCU
>   * callback context by percpu_ref_kill().
> -- 
> 2.21.0
> 

Thanks,
Dennis
