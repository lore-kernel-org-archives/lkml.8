Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7CFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0779921835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yVZIlWrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgEGS6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgEGS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:58:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC5C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:58:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w11so7311802iov.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X06gQhxNuqNC0FB5uh4LFKI+uUsgLH7IELkz/3JNWnI=;
        b=yVZIlWrdh9uyveIkGpKsIFZio5/7W9X57tsGyag7WPhT84Xn10Dm7l1E2gxJsCPI8/
         CPepTbjA5RftqJkhZmxP47Pe4UZASvjtz8oJqGiALj5nsjPSe+iRqAwLPST3+LHZ4lzD
         S0xTTOVBK37ZkTHPRgiPXXVLsXfUvi7TF0ez4pgWTWqKyjBBLzn2N+Ss9nORekhp2L0x
         tiZzM0mqXZboUxiluSs1yElFyJhTnt7snX9yeftY7wBd1GNcRU7Rt6e/yI5FJg1SHGqA
         qngqM+I6y+2G/sC86VRnOi9Imz0e7iZOTtlo0TvQIc1z1rs+0Z/nstLroceqd+gO+vdO
         Go9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X06gQhxNuqNC0FB5uh4LFKI+uUsgLH7IELkz/3JNWnI=;
        b=VNUy5scVnZ+AG8wimsbk46gTh1hNQy4N9Q5Qo8M5Q4yjtLunmg54/wN+n093r49Po+
         UOPputySGbZyNWncoQFskWsHUQSMP56bFDuZqtRi+6YUNT9jSzYVutymKep33Bie2XGZ
         vdFhKfYkeWUO8kxm1BmaTnWGTPkL5fYg3GZjFZwGYaQIwzSJ382ahXAizgXRaoRjsFuu
         rQ+KWkfaUQn6YXWbwQNrpxU6dXQXuiv3IGfIf7uaLpMsD9+4Ym/4jGtXhm2yzGcEZWMF
         ZKZdNTMOQsfr0LEJ26ZCuuuaJp6qYDykgXdkEhjqeiNasi55UBKftSHL37pHW7OS590Y
         EZVw==
X-Gm-Message-State: AGi0PubzaPLuxLHkpR0840sU8H6Gpvw+cSKbQecUgIG4ikRcLWB620oG
        C15oxlNUpB9wO2VKOhrLOhGL9g==
X-Google-Smtp-Source: APiQypLKj9rERGXnwSxHGoeKcyPtXyMeD5lEx3YG7RLuJaR44rMQRzpnWHbj/jf6H0x74lZ8l+ciHg==
X-Received: by 2002:a05:6602:2e0b:: with SMTP id o11mr14921537iow.94.1588877932759;
        Thu, 07 May 2020 11:58:52 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z2sm3085748ilz.88.2020.05.07.11.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 11:58:51 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
To:     Max Kellermann <mk@cm4all.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200507185725.15840-1-mk@cm4all.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a048108e-67e0-b261-ab56-312a98045255@kernel.dk>
Date:   Thu, 7 May 2020 12:58:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507185725.15840-1-mk@cm4all.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 12:57 PM, Max Kellermann wrote:
> If an operation's flag `needs_file` is set, the function
> io_req_set_file() calls io_file_get() to obtain a `struct file*`.
> 
> This fails for `O_PATH` file descriptors, because those have no
> `struct file*`, causing io_req_set_file() to throw `-EBADF`.  This
> breaks the operations `openat`, `openat2` and `statx`, where `O_PATH`
> file descriptors are commonly used.
> 
> The solution is to simply remove `needs_file` (and the accompanying
> flag `fd_non_reg`).  This flag was never needed because those
> operations use numeric file descriptor and don't use the `struct
> file*` obtained by io_req_set_file().

Do you happen to have a liburing test addition for this as well?

-- 
Jens Axboe

