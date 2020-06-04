Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6FDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E7C206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ybbo+SNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgFDIuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFDIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:50:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D8C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:50:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so4411276wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9Lb2kfvjheBiCcoIHR9vzCH13IVr9VVaRPFD6gb2tw=;
        b=Ybbo+SNCbbdB4Db0BERZoV+IS/ZAal0nUHM3rPHsiXQqvcrG+ZHVRyxh3RH3Omt1c0
         FReP1+SVrFh7MwOIEhSRfFCGLJHOiF9AZyikehWDzkS5dAWex+8sebsToS3k3C99iZ1H
         bGMRMBK8useA8FreYZvnAo0KqadijvyGAz87U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=i9Lb2kfvjheBiCcoIHR9vzCH13IVr9VVaRPFD6gb2tw=;
        b=iS6V3ehx9SD2CzwTd+yWR+zMZfb7ID8Z5INamrhqXUPlqeMIvuq6s1GuXAQCcxu1GH
         QPrNM4pm5ntMafzq0UYV8MxXl2UKBcllI3LoPu0G6MjpPj0Krhyr6FZzfaXss7oQpi0t
         DLyRzQL2lS9/FGDXnykmRk4XSnFnXEszDnuoT11UvdOu3o9mRRIUZcbZISXVrRot5603
         f/w5VMzSAidIiWBtOjSqCRb7yE8QIEtF9R7C63wOJSPpXyiJtYCzW4sTiutLHGPPOHhy
         CNFMkenSgx7jV1CcNiaIIFaT/ZgPUH6AohKFmgJZba2bkl09h88QsfWI0BZQzWZ2gMy6
         rPqA==
X-Gm-Message-State: AOAM531EnQzLk7/x86aqasvkLwiz6U6MTknkWEYcMWe8hTKv6xpAkjFy
        KRUk5e1q+CY1Pt/xjcSitp5GtQ==
X-Google-Smtp-Source: ABdhPJzlfYUG7REX7JnlfEgpF/yYLe/bFD3D+XFPyipYhk5uI0hmUf/ZT9TOZo4R/GLocgZ+amrrSQ==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr3019544wmo.139.1591260602159;
        Thu, 04 Jun 2020 01:50:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t13sm6718960wrn.64.2020.06.04.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:50:01 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:49:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/6] dma-buf: Remove custom seqcount lockdep class key
Message-ID: <20200604084958.GU20149@phenom.ffwll.local>
Mail-Followup-To: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        David Airlie <airlied@linux.ie>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
 <20200603144949.1122421-7-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603144949.1122421-7-a.darwish@linutronix.de>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:49:49PM +0200, Ahmed S. Darwish wrote:
> Commit 3c3b177a9369 ("reservation: add support for read-only access
> using rcu") introduced a sequence counter to manage updates to
> reservations. Back then, the reservation object initializer
> reservation_object_init() was always inlined.
> 
> Having the sequence counter initialization inlined meant that each of
> the call sites would have a different lockdep class key, which would've
> broken lockdep's deadlock detection. The aforementioned commit thus
> introduced, and exported, a custom seqcount lockdep class key and name.
> 
> The commit 8735f16803f00 ("dma-buf: cleanup reservation_object_init...")
> transformed the reservation object initializer to a normal non-inlined C
> function. seqcount_init(), which automatically defines the seqcount
> lockdep class key and must be called non-inlined, can now be safely used.
> 
> Remove the seqcount custom lockdep class key, name, and export. Use
> seqcount_init() inside the dma reservation object initializer.
> 
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Patch lgtm, and Ahmed says plan is that this should land through -tip
since it's part of a larger series, so

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

for merging through whatever tree/branch fits bets. I don't expect
conflicts here, nothing in-flight touching this. I expect this will show
up in 5.9-rc1 or so.

Cheers, Daniel

> ---
>  drivers/dma-buf/dma-resv.c | 9 +--------
>  include/linux/dma-resv.h   | 2 --
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 4264e64788c4..590ce7ad60a0 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -50,12 +50,6 @@
>  DEFINE_WD_CLASS(reservation_ww_class);
>  EXPORT_SYMBOL(reservation_ww_class);
>  
> -struct lock_class_key reservation_seqcount_class;
> -EXPORT_SYMBOL(reservation_seqcount_class);
> -
> -const char reservation_seqcount_string[] = "reservation_seqcount";
> -EXPORT_SYMBOL(reservation_seqcount_string);
> -
>  /**
>   * dma_resv_list_alloc - allocate fence list
>   * @shared_max: number of fences we need space for
> @@ -134,9 +128,8 @@ subsys_initcall(dma_resv_lockdep);
>  void dma_resv_init(struct dma_resv *obj)
>  {
>  	ww_mutex_init(&obj->lock, &reservation_ww_class);
> +	seqcount_init(&obj->seq);
>  
> -	__seqcount_init(&obj->seq, reservation_seqcount_string,
> -			&reservation_seqcount_class);
>  	RCU_INIT_POINTER(obj->fence, NULL);
>  	RCU_INIT_POINTER(obj->fence_excl, NULL);
>  }
> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> index ee50d10f052b..a6538ae7d93f 100644
> --- a/include/linux/dma-resv.h
> +++ b/include/linux/dma-resv.h
> @@ -46,8 +46,6 @@
>  #include <linux/rcupdate.h>
>  
>  extern struct ww_class reservation_ww_class;
> -extern struct lock_class_key reservation_seqcount_class;
> -extern const char reservation_seqcount_string[];
>  
>  /**
>   * struct dma_resv_list - a list of shared fences
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
