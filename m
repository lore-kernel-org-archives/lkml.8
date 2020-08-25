Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D35C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40B120639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX/N1OKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHYBoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:44:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC469C061574;
        Mon, 24 Aug 2020 18:44:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p25so9650662qkp.2;
        Mon, 24 Aug 2020 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fe927XpL2PIePdhPHFFj/u8541ev56/XnVnreXE8fcA=;
        b=HX/N1OKrA8nEMk3KbUEGSvsgJXZ66O7ArZQanOXFOKHFH8g7LzDX5NWzYGBbnI4zqb
         wP/IPSnUx2tg3MWVN4Ne+z9knP4ww4AEfToG0KsNZ97q2dlx8nXbeMGKb4YPhBF0A0Ll
         LT95u8c0hezhD1w3n4NBTdZBIxX+JLWz61pYBjdJbCQWKRYaQpTZPiZb3BwAFQYjGy8F
         9vnLIe/apvqKzKbtJ9u1PxCsJR6PkpL/Ci3pseZ+uf10Aud4uHGG2YmfMnDbcwh6rslx
         7ZMxPfKPfG++eIn2HooOWbMIz4qZg+r5jrRN9f5c/pYpbM/6iW59prbe2M1dzF0qfPMi
         9rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fe927XpL2PIePdhPHFFj/u8541ev56/XnVnreXE8fcA=;
        b=okw+rdYvEitv9/FgNwTV8oIOHA7PkcWQDE7d03dpC5HulcZTxZNjDK3YeMeDhOEUQB
         E2VpiEoS43udaZDEzDHLhYlppg32+wti4wBcSJ6FZuheI5lttAk7+hNsRopJKkevXWg/
         xvHQv/PyRGA0sGy1TvXiozzEgJ84UTLhXBWay7ulAkhBtb/dnSMzuHjyKyT0A2S/iPF/
         6ArkcsQiaJ3lakag2SL4K91YIa3cNqpuFt9r2wJLfX5CkLh7LLYHgrTYCCTrphu6i67Y
         Z7tUSyYQHUMVEFvoCSJHiBsSre2TbBi9WCSTHcMMEFpy6GaEkn6jMb97I8vGDHpiuLCe
         J2uQ==
X-Gm-Message-State: AOAM530c6oZblmXoTWbCL7dGo8mthBCsp9VtqFdAZ3J5JUP918zETObP
        9H0H0iDWo5Ircthdth98LK9x9eNE7qHwGQ==
X-Google-Smtp-Source: ABdhPJxfn+TI8Y9xjJ/3Gk+yyNnj1KyvdpFFZDtO8DBbk/jj8iJP37pLpb5GHc24Due3eBVDeYBEQA==
X-Received: by 2002:a37:98d:: with SMTP id 135mr7246102qkj.384.1598319856217;
        Mon, 24 Aug 2020 18:44:16 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id u16sm6625694qkm.121.2020.08.24.18.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 18:44:15 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
To:     Vaishnav M A <vaishnav@beagleboard.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     robh@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
 <d53f0014-db7c-902c-70c7-eacac41cc6ed@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <cc4fc632-caf0-93d8-804f-431ec053133d@gmail.com>
Date:   Mon, 24 Aug 2020 20:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d53f0014-db7c-902c-70c7-eacac41cc6ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav,

Apologies in advance -- I expect to be very slow in responding this
week.  Linux Plumbers will take some of my time and I am moving to
a new home.

-Frank


On 2020-08-18 15:38, Frank Rowand wrote:
> Hi Vaishnav,
> 
> +me +devicetree
> 
> Please add these two recipients to future versions.
> 
> I will comment more after reading the first version and v2.
> 
> -Frank
> 
> 
> On 2020-08-18 07:48, Vaishnav M A wrote:
>> Hi,
>>
>> This Patch series is an update to the mikroBUS driver
>> RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .
>> The mikrobus driver is updated to add mikrobus ports from device-tree
>> overlays, the debug interfaces for adding mikrobus ports through sysFS
>> is removed, and the driver considers the extended usage of mikrobus
>> port pins from their standard purposes.
>>
>> change log:
>>         v2: support for adding mikroBUS ports from DT overlays,
>>         remove debug sysFS interface for adding mikrobus ports,
>>         consider extended pin usage/deviations from mikrobus standard
>>         specifications,
>>         use greybus CPort protocol enum instead of new protcol enums
>>         Fix cases of wrong indendation, ignoring return values, freeing
>>         allocated resources in case of errors and other style suggestions
>>         in v1 review.
>>
>> Vaishnav M A (3):
>>   add mikrobus descriptors to greybus_manifest
>>   mikroBUS driver for add-on boards on mikrobus ports
>>   Add Device Tree Bindings for mikroBUS port
>>
>>  .../bindings/misc/linux,mikrobus.txt          |  81 ++
>>  MAINTAINERS                                   |   6 +
>>  drivers/misc/Kconfig                          |   1 +
>>  drivers/misc/Makefile                         |   1 +
>>  drivers/misc/mikrobus/Kconfig                 |  16 +
>>  drivers/misc/mikrobus/Makefile                |   7 +
>>  drivers/misc/mikrobus/mikrobus_core.c         | 692 ++++++++++++++++++
>>  drivers/misc/mikrobus/mikrobus_core.h         | 191 +++++
>>  drivers/misc/mikrobus/mikrobus_manifest.c     | 444 +++++++++++
>>  drivers/misc/mikrobus/mikrobus_manifest.h     |  21 +
>>  drivers/misc/mikrobus/mikrobus_port.c         | 171 +++++
>>  include/linux/greybus/greybus_manifest.h      |  47 ++
>>  12 files changed, 1678 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt
>>  create mode 100644 drivers/misc/mikrobus/Kconfig
>>  create mode 100644 drivers/misc/mikrobus/Makefile
>>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
>>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
>>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
>>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
>>  create mode 100644 drivers/misc/mikrobus/mikrobus_port.c
>>
> 

