Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D710C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FCE21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ou7OV9nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGQMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:12:43 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41751 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:12:43 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so2134072ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lAnZ0KfpoJFXJXqEJp2h1hR24YKg8DCqzE8GT1Sg/80=;
        b=ou7OV9nXB1rt4NAnNWVFHl5DT/z7arx3n217cok5UsX7/dZAEB/6gZZdgo5CRHKbtq
         5MlVqxPBMVocDORdwmh/qiT1eSTmkMlpW+xIzeN3lYZj98PTiGVeUysgpuqebVnyMfiq
         THrIoHPrfTrSpAMEGRQRuOOADT1okKx60iaHfjSi1C1VhnvFObLxss+/wqKfXI7daUDo
         pU/yQEV036+gvU2gQoav9vyoYArKiK9vm0yjiEh4WmHKM/WvGTROd9a/JsKEr/iXZJcR
         ldiZWBGMsC3THXrmtMnOunfqXpg7KjPd+OY2Uh2TwkySzeCQVCs2nUoko9r8tFVpqwk3
         j47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAnZ0KfpoJFXJXqEJp2h1hR24YKg8DCqzE8GT1Sg/80=;
        b=m0hw/yguitKGgqiY14MgRerK1JUEQnmERtOhi+8KkuzmOq2fU/6c3Qk47Z7bH3u9Rg
         0kzmfCR9ulIlcHvEypHlkTMGvDAkY+8BexTm5CXEMdfnMOj1hg5RpQ4fDxb/URxwGHz0
         SxD9B7OjeXZf9VR/ZlzUmGCIPjUQ3dqIACVX3qDiNWRjK9S6AFalDYI5VimCutIDzy7O
         M98f0I9Jk89LjwqT4gccPSIcZiLyk/hYWCEWFZ0rB0mGpc2mTu45pgTRSZMXqg8t55gZ
         9JmWTxarzRYg2V78vygPvqvSh2T7AnXDtCM2dRoZxVj9L14pNL66chAhBEYCw38MnJj3
         ho2w==
X-Gm-Message-State: APjAAAWBfFanM+ypAdjzTLpUS8c0Ie1EOyHJXGLGW2ghJWhroHpfC5h5
        LTO0QhrlbGin3W6jpKEQuMkUelM2zRo=
X-Google-Smtp-Source: APXvYqxlLfKpSh0/MAQWoZOGzqwYq4/oCYfhJFBjQabCpXWy7DdmtSgrXlico21x2I3TZIkM7UM2Dw==
X-Received: by 2002:a92:3a07:: with SMTP id h7mr87346ila.203.1581091961049;
        Fri, 07 Feb 2020 08:12:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d7sm999245iof.14.2020.02.07.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:12:40 -0800 (PST)
Subject: Re: [PATCH] io_uring: flush overflowed CQ events in the
 io_uring_poll()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org
References: <20200207121828.105456-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0acf040c-4b00-1647-e0c9-fc8b1c94685d@kernel.dk>
Date:   Fri, 7 Feb 2020 09:12:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207121828.105456-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 5:18 AM, Stefano Garzarella wrote:
> In io_uring_poll() we must flush overflowed CQ events before to
> check if there are CQ events available, to avoid missing events.
> 
> We call the io_cqring_events() that checks and flushes any overflow
> and returns the number of CQ events available.
> 
> We can avoid taking the 'uring_lock' since the flush is already
> protected by 'completion_lock'.

Thanks, applied. I dropped that last sentence, as a) it doesn't
really matter, and b) we may very well already have it held here
if someone is doing a poll on the io_uring fd itself.

-- 
Jens Axboe

