Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89684C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59438208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aYPt015R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEHP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:29:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C2C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:29:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so2141900iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nk6RHcExY0LgqkERTzLyOugz5IoSHIMF3+L+W3k3sTM=;
        b=aYPt015R3MZqJU6zTu0YTrS7KdSMum8HJnR6RQ6e24WQOjI4Ur9QVeRJSY7NnRIFZd
         IZsmJq0UDIY5bHgFrmoNzkk8HH+8BGvKWk8akxsxOkOpB630b9BQiCvT4zMi+qY8JgCD
         3+8cGBW551YKMlefQVS+yAHfyVzzPbtmkMqbTh5P+veODcnjHamwHJKPaPuLICvIO5AP
         MfWRVMizT+trP06HQvKiby2brIKZcTfW/o9uMrcVEc/jvBfnIZzrAf/lLkZRspTAXUQ0
         3LrM7X0RSt0briJXai/4T912sG84ytx04Yl5ggGd6jN2UzCykfXlpWfub1e6Chvie+Xp
         9z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nk6RHcExY0LgqkERTzLyOugz5IoSHIMF3+L+W3k3sTM=;
        b=ID8mEiIFb1QJU2xvmo6tXWC0kPwGfLjZ60goFp2HPF+8qvDuxK0yU8zloMWGs+In7v
         NkMHtfOeplX/0sj3b6eI0jFfbCxD8IElRoBp434/4SrINsrwYMliVfHhT5FfA3zAV4b2
         bF2NWLuDl94LNmKOyHwwY63LikhNKl4uAzuMblruh9l5cr4yyr+K7KJtiIhpDlLOXV9K
         zF+yJqwSGd6BuUvSOYLxFYC/8IL5yoBTQWDOCTycvxgfsAuj9J1zQrvOmUYm9yIPKVs7
         xS3J2C7mcDRkGtP0ex2jsH68OPzR508UKxcYkuzpYpMGrE5mQScFD6HBYMvMdnQBlcxr
         ngiQ==
X-Gm-Message-State: AGi0PuaF1WvFMDMYdbfuqIYElj3nAQyMZ9gLGI+9PinfEl2ELZX40jaY
        DXBRBcILbuvYUimyn/+/OZv1fZFZccQ=
X-Google-Smtp-Source: APiQypIXgmex+zsOFZGr9ugAJltkk+meCOXpP254DY7Slv+ItHa08HS3rmtyOi/opsj8ElzkdXFEVg==
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr2911600jap.93.1588951793971;
        Fri, 08 May 2020 08:29:53 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t62sm915931ill.87.2020.05.08.08.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:29:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] fs/io_uring: fix O_PATH fds in openat, openat2,
 statx
To:     Max Kellermann <mk@cm4all.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200508063846.21067-1-mk@cm4all.com>
 <20200508064056.GA21129@rabbit.intern.cm-ag>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1f9d108-7f31-c586-330a-ce5a2f1e5bc2@kernel.dk>
Date:   Fri, 8 May 2020 09:29:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508064056.GA21129@rabbit.intern.cm-ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 12:40 AM, Max Kellermann wrote:
> On 2020/05/08 08:38, Max Kellermann <mk@cm4all.com> wrote:
>> This fails for `O_PATH` file descriptors, because io_file_get() calls
>> fget(), which rejects `O_PATH` file descriptors.  To support `O_PATH`,
>> fdget_raw() must be used (like path_init() in `fs/namei.c` does).
>> This rejection causes io_req_set_file() to throw `-EBADF`.  This
>> breaks the operations `openat`, `openat2` and `statx`, where `O_PATH`
>> file descriptors are commonly used.
> 
> Code is the same as in v1, but I investigated the root cause of the
> problem and updated the patch description.
> 
> Jens, I believe this should be a separate trivial commit just removing
> those flags, to allow Greg to backport this to stable easily.

I'd prefer just to keep the single patch, the stable backports tend to
throw rejects anyway, and it's quick enough for me to just provide a
tested backport. The single version I posted also gets rid of the
extra sqe read, where we really should be doing just one, for example.

-- 
Jens Axboe

