Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3382FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EADB22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHGG1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:27:53 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:56928 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGG1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:27:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 8CDF320139AA;
        Fri,  7 Aug 2020 14:27:50 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9WOy95z1dk9E; Fri,  7 Aug 2020 14:27:50 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 69B1220139A7;
        Fri,  7 Aug 2020 14:27:50 +0800 (HKT)
Received: from [10.128.2.32] (unknown [203.145.95.159])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 36D4DC019FB;
        Fri,  7 Aug 2020 14:27:49 +0800 (HKT)
Subject: Re: [PATCH v6 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
References: <20200712044411.23323-1-chris.ruehl@gtsys.com.hk>
 <20200712044411.23323-3-chris.ruehl@gtsys.com.hk>
 <20200713150022.GA175274@bogus>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <f2b6ed1d-4109-15a9-349d-e6d2dd59b175@gtsys.com.hk>
Date:   Fri, 7 Aug 2020 14:27:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713150022.GA175274@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

sorry for late reply, I have my head in setup production install the dt-schema
and rerun the check, with 2020-6 no warnings lets fix it.

Chris

On 13/7/2020 11:00 pm, Rob Herring wrote:
> On Sun, 12 Jul 2020 12:44:10 +0800, Chris Ruehl wrote:
>> Add documentation for the newly added DTS support in the shtc1 driver.
>> To align with the drivers logic to have high precision by default
>> a boolean sensirion,low_precision is used to switch to low precision.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 57 +++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:24.13-26: Warning (reg_format): /example-0/i2c1/shtc3@70:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:22.20-26.13: Warning (avoid_default_addr_size): /example-0/i2c1/shtc3@70: Relying on default #address-cells value
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:22.20-26.13: Warning (avoid_default_addr_size): /example-0/i2c1/shtc3@70: Relying on default #size-cells value
> Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
> 
> 
> See https://patchwork.ozlabs.org/patch/1327453
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
