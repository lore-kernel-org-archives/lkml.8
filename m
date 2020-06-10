Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435912072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NclwIeeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgFJPDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:03:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5087CC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:03:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b5so152577pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMsDTxTe265sNJg6PUfwdFFCnI5249Qs8oZ77boy+lY=;
        b=NclwIeeXCjhbOqgaQbTUJ3Kv+XHcUUlF5Ngc9XojEKTpNzkOtIkBPCH/MuOs30poTQ
         p9TZWxZrxoBCKlj8s4gpN5FDzkwcbHRLkJWbOz1VDXgtd2Q7a4Jrs+7g+CSAUbtYxiZq
         eSFjsMAhfSYOt5fhSxBrTGKaQNTHk5jjAdweY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMsDTxTe265sNJg6PUfwdFFCnI5249Qs8oZ77boy+lY=;
        b=Ljni4PAcEr1BbuJ7g/Erl+6NiA/p+0icbqKoju7EPomWx3t3rGBrse9Ld7UNNXvUpm
         uKSMFA4Yg32S2/8q85dmsLyOCoN5c9Kulko5d3nsA6MmrpwSMBnZos7TX1KPp+fBaeU4
         eTm/aKD6Jg0+7hgVgDMi7USaNyiyEjv6AhELZk+gTri4oaYjw4R+UHNpqD2x1LUQFauh
         mRYK8mklWBaKB80gESZ/z0TrsIOeJb/ViQ8QzmwEitZjl+0aXPcHg8P3WwWCuq5XF4BV
         GbMql90EeccBtWCakkPTNgEr2Pj/HaImb7NNlklXfE7UYUc/+c0B/DOgs+bDr1XPP4fQ
         ankw==
X-Gm-Message-State: AOAM532IvZPoRfiUEhWQTl7ox040Qpcx9m+oh3BAmJMXsKcR0UyWuhTs
        V8iqLGVaI/IB6itHNPGdw3jlKQ==
X-Google-Smtp-Source: ABdhPJzL/GPEXymxpqvCRxAK5Iepb3drRWpQrZo2t5IxZ2So3junvr6gQ81pv44i/cDTDVMpBL6RbA==
X-Received: by 2002:a62:d158:: with SMTP id t24mr3049240pfl.267.1591801427131;
        Wed, 10 Jun 2020 08:03:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x2sm186590pfr.186.2020.06.10.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:03:46 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:03:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     ebiederm@xmission.com, ak@linux.intel.com,
        alex.huangjianhui@huawei.com, linzichang@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Delete the code of sys_sysctl
Message-ID: <202006100803.87D14D1CC7@keescook>
References: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
 <202006090839.6EDB4BA@keescook>
 <21a9d711-af31-f7bd-1143-af2ca5b77ba9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a9d711-af31-f7bd-1143-af2ca5b77ba9@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:17:49PM +0800, Xiaoming Ni wrote:
> On 2020/6/9 23:40, Kees Cook wrote:
> > On Tue, Jun 09, 2020 at 02:20:05PM +0800, Xiaoming Ni wrote:
> > > Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
> > > sys_sysctl has lost its actual role: any input can only return an error.
> > > 
> > > Delete the code and return -ENOSYS directly at the function entry
> > > 
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > Looks right to me.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Should this be taken a step further and just remove the syscall entirely
> > and update the per-arch tables with the ENOSYS hole?
> > 
> > -Kees
> > 
> Searching for git log, I found a commit record that deleted syscall:
> commit f5b94099739722 ("All Arch: remove linkage for sys_nfsservctl system
> call"). Could I use sys_ni_syscall to implement the hole as in the example
> here?
> E.g:
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 7b3832d..f36fda6 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -162,7 +162,7 @@
>  146    common  writev                  sys_writev
>  147    common  getsid                  sys_getsid
>  148    common  fdatasync               sys_fdatasync
> -149        common  _sysctl                 sys_sysctl
> +149  common  _sysctl                 sys_ni_syscall
>  150    common  mlock                   sys_mlock
>  151    common  munlock                 sys_munlock
>  152    common  mlockall                sys_mlockall
> diff --git a/arch/arm64/include/asm/unistd32.h
> b/arch/arm64/include/asm/unistd32.h
> index f8dafe9..ca41bb7 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -308,8 +308,8 @@
>  __SYSCALL(__NR_getsid, sys_getsid)
>  #define __NR_fdatasync 148
>  __SYSCALL(__NR_fdatasync, sys_fdatasync)
> -#define __NR__sysctl 149
> -__SYSCALL(__NR__sysctl, compat_sys_sysctl)
> +                 /* 149 was sys_sysctl */
> +__SYSCALL(149, sys_ni_syscall)
>  #define __NR_mlock 150
>  __SYSCALL(__NR_mlock, sys_mlock)
>  #define __NR_munlock 151
> 
> 
> In this case, I need to modify a lot of code in v2.

Yeah, that looks like a good example.

> Can I add "Reviewed-by:
> Kees Cook <keescook@chromium.org>" to the v2 patch?

No, it'll be very different. I'm still a fan of the change, but send v2
and I can review that separately. Thanks!

-- 
Kees Cook
