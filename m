Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36F920684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyUGKTMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWN4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:56:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727312AbgAWN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579787805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHr+dKKy6YFY8CdkcCg0p7DmA174EWGz4sMjLUwEXGU=;
        b=RyUGKTMcPBvTu7s8pxcjZeUwbdHPKclHkkTNLPW1wH/nELK4NwWlZmPai2zIHAoCzhBQS4
        K/QdSDiUcvyw9y/huVdeGROB2x9sMvUWJfQz8Yp3fgyAKpDP3NAxCo10ZFjiBN9R8VJ2KX
        QOMbiM6S93yYu6rubmUjYtU7XIY8V64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-rEhbHhUVN_GO2ta-z4iWdg-1; Thu, 23 Jan 2020 08:56:43 -0500
X-MC-Unique: rEhbHhUVN_GO2ta-z4iWdg-1
Received: by mail-wm1-f70.google.com with SMTP id 18so1071460wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mHr+dKKy6YFY8CdkcCg0p7DmA174EWGz4sMjLUwEXGU=;
        b=eDhEH0gvaQ3qEesR3r6QjDhtf9UElzxBu+318X3UBx9iW9Z92Py9ZbueMVh75iOQav
         5B3YWw2EMN/XN0/hLb+vvSV55xw1Sy4ljGAK3kWff5dc4Yx2qrBHwGty4hLwocpsA8qh
         EdFXXEBeMW4V/+xbMkj1jAWK1lpPdOh9cjf9yiYMiYnCi97ccF9emzSdQfcOHYsfJojC
         ZXZWUSNuEt36ju1ecAGIIOoDc1Z0GZUUJ37C9cjgJrfLHXPEM38K1sr0kXS/uzbF61R2
         d4Ny2XYFV/tjTTJDCoJ8lBgyeH+MsN0fcNzvTNFgCw/vOaYirKGsidlpvvnNi2NDSCpa
         XG6w==
X-Gm-Message-State: APjAAAWGUjftBIud8shMHqOSrRcreerSvMXodUssH0mhbNqmaaN1EuWs
        dyJV3zLTCiUQtfmxpavT5rZPy9Of4DNLhJv5Vh/8A4jBiMNOk9omQ5ysb76cfwKn55sqZSAHTOW
        zs7CyYjbtJ3D3PC5UaJcNZ9Jq
X-Received: by 2002:a5d:4805:: with SMTP id l5mr17456360wrq.3.1579787802235;
        Thu, 23 Jan 2020 05:56:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZC7YBx84D1F36G8gvu21bmP7ysQY2lzIRWZ71Z2AzAlJvArAH8hVVcrlvIvltJI2Auz8fqA==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr17456334wrq.3.1579787801943;
        Thu, 23 Jan 2020 05:56:41 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id l17sm3148064wro.77.2020.01.23.05.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:56:40 -0800 (PST)
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        raphael.gault@arm.com, catalin.marinas@arm.com, will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200120150711.GD14897@hirez.programming.kicks-ass.net>
 <20200121175001.5jltrjuxrjklq5o2@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <ec4dc8a9-da6e-7269-dbda-3721b2dc50fd@redhat.com>
Date:   Thu, 23 Jan 2020 13:56:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121175001.5jltrjuxrjklq5o2@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/20 5:50 PM, Josh Poimboeuf wrote:
> On Mon, Jan 20, 2020 at 04:07:11PM +0100, Peter Zijlstra wrote:
>> On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
>>> In the mean time, any feedback on the current state is appreciated.
>>>
>>> * Patches 1 to 18 adapts the current objtool code to make it easier to
>>>    support new architectures.
>>
>> In the interrest of moving things along; I've looked through these
>> and 1-14,16 look good to me, 17,18 hurt my brain.
>>
>> Josh, what say you?
> 
> Agreed.
> 
> Julien, thanks a lot for splitting these up nicely.  If you post 1-14
> (updated based on the recent comments), we can look at merging those
> sooner.
> 

Sure, I'll repost the refactoring patches separately once I've updated them.

> 15-18 also hurt my brain -- probably a symptom of the existing fragile
> mess -- so I'll need to spend more time staring at them.
> 

Yes, the whole state update code hurt quite a lot as well. It took me a 
while to convince myself that my changes felt correct (to me at least, 
it might be that I got things wrong :) ).

Thanks,

-- 
Julien Thierry

