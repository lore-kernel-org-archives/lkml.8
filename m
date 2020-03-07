Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A079206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583540399;
	bh=AQzF6OqEcMz+JNwqEn75W80QTzWVCt362BYnIuITObo=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=SRMLiFctim85GsHv33Jl8rItRTvXKaFCrNxpu2uYzwi0bK3qquOJXY770n8NSLZOo
	 AC3ybDWz7nwqljEB2gCmbwwVF5kaacqXri9SVoFS/9V+MJ/FH7UDtRlx5sm3vmYpRv
	 hLcLDBu5QpjFq+6paZ+Fo0BLUq99LFs6y9bfCOCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCGAT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:19:58 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39624 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCGAT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:19:57 -0500
Received: by mail-io1-f67.google.com with SMTP id h3so3825928ioj.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NSjfSL+QfSTDf8gsw0rEhWcCVhS3ZyC2JHCZZDzLAkk=;
        b=BfHT6MrTqmTvz6StrgNngfhAD9KFspP5YNkvhnAgFKMFrW2HsdtpPY+eM9MTT560bx
         AT5zjLYF75bZYSGUwUaG685a/NdICEkNElbBvzqGy9Cw/ZvVyXV3TE7izOhF/G7kmCjJ
         hYYz4hbVwOuQWTk5fzEc7eXGUZtxXsZnT3e88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NSjfSL+QfSTDf8gsw0rEhWcCVhS3ZyC2JHCZZDzLAkk=;
        b=jxnIopnTZ97d/N+7lzl2xs9Hu0CPyQRdNfcBT3IVwbwTAyDdRPvCZjawKcf6FA8mZd
         eDbKg/3ddgbdFkBCpMQTg4Se3iJPFKhK+xIZCYY/tWM24ctdmNDZD/Qha4LMRBZdMk0v
         PCBdIwtLE4T5Fm8SsGZYbzAoMoqmSShLI1049Tf3eOZvFcGE3QGYZVkFS0XKVeOg7KvA
         SFMlh5nHhPlpErxcA9iBHGWU9qWU/KofNwnx+MzoI3kziSMJFL8jQvrZvZ9oIHE/lPEO
         xawT7/cagW/Z2Kh/g+NSI4JFkkrWfrTJY2siIJAS8wJ2bHK3QQhaK3K3SugU72aBjVJA
         FvCg==
X-Gm-Message-State: ANhLgQ3m+nBy1/kScFF/rX9IFEcz7q9+qx9Lg8fyBI2Xf2FNcU5PjdsZ
        I0+RSAbWnxi/4Sc5PntoJ/a2PQ==
X-Google-Smtp-Source: ADFU+vsZcOc+y0H4k1ol3rKOKsW2mSj+/AU6MpZ505QjGYHGgFwSGBxKCxVcY4XqUfBzlAgk7WzLRw==
X-Received: by 2002:a6b:e013:: with SMTP id z19mr5109744iog.103.1583540397178;
        Fri, 06 Mar 2020 16:19:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n5sm685109ion.25.2020.03.06.16.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 16:19:56 -0800 (PST)
Subject: Re: kselftest selftest issues and clarifications
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <MWHPR13MB0895B92C9B4807D94E1E6B04FDE30@MWHPR13MB0895.namprd13.prod.outlook.com>
 <f1f991a6-6e05-6ba3-b5c1-174b93029a99@linuxfoundation.org>
 <818d8b84-4ce2-4cbd-d561-293137c5d884@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6af54eab-a982-dfa9-c6d3-c3e017dd4ed2@linuxfoundation.org>
Date:   Fri, 6 Mar 2020 17:19:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <818d8b84-4ce2-4cbd-d561-293137c5d884@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 5:18 PM, Randy Dunlap wrote:
> On 3/6/20 3:30 PM, Shuah Khan wrote:
>>>
>>> And I'm using a KBUILD_OUTPUT environment variable, rather than O=.
>>> Let me know if you'd like me to build a matrix of these different build methods.
>>>
>>
>> This is fine. Please note that relative paths don't work in both of
>> these. Something I will tackle once the bugger problems are addressed.
> 
> Please see/test/try this patch:
> 
> https://lore.kernel.org/lkml/158351957799.3363.15269768530697526765.stgit@devnote2/
> 
> 


Will do. Thanks Randy for the pointer.

-- Shuah
