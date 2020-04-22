Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E74FC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0899E20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AEltxgy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDVQNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDVQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:13:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62084C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:13:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so1132876plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=haXh/tX3SOSYaN3kdWmh7tZgIKTN2Ame+pI+xos3JF4=;
        b=AEltxgy4q2TsGFOClMObm9b8h2g/JMbN+vHeWIqltddb75/cdCpCAGFLLAgbAI/w9P
         oepX1X1aTof6tPXJ9N0NnlGGmxxI2vEQs+VMHUAQ2ycqjZqEaKU8B81YjNaUzA7FFmmk
         H6uaYVnXPt9Dw11ajIUXpCw78p1shIy/X/9e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=haXh/tX3SOSYaN3kdWmh7tZgIKTN2Ame+pI+xos3JF4=;
        b=JQH5hK17CU1I5XbHsFs01GPaGsSlKMzwI9wRq3mPROqcjWbn6IJ+VIHp3RyiQ5HGMp
         23bi8pXUMkiC+LbzfEa8WZln0xztnczZubtSijBb9keDiMeBLB8SRmCRWYyMbOa3cBek
         zWW6qKpQSWlFKaa5sTXFu8om8YdaoesPwtEs2TNuyMdOqRHEeN5uUOTqVbe45MslwoJj
         KJHYPQqg1wNI9d1BrlUah6Yps3HyWAnKvguO6RGVS9GgPEYArmUP7QEpx9ypC/Woxmug
         /JdSTB9v0Zn9lESFNblzjV/US9FVQw7BZ71UYN+VJx16EydXXj2OwY4L/3NPfYHG7aut
         Mzzg==
X-Gm-Message-State: AGi0Pua3PcxjdWDdOiF2/dhcIRshOHFWrff9yE+No+3SH0Rqyx49XVPa
        sl9WLftw7fcOPsMdNQld3LHgZA==
X-Google-Smtp-Source: APiQypLKRMv51EGdO91pErzP8PP5oDLeOGr+Ipbp7l6ZVumCxGF1jiLK98xv6P2Zls315J2pP9ZwoA==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr26324580plp.272.1587572027787;
        Wed, 22 Apr 2020 09:13:47 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p190sm4192374pfp.207.2020.04.22.09.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:13:46 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] misc: bcm-vk: add Broadcom VK driver
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b626e7fe-ae3f-827f-6f5b-2e6639f55775@broadcom.com>
Date:   Wed, 22 Apr 2020 09:13:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422113558.GJ2659@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-04-22 4:35 a.m., Dan Carpenter wrote:
> On Wed, Apr 22, 2020 at 07:17:34PM +0800, kbuild test robot wrote:
>> Hi Scott,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on driver-core/driver-core-testing]
>> [also build test WARNING on next-20200421]
>> [cannot apply to char-misc/char-misc-testing kselftest/next linus/master v5.7-rc2]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Scott-Branden/firmware-add-partial-read-support-in-request_firmware_into_buf/20200422-114528
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 55623260bb33e2ab849af76edf2253bc04cb241f
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.1-191-gc51a0382-dirty
>>          make ARCH=x86_64 allmodconfig
>>          make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>                                             ^^^^^^^^^^^^^^^^^^^
>
> Sorry, you asked me about this earlier.  You will need to add
> -D__CHECK_ENDIAN__ to enable these Sparse warnings.
This is strange.  I ran the sparse build and thought I had fixed all the 
issues.
I'll have to try again.

One other question with the sparse build.  I get many of the messages 
printed but the build seems to go to the end (even without my patches 
applied):
./arch/x86/include/asm/paravirt.h:333:9: error: got __inline
./arch/x86/include/asm/paravirt.h:338:9: error: Expected ( after asm
./arch/x86/include/asm/paravirt.h:338:9: error: got __inline
./arch/x86/include/asm/paravirt.h:343:9: error: Expected ( after asm
./arch/x86/include/asm/paravirt.h:343:9: error: got __inline
./arch/x86/include/asm/paravirt.h:348:9: error: Expected ( after asm
./arch/x86/include/asm/paravirt.h:348:9: error: too many errors

Any way to suppress or I am doing something wrong?  I just run the 2 
make commands:

         make ARCH=x86_64 allmodconfig
         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

> regards,
> dan carpenter
>

