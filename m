Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCBC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564C921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCIPlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:41:24 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:49707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCIPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:41:24 -0400
Received: from [192.168.178.72] ([109.104.48.84]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbXu-1ium9B35Dg-00Kyek; Mon, 09 Mar 2020 16:41:09 +0100
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wahrenst@gmx.net
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
 <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
 <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
 <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
 <f2ec22160ac86aec8d252ade7d6eb8789777cc42.camel@suse.de>
 <01ceb60e-a791-b6ca-352e-ad2e79f264e3@i2se.com>
Message-ID: <ddcb8fd5-9e35-454c-b38d-d36e7b41ef07@i2se.com>
Date:   Mon, 9 Mar 2020 16:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <01ceb60e-a791-b6ca-352e-ad2e79f264e3@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:bO13uPSY3dmn10K0yyew7rJcTEabzPG7iig+bLHIqMdpoENbY+b
 i5HPjy0tu/jYA0LrpGE+k0GsKdKtgwqmRIj9y1ptLNcbLmd9N+F9KEFtjZGij4I37XblbUq
 fqQ9peqnPWdyim6yKiTK7tFw2kP8moAwNhgBKv4YRUmkoVKcXCSVJOt2Luvm0g26hOIMQIV
 NLsBaNij49eW2oy8Oes0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x2sZWdZtJyo=:I/UXkQxEboRRIvWWiPhTa0
 VMx+4afGgdfVE7WafXkNF9ptPv3Ds9xntQBroxJRda+hEKq19GQxZ4iLEiT6P1eaWkc+8gxE6
 I/4azArlMrE8SO8Kr97+j0xAS+lZ7TyFoUtjw40Vl/JptNfNjZTx/gEVMiuXar3qTXPFoy5fC
 w4drlHOMVBo4nST9iA2cAOTO0MrWHT8IQSt8NY/0ESe8lervSYyr5B6+iZ88X7gs5MMDQnwm0
 F/xmt4Rs4tN6xHN5u3WDF3P4uijVgswW+LIIClb6xrdr4iaAtJnEoHA7hIDmcYzm2xi3nXqHS
 w3ZzTdaLbPqjrU88ATC2htvx1WXcX4vLly8+pk9IYtGY6ugUui47lqGGxrdQp826YEf5n9Gdg
 cLpWITFvZScth3CGKANFdcCb5iwr86D024EzDIyioXO87pW2loOedI2sR8APOzbUkySsUmBfp
 z3nzZd9a6Zsl25bhfwPlee67S0AL/PAj0dHftkZjYbt+Ej/qC1YdRg86KAV1P8/E9opufkKXZ
 yUJmRcph+DYgMJbBTJkzPq86wWLmvCZtACs1I0ypq4w8FtJKBiSAtht2Y8kiKSct3JDPDJk87
 0YepSuA9fHWuzB7tTJxS4tmm+9yZ8OuP//2cg1Jrtlh+YYe2z2HnfVkhviyNbd1xP0cIG2xYG
 2MoYu9IE89vaDn1cNl4iS+jSUK1ktzsIVDQRy88mWLKW0fwJl4AEAaVFayaLfeywknATWUhhg
 i2FvWKMqHWdtYJlgOp18OsR79VSww0K4QQLkKWsyRlcVT9xG6InshXOYiMJlERrw8frm7X0oJ
 xz4GcfbDOOZXkqa4d35peC4wd2ecz5UicCRzKeKd499dIH+CoJwM4v+g06yUPzL+wgx+OX+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 06.03.20 21:33, Stefan Wahren wrote:
> Hi Nicolas,
>
> Am 05.03.20 um 11:44 schrieb Nicolas Saenz Julienne:
>> Hi Stefan,
>>
>> On Tue, 2020-03-03 at 20:24 +0100, Stefan Wahren wrote:
>>>>>> Note: I tested this on RPi3b, RPi3a+ and RPi2b.
>>>>> as i already wrote this prevent X to start on current Raspbian on my
>>>>> Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be careful here.
>>>>>
>>>>> I will take a look at the debug UART. Maybe there are more helpful
>>>>> information.
>>>> It seems we're seeing different things, I tested this on raspbian
>>>> (multi_v7_defconfig) and on arm64. I'll try again from scratch tomorrow.
>>> My modifications to the Raspbian image (from 13.2.2020) are little:
>>>
>>> - specify devicetree to config.txt
>>> - change console to ttyS1 and remove "silent" in cmdline.txt
>>> - rename all original kernel7*.img
>>> - copy dtb and kernel7.img to boot partition
>>> - copy kernel modules to root partition
>> Would you mind retesting with the latest linux-next? I validated an image based
>> on 5.6.0-rc4-next-20200305-00001-g285a7a64cd56 and a fresh raspbian download on
>> RPi3a+ without X issues.
> i retested with todays linux-next and the issue persists on my RPi 3A+ /
> HP ZR2440w with this patch applied.

I tested my display with a RPI 3B, 3B+ and a Zero W. All of them had the
same issue. Btw i used this display the last years for testing the
Raspberry Pi.

After that i connected the RPI 3B to my TV screen and it works with the
patch applied.

>
> I will try more hardware combinations tomorrow to see, this issue is
> more board or display related.
>
> Best regards
> Stefan
>
>
