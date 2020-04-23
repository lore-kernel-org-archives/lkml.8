Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6ABC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980542075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2FM3x+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgDWTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDWTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:20:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DCC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:20:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so2897554pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pj7YvXndAsw3KaR10nmCY2tYup64japEjFPLxVjCNOA=;
        b=S2FM3x+SR5YwiCVIrYK19/potP3N5sei7L8LFMjdWJGBbGe55A+YWGw7MKDA75xUck
         3jsBgKi+Gduo/014ZQcV+lheRzoUxmW3O4h7LtuYprQylBwNAdivmZ+PM7foYFgg9W+i
         OPDK+t9hHeas3PZUmRO6pavgzkpvw8o9ozq4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pj7YvXndAsw3KaR10nmCY2tYup64japEjFPLxVjCNOA=;
        b=g9IcGlrZyy+v+YSXiUtMhK2yj73XvEzYSbX3RzYuAZQ5nmHw6NIpHorhsTbc/raG7Y
         AX6dk9eCjgn/sr3LwVya7Hx2rNWkcKWKo4K6wvddEvZu2puP89+AORYu1FDop2ePyhrF
         UeHdIbrdI3+iH2psoFeFuG11oNZz5ZR4VN0qTzOizF+O8LtRooh4ZoWhRa5SOaZuXEdR
         wobma8Rmx1bVkGVpNryPy+hs/zlSZhyVbHtEHiX8jR+S0PfVXY9BFFhfdUl5tb8PcIrK
         SahSIdEVlMWD0PY1+CN4qaKGe3a7ytJyhHhG8eUflDy+5c8nf5bMKuHLxvkuVkgg5bUY
         ATSA==
X-Gm-Message-State: AGi0PuYDiyaLnidvy1pRB+XqTDHmJBI7DPrzID/G+PxD+RMZ4GJGR6Eg
        QD446lSEvTugaK0JDolgWIFPDw==
X-Google-Smtp-Source: APiQypLdog+wYLsxeovYB7jGaEduttLLjw1FVcyUhoH8HDTv2ywSD76b9e5GWemx/GSnfxgiFW4shw==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr5316647plb.148.1587669623714;
        Thu, 23 Apr 2020 12:20:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2sm3391903pfb.73.2020.04.23.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:20:22 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:20:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org,
        x86@kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH v4 6/6] Documentation: Add L1D flushing Documentation
Message-ID: <202004231220.89FC5FCE@keescook>
References: <20200423140125.7332-1-sblbir@amazon.com>
 <20200423140125.7332-7-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423140125.7332-7-sblbir@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:01:25AM +1000, Balbir Singh wrote:
> Add documentation of l1d flushing, explain the need for the
> feature and how it can be used.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/admin-guide/hw-vuln/index.rst   |  1 +
>  .../admin-guide/hw-vuln/l1d_flush.rst         | 40 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst
> 
> diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
> index 0795e3c2643f..35633b299d45 100644
> --- a/Documentation/admin-guide/hw-vuln/index.rst
> +++ b/Documentation/admin-guide/hw-vuln/index.rst
> @@ -14,3 +14,4 @@ are configurable at compile, boot or run time.
>     mds
>     tsx_async_abort
>     multihit.rst
> +   l1d_flush
> diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
> new file mode 100644
> index 000000000000..7d515b8c29f1
> --- /dev/null
> +++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
> @@ -0,0 +1,40 @@
> +L1D Flushing for the paranoid
> +=============================
> +
> +With an increasing number of vulnerabilities being reported around data
> +leaks from L1D, a new user space mechanism to flush the L1D cache on
> +context switch is added to the kernel. This should help address
> +CVE-2020-0550 and for paranoid applications, keep them safe from any
> +yet to be discovered vulnerabilities, related to leaks from the L1D
> +cache.
> +
> +Tasks can opt in to this mechanism by using a prctl (implemented only
> +for x86 at the moment).
> +
> +Related CVES
> +------------
> +At the present moment, the following CVEs can be addressed by this
> +mechanism
> +
> +    =============       ========================     ==================
> +    CVE-2020-0550       Improper Data Forwarding     OS related aspects
> +    =============       ========================     ==================
> +
> +Usage Guidelines
> +----------------
> +Applications can call ``prctl(2)`` with one of these two arguments
> +
> +1. PR_SET_L1D_FLUSH - flush the L1D cache on context switch (out)
> +2. PR_GET_L1D_FLUSH - get the current state of the L1D cache flush, returns 1
> +   if set and 0 if not set.
> +
> +**NOTE**: The feature is disabled by default, applications to need to specifically
> +opt into the feature to enable it.
> +
> +Mitigation
> +----------
> +When PR_SET_L1D_FLUSH is enabled for a task, on switching tasks (when
> +the address space changes), a flush of the L1D cache is performed for
> +the task when it leaves the CPU. If the underlying CPU supports L1D
> +flushing in hardware, the hardware mechanism is used, otherwise a software
> +fallback, similar to the mechanism used by L1TF is used.
> -- 
> 2.17.1
> 

-- 
Kees Cook
