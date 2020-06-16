Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE9AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AE5208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592326099;
	bh=Yp5ktvlrV3cIfFYYxM42ROqzEldL5pRbByiyKD86rvw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=NOFyJ9HrU9RUQAIlwd2t8Cisl2yQEKcG/V4atjSDJ0CahTIK1jlOdYrwJiwpbXGfY
	 YIf/+uV9nwkPk1u6UsF1pk5M2vaKCOPDQYqp+N3FEq8B6KMZa67lteAl4xWCPZtYAD
	 b+K1w6AWQJmP1hUejuzoMEH2nYskC828E5++Jo68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgFPQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:48:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D2C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:48:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e5so16436852ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rUF2LfAoNKaTd4vWHI3MdLVKx6YmjE2fH2WB8RQ4cM=;
        b=Qnh9zamxRTz9tICXi94zKmLrRe6pOvx4YLq+3bTEUhbgMqMofGpjsQqCdAGWQXyYUb
         hNLm6hJDZdEiLiN0yh093FhlPeGpkdZFLrH2oOiBgSyL/kJVazmmL1KVFsb6ncYeThfg
         ZJpDoiwuvkW5604CWku7XL/I679fBoHG9VIa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rUF2LfAoNKaTd4vWHI3MdLVKx6YmjE2fH2WB8RQ4cM=;
        b=p/kbmjBYjZPDtDunFIs17ar2MC31GxQ52vDdPEwGhiP8thDVC1bA0gzlyIQA54hmce
         4ZtO5jpYhYGert65fDYYz9pS/cX3HHD7I1+UC7oNgyc8uAPfbInxp7JMwcZgArZax9Gu
         qOERq/eLHAhECxqcGkN6feeLMM7Sdjf9as1M4g9jFjMm/9+dn9F4sNH4VJwB9P8cJbjB
         +jnYaHbOnsa5tjNfhTTeFuMQdRN/FCoxbYkmEShgoRpGZFLP4bVM+r7Y1qorh72Y99vD
         +RikC1cPxoP9rf0vW/EHIP0OO217CZD/blfYA5mcO9uxrLOlisSdImaAmt+p5cVn4VH2
         rvCA==
X-Gm-Message-State: AOAM530Sn+cB/y9IwYCjHVRJO+DErCGXPKc/BouSY33YUg8byNitcahf
        CXs2BqhvTPff7Zi2+XUJHIJUAQ/e+fI=
X-Google-Smtp-Source: ABdhPJxsRUguwXES0v09lV50WYgYiQaZP7HUqFVEuuzjIDuUKNsegdaX7ZDaQWw1JcDtGU4Ink7YHA==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr3371442otr.339.1592326094539;
        Tue, 16 Jun 2020 09:48:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z7sm4156278oto.2.2020.06.16.09.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 09:48:13 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        skhan@linuxfoundation.org
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
 <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
 <20200610145535.747d2765d60e6e3923441768@kernel.org>
 <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
 <20200610093206.5b9fb1b7@oasis.local.home>
 <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41b50b37-c9cb-9e7c-3ea7-d0824a41c03c@linuxfoundation.org>
Date:   Tue, 16 Jun 2020 10:48:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 6:03 AM, Shuah Khan wrote:
> On 6/10/20 7:32 AM, Steven Rostedt wrote:
>> On Wed, 10 Jun 2020 06:04:33 -0600
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>>> Steve, what would you think?
>>>
>>> No worries. As far as kselftest tree is concrned, I can apply these
>>> after rc1 comes out with Tom's patch.
>>>
>>> Or I can give Ack and Steve can take these through tracing tree.
>>
>> All my patches have already made it to Linus's tree. Perhaps
>> cherry-pick the commit needed from Linus's tree (it shouldn't break
>> anything when Linus pulls it). Just let Linus know what you did, and
>> everything should be fine.
>>
> 
> Good to know. I will get these in.
> 

I applied all 7 patches to linux-kselftest next for my second update.
I saw a couple of merge problems with 4/7 patch even when I applied
it on top of with Tom's patch.

I resolved them and amended the commit message to indicate the merge.
It is straight forward. Please check for sanity.

thanks,
-- Shuah
