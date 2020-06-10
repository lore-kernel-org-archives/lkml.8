Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D94520656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591819363;
	bh=yglEJK0pwMFzghER1gyrVP5HUMll6Rq6p6yuAzi9TB0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vlcpBAwbKtqED/whZ9qG+0Qi9V8y9g0TNM4Z2eIEpuo/Zw7XOr0VGVHIa9y3q93vt
	 w3ZoDxqeZq1UV/ZfdrM42jX99JJEb/3pzMyFkXG8BfU6gezVd/5EgrHgTWRgx4Vsex
	 xqY89kqpsqrftJM7HXxZruB9mCOYabs3twfOP0hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgFJUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:02:41 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D07C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:02:40 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 18so761719ooy.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZencQASJRki6VdoOxeOIlcGGGCewAGYJOEcSk5Dgfg=;
        b=XPCKVMMke8Jf+Pi0GeiBzPCLOfLL99hToskxvMW9JaU93d5m/VZrbXmZ+BJHO2KYD2
         fd0PX66ZFMMUASpCcUTx+csortjmYseBTRm5zDvPp1sPEPWZlF5tFHPGZ+zKneKiMcbn
         w1WLGwVGRZWqrVddPQrdpY8vL3pEYAYieSbdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZencQASJRki6VdoOxeOIlcGGGCewAGYJOEcSk5Dgfg=;
        b=h8onQiC6vT6pxG2zhCbKgwWHKpjxtxGyLG/V2crVAg2fgL92Gy9XjoR89+edmE95it
         M+li42SUFUaeCRva36Iuur2LsiU83EgZgVkx9qH6EGWOLhFrzi/71EzB5tiCPI+ec9Sv
         DCEGVK7MffZFLLzLRvaOykYUGO3XwjbHCLHgFTSs4fcfMajBYdLd4J29IRTRfCF925Z9
         /aCc5xkRbnmc2Tyq1p/FnaMaQafLA1+9HOV4+BxGU5HKvCibEIChD+sKphDeTIwHvgL4
         tq5tMd7MKGNu55XMY3D53l7s5jgstbd7VnuyG7u8SNn0Ws60NoKylZuDHqad3p4JcTM2
         z/kg==
X-Gm-Message-State: AOAM530sQFbjy181veF6fsHc09+Gmf5awoRxGo1JHxZDZP+mauZ3El6b
        JpFYfITOKKRs/KGddJmfc8sK6w==
X-Google-Smtp-Source: ABdhPJx2LGg3UiOse93yQL2bCLbO3dMSH80eybn0HTimfQXaya+ujg9M8lnVVwZh1xpt3pxmPlsRUA==
X-Received: by 2002:a4a:e836:: with SMTP id d22mr3907706ood.54.1591819359255;
        Wed, 10 Jun 2020 13:02:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 10sm210430otq.52.2020.06.10.13.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 13:02:38 -0700 (PDT)
Subject: Re: [PATCH] kselftest: runner: fix TAP output for skipped tests
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200610154447.15826-1-pbonzini@redhat.com>
 <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
 <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fbce656a-fdf0-7662-2fcf-4f0daae8cf33@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 14:02:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 11:43 AM, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From: linux-kselftest-owner@vger.kernel.org <linux-kselftest-owner@vger.kernel.org> On Behalf Of Shuah Khan
>>
>> On 6/10/20 9:44 AM, Paolo Bonzini wrote:
>>> According to the TAP specification, a skipped test must be marked as "ok"
>>> and annotated with the SKIP directive, for example
>>>
>>>      ok 23 # skip Insufficient flogiston pressure.
>>>      (https://testanything.org/tap-specification.html)
>>>
>>> Fix the runner script to match this.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    tools/testing/selftests/kselftest/runner.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
>>> index 676b3a8b114d..f4815cbcd60f 100644
>>> --- a/tools/testing/selftests/kselftest/runner.sh
>>> +++ b/tools/testing/selftests/kselftest/runner.sh
>>> @@ -77,7 +77,7 @@ run_one()
>>>    		echo "ok $test_num $TEST_HDR_MSG") ||
>>>    		(rc=$?;	\
>>>    		if [ $rc -eq $skip_rc ]; then	\
>>> -			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>>> +			echo "ok $test_num $TEST_HDR_MSG # SKIP"
> 
> This is a pretty big change, and might break upstream CIs that have come to
> rely on kselftest's existing behavior.  I know it's going to break Fuego's parsing
> of results.
> 

Thanks for chiming in. We don't want to break CI workflow.

> kselftest has a few conventions that are different from the TAP spec,
> and a few items it does that are extensions to the TAP spec.
> IMHO, the TAP spec got this one wrong, but I could be convinced
> otherwise.  But I think we should discuss this among CI users of
> kselftest before making the change.
> 
> I started work quite a while ago on an effort to document the
> conventions used by kselftest (particularly where it deviates
> from the TAP spec),  but never submitted it.
> 
> I'm going to submit what I've got as an RFC now, for discussion,
> even though it's not finished.  I'll do that in a separate thread.
> 
> 
>>>    		elif [ $rc -eq $timeout_rc ]; then \
>>>    			echo "#"
>>>    			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>>>
>>
>> Thanks. I will pull this in for Linux 5.8-rc2
> Shuah - can you hold off on this until we discuss it?
> 

Of course. Thanks for getting my attention before I pulled it in.

thanks,
-- Shuah

