Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79956C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C117208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGCwG1Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgIGRu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgIGRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:50:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D09C061575;
        Mon,  7 Sep 2020 10:50:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g4so13541585edk.0;
        Mon, 07 Sep 2020 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gGQvma3nuTyV30O0fS82yIIMXNwAZqpMzL1inVOBxj4=;
        b=XGCwG1Z2WhE6UQB2Gd6Nad0mHac2b18Vnwv77jPr3By13c0IMK8gvuclW1VW9fS+h3
         0HHSOTlUH7fEEO4FG0AuejAaxBO+WFqITVDW2mZroL1v0GuZdPSK6GV0iOJKaryKVgHd
         lE8KfZeXi7K9OqhuBCAJbMDTvd8sIJTU/I0z4UbVhVM4L9EuSIcl0KBxkMyLjtsvRl+c
         vc6wer6PEzK1iTS/sOdY5NdC2KSDhTWZMDvfdDHEjFUYj9o/9++fxqUrvRRUOQdcpQpG
         KSWZZVIp73AZjXJ20PoYB0SDmKQ+boxjhPE/+MPjSFM7Ucfcr3DI4fQo8SSQ3I7h2FDU
         ryVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gGQvma3nuTyV30O0fS82yIIMXNwAZqpMzL1inVOBxj4=;
        b=ZGO6lNOrw4tgS58NQG3PBp5lLn492FunmVVa31qWt34T1U0q9cJmkbdLwWWAn3dumr
         +sn5xSOeeaoiZ/90KUoy7OwDM6ZY/q9Uw72LhAKLNzU0We/3PTgMo9blvfExfeK7vtms
         1a9b781Ok6is1UqFIfRaPxvhW5kyrfosYyRH7lmciS23WJmKZ7Y4Wwv/lLhE5+66gQ24
         0b75f3JBgeX92GNzE2pUvJu37Rq/WJmrf8rQ8Bu64lmQSYzsSfJDVyOU09GoEfbQ6Nf8
         +RwH3kIiu69ihcQEH2ZcS5NqkAF4CqSAAPoPdW75RXph5Ya5YJuDaSkbjxZGfSL7IQVj
         CRfA==
X-Gm-Message-State: AOAM530mH4BB+jnvAIA9j//TQUBYd8LnHfBU62/E9EsiYu5HQW/TWXqy
        ygpp4hDzyC7v2Yvc5KixS37vP+qFMLyrvw==
X-Google-Smtp-Source: ABdhPJyIYPLmgopLV56/2IHBu3wOSWeGmQ5jBx1w5BHnUPJhoC7ADTfKz8tjYbv+NpZMrwQo5Sstww==
X-Received: by 2002:aa7:d296:: with SMTP id w22mr22982033edq.327.1599501049279;
        Mon, 07 Sep 2020 10:50:49 -0700 (PDT)
Received: from bcbook.internal (a89-183-24-75.net-htp.de. [89.183.24.75])
        by smtp.gmail.com with ESMTPSA id bm2sm13423993edb.30.2020.09.07.10.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 10:50:48 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
 <20200907172303.GA3254313@lunn.ch> <20200907173534.aoupftjkxgcftfqo@pali>
 <f8cce9af-372b-f2bc-ea09-e1516367cb90@gmail.com>
 <20200907174705.clknw4375smvt47o@pali>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <97cce972-201f-dc54-644d-37bbbf369632@gmail.com>
Date:   Mon, 7 Sep 2020 19:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907174705.clknw4375smvt47o@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 19:47, Pali Rohár wrote:
> On Monday 07 September 2020 19:43:08 Andre Heider wrote:
>> On 07/09/2020 19:35, Pali Rohár wrote:
>>> On Monday 07 September 2020 19:23:03 Andrew Lunn wrote:
>>>>> My dts-foo is a little rusty, but now that you labeled the ports in the
>>>>> .dtsi, can this whole "switch0" block reduced to something like:
>>>>>
>>>>> &switch0port1 {
>>>>> 	label = "lan1";
>>>>> };
>>>>>
>>>>> &switch0port3 {
>>>>> 	label = "wan";
>>>>> };
>>>>
>>>> Probably yes.
>>>>
>>>> But that is definitely too much for stable.
>>>
>>> Yes, this suggested change is not for stable, but looks like a nice
>>> cleanup. So it could be done in followup patch.
>>>
>>> Andre, are you going to prepare and test this followup change?
>>
>> I can prep the patch if you like, but the suggested cleanup only affects the
>> v7 dts files. I don't have that hardware version to test it, so could only
>> send an untested patch.
> 
> As a result of this cleanup should be binary DTB file for V7 with same
> structure as DTB file without such cleanup patch, right? And this test
> (structure / content of compiled file) does not need particular hardware.

Ok, will do.

