Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002ED2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591805947;
	bh=VZ6cI+9JBHME4VQJ/5+n3zM7Zc9vrZOxRgaJmEdkErI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GS2LhGPm2W7Yvrh98Y6JXRJ3pYVWZdvH7QcuHhILd7MH5eieEsk0YsE0G24uovaiR
	 MIqZI0yhJ7VNk254SWXsVGEfZRSph9IhCPWELPbLHMlLA6Uhr3jHP5/XUSYjo/zCrv
	 zeuphur16zr1OUpnTkioIwSxigKOnduEZ2M6yGdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgFJQTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgFJQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:19:04 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15CFC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:19:03 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f2so607500ooo.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4BI6qJGyzZVThLkKkzXe+RUQAfRoNQO65AznCnGs0c=;
        b=ZmEUvhL+feLEo/KIN1LNGrPEkcPqaPC1iYCkLfEY6E30tND56twEYrOrCx6RvkVQLS
         PZl9Utc3sXdl3MqKaChdt+uaOd/26i1I+Zcz/6TIF/y3s/Sgw6f1/stppapGsxYsyv0s
         QWNVFG+RjbkzzjzP2CgsL7vFA+2BwToBgP7zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4BI6qJGyzZVThLkKkzXe+RUQAfRoNQO65AznCnGs0c=;
        b=UeRsmmI18NOKkNsXyjMXBr7J76aPw8sY+fY2eo8m177iNrbO3j75WrQXrELYw++kks
         0iUTBmI7LqwOGhfig7qiYMGb+Id15IkgqktY2adM6kYoKJK0lvaOxfOnLHms+pFPaQ+i
         8ah3KgrLXVawBdKB3TkN5jmnh7YKmwfAY2QWflRPEGoIDN6E722YbM7Ykosf23CpxE9B
         MEURRTy/sVuSVoqfiBYwkc7gSAD6nmOW3CF8OVkNdrfZ2+GXxfv+D24RzbB2qX3e/gSK
         Kge/SeKPWiQXiD3sAm0J12FjKl17fB1Qk4JeKyTERARO7gL3rlIbazr7kMypq0o7u4DL
         dTpg==
X-Gm-Message-State: AOAM532ZF1ZbhFkaaoL6BFRYZwUV8wQdFXDvkP0WNKjTRfZIiKSmbMEr
        PdARWoAuYIWbh29ISxO4u48mfw==
X-Google-Smtp-Source: ABdhPJzkmrZoP749LWM5495c1Z2ZESXA5/2b9BwQ2lcVb97VBEK2JDC3CVDsKFJOhnrWqW4dExCOGA==
X-Received: by 2002:a4a:c501:: with SMTP id i1mr3105074ooq.65.1591805943124;
        Wed, 10 Jun 2020 09:19:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u62sm41305oib.47.2020.06.10.09.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 09:19:02 -0700 (PDT)
Subject: Re: [PATCH] kselftest: runner: fix TAP output for skipped tests
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200610154447.15826-1-pbonzini@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 10:19:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610154447.15826-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 9:44 AM, Paolo Bonzini wrote:
> According to the TAP specification, a skipped test must be marked as "ok"
> and annotated with the SKIP directive, for example
> 
>     ok 23 # skip Insufficient flogiston pressure.
>     (https://testanything.org/tap-specification.html)
> 
> Fix the runner script to match this.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tools/testing/selftests/kselftest/runner.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 676b3a8b114d..f4815cbcd60f 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -77,7 +77,7 @@ run_one()
>   		echo "ok $test_num $TEST_HDR_MSG") ||
>   		(rc=$?;	\
>   		if [ $rc -eq $skip_rc ]; then	\
> -			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
> +			echo "ok $test_num $TEST_HDR_MSG # SKIP"
>   		elif [ $rc -eq $timeout_rc ]; then \
>   			echo "#"
>   			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
> 

Thanks. I will pull this in for Linux 5.8-rc2

thanks,
-- Shuah
