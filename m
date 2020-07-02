Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F17C20724
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593725574;
	bh=Jk0syQ/0lgUEu1YQEiKAAPwM2mEAiZPd0Au2ckJZxhQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZfqBrN/8Oyj6Gii+jygNR5Up2GBkqvVsyo9myprECVd7xsjW49C3etdujGB5MCDoc
	 fEceLI/4m39O/E01J5RKe+7tVUguictwQPgmwrDgTAQGBkDuSmW3ntAbktdQTYUUhU
	 6Q2+3IDBPQ5HxMfH+9jgdsijFLaC9IwE/CRhuYrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGBVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:32:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DFC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 14:32:51 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d4so25258426otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nX3WtTCapftQZKi1J19LFFYw/FZoTJx9oV4zdav/HAM=;
        b=W2mEdExBm5gJieoP7Q/8ZwG9gCKaZ9p9eCzN2Y50mZ6jLZXzjMnev/SY9+Be2QR2Xw
         qHVXs3dixLkGGDEWHJh315caCWuWYCcAFzoTR5R4LdocDACPNuoIX5PMCLDg3jdEkhKg
         z073WidPDOU3/u3m9yl0jBb+t0OrTzGyiQBog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nX3WtTCapftQZKi1J19LFFYw/FZoTJx9oV4zdav/HAM=;
        b=EBK3I6Zk5yx39+rtOvQe7rG9YGW0BzceRzgmtPIa4nd+9gCjpSq2LPV3oXJQ8ggzO7
         oem3QiaBVuL2AQ6m9E452uQmPCKCXtE7hz52HXNMvtXCq2MwMbReSm/jzFCDLnT/eBi5
         l5xOGrWK+suHvGSxkRP9+9uZiZOZy4TOXfK1yDrqh815fCoBWwYBDjGF7PfN+YfXfhg+
         Xc1B8asBMXs1LWjECOePtZrzbPCx4eubrijR9Kf1Stcd55AzoQmqq0oZF3iKvHZWFin4
         bzmbKIq9Iz6HtFitmGG3D3dA3P084L9lbRcd18FnrKZTb9uNVO34gDDBIAyja2WvhGyN
         Pa5A==
X-Gm-Message-State: AOAM532bJ9QiJvUBiyhuA5FwMQbPrhWrb2lZjn+zqy0yrxA5buItzcFl
        W+IMfTcuaQjyDSuntuREjFZ8Gg==
X-Google-Smtp-Source: ABdhPJzANdCeEB3WWTPYNmcant+VS0uiYdncD7z7qX7msKxD+29krliYFkcOZaYQbQgqgJYUp2Tpng==
X-Received: by 2002:a9d:32f7:: with SMTP id u110mr28817895otb.217.1593725571151;
        Thu, 02 Jul 2020 14:32:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a204sm3019240oii.34.2020.07.02.14.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 14:32:50 -0700 (PDT)
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
 <20200702194435.GA28988@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
Date:   Thu, 2 Jul 2020 15:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702194435.GA28988@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
> On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
>> Python 2 is no longer supported by the Python upstream project, so
>> upgrade TPM2 tests to Python 3.
>>
>> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> 
> I think that it's perfect now. Thank you.
> 
> Also
> 
> 1. I checked that scripts/checkpatch.pl did not report any errors.
> 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
> 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Shuah, I could pick this up after your PR (with my earlier fixes) lands
> to mainline, and sort out possible merge conflicts if they uprise. Is
> this fine by you?
> 

Yes. I will apply them as soon as PR clears and hopefully they can go
into rc5.

thanks,
-- Shuah

