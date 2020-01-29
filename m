Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE4C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D612064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgA2MWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:22:38 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49599 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgA2MWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:22:38 -0500
Received: from [109.168.11.45] (port=53528 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iwmMd-003SkO-88; Wed, 29 Jan 2020 13:22:35 +0100
Subject: Re: [PATCH v2 01/28] docs: i2c: sort index logically
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <20200123135103.20540-1-luca@lucaceresoli.net>
 <20200123135103.20540-2-luca@lucaceresoli.net>
 <20200124133548.7f01344a@endymion>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <e941cfae-f267-4c0e-b8e2-1dd99fbdb563@lucaceresoli.net>
Date:   Wed, 29 Jan 2020 13:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124133548.7f01344a@endymion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 24/01/20 13:35, Jean Delvare wrote:
> On Thu, 23 Jan 2020 14:50:36 +0100, Luca Ceresoli wrote:
>> The index page currently lists sections in alphabetical file order without
>> caring about their content. Sort sections based on their content logically,
>> according to the following structure:
>>
>>  * Intro to I2C/SMBus and their usage in Linux: summary, i2c-protocol,
>>    smbus-protocol, instantiating-devices, busses/index, i2c-topology,
>>    muxes/i2c-mux-gpio
>>  * Implementing drivers: writing-clients, dev-interface,
>>    dma-considerations, fault-codes, functionality
>>  * Debugging: gpio-fault-injection, i2c-stub
>>  * Slave I2C: slave-interface, slave-eeprom-backend
>>  * Advanced: ten-bit-addresses
>>  * Obsolete info: upgrading-clients, old-module-parameters
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>>
>> ---
>>
>> Changes in v2:
>>  - split sections in groups (suggested by Jean Delvare)
>>  - remove consecutive blank lines (reported by Jean Delvare)
>> ---
>>  Documentation/i2c/index.rst | 59 ++++++++++++++++++++++++++++++-------
>>  1 file changed, 48 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
>> index a0fbaf6d0675..f0f3b9c97abb 100644
>> --- a/Documentation/i2c/index.rst
>> +++ b/Documentation/i2c/index.rst
>> @@ -4,30 +4,67 @@
>>  I2C/SMBus Subsystem
>>  ===================
>>  
>> +Introduction
>> +============
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   summary
>> +   i2c-protocol
>> +   smbus-protocol
>> +   instantiating-devices
>> +   busses/index
>> +   i2c-topology
>> +   muxes/i2c-mux-gpio
>> +
>> +
> 
> You still have a double blank line here, not sure if this is intended?

It's not intended. Thanks for double checking!

I fixed this patch as well as patch 11. v3 on its way.

-- 
Luca
