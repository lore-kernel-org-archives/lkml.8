Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F37C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B3920880
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr+YU/ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgAJWHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:07:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41064 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgAJWHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:07:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so3665324ljc.8;
        Fri, 10 Jan 2020 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ueIAxuwE1NrUjrVJsYu2PJWCZzJduGj9FbSfPr3jwpk=;
        b=Tr+YU/uxs+T+sEeXOIt2e5jvdiaiE0Nr4HuPRsUPSol46828WaEPO57aToaLRmoCvf
         K8ik/Qp+6W7Wjj81DSS0ThiuOCuvlnbGuIa0QL1uQ6P0fkixm71v8tYukqH50QLrZvPN
         5twT9iBxovm/eyjlo7xjLoWYvii0sar3tq6YhRGkxSk0p9zIrS36DQD8y5GJcXMfHOBe
         xjIPKdqZUt2DtBkB5aLzIH9d+GWcQnPn5eMyZa6EJtAM5nA9ZNuKcfnNOdk2Pgd1oThL
         bEHgA70Ty4110yQPcp4+YTVUW4ggQdN6xGhTI/uhXbBzMKIKc/s/R9znGTuGDSQDAPQ0
         krRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ueIAxuwE1NrUjrVJsYu2PJWCZzJduGj9FbSfPr3jwpk=;
        b=mr+TO0ZL4YESIf1Y2P4l/u+fIPSAhhEoQ3Q8tx1n2U+20bZLEDgIa02p+hAJcf8SLI
         MJgMNDpSBfa9JxDHcmFFCLKDAtL/ItfhmSvs2eZFZagluPk2iFWYIigKJSF63sZbHKsR
         /fmebpKjzJdMqp31s6QwRTHRvXB7LnnXAJGIiNuRS2I6zC/bJuMjeMjMNtKJ+UNJwxDN
         f/ds2voub/8j3HlLedJwjZlvU9wuYI992bRpjme9S4FllDtr0J4aEfEIuf72H5uURxRN
         2DAdhhTCy7QhGYekE3bqVZa52oARpcPt36QB9B/9AdkKIfTdbWVzqjlKDQFoASRCxphG
         ZnvA==
X-Gm-Message-State: APjAAAWgUxfosBXFlpIIkdyD1XHbmHZN2cSbCtN0KZntEtNEqyTazAle
        c1nnbxtcHlFTNvI3xjUzLRfvQ0HQ
X-Google-Smtp-Source: APXvYqzq2Z13eusUV9C8wDnsxgZ/nIaeOnaeHgNoLTcop/geJplygcZlA6iM48HOmLiOgbdu99+LuA==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr4100501lji.214.1578694051389;
        Fri, 10 Jan 2020 14:07:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id o69sm1701360lff.14.2020.01.10.14.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 14:07:30 -0800 (PST)
Subject: Re: [PATCH v3] regmap: add iopoll-like atomic polling macro
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1578546590-24737-1-git-send-email-spujar@nvidia.com>
 <fa5198bf-0001-3a57-017f-1b40e0188606@gmail.com>
 <b9f5459f-007e-3139-a3cf-c7dfd3fc335a@nvidia.com>
 <e1ab2304-2ef8-c50d-d9c7-21569b397c23@gmail.com>
 <b14d6130-8a9e-28ac-3ce6-dc6b9e3a3886@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b13b2e54-f867-d35b-c294-bfa8fbc5a6b7@gmail.com>
Date:   Sat, 11 Jan 2020 01:07:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b14d6130-8a9e-28ac-3ce6-dc6b9e3a3886@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.01.2020 07:50, Sameer Pujar пишет:
> 
> On 1/9/2020 7:27 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.01.2020 10:24, Sameer Pujar пишет:
>>> On 1/9/2020 11:30 AM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 09.01.2020 08:09, Sameer Pujar пишет:
>>>>> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
>>>>> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
>>>>> is atomic version of already available 'regmap_read_poll_timeout'
>>>>> macro.
>>>>>
>>>>> It should be noted that above atomic macro cannot be used by all
>>>>> regmaps.
>>>>> If the regmap is set up for atomic use (flat or no cache and MMIO)
>>>>> then
>>>>> only it can use.
>>>>>
>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>> ---
>>>> Could you please explain what is the targeted use-case here?
>>> I was trying to use regmap_read_poll_timeout() to poll for status change
>>> of a register. This resulted in "BUG: scheduling while atomic". The
>>> callback function, in which I was trying to use the macro, runs in
>>> atomic context. Hence new atomic macro is added. I was checking ALSA
>>> playback/capture and trigger() callback had to monitor some register
>>> status.
>>>
>>> In general, the new macro can be used in atomic callbacks where regmap
>>> interface is used and polling is required.
>>>
>> You should send a full patchset because it may turn out that the patch
>> which makes use of the new feature isn't correct or maybe the new
>> feature isn't really needed.
>>
>> If there was a previous discussion about the need for this change, then
>> you should provide a link to that discussion.
>>
>> Please note that usually changes without a real use-case in kernel are
>> not getting picked up or they are getting removed later on if nobody
>> makes use of them, so I assume this is a kind of an RFC patch for now.
> 
> OK. I will send this as part of the complete series. Thank you.
> 

Thanks! Please feel free to add me to the CC list, I'll take a look at
the patches.
