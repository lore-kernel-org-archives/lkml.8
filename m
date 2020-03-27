Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6644CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C578206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dZbWG7+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0T2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:28:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46982 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0T2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:28:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so4941726pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ciBC3j8wG4a8pHJA61Krk7wdzxQIPFblhY8Mnmnqr/E=;
        b=dZbWG7+WmyxKjt8o1CFjmawcgYb9EEMCzsYlcILxxPtiGer6uV+HnUYpVcY1RNBFRG
         RjwL4s2vQk6bvP8QSj2WiIANCPx4nfL86AVwKtE/T3vgBWCwO+W6gCzZsM50wBfPNP02
         pVt3JhCwHQK0kEFTi5SLljHXMhHno/WK55SKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciBC3j8wG4a8pHJA61Krk7wdzxQIPFblhY8Mnmnqr/E=;
        b=dDt4NI7sISlnE2A1mAIGodpaudXqEObKVyMN3AAXjGDOt8HLzKyXgra24ycXvD8gDN
         LgqpKOlySLCWfbSTrToPQiQDZmfkIztIkyrlhBxv59GYlyymDdnMMcNw2wUhLJo5SH4h
         XsyVpjZAvf5NCUzZd+5tM9hydk4wk9BWNxegd+suXnNqjIXRL0+GXZI3oF4sNM0d00tP
         VeIAgu5yBIhKVhhpCWhYNkQ7Mm+s8cDXVJZ39MTkcqrrxTjRQxi75CHuC1f1I/W+l31s
         O6sNp6FNw/2fGL2lQPNroKk2c6LLhH5ROHGkOrjlrLlFZTe29kJRJgOrOGk52nrP+fv0
         wVSw==
X-Gm-Message-State: ANhLgQ16MVWNy8OvTZtQ5kuvCfdrjJB256d976J8tieTW0scDLCYY9NM
        FFCzOD8ElX5j90sOkwbgfD5btg==
X-Google-Smtp-Source: ADFU+vuchbCxcDuvMI0oXv3NR9kDEcIvh5PdrH4MH/b2GxywfhrWBKPCrJOWYzpn/J65ZJciM9QCVg==
X-Received: by 2002:aa7:9a01:: with SMTP id w1mr759393pfj.256.1585337286979;
        Fri, 27 Mar 2020 12:28:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm4342053pjy.8.2020.03.27.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:28:06 -0700 (PDT)
Date:   Fri, 27 Mar 2020 12:28:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <202003271208.0D9A3A48CC@keescook>
References: <20200327093620.GB1223497@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327093620.GB1223497@xps-13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:36:20AM +0100, Andrea Righi wrote:
> Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
> (disabled) in the "settings" file for a specific test.

That seems to be a reasonable optimization, sure.

> NOTE: without this change (and adding timeout=0 in the corresponding
> settings file - tools/testing/selftests/seccomp/settings) the
> seccomp_bpf selftest is always failing with a timeout event during the
> syscall_restart step.

This, however, is worrisome. I think there is something else wrong here.
I will investigate why the output of seccomp_bpf is weird when running
under the runner scripts. Hmmm. The output looks corrupted...

-Kees

> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index e84d901f8567..2cd3c8def0f6 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -32,7 +32,7 @@ tap_prefix()
>  tap_timeout()
>  {
>  	# Make sure tests will time out if utility is available.
> -	if [ -x /usr/bin/timeout ] ; then
> +	if [ -x /usr/bin/timeout ] && [ $kselftest_timeout -gt 0 ] ; then
>  		/usr/bin/timeout "$kselftest_timeout" "$1"
>  	else
>  		"$1"
> -- 
> 2.25.1
> 

-- 
Kees Cook
