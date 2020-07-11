Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 23:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A5720731
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 23:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGKX7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 19:59:08 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:53228 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgGKX7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 19:59:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 45DBA200080F;
        Sun, 12 Jul 2020 07:59:05 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mk8KdIFMvSK7; Sun, 12 Jul 2020 07:59:05 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1F2C6200029E;
        Sun, 12 Jul 2020 07:59:05 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.79])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id BF109C019F4;
        Sun, 12 Jul 2020 07:59:04 +0800 (HKT)
Subject: Re: [PATCH v5 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jack Lo <jack.lo@gtsys.com.hk>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org
References: <20200710021536.27544-1-chris.ruehl@gtsys.com.hk>
 <20200710021536.27544-3-chris.ruehl@gtsys.com.hk>
 <20200710163153.GA2760091@bogus>
 <d45ba090-a09b-dd51-4645-bc62e90cb9bc@gtsys.com.hk>
Message-ID: <4189dcf7-fc67-29c4-6357-646071d7ded0@gtsys.com.hk>
Date:   Sun, 12 Jul 2020 07:59:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d45ba090-a09b-dd51-4645-bc62e90cb9bc@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning,

On 11/7/2020 6:05 pm, Chris Ruehl wrote:
> 
> On 11/7/2020 12:31 am, Rob Herring wrote:
>> On Fri, 10 Jul 2020 10:15:35 +0800, Chris Ruehl wrote:
>>> Add documentation for the newly added DTS support in the shtc1 driver.
>>> To align with the drivers logic to have high precision by default
>>> a boolean sensirion,low_precision is used to switch to low precision.
>>>
>>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>>> ---
>>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 57 +++++++++++++++++++
>>>   1 file changed, 57 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>>
>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> Error: 
>> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:25.13-14 
>> syntax error
>> FATAL ERROR: Unable to parse input tree
>> scripts/Makefile.lib:315: recipe for target 
>> 'Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml' failed
>> make[1]: *** 
>> [Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> Makefile:1347: recipe for target 'dt_binding_check' failed
>> make: *** [dt_binding_check] Error 2
>>
>>
>> See https://patchwork.ozlabs.org/patch/1326414
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure dt-schema is up to date:
>>
>> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>>
>> Please check and re-submit.
>>
> 
> Hi Rob,
> 
> I did run the test and didn't had any Error. dt-schema 2020.06 installed from 
> git. pip3 install -e.
> 
> Can you help?
> 
> Chris

Solved, missing ";" behind reg = <0x70>

will resend.
