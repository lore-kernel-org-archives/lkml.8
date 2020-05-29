Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC13C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB50B206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590783734;
	bh=bdX6ve+DHrzJWe2+x/V9kAS8WCsK95RNK2H+Um7eEYw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=A7IwA+dAxATyCGpoLEwEhJJsO4FIK6bDZzZCm0gGhQjx1Ek5DB+i5igoMuli8w9YJ
	 wIchSjY5rMz6S2R5FQc5pVRU6vobvPxBl893g26P8YtJzzG16Ek++IxJZPk/w2VHzf
	 6ql+frwrMiwvHfOrk/dt/Miiqo6lX77Ek8DOaDSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgE2UWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2UWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:22:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFE7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:22:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d26so2940324otc.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=27+ZatDP3RQovQk4qdaOmfeyVOMajbGmTbvCmCTKoq4=;
        b=O1ILFI8nKmFMFDQH20Mo0pWkb3IpT/BWIEl0S+yFPPG1TijSqVVpUOzvLZM+XZ9xLA
         TNJmAHJHhtA8YSfAjOUzPh8TiN0q+5mxQ6RSo13OUq3f9JdLil8XutM2XnMEAlUbXTz4
         6/HVNhFck6INbtnpWGB21hrv0lZ81471i5eNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=27+ZatDP3RQovQk4qdaOmfeyVOMajbGmTbvCmCTKoq4=;
        b=ccvBGSeHbPIfoACh37Z9aeVHsKTdmhrBFDjnyZxncF9RrFx6P60mS74Tfx6ggMOTiF
         qaqICO2vFjq0QHIDYSYxzdqngVJA83hduYLiXvMqOTu/KZHY47778XoLXXDg+V4SsQCA
         jyby5rVKiGLLV2Gk0R+8lvwIX6Xe+G/VGQpfXyXC+pt1pfgd7OYuLMTfEwJlaROpbF8X
         Jqix05LuH0yPj4lpWVhZm3mW735O9WNvmQj43ULsLKq/srD28ao7BUbl3CLgKSuiHx1G
         QgzHxWC9JE7RhAjIqES8rXkk8Xfy5LN+n2C9En9XurD//GcHPC0A7Wk0slZWMd78X/AD
         39DA==
X-Gm-Message-State: AOAM533LFqrQh+MEJyKNQWJEz1Pibn9wrH1351so/jEa2ONjp9JHJqnw
        NvAggBM2Ln8q7cImDvRcenc3MA==
X-Google-Smtp-Source: ABdhPJxu85JNRAuCXevGB/jNaZytBBd2ZdSUE0ZCQ2T8VnSzvdMDlsGGmEqMZos9MFmEXaqUvNvjFg==
X-Received: by 2002:a9d:7dd0:: with SMTP id k16mr7461301otn.126.1590783732425;
        Fri, 29 May 2020 13:22:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m26sm2736384otl.30.2020.05.29.13.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:22:11 -0700 (PDT)
Subject: Re: [PATCH 3/4] selftests/lkdtm: Reset WARN_ONCE to avoid false
 negatives
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <20200529200347.2464284-4-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a5808685-88bf-2e04-1973-a9dbdb23f5e3@linuxfoundation.org>
Date:   Fri, 29 May 2020 14:22:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529200347.2464284-4-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 2:03 PM, Kees Cook wrote:
> Since we expect to see warnings every time for many tests, just reset
> the WARN_ONCE flags each time the script runs.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   tools/testing/selftests/lkdtm/run.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index ee64ff8df8f4..8383eb89d88a 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -8,6 +8,7 @@
>   #
>   set -e
>   TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
> +CLEAR_ONCE=/sys/kernel/debug/clear_warn_once
>   KSELFTEST_SKIP_TEST=4
>   
>   # Verify we have LKDTM available in the kernel.
> @@ -67,6 +68,11 @@ cleanup() {
>   }
>   trap cleanup EXIT
>   
> +# Reset WARN_ONCE counters so we trip it each time this runs.
> +if [ -w $CLEAR_ONCE ] ; then
> +	echo 1 > $CLEAR_ONCE
> +fi
> +
>   # Save existing dmesg so we can detect new content below
>   dmesg > "$DMESG"
>   
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
