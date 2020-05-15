Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7FBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8332076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xD33G4jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEOPNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbgEOPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:13:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723FC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:13:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f4so1073458pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bfBhHYTtohVO95sNvjwzNyBK2wYpRf6EXbUlmqF97hY=;
        b=xD33G4jCnZyZK/tVplz8bvqfeTRe8c8TYLRHnuCfRcELdIU9IUSSMWdH4cg8VNjBTB
         XFKndQLtX8nj+DkAz7hT1qCu84OdkLnoxEIHrNIWszFtboQ2VAP05Qz0KdE5f5gSr/Fr
         EhDnYKdxeQBr0qrekR4PnuQD6V26t4Sb1RMDxwnuiABeZOY2piNE8c/+NVO9+OjysYnz
         fgqdjcRmmxb01XKczSvP6+Ve5gdeM5ipZ8mI+Wj28HgWDe4sd3PG5FhDQxanwZw6joxz
         JN9EFqwErcw7YRJ6fQC+5d+v9jcQEqlqsPck3/o763qssedKbJwO/M7sFOEfMaP2fsW7
         kELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bfBhHYTtohVO95sNvjwzNyBK2wYpRf6EXbUlmqF97hY=;
        b=Lme6ieJ2zhM19nBOsCEZArMsWgVAQ7zJwdbXvRM/SKi6Y14DHqnF5rkmFp/kfYC//E
         yEAA/lPFDFPdxwXhfTOqCQpwWqzKp2SMTSb3zUviE5pSRhOIUsSUBx5sLw1fC093k7GO
         EiSLmnvwn6s4IVlBwOSdIBswOYpU3lGQCcNXg+n6MkWdDF8bjkmk2yCzs/g3fx7xZVkf
         BjeRVX1LnZqf6v287ggEUYhvru8TP3HSjN3egAPmZNEFTK3Cd2r93g/y+1Y8NPY+H1HO
         8R8gDse+oWuzpCtM1wODgl5T+0JOfUBP0doJrymKycFQQWt1HyIVdSgiJyNKHWdVo17P
         gaXg==
X-Gm-Message-State: AOAM532XM5ogkp3zDu1A/lb2XMcvoMBdYxq4IGLPEK0OjZuWYsG4tYwf
        S1pqzjCjaOo0a1qCPvs43s6vQQ==
X-Google-Smtp-Source: ABdhPJwjkUi4YQauXs6/fEa1OaygsEMg8M7xaZVFabwiAKCRkC0c9/HThyf43z2ib0G01cAbex7X0g==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr4244848pfd.226.1589555615469;
        Fri, 15 May 2020 08:13:35 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:aca2:b1c9:3206:e390? ([2605:e000:100e:8c61:aca2:b1c9:3206:e390])
        by smtp.gmail.com with ESMTPSA id co16sm823398pjb.55.2020.05.15.08.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:13:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] io_uring: add a CQ ring flag to enable/disable
 eventfd notification
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200515105414.68683-1-sgarzare@redhat.com>
 <eaab5cc7-0297-a8f8-f7a9-e00bcf12b678@kernel.dk>
 <20200515143419.f3uggj7h3nyolfqb@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7ac101d-0f5d-2ab2-b36b-b40607d65878@kernel.dk>
Date:   Fri, 15 May 2020 09:13:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515143419.f3uggj7h3nyolfqb@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/20 8:34 AM, Stefano Garzarella wrote:
> On Fri, May 15, 2020 at 08:24:58AM -0600, Jens Axboe wrote:
>> On 5/15/20 4:54 AM, Stefano Garzarella wrote:
>>> The first patch adds the new 'cq_flags' field for the CQ ring. It
>>> should be written by the application and read by the kernel.
>>>
>>> The second patch adds a new IORING_CQ_NEED_WAKEUP flag that can be
>>> used by the application to enable/disable eventfd notifications.
>>>
>>> I'm not sure the name is the best one, an alternative could be
>>> IORING_CQ_NEED_EVENT.
>>>
>>> This feature can be useful if the application are using eventfd to be
>>> notified when requests are completed, but they don't want a notification
>>> for every request.
>>> Of course the application can already remove the eventfd from the event
>>> loop, but as soon as it adds the eventfd again, it will be notified,
>>> even if it has already handled all the completed requests.
>>>
>>> The most important use case is when the registered eventfd is used to
>>> notify a KVM guest through irqfd and we want a mechanism to
>>> enable/disable interrupts.
>>>
>>> I also extended liburing API and added a test case here:
>>> https://github.com/stefano-garzarella/liburing/tree/eventfd-disable
>>
>> Don't mind the feature, and I think the patches look fine. But the name
>> is really horrible, I'd have no idea what that flag does without looking
>> at the code or a man page. Why not call it IORING_CQ_EVENTFD_ENABLED or
>> something like that? Or maybe IORING_CQ_EVENTFD_DISABLED, and then you
>> don't have to muck with the default value either. The app would set the
>> flag to disable eventfd, temporarily, and clear it again when it wants
>> notifications again.
> 
> You're clearly right! :-) The name was horrible.

Sometimes you go down that path on naming and just can't think of
the right one. I think we've all been there.

> I agree that IORING_CQ_EVENTFD_DISABLED should be the best.
> I'll send a v2 changing the name and removing the default value.

Great thanks, and please do queue a pull for the liburing side too.

-- 
Jens Axboe

