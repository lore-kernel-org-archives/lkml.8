Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7947C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CF621D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599684554;
	bh=WhD+DsSwvfurTaZIlOZ15wTteGNAQzgwazC7QiKGT/I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xaSZ62naYYr3t4J+poMID5IBQCm/g2P8HpA+sP2/Zry8RlISD5DElvzhpaw00bIXO
	 EOvSnm+iSoINXfhg8KARGqpKAj6y/vLCaOKy4VceHGliRaLdj66D9jaSKYAKFbLO7Z
	 f/6Jj4ANOgfbAL0x5KMdEzHD5YM+0sYpcWn5Rypk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgIIUtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgIIUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:49:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A013C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 13:49:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y2so3655432ilp.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hx4c3GIuv16DFuUNrX0P7a0FqrG5ZXLPK5uInGDH+uc=;
        b=X/4Oxj0XETaW4Z8kWLEu5GO2V4ksuf2+PcPOE6hTPkpE8PyFPydMHVYLr7DmtvOEmW
         2nq7+hyh2blxtxDhNTbsTIhWrzluse1y57Vkn61re6s3qNtaHvJYcVi+tEup++kynjWm
         j58xZUaj5pWl+nwBUhFCVyPyD56//TfLgByKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hx4c3GIuv16DFuUNrX0P7a0FqrG5ZXLPK5uInGDH+uc=;
        b=iiN+0c2Kqd+zPJ2WVjEV3kKGfxmALV8LXg3nqsHUoMXl2ZvMtFTeyetmTqaJ7zwiqf
         uuu1t4gKc0/KLb3LHex2Qp3Io9rPD0UprSge4x4XkaYiblT16GI0UhBN1DqOMYHCsZt5
         unYzuREK9czZeDcdH9AG8ZjU2vrwkms3+RbblC22R9jT9mL4omQkseFXcuFYrH9nZEvQ
         I7bg/Xdgw3+7ewDqbkgPpJWOGK4wS6OyC0pUBtZfHvYgxJq93PkOSvgg2j/eMjA+bepy
         hPb72EFf+Bft6vk4GQCsAYUd1yXPyc1+6VXNihaJgagYRDCulucOHWjzKeUCZUsQZWQp
         kWoQ==
X-Gm-Message-State: AOAM531QOMRAc6hJz2YQutd55HCL7ssqIWBSHpZh/SCVTmj2NC8Vefye
        yxg7ReD+3L7/B5Y5ivD8DeqZthNm0qUjew==
X-Google-Smtp-Source: ABdhPJxWwJJ8zHQ9V/VMrokA1q2M1spiFJgBXeZrNoZOF2JS5XckGcnfEsLGNalCYLSSbV8GoIi7wA==
X-Received: by 2002:a92:9ec3:: with SMTP id s64mr5261269ilk.294.1599684542673;
        Wed, 09 Sep 2020 13:49:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h184sm1746394ioa.34.2020.09.09.13.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 13:49:02 -0700 (PDT)
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202006261358.3E8AA623A9@keescook>
 <202009091247.C10CDA60C@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7271a7e7-c4fb-c656-f6d2-6ff4a29a9e06@linuxfoundation.org>
Date:   Wed, 9 Sep 2020 14:49:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009091247.C10CDA60C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 1:49 PM, Kees Cook wrote:
> 
> On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
>> Instead of full GNU diff (which smaller boot environments may not have),
>> use "comm" which is more available.
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
>> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Shuah, this really needs to land to fix lkdtm tests on busybox. Can
> you add this to -next? (Or is it better to direct this to Greg for the
> lkdtm tree?)
> 

Kees, Thanks for the ping. I can queue this up in -next

Greg, would you like me to take this through selftest tree?

In case you want to take this through lkdtm tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


