Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38517C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063EE20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591126849;
	bh=O8Y52rmvCor7/gioG1PySV36lRyVHgtIcDVZ3JNbgt8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RNhPhCkNVFTHjEyVk0Zt16Py61nOQHAaSib/ZSKbfIqD46IwXvSBJNe96snZcv24S
	 3FZq+KNVpS8C0ZntboK6Wvzrq0S3jrwh0GuHoXP1Ft+cNbU66aand/LO68PSazntV0
	 y/OvuL1/R0ZjNKH3ZoVDRvEt42y7awFUmtLjkw3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFBTks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgFBTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:40:43 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17866C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:40:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o7so7433509oti.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2I+4S8tbIx7DwMo7JNczQsK841BfxFTSjY0MHCxNYIU=;
        b=RfILkcDdS5Dw4tjKJUDbUCzR3ll3NKNjJAcSgdGam226ZRMseGj5qe273EFQQvXA9f
         KJi8xFz/CQ6R3Xll1dDTZpPe3A5Xl/nbUIB6FuftNNmc8eCPXJKV5AbZo1/gXBRabqu0
         HGaaJmma/HW55BM8Cqxss1rUeAlL1vYBg2PT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2I+4S8tbIx7DwMo7JNczQsK841BfxFTSjY0MHCxNYIU=;
        b=ulfzTzFKdmfNdCLYsgL1NzyZv4dvUTlQXw6O+zfvMGBywKI54nfItdVdwHPbIqnye9
         fxte8xFnAUvjmnayVcTHxtzdZLnzCgPMI8QGxwZ521PITDpbHuRuesWxLLlJzJ/+mG0L
         FKyTUCg+/7rvUzkAuBwitIhvjwh2FJ+3t43ZJuFV9XNe95JsvYmyiT52+6qqE9ADDc+A
         ytV0dfxhWdG1bvqi1Qv+kNLCzpliVEk6cv/unn8pZNDX2sjx89gpYOVtst3GxZ9Bc5OT
         uRiUHTdD6BqXmPDlWv5HDdo/o/7bTkWCEseXh/EbBL5EcK/4WZWiqEm6/sao4kXRPOIO
         C6pg==
X-Gm-Message-State: AOAM533/tFEQJ23FZZO9QhZRBj0xWi87a3bd7km2WxClJNJfVMkxYH8k
        2b2uz4pciWkCdYp9LpHpKNGe3FG7JFA=
X-Google-Smtp-Source: ABdhPJyO+YiEkWCKUiWfbv50giAJAa8LV/HDs6CajK377rV7mJSLpwA75R+tRe8S/deTEbCX8vPnUA==
X-Received: by 2002:a9d:4e5:: with SMTP id 92mr606889otm.146.1591126839965;
        Tue, 02 Jun 2020 12:40:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c1sm850342otn.81.2020.06.02.12.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:40:39 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200511131350.29638-1-anders.roxell@linaro.org>
 <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
 <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
 <76811e1b-c26f-53ac-5703-104aacd06666@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6b5c1db-c0f6-5f8e-3afd-8a7075721ffb@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 13:40:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <76811e1b-c26f-53ac-5703-104aacd06666@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 1:13 PM, Shuah Khan wrote:
> On 5/28/20 1:07 PM, Brendan Higgins wrote:
>> On Wed, May 27, 2020 at 4:49 AM Anders Roxell 
>> <anders.roxell@linaro.org> wrote:
>>>
>>> Hi all,
>>>
>>> Friendly ping: who can take this?
>>
>> Sorry, I just reviewed the last patch.
>>
>> Shuah, do you mind picking this up for 5.8?
>>
> 
> Yup. Will do. I was watching this thread waiting for your
> Ack. I will apply it once.
> 

Applied to linux-kselftest kunit branch for Linux 5.8-rc1

thanks,
-- Shuah

