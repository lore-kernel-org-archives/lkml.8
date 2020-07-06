Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F5C20702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594067537;
	bh=ozSI9lYT/YSibvf+brla+Wf1ostxTtXMw8lR018NDz0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=L9zp3nZgmLSc4SXOATlf1Nczp7lCj4TuynFCsjIx51ICUSngPX9jkht9WuEvhbBxT
	 Sp9oHWRIa1kEhwrPH/T9JtcYb6QXJ+wPshE2RaiQs94SOvjeiiKZUb41kHwK4C2wft
	 Dr0WWK0xU7IAigNnfi7AqJsDZ1CQ1/KRuSH6SPvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGFUcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:32:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5CC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:32:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so19846471otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYQOdCfTTkXILORVtgEAOSWFzdmimDz+yZgYtM4yZbE=;
        b=VQIIiHM2Ao/EeMWSJrjPlMGvUtC+rgPUY2bgc58R3cMyriGsceTf+Kx01YXOOZqIXw
         upAgmJV15tUFe0W76Yexn9k/dG/4xYzDYNQY1/AWWB0IKUmhfuOPDqcqX27aBowFgjbF
         1dY9tzGMkt2CdilQlzd3ue5U6A5kt1im4geNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYQOdCfTTkXILORVtgEAOSWFzdmimDz+yZgYtM4yZbE=;
        b=jSZjjBJqLPNCFGtXk4cruc2bQzMRmDwCxixuBHywPJ5Y1qIDTZUG0gOGCd5+E2lONX
         kSmvDK7IbivoAdlgyS/ByBPvPSXmIKMBQrMOxSFH1YjY4lCqzojNNjXCKohM6L4kW1ZL
         uu5IWI97V+wnTt2fISrmctRuO9t62P9exjdSN+NuYs6JSzBcZWdi1gNnfPlQgpBkfekV
         7IqTTsfSvlLRJ0JJv3y5/DnQWLBGSv651AA1RbHG6v64dJrxKNIUQq3MzZQmeO/5RMHR
         kf7mMMXeX/4lpLQ0JjTj2QF5Hxq9cly7qnQB6WT0ZV6Ke8oueRvs22vLrl/c4ZN2NaBz
         LeQw==
X-Gm-Message-State: AOAM5310Q+kYBvIb9jKyAkso3aa/WKcgkThMPMSLZadbyPUvRlafoy2E
        sC+7BgLY2nNMkDkg6uqGpV/R7A==
X-Google-Smtp-Source: ABdhPJw6ob5Foy2BcLVulUulHHyB2XDn2hXJ0IJM3C9aaf5FcZHvP152UHhejq0INirO6Q1UySgibg==
X-Received: by 2002:a9d:24e6:: with SMTP id z93mr42571857ota.360.1594067534692;
        Mon, 06 Jul 2020 13:32:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t187sm5273105oib.45.2020.07.06.13.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 13:32:13 -0700 (PDT)
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
 <20200702194435.GA28988@linux.intel.com>
 <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
 <20200703012005.GA23276@xpf-desktop.sh.intel.com>
 <02c7dda4-3a05-b118-1edf-ec020eb08193@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <444c90ba-3ad3-6ce1-d83e-bb918856079f@linuxfoundation.org>
Date:   Mon, 6 Jul 2020 14:32:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <02c7dda4-3a05-b118-1edf-ec020eb08193@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 2:12 PM, Shuah Khan wrote:
> On 7/2/20 7:20 PM, Pengfei Xu wrote:
>> Thanks a lot Jarkko and Shuah!
>>
>> BR.
>> Thanks!
>>
>> On 2020-07-02 at 15:32:49 -0600, Shuah Khan wrote:
>>> On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
>>>> On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
>>>>> Python 2 is no longer supported by the Python upstream project, so
>>>>> upgrade TPM2 tests to Python 3.
>>>>>
>>>>> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
>>>>
>>>> I think that it's perfect now. Thank you.
>>>>
>>>> Also
>>>>
>>>> 1. I checked that scripts/checkpatch.pl did not report any errors.
>>>> 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
>>>> 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
>>>>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>
>>>> Shuah, I could pick this up after your PR (with my earlier fixes) lands
>>>> to mainline, and sort out possible merge conflicts if they uprise. Is
>>>> this fine by you?
>>>>
>>>
> 
> I started applying this and then passed.
> 
> Doesn't this test fail if python3 isn't installed? Do you have to
> support both versions?
> 

Never mind. Tested it on with python2. All is well. Applied to
linux-kselftest fixes for Linux 5.8-rc5

thanks,
-- Shuah
