Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429DC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE92E20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ABZfSEws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgD3TwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgD3TwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:52:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342ECC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:52:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so1299193pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yFism+I4O6MfQ6MRmwj94cYLydvQt2/w8BD993n5VWo=;
        b=ABZfSEwsV1VLYG59/UynFuYlWMWy4kR/W09o37ftty40EYSGB5Wmrp7yHOvw6/bpDp
         BJLWGLkoZjHshNVmGGvItGPyUFhvts1E90bh+9lEvV059qLRmX/8/uvqvdEndz7SE7t1
         O3JyGKLMVO7g16zE7nmmi95FrbeGt58RhbtQ614B5/zdtFjk5RJvDes3XZsz2/5mYc8c
         TJf37qd3gIC1FZvWmBVnmrgu5yzFnktUFjSmk2gdxzjvPsNKvWf/WrmLXmfTK4MZzyIY
         ob+RLIV8KFA8RznQYHEBEvlgL8dJOEoCzvufWHIJwkYSajlBW6Rqr+tS2nfTo1Elg07x
         Bccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFism+I4O6MfQ6MRmwj94cYLydvQt2/w8BD993n5VWo=;
        b=GyazwgKnCkw56nQABmHWTZy5PFeKmgKGGsqb3DJRXP8nA3dpmNlwy7o0ad3kI5gh6y
         WW1xQGPZuFsXX34MK3UjhLd95TmdTc4Q/xgUZhbaOUb6JqmE9v+o5qhdV5EmeYHdOcfn
         +mzgfkQ6K5rx/8N00IiSAozNwT8Rld90Fb/thuuKBe1BtXWu1aGGZOK2ZOzKSC7zaD8l
         pkWehCuU9/1wusVEbrVP5pepWxTlNrwWnwazxS8FV1q+HGDZwSRTQ8sy7NWlVUbASINg
         bmCODvYjL8+il1TGLF4Fkr4TImqry+MXh+xq7DNy4RfGNEIsv3B+FXlWLHdcGMZNv1yJ
         zAxg==
X-Gm-Message-State: AGi0PuaiAUKCS292lQBJ87LZpleBlcbqzR+LBvCHUdh9PGYtietZF5UV
        LQb3p3aGsZCELWbOiZM07Dz7447zjW8+SQ==
X-Google-Smtp-Source: APiQypK03eqVAGWd1E3h/uqkrtARYMFce4LorMdCoKF2HtB35eZrfEvlrECjRcrU2Y1NL9LjR+XJrw==
X-Received: by 2002:a17:90a:3726:: with SMTP id u35mr514438pjb.162.1588276320260;
        Thu, 30 Apr 2020 12:52:00 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id k63sm478083pge.42.2020.04.30.12.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:51:59 -0700 (PDT)
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
 <20200430175856.GX29705@bombadil.infradead.org>
 <d00f0ead-2782-06b3-6e21-559d8c86c461@kernel.dk>
Message-ID: <bb78a400-8af5-aae8-8049-fd37e1a4db07@kernel.dk>
Date:   Thu, 30 Apr 2020 13:51:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d00f0ead-2782-06b3-6e21-559d8c86c461@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 12:47 PM, Jens Axboe wrote:
> On 4/30/20 11:58 AM, Matthew Wilcox wrote:
>> On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
>>> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
>>> also check for IOCB_NOWAIT for whether or not we should handle this read
>>> or write in a non-blocking fashion. If we don't, then we will block on
>>> data or space for iocbs that explicitly asked for non-blocking
>>> operation. This messes up callers that explicitly ask for non-blocking
>>> operations.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> Wouldn't this be better?
> 
> Yeah, that's probably a better idea. Care to send a "proper" patch?

I take that back, running into issues going with a whole-sale conversion
like that:

mkdir("/run/dhcpcd", 0755)              = -1 EEXIST (File exists)
openat(AT_FDCWD, "/run/dhcpcd/ens7.pid", O_WRONLY|O_CREAT|O_NONBLOCK|O_CLOEXEC, 0644) = 4
flock(4, LOCK_EX|LOCK_NB)               = 0
getpid()                                = 214
ftruncate(4, 0)                         = 0
lseek(4, 0, SEEK_SET)                   = 0
fstat(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
lseek(4, 0, SEEK_CUR)                   = 0
write(4, "214\n", 4)                    = -1 EINVAL (Invalid argument)

which I don't know where is coming from yet, but it's definitely
breakage by auto setting IOCB_NOWAIT if O_NONBLOCK is set.

I'd prefer to go your route, but I also would like this fixed for pipes
for 5.7. So I'd suggest we go with mine, and then investigate why this
is breaking stuff and go with the all-in approach for 5.8 if feasible.

-- 
Jens Axboe

