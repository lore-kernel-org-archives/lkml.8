Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8673C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8211620657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUoew+YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEOIGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbgEOIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:06:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3748C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:06:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so619435plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jG2zPlUjuy3TaHmBjzz54CmTcwOEHnFNJYuMRLsgt3o=;
        b=DUoew+YPlBJlFGhJMGcpvILcRmegBRmwn4SG3fljK7KRjGVaf+NbqI92muMsHhxSzd
         uoD3o+TE+gzuBuLRMXyeGXGh/xmzjhB0YkePh8Qst7glNg/dJ9vLFvlTK+c+5GA2/Kb1
         YMiG3vnsDsll6LQA876jclVWLpEEl50gQNWrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jG2zPlUjuy3TaHmBjzz54CmTcwOEHnFNJYuMRLsgt3o=;
        b=kh/c6vOIRYUUJ50gTyGlgXcXElIqTRkfFlJMJLKf7VFXVgeUlnll0xU2tF7MTl74lg
         jmpSbcKrFpBjh4Cm0ufv72Xx042CXdpOdgMLV9VavMTzGl23v4acDEZulWRaRDOd82G0
         hc15FxRyUyfzKf/10e2D6/OLD4JkcUvq8Ihq3HEKTJ87F+S1pufSb5l1YrE4D5Xy6DKm
         HSZoRV+v3QU5sDIAvo+7APSazTYvdEWLajgMjdKFv2o3l0aL2AHGPkdrxfjVTMngnVmk
         3z+pYVKon/QsXf/pVXu+0DwfqltMuW/Ay3WCEbzzS8uKD+/S9kkVVVFA2fLuWYRwJSmB
         g2AQ==
X-Gm-Message-State: AOAM5320Km+uRuxxPENzKPms284e2HRK1kW3nJV/qeFEp3dCfbBaCkQD
        zLrTwTuz00uh+VaBTzNJheEE0A==
X-Google-Smtp-Source: ABdhPJwivc3rrGEJYMaQgUVSdU6qrOT33KMO3Id4LWhkBY0GN66928/qLjX4HIpzdr1su8//lFZRIg==
X-Received: by 2002:a17:902:6b4a:: with SMTP id g10mr2398745plt.141.1589529989396;
        Fri, 15 May 2020 01:06:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11sm1105913pgs.41.2020.05.15.01.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:06:28 -0700 (PDT)
Date:   Fri, 15 May 2020 01:06:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
Message-ID: <202005150105.33CAEEA6C5@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
> Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
> used in both sysctl_writes_strict and hung_task_warnings.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  fs/proc/proc_sysctl.c     | 2 +-
>  include/linux/sysctl.h    | 1 +
>  kernel/hung_task_sysctl.c | 3 +--
>  kernel/sysctl.c           | 3 +--

How about doing this refactoring in advance of the extraction patch?

>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d45..acae1fa 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -23,7 +23,7 @@
>  static const struct inode_operations proc_sys_dir_operations;
>  
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { 0, 1, INT_MAX };
> +const int sysctl_vals[] = { 0, 1, INT_MAX, -1 };
>  EXPORT_SYMBOL(sysctl_vals);
>  
>  /* Support for permanently empty directories */
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 02fa844..6d741d6 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -41,6 +41,7 @@
>  #define SYSCTL_ZERO	((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE	((void *)&sysctl_vals[1])
>  #define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
> +#define SYSCTL_NEG_ONE	((void *)&sysctl_vals[3])

Nit: let's keep these value-ordered? i.e. -1, 0, 1, INT_MAX.

-- 
Kees Cook
