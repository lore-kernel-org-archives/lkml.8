Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81069C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F4207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bD+ngeex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgE2FwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgE2FwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:52:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5270C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:52:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so719436pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h4tm8V5uFxYnwzK9siWKmg26ctSppcNlyJSzTpDlWPk=;
        b=bD+ngeexaCAMKJhxvK7o0CjvhGq7KEg3PaSxi2NnHCgyyrZBU/EkhY+2v9hIDDWXPq
         tUMvw6QupCHQHW1wOQ0O1A+NvFGVK+mNH7bqcrIsUaO1sWgw+aDgFIgwrF1a/cp5xMCw
         lTLCR4MdqA2kOuwZIZmm5cwIWlA3UzyiCZi6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4tm8V5uFxYnwzK9siWKmg26ctSppcNlyJSzTpDlWPk=;
        b=npWyJcy7Js270L8qhaymDN2dukXrWxrwmfIvfQkZF8NxkJkRCwkIPRi5UjLboK0t6y
         tE6tAvab/coPP2nTABpbbfvhfYTwgX7gM7UGv/nNNOnpLpthBXt6EtgiBvUEg22Zxjzp
         n4mFcXP+lcDlJCjs4j2joALDMIAmp50Z5kvvd9zBTorg7obfez9VkjkkvZDKnWi1VVjp
         PWa3tGbWQx3CtVkcHkpVdAjzODNNB5W/Kr/FyzhoFtzA/K6BHdjV9evr0LbmsWEEf8P4
         +fIWLi5zOIZhZikgmH5FM4K2W4+boZmvqWBJWQjTRwJb2SvQBfh6sXEq4HEESZmP6c69
         V7Mg==
X-Gm-Message-State: AOAM5337X3rC1/3uW2o5GBsQivbPn/mpTyRvQT54/GUOadEvzHmVOguE
        4RGxxslY8/wE1gRDGQan32m0jg==
X-Google-Smtp-Source: ABdhPJy1PDGtyg4/nT4CXLd09BR+6f0Jy08cCbgw5PBgkzaekl0QgUkn2QMqBAAyuLWjecVAxGYaSw==
X-Received: by 2002:a63:7016:: with SMTP id l22mr6579160pgc.284.1590731540555;
        Thu, 28 May 2020 22:52:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm9887974pjf.3.2020.05.28.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:52:19 -0700 (PDT)
Date:   Thu, 28 May 2020 22:52:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 2/4] lib: Make test_sysctl initialized as module
Message-ID: <202005282250.5E37391@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067753624.229397.13771427935697541820.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067753624.229397.13771427935697541820.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:52:16PM +0900, Masami Hiramatsu wrote:
> test_sysctl.c is expected to be used as a module, but since
> it does not use module_init(), it never be registered as
> a module and not appeared under /sys/module/.
> In the result, the selftests/sysctl/sysctl.sh always fails
> to find the test module and is skipped.
> 
> This makes test_sysctl.c initialized as a module by module_init()
> and allow sysctl.sh to find the test module is loaded.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  lib/test_sysctl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 566dad3f4196..ec4d0f03475d 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -149,7 +149,7 @@ static int __init test_sysctl_init(void)
>  	}
>  	return 0;
>  }
> -late_initcall(test_sysctl_init);
> +module_init(test_sysctl_init);

This is the only part I think we need to double check. As a non-module,
module_init() becomes device_initcall() not late_initcall().

I don't see any notes in the commit log for the original driver that
mention why this needs to be late_initcall(), though, so I *think* it's
safe. Luis?

-- 
Kees Cook
