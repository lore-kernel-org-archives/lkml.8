Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF42C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FC320738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGHD2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:28:03 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:43594 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:28:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 728B02000305;
        Wed,  8 Jul 2020 11:28:00 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ok6ktCoPkYuW; Wed,  8 Jul 2020 11:28:00 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 4F28220001F5;
        Wed,  8 Jul 2020 11:28:00 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.79])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id A46BDC01B68;
        Wed,  8 Jul 2020 11:27:59 +0800 (HKT)
Subject: Re: [PATCH v2 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jack Lo <jack.lo@gtsys.com.hk>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
References: <20200705034727.1429-1-chris.ruehl@gtsys.com.hk>
 <20200705034727.1429-3-chris.ruehl@gtsys.com.hk>
 <20200707201532.GA558059@bogus>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <713b05fa-b025-4869-7dee-b1b6af4fbd26@gtsys.com.hk>
Date:   Wed, 8 Jul 2020 11:27:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707201532.GA558059@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2020 4:15 am, Rob Herring wrote:
> On Sun, 05 Jul 2020 11:47:26 +0800, Chris Ruehl wrote:
>> Add documentation for the newly added DTS support in the shtc1 driver.
>> To align with the drivers logic to have high precision by default
>> a boolean sensirion,low_precision is used to switch to low precision.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml:  while parsing a flow mapping
>    in "<unicode string>", line 43, column 9
> did not find expected ',' or '}'
>    in "<unicode string>", line 47, column 14
> Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> Makefile:1347: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> 
> See https://patchwork.ozlabs.org/patch/1322963
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

Rob,

I installed now latest scheme and run dt_binding_check, its clean now.
..
"CHKDT   Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
"CHKDT   Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
..

Will be submit with v4 of the patch set.

Thanks.
Chris
