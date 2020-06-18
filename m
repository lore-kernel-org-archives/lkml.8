Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79ECC20773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fH2Bztqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgFROmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbgFROmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:42:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A4C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:42:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ne5so2630873pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+CwHsxmZO7al02eIsWAPOcThZHp6rfmpE6RrFb8EcPw=;
        b=fH2BztqrIj/VG/8Fx6R4BMU6mIp3/E6CMLGmQU/uhMq9bushUQaKRmtjc2Jv6li16i
         ai2HkjDikjqrO929y3PfF8UAJgLIPhzNlFOtssQW1rvMm27YMQIRPEjfv/iEY3kB2kzu
         qE0MLbvqx4DYL1d6BUSoWEsI+fMbJAN0T+bF1N79Kokc4YlMcqM/UdkpuTK4BXbq8cvD
         8qIhpehLRYycZhOttdFGbGvvWzHx4HsWXUbEQIkyYUqhJIncv3PyFS4eoVQF7sdRrr1N
         NhxbZ4sOAxaYxAuZuhrIk7Pv2J4+CnmmlNQLkN8hb9Y/+bQR0hGFz+7NquTfx2vNaPKa
         Wg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CwHsxmZO7al02eIsWAPOcThZHp6rfmpE6RrFb8EcPw=;
        b=Q7ELpQyTm/78zUsWglXsMteaJppckvCdPISDSnGeKHSy5b29318EBV2k4vGi/XjSjx
         OK1qq97eEhd6CukpeEC60MiyRf6bxQeCXpOqHHpzK6y2YbDmnpHcO3l0FN8BUJdk1Kjq
         mS/yLRppyNAvy4lB+XdUA9GEeAaEB88Ec5Kc3vnE4fZivd65W2lMSjEj3sjV+XMo5qY+
         c02x7w+COUFhTnUWVBL1sk7Wjdg7i0G5c2vFIYmz8vnjoXIHphdybsvf5JirFfjiP4o0
         uHTSic3VVrNe3XmOv0jWlytA9G8Pnu6wf0/LGOnNXfWrZy9QlG8ZlPLU71jHLW2E/nSL
         o1Mw==
X-Gm-Message-State: AOAM533go0aj2qKZzioK0Yu0zlVtRoqtYc5b+XeMKFGPE4g1ZkKqcwWY
        8PKVmo7ld3VKbOodF8uIbC/HqA==
X-Google-Smtp-Source: ABdhPJycmaH/Sq6ALxmP55R4OyQZwQBY9HYoAjxXJCFGcMDHXq30eGLpBKlGwC81JM1FheQuhhv4eg==
X-Received: by 2002:a17:902:7881:: with SMTP id q1mr3907257pll.159.1592491321424;
        Thu, 18 Jun 2020 07:42:01 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u74sm2786453pgc.58.2020.06.18.07.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 07:42:00 -0700 (PDT)
Subject: Re: linux-next: Tree for Jun 18 (fs/io_uring)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20200618141530.0ca9897d@canb.auug.org.au>
 <25b48bfa-07ef-c6c8-c4c9-61c213e22f66@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52b64a82-34c2-268f-7aa3-4cb4f7a14e23@kernel.dk>
Date:   Thu, 18 Jun 2020 08:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <25b48bfa-07ef-c6c8-c4c9-61c213e22f66@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 11:38 PM, Randy Dunlap wrote:
> On 6/17/20 9:15 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> News: there will be no linux-next release tomorrow.
>>
>> Changes since 20200617:
>>
> 
> when CONFIG_BLOCK is not set/enabled:
> 
> ../fs/io_uring.c: In function 'io_async_task_func':
> ../fs/io_uring.c:4559:7: error: implicit declaration of function 'io_sq_thread_acquire_mm'; did you mean 'atomic_read_acquire'? [-Werror=implicit-function-declaration]
>    if (io_sq_thread_acquire_mm(ctx, req)) {
>        ^~~~~~~~~~~~~~~~~~~~~~~
>        atomic_read_acquire
> ../fs/io_uring.c: In function 'io_sq_thread':
> ../fs/io_uring.c:6268:4: error: implicit declaration of function 'io_sq_thread_drop_mm'; did you mean 'io_sq_thread'? [-Werror=implicit-function-declaration]
>     io_sq_thread_drop_mm(ctx);
>     ^~~~~~~~~~~~~~~~~~~~
>     io_sq_thread

Fixed it up, thanks.

-- 
Jens Axboe

