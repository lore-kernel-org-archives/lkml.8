Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797FDC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D04D21532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNwlXdbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgIGRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbgIGRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:44:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E1C061573;
        Mon,  7 Sep 2020 10:44:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so13526816edk.0;
        Mon, 07 Sep 2020 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AKtE0f3df7stLoOpg6l1Dc/R8Dgd/mB97dSaL3OrIPw=;
        b=YNwlXdbPXE0UJdb1nCQVOqATN2iWszAu1rl+rnqPTZLoJBxKgNxrlwbVj9Uv1NXHIn
         nZAbLfNkYv4/COWXQLR05TCpsNSDVzvkEaBjUezt3YqpfbofrO53hLSE9i2/OUY0yfUk
         aM/s4B1xRhzRDtkKEM5tV6Pa+BcPV0WyAFfq6wOKzYNkDcY8qHi5qJk0faJtAo8A5ZqG
         4AX/1nmXtUsas8S5QUrkDKgkrrrBrAvkN0Pi9ZdrtPLvX8REjGs6Vw9VCo6HaUjGuj2w
         C9R5KoZZ2UrevHnYMO/uYdGOjsBP7ddxY+W7DEyldYco2ay78NxJiiilIi7fCCq9kH5P
         0/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKtE0f3df7stLoOpg6l1Dc/R8Dgd/mB97dSaL3OrIPw=;
        b=k7a/CPu04Ut08ckneJIGyBdSMJFQIYg3q1MyQwBROMQIUxM5aUxpfQn+rYv0ooj3OL
         OVCR5RL5qqZEAZYmG12Gbj1fd2mWPxk+fvs/KkBiBa3F508IU8simtB0ZA/42EQYJq79
         6/M5WwpIiv2PBVF2/cAgmmlR7i07aJAF+xOZBg9HolBY7Pr7tawPPLqgev3FPXN4nwFj
         HrOVIr54/8BNiDFn053YWx4QG9spqO1MGXPKCgZSew2rxFFJCmu98M8z192N+lfODK9A
         05rN22Zg5EbYj6XC6zy/WdINUmK4yHgIoV0l/ikgWCdPUZRf0MD7QtPDBbRo2R2uSuWl
         7Uqg==
X-Gm-Message-State: AOAM533/OZ4K8muNVxCMs8Mehk/C/Av62L6eFvQP+nAEyHffbs1iONIP
        S+dYhe+7vemNwHay4IdpUoyZ/oUWsBmNbA==
X-Google-Smtp-Source: ABdhPJyIVQAd1ibjCqlfSC4NnSs5F3EYyXoYchNzk4W9Yrd1xOME9VDIBgcuxR2fKAJeYpSobINVHA==
X-Received: by 2002:aa7:ce97:: with SMTP id y23mr23412501edv.128.1599500660739;
        Mon, 07 Sep 2020 10:44:20 -0700 (PDT)
Received: from bcbook.internal (a89-183-24-75.net-htp.de. [89.183.24.75])
        by smtp.gmail.com with ESMTPSA id dt8sm15377533ejc.113.2020.09.07.10.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 10:44:20 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
 <20200907174200.yqojaguthi6khn3v@pali>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <9c0e3c31-866d-d53a-5a5c-d66e2da27f6c@gmail.com>
Date:   Mon, 7 Sep 2020 19:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907174200.yqojaguthi6khn3v@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 19:42, Pali Rohár wrote:
> On Monday 07 September 2020 19:13:41 Andre Heider wrote:
>>> @@ -120,7 +124,7 @@
>>>    			#address-cells = <1>;
>>>    			#size-cells = <0>;
>>> -			port@0 {
>>> +			switch0port0: port@0 {
>>
>> This label is unused it seems.
> 
> Yes, it is unused, but I defined labels for all ports so it would be
> clean that ports are indexed from zero and not from one. Also it looks
> inconsistent if some of DSA ports have labels and some does not.

Alright, sounds good:
Reviewed-by: Andre Heider <a.heider@gmail.com>

> 
>>
>>>    				reg = <0>;
>>>    				label = "cpu";
>>>    				ethernet = <&eth0>;
>>> @@ -131,19 +135,19 @@
>>>    				};
>>>    			};
>>> -			port@1 {
>>> +			switch0port1: port@1 {
>>>    				reg = <1>;
>>>    				label = "wan";
>>>    				phy-handle = <&switch0phy0>;
>>>    			};
>>> -			port@2 {
>>> +			switch0port2: port@2 {
>>>    				reg = <2>;
>>>    				label = "lan0";
>>>    				phy-handle = <&switch0phy1>;
>>>    			};
>>> -			port@3 {
>>> +			switch0port3: port@3 {
>>>    				reg = <3>;
>>>    				label = "lan1";
>>>    				phy-handle = <&switch0phy2>;
>>>
>>

