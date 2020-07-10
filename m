Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C882070E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGJCJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:09:00 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:50472 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJCI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:08:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id EDF1720160C8;
        Fri, 10 Jul 2020 10:08:56 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aottJ6C8Q-Yh; Fri, 10 Jul 2020 10:08:56 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id CC1E220160B5;
        Fri, 10 Jul 2020 10:08:56 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.79])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 87C61C01FBA;
        Fri, 10 Jul 2020 10:08:56 +0800 (HKT)
Subject: Re: [PATCH v4 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200708040748.9014-1-chris.ruehl@gtsys.com.hk>
 <20200708040748.9014-3-chris.ruehl@gtsys.com.hk>
 <20200709165107.GB498064@bogus>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <21a3f5a0-6f66-33d2-6def-725743cc67e3@gtsys.com.hk>
Date:   Fri, 10 Jul 2020 10:08:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709165107.GB498064@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/7/2020 12:51 am, Rob Herring wrote:
> On Wed, Jul 08, 2020 at 12:07:47PM +0800, Chris Ruehl wrote:
>> Add documentation for the newly added DTS support in the shtc1 driver.
>> To align with the drivers logic to have high precision by default
> 
> If 0x70 is the only address, then do:
> 
> reg:
>    const: 0x70

yes, that make sense.

> 
>> +
>> +  sensirion,blocking_io:
> 
> s/_/-/

done!

>> +
>> +examples:
>> +  - |
>> +    i2c1 {
>> +      status = "okay";
> 
> Don't show status in examples.

Thanks for your advice.

updated and patch set v5 is out soon.

Chris
