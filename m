Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A7C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154E020C09
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjUD9XGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgIDUy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgIDUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:54:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69346C061244;
        Fri,  4 Sep 2020 13:54:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so3581079pjr.4;
        Fri, 04 Sep 2020 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=abXcuEUelaj9kxffdNgxgkoV1UDpFrtIAbheN4tXg6Y=;
        b=MjUD9XGWDb7ARm4xrJcPEGBgTYvNRkRiSvqGhEaTKOrW4rBB8sVqG5MBbkI2phyN4o
         7yTnbqjZuzkMyRqA4TUdFNdY178yzkzMtMfYe4arAzhh5ijFxM3YJJKYma+LPUu7KzGS
         y5hkFicJD2hpdlLwheSREDDWfa+dHThrj0wkaHdE9v5aCh/xV9ZrNuejO0jgTW0+9Ue2
         Uk7Rsih6iAlijQDhjF/QSEQ6/nFOCYcILDLNXz0VEssEl83d6hc0QuHoGs/8gncjOdN5
         zFEhLFfj8V+X+vGa4BFAs7bDHelStmIVZtVc5icOgvtlcS183C3ZahUsEktjCa3OaW5r
         YlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abXcuEUelaj9kxffdNgxgkoV1UDpFrtIAbheN4tXg6Y=;
        b=QVx1/dD7I2dtwJUXEIq+8IwQGrVFDyBVIM+FTUOclrqjZMiu5xfPEj8D+oJEBjO1Wy
         zx/Vo7q7sNOvM7G0ZrnVTB2gL126qPnQbgMLOD11CBzyeFp+D8I1ZRbwGf4hIAeqcihq
         SWcQoX+FnfXXLRFSuL7N591N1POmQ4Uwrm4+69huxDCh/LuuXp/4HfVaer6S644D4P1Y
         cmUCukpdVkRHUVIRNXP0ToDhxGyIm3PUgECR9hwsOX1R3kB1DtPSYFMDDBejAAkNetbz
         7PV4IeoXVwZYKJ9H/6vg33+JfcGasXOOIO7OQP9fV2sjeLaKXlgFAnuMf6wJMt3v9Y7Z
         ZcdQ==
X-Gm-Message-State: AOAM530RPCmtOWaTY/I8ToxbVywDhc1RMHxzaDwPF4GaHiLf/RKJbBrT
        Y7b6rLzAMyBh62uGJqU1iMQ=
X-Google-Smtp-Source: ABdhPJxJ6ot2ilr+8tMqsPOWyHdLeHwQu3tqvkP5f90llfzb9zNv6wMSwMXT9HDCVhojW1D3lJE95w==
X-Received: by 2002:a17:90a:890b:: with SMTP id u11mr9534847pjn.114.1599252894971;
        Fri, 04 Sep 2020 13:54:54 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y203sm7807877pfb.58.2020.09.04.13.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:54:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] ARM: dts: NSP: Fix SP804 compatible node
To:     =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200828142018.43298-1-andre.przywara@arm.com>
 <20200828142018.43298-4-andre.przywara@arm.com>
 <73b35bcd-0e8c-0f62-ed2b-e0c64261f930@gmail.com>
 <c97c1472-c308-27e2-ce68-30bc82b96aae@gmail.com>
 <98cdc873-e36a-c47d-6eaf-cc4e023f977c@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8d428e29-9931-2b15-a150-6b0fc90c3ba8@gmail.com>
Date:   Fri, 4 Sep 2020 13:54:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <98cdc873-e36a-c47d-6eaf-cc4e023f977c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2020 6:04 PM, André Przywara wrote:
> On 02/09/2020 00:04, Florian Fainelli wrote:
> 
> Hi Florian,
> 
> sorry, the mail got swamped in my inbox...
> 
>> On 8/28/2020 10:12 AM, Florian Fainelli wrote:
>>> On 8/28/20 7:20 AM, Andre Przywara wrote:
>>>> The DT binding for SP804 requires to have an "arm,primecell" compatible
>>>> string.
>>>> Add this string so that the Linux primecell bus driver picks the device
>>>> up and activates the clock.
>>>>
>>>> Fixes: a0efb0d28b77 ("ARM: dts: NSP: Add SP804 Support to DT")
>>>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>
>>> This looks fine, however there is a ccbtimer1 instance that you missed,
>>> can you resubmit with it included?
>>>
>>> With that:
>>>
>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> Andre are you going to resubmit a patch with the second instance
>> (ccbtimer1) fixed as well, or should I take care of that while applying
>> the patch? Either way is fine, just let me know.
> 
> So I was waiting for more comments, but there was nothing so far that
> justifies a new version. So would you mind fixing this while applying? I
> must have indeed missed this instance while diffing before and after.

Applied and fixed up the ccbtimer1 node, thanks.
-- 
Florian
