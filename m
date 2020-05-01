Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F89C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C3620731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nx7BXMoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgEARyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729973AbgEARyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:54:38 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343BC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:54:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u11so5629375iow.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uhch7fSB/7Ki1vYFi3Z0iSi1LX7KXkljEn4AyEBquZE=;
        b=Nx7BXMoSRhrWDV3OPwFEVATv5EIqod9Ke6TsglxqcaGtC5ZebrOKW3kUTkIyjnrbcv
         drFHpu/isCG0aTZ9FZXSEf0Z54ZWsTcJlUx1ZlPTt8Nk9CchbeugUMSdwFQfMH9GYZ/P
         Z5tf9J4N5cJ/CQHjxrLNoNQeGKHlS0Cjmoe+0+YCR5LqTlIgEzCyld0X4zHtA6qPLERc
         Foi3m/rwrIOXx23Ap+0gIWMeZfh33maZDqF/jrVORJwzHr/jyja9Qf9om/FUQkeiZmfc
         SACzicfCTmKby6ww6lOeYtQNXhgfaYUMydg++Oy9fy8YV+Wy3vfn6C3YzNAC9crGLKpu
         Hvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uhch7fSB/7Ki1vYFi3Z0iSi1LX7KXkljEn4AyEBquZE=;
        b=olfrG3f/cM3pmRzdz9OBye11YMJSJ91Ptuq5Z/j2cweYWtyU6fcZ2AX3BoTSiGyGXy
         FFj4zG+GmWOq/QEgki7Q+TDrXIqFuaD5CZ97ceM45xEkKoEvWuueIreXQmVPzoM4ItIi
         ukkO9Nxb+R/d8/pfzKPEqAL3aawuvoXnP/5Mqfs9MTtX/afiicvvR2Lll++8OhKv6wcC
         Gwtv+grm0E6gBDVNLdkfHh2Jz2H5ihPhV8su9jWAAQSkBy6+aN+qf8fIvdUHURoR4u60
         HKINTqSRixXNBw7vWp4Z/IbRBh2dxMn2gOIu1c0/qKuJJytoht3TqGTgggXdPMWjfV5W
         M6aw==
X-Gm-Message-State: AGi0PuaF6MnpwWw0jvmu+wGXwIqn7kNyPI3ADajAePkdYhctQeSfU/Gv
        nf8pSsE01PxvvZA7CYdyIAs/Hed+/4Z9Ag==
X-Google-Smtp-Source: APiQypJNFnYwbuS2xi8dA49XKVMcqRvoptJd8A3fVr/x8ct+Ixbn3LW9/DAsNtU6s1SUh3SiapWMQg==
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr4064657jap.93.1588355676393;
        Fri, 01 May 2020 10:54:36 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k3sm1510390ilf.67.2020.05.01.10.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:54:35 -0700 (PDT)
Subject: Re: [PATCH v3] eventfd: convert to f_op->read_iter()
From:   Jens Axboe <axboe@kernel.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4037e867-af74-6a11-a501-7e5b804beec5@kernel.dk>
Message-ID: <222126cc-0eb5-31b1-2a31-ef1ff2b24f72@kernel.dk>
Date:   Fri, 1 May 2020 11:54:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4037e867-af74-6a11-a501-7e5b804beec5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 11:53 AM, Jens Axboe wrote:
> eventfd is using ->read() as it's file_operations read handler, but
> this prevents passing in information about whether a given IO operation
> is blocking or not. We can only use the file flags for that. To support
> async (-EAGAIN/poll based) retries for io_uring, we need ->read_iter()
> support. Convert eventfd to using ->read_iter().

Attached the wrong patch, forgot to update it... See 3b posting. I ran
this through my io_uring related eventfd testing, and it looks good.

-- 
Jens Axboe

