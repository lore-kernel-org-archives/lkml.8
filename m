Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB132075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590684362;
	bh=2PyVcrGeLrxuLkmqXC3FLbFODEHt9N0SeO6PDQkwEJc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=NABdX5rod9DuwZxyAwK8JfVngSpRnvbXz2tFLHToBYFPQ7sqQkEgIw6996+Fv5OSf
	 R3PJZHac6jJGWG515/6DMyG+Pln5rGcXqB92Sg3AcB7U8U2CFqNZE++6+e+AjbwWZd
	 SxZkE2z5scKN80cfPVYFnSjWwGS5EheuQVA+h548=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405165AbgE1QqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405154AbgE1Qp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:45:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F50C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:45:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d26so2861186otc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqJPlIw10s9Ij/zrETOCDphuCrsusdSvfBPan3DJSeI=;
        b=ba0UjTXhf1uH8fl/cUodMv7++faO5D0gtXNXssPhpJqkjn2JLzJTRBq7AE79JvIzhT
         qpHKNdxWaYvgFKswEhjsbL5KHh5JpO8dC7r8tGO4iiV6Xr4KuzdQgkSmzkDKNTUX8Vhu
         YE/kneNase+CEm39JNI37HEDNo5NqK/Pei0rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqJPlIw10s9Ij/zrETOCDphuCrsusdSvfBPan3DJSeI=;
        b=Qtz1j1bMxJaLIiJnOL5RXFTz1LyZPZVRPVM9sAQNN+IHpQSU/3HYTC+4DoZlQFJb8D
         tVhFKMS7kX9QUki4rGG4wKovI43wb6F8VWI3YgKoBiWm88s1I9SO/anYkitFG7tXy54Q
         PQW93z/t7JtZ+rxcrTfktr78r9UOFRXuupfzg8Vc5x2x+uZPX76KlZSCNTknFVX/FENf
         sdhFt0WgUfLlz5g33elZFTsdDXpmtWB1oqm+xTkeW5b74JQnHY7UkCVVIVXqw8V4M618
         uk26EzaQLhCWyPy4zeW9Eb8r+h9LZu06cLG/FcVrL7EpOnExQVHff4Fpqv6bTxaAZlVy
         Ffhg==
X-Gm-Message-State: AOAM530Pm3n5yA5RWDa1q/f+RUg9wgq+zMkriSdIR5oMgk8QTab3tGWX
        lnbpKiQX6is/8X8YOm+8OWaI3Q==
X-Google-Smtp-Source: ABdhPJx2phhHCCTSMcd8x9B0836mZiGJ+WjKKrBJbJbydW5C7TtGeSceoh3cnrWSDcF7DjPlCyWvCQ==
X-Received: by 2002:a05:6830:1601:: with SMTP id g1mr2753646otr.228.1590684357287;
        Thu, 28 May 2020 09:45:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t6sm1748396otb.27.2020.05.28.09.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 09:45:56 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: Return unsupported if no error_log file
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159040205682.10129.10826221002090446642.stgit@devnote2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bfaf034d-4bbb-1ca2-1cd7-309d4df79403@linuxfoundation.org>
Date:   Thu, 28 May 2020 10:45:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159040205682.10129.10826221002090446642.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 4:20 AM, Masami Hiramatsu wrote:
> Check whether error_log file exists in tracing/error_log testcase
> and return UNSUPPORTED if no error_log file.
> 
> This can happen if we run the ftracetest on the older stable
> kernel.
> 
> Fixes: 4eab1cc461a6 ("selftests/ftrace: Add tracing/error_log testcase")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> index 021c03fd885d..23465823532b 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> @@ -14,6 +14,8 @@ if [ ! -f set_event ]; then
>       exit_unsupported
>   fi
>   
> +[ -f error_log ] || exit_unsupported
> +
>   ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
>   
>   exit 0
> 

Applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux kselftest.git/ next
branch for Linux 5.8-rc1

thanks,
-- Shuah
