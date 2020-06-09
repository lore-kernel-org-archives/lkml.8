Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6955206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591732036;
	bh=ejjV/e8+kCQZ1HixpapPccYz22zf+UgYgzHEwPwr+oc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WuSMGUpjYn2G/C/k9K+KqAeMD1j85Qap3pp6bRZ6fNvHvhbHYSAPTTl7rpG7HCSyz
	 BrPlZBc8Dsup959BFZR4Va+oLWn6CJ8R38CsPmnA/C/XiDKyNfM3K79STbic+C6Jjs
	 n1Ie8NQy8huJkgFRD7Fe+N0himj6RnCma0wNTONg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgFITrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgFITrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:47:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D69C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:47:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x202so19904336oix.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJHHkDUbokY+54DQEArYhqlw2m9nYTGAzxOkgAkUWeY=;
        b=WXtsedVfP3o1vfsUqp9SFhXoVaZT2RWMlQqJ1vHWpk3WyTLEZUd3NiMq6zfRqO5UbF
         BfIpm5z/znMwSry3ZVHTa6S4xXg78v+/9tgPGruWE0yDGTEZc2pbDGqgE6Osf3gwkU3N
         Vq7g07ijZN4PQD4Vr+wOiewFQEz1wW2dZAYhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJHHkDUbokY+54DQEArYhqlw2m9nYTGAzxOkgAkUWeY=;
        b=PRv8F/K1Atje5wVE1zEOTJN4/GegSKLWz6eyfH8R8uHFCaPIMFixomO1l50OnVKReu
         1Kexczo+EiVQ0Vrqm5cM/IZbM+KKNEgkf3HJXZZBgZ7P4eOu6VRkY8JMM79rhDkmCFbF
         olqd31gcMh8UqnVXVGNWAjMbjbqXhveWsbl60yCNCq8fc1vPllKD6KkWLAnCUejMsZVP
         ih3qlPVlQ7LLj//Gjdon5UrQTHDSaVLaKsE0zEGwVmbFJBm6L7GVGap/F4UzXwqsm8HZ
         3Q66x4Ua0nillYFPE4HTwCj6zAj1uyljf3S3chABC+UCBWNL9uF0xbu4R5YANjHS+7mn
         MSfw==
X-Gm-Message-State: AOAM530VshME/c0grbskxefNikbkp9eTl8T/F7WAQPImm12KEDr/2eE5
        Z9XT+uw87iCPy7acjZCtCKH25g==
X-Google-Smtp-Source: ABdhPJyrjWmHTMRP25i31oeVNd2eDv9bTCijGBLQDfU/kgKT+C11897+WkO+8gV7JrS+tHAmTk4Yrg==
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr4937372oif.42.1591732030191;
        Tue, 09 Jun 2020 12:47:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j46sm2369331ota.69.2020.06.09.12.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:47:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] tools: testing: ftrace: trigger: fix spelling mistake
To:     Steven Rostedt <rostedt@goodmis.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200609163853.1602-1-f.suligoi@asem.it>
 <20200609135235.608cdbf6@oasis.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6334f193-675d-80a1-ccb3-d007c8179bcb@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 13:47:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609135235.608cdbf6@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 11:52 AM, Steven Rostedt wrote:
> On Tue, 9 Jun 2020 18:38:53 +0200
> Flavio Suligoi <f.suligoi@asem.it> wrote:
> 
>> Fix typo: "tigger" --> "trigger"
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah, want to take this patch?
> 

Yes. I will get this one in.

thanks,
-- Shuah
