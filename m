Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F47AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEEA206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594066326;
	bh=fYeWno6eIJhW7WG2EftixMnePhTjX5NPHja5EE5eoa4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=B6SjB9euJgo2vRU/JPXwUld0hmEV4gdjj/Ump9xxFQ/ThvY2VuHokqOl4Gk7DNqJT
	 sunTiaE9UPC2REl0KNVm0/h7qYvuztl8AaVOyjLyXiWcEvv0iz5TDQBknG+10WqB+C
	 DolEPc3gjjoKtVs77hwJTmVpo2k5CNoHwRjMsYrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgGFUMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGFUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:12:04 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF02C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:12:04 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id x2so551206oog.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aPoqTBTd4Fvr1FatyV2n4cKiG3l+p0twEU6wlQSoIMo=;
        b=S1LAlmWR81o6w2df99eOJ7JGN5ZLNQQlgmBr0AovHqGoTEhDP1dJIQzYrKsv5JhbJK
         kGiV7RWOXcm94Dc6W4uVphRdSgEobOxM3wWPL7Ej4QGDrUu1evxGdCrrXul7Ij69P17N
         sCLrJuu5UMKl/7Igd4SfcBs9k/TeXK5zn2WNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aPoqTBTd4Fvr1FatyV2n4cKiG3l+p0twEU6wlQSoIMo=;
        b=BySA4dpSlDvOdp+OOWDr22Y6jK5kVIy+ndwnVvjX6ikIvGKC2JbO5gbWJyjZ/Ib7Ux
         5PrpCr7+cbO9DrXxs71pQiea1PhttEtSmen/72ARbh63389PHY23LlZFWrvIqTYqJnNm
         r4lrDQ70QAIFLfF6kwoGbH2VSYF9RNNDZTOrY3qEGfo31IVIMnzcIf2mpJP1pD7n373G
         jaQJ5Eki+yDEENSV0iICG9hseyrRRz96Fl8vd4sL5wcOVIyGoa03yqWg/el0xe4Zi/CT
         ZYexomQ4+fwiRgN1lTZYg/4wSU5ol6LiUZ9bnI/dFoZZNwYqD/0InvprAjRpSVd77luq
         ox2w==
X-Gm-Message-State: AOAM531JT9PLhZnEOq87MqEIoxJLRw3uRyCnXBYcEzIAT14Ktzz0EmAS
        fA1GdtIeHReiMyuzQ21yOllDKQ==
X-Google-Smtp-Source: ABdhPJyRxhPxu99g6AO6b/F2qYBGVuPKy8moAvlb1q+8+tNXPXZ0ncJvdUpKWVJ8hmvLy0Ra1yusvQ==
X-Received: by 2002:a4a:2459:: with SMTP id v25mr43655306oov.75.1594066323687;
        Mon, 06 Jul 2020 13:12:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d26sm5359898otl.49.2020.07.06.13.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 13:12:02 -0700 (PDT)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <02c7dda4-3a05-b118-1edf-ec020eb08193@linuxfoundation.org>
Date:   Mon, 6 Jul 2020 14:12:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703012005.GA23276@xpf-desktop.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 7:20 PM, Pengfei Xu wrote:
> Thanks a lot Jarkko and Shuah!
> 
> BR.
> Thanks!
> 
> On 2020-07-02 at 15:32:49 -0600, Shuah Khan wrote:
>> On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
>>> On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
>>>> Python 2 is no longer supported by the Python upstream project, so
>>>> upgrade TPM2 tests to Python 3.
>>>>
>>>> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
>>>
>>> I think that it's perfect now. Thank you.
>>>
>>> Also
>>>
>>> 1. I checked that scripts/checkpatch.pl did not report any errors.
>>> 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
>>> 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
>>>
>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>
>>> Shuah, I could pick this up after your PR (with my earlier fixes) lands
>>> to mainline, and sort out possible merge conflicts if they uprise. Is
>>> this fine by you?
>>>
>>

I started applying this and then passed.

Doesn't this test fail if python3 isn't installed? Do you have to
support both versions?

thanks,
-- Shuah
