Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF94C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B863F20757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sWO4PNY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbgEANzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730569AbgEANe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:34:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D42C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 06:34:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so2303726pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+bmrtSHAyFI7P6ziJ3xGe8cTwBT8YOneJTOxmYdhGZc=;
        b=sWO4PNY9YAPlMcmQTFYRy58u3AGk/QRym0idM1ioVic2+sgGTcaVvxbRjP529xqfKo
         QIY5xGGj0avqcE8fEdZEcmZttXUyjQhoKQFJR8zc9ocM8keWbLpJ0KDLD+j8WjDDtsdI
         dhgVsmF0w2V2wqVrSe1MY711Uebu0smXDe3nolZ7UvkpSYjcA29No4nXX1zShE5IrBmO
         uZcnPFpxjsowt25d6A/HMu+4gw5oTHDNekrJ6CNLntaDKePyVY0pXPTh1+kG2osYMl+H
         B+RXPJVdTonCU3tSlVFljHkrXOVfL+OHrakrJolGC6ifg5LdN24VKGVbQyp3In3GQjpl
         TvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bmrtSHAyFI7P6ziJ3xGe8cTwBT8YOneJTOxmYdhGZc=;
        b=EGMsIORxhW8rie8tnrtTW2clcbVSTJyewCxzDp6HeaQITM0bIpZyX3tP4sd/w4dnA7
         H3edfX1UrjJt9uJesG+fYKZ9Rbxb2I/vX9Q13vDHSO6UtO1MIkb8MV5kKD/NIq6rlI4q
         Mhpan5n8umqaizFhlmsHapRlaycEbj2aYzF8ufa4jnjAewpm4HVhRdDYcyxhR3Cv5J+z
         bSaoSzkE10yfuTWYFtwU/CCTzrcSO+Zzhg5Jl6EpC19Vm3ZG2yV3bjPUwv6QiDOv+qA2
         a6ny39fg7ObRKs1JK9e5ZQWzqvL5+vsVG5MEnmSsHxLUGXLOs8fs4OOf9iIkpFF+mJQo
         l7aQ==
X-Gm-Message-State: AGi0PuY+jlxBUFoBbt9yXrUkExY6Vey8ebV8Z2RigRxGlttq6hyWLO7V
        70Yb8/rI5yRINNZHkuwmI5xSC6wCDdrAaQ==
X-Google-Smtp-Source: APiQypLxg0DxSuXSZ6n95JDcUikNRX6xaAN5w06xsc1r2DmCej7hLmZ2BDXQTy8ezdmV4N/JvVd9Ag==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr4070767plc.209.1588340067042;
        Fri, 01 May 2020 06:34:27 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i190sm2323153pfe.114.2020.05.01.06.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 06:34:26 -0700 (PDT)
Subject: Re: [PATCH 0/5] timeout fixes
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1588253029.git.asml.silence@gmail.com>
 <8665e87d-98f8-5973-d11a-03cca3fdf66f@gmail.com>
 <8d9b5e06-4100-c49a-c9ca-0efc389edaf3@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7aefe37-d740-5324-905f-1b095cfb4ea7@kernel.dk>
Date:   Thu, 30 Apr 2020 22:26:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d9b5e06-4100-c49a-c9ca-0efc389edaf3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 3:38 AM, Pavel Begunkov wrote:
> On 01/05/2020 11:21, Pavel Begunkov wrote:
>> On 30/04/2020 22:31, Pavel Begunkov wrote:
>>> [1,2] are small random patches.
>>> [3,4] are the last 2 timeout patches, but with 1 var renamed.
>>> [5] fixes a timeout problem related to batched CQ commits. From
>>> what I see, this should be the last fixing timeouts.
>>
>> Something gone wrong with testing or rebasing. Never mind this.
> 
> io_uring-5.7 hangs the first test in link_timeout.c. I'll debug it today,
> but by any chance, does anyone happen to know something?

That's not your stuff, see:

https://lore.kernel.org/linux-fsdevel/269ef3a5-e30f-ceeb-5f5e-58563e7c5367@kernel.dk/T/#ma61d47f59eaaa7f04ae686c117fab69c957e0d7d

which then just turned into a modification to a patch in io_uring-5.7
instead. Just force rebase that branch and it should work fine.

-- 
Jens Axboe

