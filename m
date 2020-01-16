Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396ADC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF8C20723
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajk8NqoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgAPBo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:44:59 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41326 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgAPBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:44:58 -0500
Received: by mail-wr1-f47.google.com with SMTP id c9so17537266wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHyBv9/uEUzj2yZpH1lPNDp/96TDlfsa3OqJUI+/4dM=;
        b=ajk8NqoFzUUWEVPoY2YbpKmKovEbVpNC/G8dbwzkRIfRyNhL/ngheXVmIgb6pDrbao
         FUWhzGPpa/oEe1zobU9JNgXhpZR1XjDfdqrnxlYFhEwi3N4INsKVi0qiqTLwCvTZF32u
         kTNLBQH2N4O7WDwxfsALb9HrTzCIM/7Iqx+Wxrsq4/oqq3RyS2rxcy4tdmClzQIGLf74
         2rJT0IBbeB3YWi5aFnrq5PQ1liOv66yMK5P6RZOY67JG69r3y2P1E3+VpHrKOxgabfeH
         RJjutBwAPLO5mSrvgLl6KfcaPukSK3YQm0fWt8Wb7zx7l+ESm85Rw2s7gEMlu59ZQ1t/
         QCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHyBv9/uEUzj2yZpH1lPNDp/96TDlfsa3OqJUI+/4dM=;
        b=Z2jfjV42VvV2u9gyW5kL0csQezgyPXohjnJdGEE9DpUeYnDa+kYXnA/lYjpCTlvCvI
         3MDcWyQ9LroDlFJ3QIfRsjMGxCpR5447sBgWGtVzdD9hFUJ89WMc36yvKa6Ls+bCq4uv
         XeIMTRKRcB9/ITbnUJ6B7ZbM8xGPWQKFl0x2/5ptwI3cY7g+pwGq00Jo6T774Bv7Yqp9
         hA9V2KT4aJPvtsugUUrJdfsha9Q85MKMos+EXqGz9FPlZ94d20Oa7Ng3oN+uV5mQ2c7P
         d5cVVW6Pu515cN8xvuxau3dkwq2RybZbFv0xmhjgMqLPaSOe7QyUHo142loPrh5gaVw+
         j6Ng==
X-Gm-Message-State: APjAAAWVFIrXmN4807jhv8V/Gh0gOzIu2r8d1W0BKTZN4a93vmJdyGfY
        iRbZLW1nxjZbqAv6nEw1F8wkkucNmzA=
X-Google-Smtp-Source: APXvYqzrdHr6ViCBpGA8HoqiJ6r1JJpA8bbbJfh9MIOIuK0CtXAFlGH5oCt5SaUo7gz/zIiiwaNuPA==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr246806wrs.287.1579139096285;
        Wed, 15 Jan 2020 17:44:56 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k16sm27619337wru.0.2020.01.15.17.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 17:44:55 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the usb-gadget tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200116070726.7e2ef8cc@canb.auug.org.au>
 <b7ef5047-c8c3-42cc-d049-fb72563d3544@linaro.org>
 <20200116124100.58af81d5@canb.auug.org.au>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <6b984328-b3f4-a23d-efb3-7e7955ad165a@linaro.org>
Date:   Thu, 16 Jan 2020 01:45:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200116124100.58af81d5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 01:41, Stephen Rothwell wrote:
> Hi Bryan,
> 
> On Thu, 16 Jan 2020 01:19:22 +0000 Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>>
>> How should extra long fixes like this be divided up ?
> 
> Just let them run on even if they are too long i.e. don't split them at all.

That's what's in the git commit log though isn't it ?
