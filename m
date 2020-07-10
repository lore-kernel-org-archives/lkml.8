Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B23CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1872A20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594390735;
	bh=BLLaPv/+3ip2ly+XaDZVw+P0zoPzAFFIDGI/ZFSOfcI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jbgBGjv3A4FFGA686iLrgu3yyJMLG1jNhEcQiZNSgkAKbSdODk+X/mQCIrEfSAkVz
	 V9sa57AgxVXkI8VRy2zZm9+s0p/5AFASIwt6DDBCgOOxbfhAw27Isl0lyDrlVJ08iW
	 euE7UcJtS5JwKzmcvMA9wHLDhSIffzzrccabEEE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGJOSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:18:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6321DC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:18:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so4298879otv.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PDkeD7akaYc+KDClaom9zWMxwhKX5k48L8L5j9McWnM=;
        b=SktJprXvPgcuo/VJ93DjQ1b6oAP91Kjvyl6zRqpGHLKoIEDZBeXLFIYSpqnIY6XaMU
         J2aoIOWLheOa8u6c/ypc0mepQXtkeDjlRXQeCW086Cn2ntYpFhjuZZuFAZjowXLpDEC5
         dO6TCqHMBzDHr0jgwmT/cnS9F0xjJYGjLmPj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PDkeD7akaYc+KDClaom9zWMxwhKX5k48L8L5j9McWnM=;
        b=AWtGjp/KaVjjS0k/b9ZA/2KwFAJzZxGqcjmvneygIGUfECK1eIz1Kt6apiLC4Fg6mo
         UXkmli6EmCQ03KDyiJZvUSKh6S/QtXsOxqdMu7i7IIEc/dhYY3xn2ZK/32o+WSaUeTqh
         MBvC4IQmWstIaDRa60KXcR9O0FC0cptV/Mootmqol/9Xsl693RrJLFYcz+P1B2sDDSXO
         mGetAGTH6XNVDTLpvZ/1jxFIs29ipKCcutiNyD5ZpNFI2aprjxVURwhk4KxPr/V2XpHQ
         S2uHRExlb/mREYMXtRSABiqCQ4pCp2dWz5XyD0mtk+dwt1xJF9BsJ0m5A8k/fWkA06HS
         v8Yw==
X-Gm-Message-State: AOAM5322pLxgjzFXJQlQZ/2IpknYGYhuORZEqBdFBGnQGh0eTOB+AwNm
        U676VP2GKG82eBMFj05719VAm9/QtaI=
X-Google-Smtp-Source: ABdhPJwpNl45l2iTeVFgZmaAi054E5Smh5x/gbRjeGzpu74xxKNrENHyuHBvQlKr0f9uj7V6mCjjvg==
X-Received: by 2002:a05:6830:4aa:: with SMTP id l10mr23319482otd.214.1594390731767;
        Fri, 10 Jul 2020 07:18:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n6sm1110367otq.33.2020.07.10.07.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:18:51 -0700 (PDT)
Subject: Re: [selftests] 7cb32086e5:
 kernel-selftests.x86.check_initial_reg_state_32.fail
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200709064946.GQ3874@shao2-debian>
 <9cfe8123-9cd7-a6ec-f73b-3252d695a387@linuxfoundation.org>
 <CANoWswkjNnyBi68HL6VjX9dWt6VdjxycXV09j5L+jkCAbnrHrg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8316a170-4aee-eb57-9038-3afb91c6f0e2@linuxfoundation.org>
Date:   Fri, 10 Jul 2020 08:18:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CANoWswkjNnyBi68HL6VjX9dWt6VdjxycXV09j5L+jkCAbnrHrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/20 12:02 AM, Yauheni Kaliuta wrote:
> On Thu, Jul 9, 2020 at 6:36 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/9/20 12:49 AM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 7cb32086e59b514a832a3e11f5370d37e7cfe022 ("selftests: simplify run_tests")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>>
>>
>> Thanks for the report. I will drop this patch for now from next.
>>
>> Yauheni,
>>
>> This patch broke x86 32-bit test run
>> make run_tests -C x86
>>
>> Please resubmit the patch with the fix.
> 
> I did not check carefully the report, but isn't it expected that some
> tests are moved after the patch since they originally were placed
> incorrectly?
> 
> 
The failure doesn't have anything to do with test being moved. You can
reproduce this very easily by running make as shown below in x86 dir
under tools/testing/selftests

make run_tests -C x86

I reproduced the problem with your and patch and verified that the
problem tracks your patch. I dropped the patch from linux-next
Your other two patches in the series are fine.

In any case, this patch isn't really adding any functionality and
is a good cleanup. Let's do the cleanup right or not.

thanks,
-- Shuah
