Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45C320760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2eSC5h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFKLbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgFKLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:31:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95651C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:31:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so6058666ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZI0uRQuWUt+bbhxRlulOcMky2K69l8uS5RWj37ZKSU=;
        b=O2eSC5h/UIUSN8YdTXYoM2GxMaLHDuLBL80QYWThofDsGoN2ZvZDRRRABrEyrHkaEI
         K0j0bTbw35reBwy6NRKAeV4Kg2bGKdfRN6Rr/eO5ltxDH7bADZ00TU5bQWVhQcSvCJFq
         7UljWwRep6eDGm0fydTBVFsCHIb/OAQs8X4iyu2KLchotcgWLCzWqabmVBxw1kCmNVqM
         +h6KETWJPOF3So1hsyuxKCqvjudWGRJQliU2IDpvW64yNiOFDyZVprw/v5QcPhIMw0cf
         35BSxMTc4umjRhqy3Uw+tQzWT0n18q/sO0i5xbe09Sw0KI0HOSdBooaFns7GEAoMUgi6
         Z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZI0uRQuWUt+bbhxRlulOcMky2K69l8uS5RWj37ZKSU=;
        b=Qrll2a7G2jtjo3+lVYJyxhYJW7WGv1AsKUIgWCcxwYh/MU2PgA38qDer3qLiFyovu5
         Rx6xDsqe8RF/lo1ED+OfDlqB4kIOVfZw89n+4xLjOkaoTTOSngkBqqHVbCnYz34zxmAS
         KcjTIDc+DasVjq//hrrF7WpGpoQcBp+QuJA0VryI56hCg3uqgr4N8OLCY6IX6z8wiEaf
         QUG3KqnU0/UuYeVV0spygQDsLfSK7ye0z6GSA8UA4VFM2Y4SO+iWSO83RbU/QZEagVP0
         se11kROeUKtU4VXCKFhE3s1tYbbxmqTEq/kTnCB75hCDMH1twNR8CMK3eoiSn+cOWxj5
         tFyA==
X-Gm-Message-State: AOAM530k8iTs14IfiOPV3MBHjJQeQQx0GYwdBaKa4sc5JoqHC3uafjcS
        Wia54KbU0ty2VS/vhI8ZiYZ3Iw==
X-Google-Smtp-Source: ABdhPJyQ1qn7IO1LzSekQnj4oHhjiJ9BS1eH8JqyujBg91YWEFxFDPUx+MplfmXECktgGP6foP9h9A==
X-Received: by 2002:a17:906:f155:: with SMTP id gw21mr7806470ejb.388.1591875070279;
        Thu, 11 Jun 2020 04:31:10 -0700 (PDT)
Received: from [192.168.1.5] (212-5-158-114.ip.btc-net.bg. [212.5.158.114])
        by smtp.googlemail.com with ESMTPSA id q14sm1381962edj.47.2020.06.11.04.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 04:31:09 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] venus: Make debug infrastructure more flexible
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, Jason Baron <jbaron@akamai.com>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
 <20200609104604.1594-7-stanimir.varbanov@linaro.org>
 <20200609111414.GC780233@kroah.com>
 <dc85bf9e-e3a6-15a1-afaa-0add3e878573@linaro.org>
 <20200610133717.GB1906670@kroah.com>
 <31e1aa72b41f9ff19094476033511442bb6ccda0.camel@perches.com>
 <2fab7f999a6b5e5354b23d06aea31c5018b9ce18.camel@perches.com>
 <20200611062648.GA2529349@kroah.com>
 <bc92ee5948c3e71b8f1de1930336bbe162d00b34.camel@perches.com>
 <20200611105217.73xwkd2yczqotkyo@holly.lan>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ed7dd5b4-aace-7558-d012-fb16ce8c92d6@linaro.org>
Date:   Thu, 11 Jun 2020 14:31:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611105217.73xwkd2yczqotkyo@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/20 1:52 PM, Daniel Thompson wrote:
> On Wed, Jun 10, 2020 at 11:42:43PM -0700, Joe Perches wrote:
>> On Thu, 2020-06-11 at 08:26 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Jun 10, 2020 at 01:23:56PM -0700, Joe Perches wrote:
>>>> On Wed, 2020-06-10 at 12:49 -0700, Joe Perches wrote:
>>>>> On Wed, 2020-06-10 at 15:37 +0200, Greg Kroah-Hartman wrote:
>>>>>> Please work with the infrastructure we have, we have spent a lot of time
>>>>>> and effort to make it uniform to make it easier for users and
>>>>>> developers.
>>>>>
>>>>> Not quite.
>>>>>
>>>>> This lack of debug grouping by type has been a
>>>>> _long_ standing issue with drivers.
>>>>>
>>>>>> Don't regress and try to make driver-specific ways of doing
>>>>>> things, that way lies madness...
>>>>>
>>>>> It's not driver specific, it allows driver developers to
>>>>> better isolate various debug states instead of keeping
>>>>> lists of specific debug messages and enabling them
>>>>> individually.
>>>>
>>>> For instance, look at the homebrew content in
>>>> drivers/gpu/drm/drm_print.c that does _not_ use
>>>> dynamic_debug.
>>>>
>>>> MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
>>>> "\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
>>>> "\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
>>>> "\t\tBit 2 (0x04)  will enable KMS messages (modesetting code)\n"
>>>> "\t\tBit 3 (0x08)  will enable PRIME messages (prime code)\n"
>>>> "\t\tBit 4 (0x10)  will enable ATOMIC messages (atomic code)\n"
>>>> "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
>>>> "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
>>>> "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
>>>> module_param_named(debug, __drm_debug, int, 0600);
>>>>
>>>> void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
>>>> 		 const char *format, ...)
>>>> {
>>>> 	struct va_format vaf;
>>>> 	va_list args;
>>>>
>>>> 	if (!drm_debug_enabled(category))
>>>> 		return;
>>>
>>> Ok, and will this proposal be able to handle stuff like this?
>>
>> Yes, that's the entire point.
> 
> Currently I think there not enough "levels" to map something like
> drm.debug to the new dyn dbg feature. I don't think it is intrinsic
> but I couldn't find the bit of the code where the 5-bit level in struct
> _ddebug is converted from a mask to a bit number and vice-versa.

Here [1] is Joe's initial suggestion. But I decided that bitmask is a
good start for the discussion.

I guess we can add new member uint "level" in struct _ddebug so that we
can cover more "levels" (types, groups).

-- 
regards,
Stan

[1] https://lkml.org/lkml/2020/5/21/915
