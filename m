Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55413C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABD420684
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595077547;
	bh=TlEuQav6MWP1U6kHwMge1AyrBV4gTI6XZdzmRQvJr+g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lJU+sm+Zs5y/7fjY4BhxMSTWyq7ml/1SSiFFI/AP7dpHpxbiiY/03Qd9CGMwYAdyF
	 6tW8nkqpSjHq9D/alqeuxnTbnt5gWU8Mcu9frhiMOtPrWJQB6hAiHyOfKyVBfSiCUz
	 UAuixNQf+h1mzk5mjyqlLqba1TJERblFW0cdjRL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGRNFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:05:45 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:40590 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgGRNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:05:45 -0400
Received: by mail-ej1-f44.google.com with SMTP id o18so13658317eje.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 06:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQQRaX3pXuawLT/zNRNMYLJFYUSdiLn+MtY3ctdSgCU=;
        b=iFam5tTwb7aipf769OYBOlC5FeLnGA62p7uDkSngUrTPklEffKoo2TZfoYZgU2YjE/
         a7RFMR9ePUvMii2deL43Lf3+Vzd4ZOxEYkbVLRouFMmZALE6uq+S1SvFkVwROCeRBW47
         sSO/1rPWijkgQoRihIOMCTNZehyqeQb87Pc/0l6E2+4EVMDUDi6V3gcHyRTbytzFf6AK
         EpOMZ7FnFyFp+2WTR/QGT+wbybD3vT36iAmjIeYCCu/7gZFnILOJeX78OVT35K9/iPgi
         G0Z8EPe3mkqk2TcJRctVyAGUiYx7cL9gvN0KxzJRmWK0qKIYxnc+EpCncgLIpSmZUrW+
         5sug==
X-Gm-Message-State: AOAM531rxM2BWwZLwF4c427KGCf/j9ufDNEZ/NzVXGg6yYwuvb2cPgff
        enwdFcaayLyWV71oj+5XlaiUkPe5
X-Google-Smtp-Source: ABdhPJxTy3+cb3JhadCFh36x5rXKTol8/nmnp1fvc0kg+N1AFhbxAm79I/UAdlps5R2M//F/e7JObw==
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr13432397eja.171.1595077542689;
        Sat, 18 Jul 2020 06:05:42 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id u19sm11326872edd.62.2020.07.18.06.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 06:05:41 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717111203.f32s7r5vdvdn535u@wittgenstein>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b923c34f-5765-756b-fdeb-f756a278b6a6@kernel.org>
Date:   Sat, 18 Jul 2020 15:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717111203.f32s7r5vdvdn535u@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 07. 20, 13:12, Christian Brauner wrote:
> On Fri, Jul 17, 2020 at 01:04:38PM +0200, Jiri Slaby wrote:
>> On 17. 07. 20, 12:45, Jiri Slaby wrote:
>>> Hi,
>>>
>>> the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
>>> and i586:
>>
>> make check needs -jsomething, running is sequentially (-j1) doesn't
>> trigger it. After the error, I cannot run anything. Like ps to find out
>> what test caused the crash...
>>
>> 5.7 was fine.
> 
> Can you try and reproduce with
> 
> commit e91b48162332480f5840902268108bb7fb7a44c7
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Tue Jun 30 17:32:54 2020 +0200
> 
>     task_work: teach task_work_add() to do signal_wake_up()
> 
> reverted, please?

I reverted these 3:
+This reverts commit b7db41c9e03b5189bc94993bd50e4506ac9e34c1.
+This reverts commit ce593a6c480a22acba08795be313c0c6d49dd35d.
+This reverts commit e91b48162332480f5840902268108bb7fb7a44c7.

But it still crashes.

thanks,
-- 
js
