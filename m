Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D330C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400EA206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ac8PH9gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBLOJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:09:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55793 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBLOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:09:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so2427617wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 06:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZYSr9Lthmw0rEdKlAUNqWqVy2KZbgG19jAuOZOJ4u8=;
        b=Ac8PH9gvOLzanxQ9KYMov+xhlfa8TnIZ+Xf/tJUXNpXqBpkBBJl/ZdSH3o9EqMCd8P
         6bbIkGSqk2wOXavdvurN1a4f3Dp8r4HC3siE9nrJNq4gx+Vl8QaXgmgU+LSIcn0NtuKQ
         B/KS3jjXJLTr0P5mvq2OKJmCMmrKC/gV1g+xRQvMC17WI4kSzRwnHLuupgf0vI4S5x8I
         +sXJFBxZMUN3jQmmYWPQWwxLxc2l/T9q2nuxUXm3pC8BNBen4JSSLF2gI70E52NO1Naa
         TmEECb+uH6zfKXDk11hUsEJNEYLdOd+giVI8s5lQ9ndMEGQ7KhRJxtIk0m7Lt79p+kq2
         10Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZYSr9Lthmw0rEdKlAUNqWqVy2KZbgG19jAuOZOJ4u8=;
        b=TEmBBehjtbifcQ2W4n0ONyl124LCkJCzJ2OWJO7TImIGSE7FS9ihS3+clfU87rBkaA
         8VOhSpk+Jjt5hJanEu73UFvk1O/gZO4pGsZUWqo4/eEdd1DTyHU0vGz4AvZi1s5DR18E
         6SmPWaL4vWbGLCk1l0MvSdNGQxrSV02zDb6MFIcFoukYXrZI7dSLgvUzoHVJvevN1u/M
         YIKfxvASnUWtTQwkTGVbT4fBLM30TCsbB74+B08HizAL5YNcICmtttOd3i8XZPXjdaNh
         wy2Rnd0KhC6FRTljnH5Ap99PQ651+CQTbyk0GkAzLRWxiFv49me91P228CBIf3hNHJIp
         saOg==
X-Gm-Message-State: APjAAAURaemYb13yv8vV8bbOdecXoY4kj26GxhevyFYli/y6jWLBOoFE
        3azi/9SrcqGuqML6TPZZwuHrPA==
X-Google-Smtp-Source: APXvYqzsyWi/3pMvejlnOOdjV8T8KAb10ZXcoRdiHPdLErpXYSk6E13Et4wSUp809q63cBGH7G3Ekw==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr13269388wmo.147.1581516581552;
        Wed, 12 Feb 2020 06:09:41 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b10sm721174wrt.90.2020.02.12.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 06:09:40 -0800 (PST)
Subject: Re: Linux 5.6-rc1 kselftest build failures
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Andrei Vagin <avagin@gmail.com>
Message-ID: <c31e468a-3afe-f9b6-b006-c3bc3f35f1cc@arista.com>
Date:   Wed, 12 Feb 2020 14:09:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On 2/12/20 12:35 AM, shuah wrote:
> The following tests fail to build on x86_64
[..]
> timerns:
> 
> tools/testing/selftests/timens'
> gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o
> tools/testing/selftests/timens/timens
> /usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
> timens.c:(.text+0x65a): undefined reference to `timer_create'
> collect2: error: ld returned 1 exit status

I've just send a patch to fix it:
https://lkml.kernel.org/r/20200212140040.126747-1-dima@arista.com

Could you try it?

Also, it seems that the same thing affects futex/rtc/tcp_mmap/tcp_inq tests?

While looking into this, I see there are new auto-generated lkmdtm &&
pidfd tests, is it worth to add them to .gitignore?

Thanks,
          Dmitry
