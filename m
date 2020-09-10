Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37DAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9819420770
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0bs/fLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgIJXSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:18:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:18:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s65so4125324pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ahcfJWxMLLWCQWWMSaduDRixyqLU7R2VmWJmYScB+xI=;
        b=e0bs/fLL5/nal1hkQQK8DqWL0oUik0NhYYhdIwGet7sKAsECUiTvD0lpGfKcU5pPSz
         UWGqg4d+81XpUEqJGRxPydRngpjoC+VeTS1Z01mtq0/4saWZosh7U4GKnJWYMXaqhvex
         MrsLwwKtAJrOwh/txFCgXVdSCsIGtRRcNzL4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ahcfJWxMLLWCQWWMSaduDRixyqLU7R2VmWJmYScB+xI=;
        b=DqVkL3yRWXQ9rfsAMG/wdUjuqi/L5T/sRGHJszEAPBABzixviVRhWISm/r7p3r+iyW
         QMcixN4KEASJ3d4YOExXIshF/yzk2AFr6DX9nYD7zWGRvX2WOmlTsnKIFVaEskcUF20r
         Ol8DMlAN3KIs/QbwsTyaeo6FNvdIqz2clB09Hrq0NufQOYtCCF4IUulJ/eKku84qQw5+
         phP/V/0d6SKCXHFAfiKibyno6S6Zhlg10Mf/tcH8qw7TnaqkUr+aYEWbVD65JYkSWjfL
         DsOj+w7VIbVav+vl64OTAXME6c0ZxVzIb1SL8l5Qf85FIVu3KikbKtpAjWUGPhAlNHmp
         2oOw==
X-Gm-Message-State: AOAM530jBNFsO5RZuvSH78EBYEnYcl39IaviXFtIvxxZt1NMS3CTMgP6
        Fwb7q6qQo31534tq2AHB20/tPw==
X-Google-Smtp-Source: ABdhPJyDlBU+y8fl3h3ui9sPcSP+9dtdObZsk3zIBZIW66XSoC5FKE/37mQEGAa93/DFlZtCDe1HSw==
X-Received: by 2002:aa7:8ec7:0:b029:13e:d13d:a080 with SMTP id b7-20020aa78ec70000b029013ed13da080mr7345919pfr.23.1599779890038;
        Thu, 10 Sep 2020 16:18:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm166428pfi.55.2020.09.10.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:18:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:18:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the
 fbfam feature
Message-ID: <202009101615.8566BA3967@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910202107.3799376-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:21:02PM -0700, Kees Cook wrote:
> From: John Wood <john.wood@gmx.com>
> 
> Add a menu entry under "Security options" to enable the "Fork brute
> force attack mitigation" feature.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/Kconfig       |  1 +
>  security/fbfam/Kconfig | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 security/fbfam/Kconfig
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..00a90e25b8d5 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -290,6 +290,7 @@ config LSM
>  	  If unsure, leave this as the default.
>  
>  source "security/Kconfig.hardening"
> +source "security/fbfam/Kconfig"

Given the layout you've chosen and the interface you've got, I think
this should just be treated like a regular LSM.

>  
>  endmenu
>  
> diff --git a/security/fbfam/Kconfig b/security/fbfam/Kconfig
> new file mode 100644
> index 000000000000..bbe7f6aad369
> --- /dev/null
> +++ b/security/fbfam/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config FBFAM

To jump on the bikeshed: how about just calling this
FORK_BRUTE_FORCE_DETECTION or FORK_BRUTE, and the directory could be
"brute", etc. "fbfam" doesn't tell anyone anything.

-- 
Kees Cook
