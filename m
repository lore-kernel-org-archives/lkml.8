Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99277C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764F82076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GKxKz1Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDVWBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgDVWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:01:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E621C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:01:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so4462229wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=em+wcShpdUXMOwEuiMKWPovG1hGJ7vnjNO1+x5kgI0M=;
        b=GKxKz1ZpRtm0Zath9tELAqG/QrfcwqyTN791UFjljwVoF/QYBEfF5W5V877GGat3MF
         4a+wKQQkqA6adYYwVLZzyz1N8RXUac6p5fJZq08vBjqmQFrTjYVDL79IV6jj1Qo+LZLQ
         3120q21JUFdmW+FqSTo2C7aY1tviiDz+7tJT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=em+wcShpdUXMOwEuiMKWPovG1hGJ7vnjNO1+x5kgI0M=;
        b=nVq/IU+P2nc6GGTfnL1YE6YBTuZqTqPABEPF1PU0c3csPQKudufMvIAUiuanMxuSfd
         zDIBVByHvuSYwQmU3EIcgxdn5Ydq2cRFbo7u+a1Nh2GOV8+CJ3A9Acf4wAnpYOlOdblt
         3wDGQUQEQh2ZZL4R5KcMfMwFlJ6rsKSxO19H16+xXM2hpupIJLvsGfhKRsoA6bONHr1S
         /sK7zrS/J5iB6+OartWYT2HU6VkjSQ9HbFCWQpiYpDtgvCQkra/OsFOoO7yL0qYTVPTu
         rl1Yo5hamaXEdh5/BxK9jBLR1VXaPXqz0TSi9/ivuEMKrWNz6UL8nYYCyQ0ayuLHZi+6
         LKOA==
X-Gm-Message-State: AGi0Pubi0OiRr9vjiK0qcZWveioeg5QrgJ1mCtpswtBpsaglztlkko/E
        j90d2ZHfSDgPHZ1eIfgSYoJKtA==
X-Google-Smtp-Source: APiQypKI8k4TySX2HxG45ANUOlTXZ016fEV88ihQ/i/kGs1Reh4zJF1QAgKUNB6iUGMJJTHVq4CGAw==
X-Received: by 2002:adf:a309:: with SMTP id c9mr1154684wrb.97.1587592911938;
        Wed, 22 Apr 2020 15:01:51 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z10sm702728wrg.69.2020.04.22.15.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 15:01:50 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] misc: bcm-vk: add Broadcom VK driver
From:   Scott Branden <scott.branden@broadcom.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dan Carpenter <error27@gmail.com>
References: <20200420162809.17529-7-scott.branden@broadcom.com>
 <202004221945.LY6x0DQD%lkp@intel.com> <20200422113558.GJ2659@kadam>
 <b626e7fe-ae3f-827f-6f5b-2e6639f55775@broadcom.com>
Message-ID: <d9e6d8a0-9e99-e822-8907-e1478c3a7f47@broadcom.com>
Date:   Wed, 22 Apr 2020 15:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b626e7fe-ae3f-827f-6f5b-2e6639f55775@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-04-22 9:13 a.m., Scott Branden wrote:
>
>
> On 2020-04-22 4:35 a.m., Dan Carpenter wrote:
>> On Wed, Apr 22, 2020 at 07:17:34PM +0800, kbuild test robot wrote:
>>> Hi Scott,
>>>
>>> I love your patch! Perhaps something to improve:
>>>
>>> [auto build test WARNING on driver-core/driver-core-testing]
>>> [also build test WARNING on next-20200421]
>>> [cannot apply to char-misc/char-misc-testing kselftest/next 
>>> linus/master v5.7-rc2]
>>> [if your patch is applied to the wrong git tree, please drop us a 
>>> note to help
>>> improve the system. BTW, we also suggest to use '--base' option to 
>>> specify the
>>> base tree in git format-patch, please see 
>>> https://stackoverflow.com/a/37406982]
>>>
>>> url: 
>>> https://github.com/0day-ci/linux/commits/Scott-Branden/firmware-add-partial-read-support-in-request_firmware_into_buf/20200422-114528
>>> base: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 
>>> 55623260bb33e2ab849af76edf2253bc04cb241f
>>> reproduce:
>>>          # apt-get install sparse
>>>          # sparse version: v0.6.1-191-gc51a0382-dirty
>>>          make ARCH=x86_64 allmodconfig
>>>          make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>                                             ^^^^^^^^^^^^^^^^^^^
>>
>> Sorry, you asked me about this earlier.  You will need to add
>> -D__CHECK_ENDIAN__ to enable these Sparse warnings.
> This is strange.  I ran the sparse build and thought I had fixed all 
> the issues.
> I'll have to try again.
>
> One other question with the sparse build.  I get many of the messages 
> printed but the build seems to go to the end (even without my patches 
> applied):
> ./arch/x86/include/asm/paravirt.h:333:9: error: got __inline
> ./arch/x86/include/asm/paravirt.h:338:9: error: Expected ( after asm
> ./arch/x86/include/asm/paravirt.h:338:9: error: got __inline
> ./arch/x86/include/asm/paravirt.h:343:9: error: Expected ( after asm
> ./arch/x86/include/asm/paravirt.h:343:9: error: got __inline
> ./arch/x86/include/asm/paravirt.h:348:9: error: Expected ( after asm
> ./arch/x86/include/asm/paravirt.h:348:9: error: too many errors
>
> Any way to suppress or I am doing something wrong?  I just run the 2 
> make commands:
>
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
I figured out the sparse utility on ubuntu 18.04 is out of date causing 
the issue.
>
>> regards,
>> dan carpenter
>>
>

