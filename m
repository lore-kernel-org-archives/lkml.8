Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1022078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MBM2K/qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:41:58 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CDC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:41:58 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g14so8459088iom.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hzbm3U98VQ+ShITvSxX5QCW9SBtJ8CzZvSrTwXTlKwM=;
        b=MBM2K/qelVHRwtlKmhypAUIfRGzEcAeP0Pqv1YTk9a/T+e9Ek5fRA/e+QI9wJ0oOLX
         6ZjS0N4WJ6XMC++IxkV4RrNtoZpoJgCV3MSJIjt+w0Uzh5nGBIHE7ZLlB3bIuUKwfEN4
         rYQNoaWD1smF5p3ftzsFvrnC2BLucG8Vz0rMG8OqqK68GLsGQDQ7Vhu4UQx704MBzMtV
         MgKMes0fQ0tDItr/cxs0aPHxHq9X5RYav0EieWK9ynngPDaYbSqNqepVItfC2635gf6F
         gDYEoEB5cDrFjYbks+BN5ko/UUAK3slq+iLik138fx0pIzAjJ6AFA29yCSz2FvO9dzDX
         x/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hzbm3U98VQ+ShITvSxX5QCW9SBtJ8CzZvSrTwXTlKwM=;
        b=l8YiP9wGejHYETtEeQ4+4LQ9nd6x4pkne0kT5MkdJFUPD8b96B4f4Y9xbtiotIQSHF
         NEAw2wgwYKGkuAsevaCUqt2x9VGTjhWxMmbjKSrt9rrVRS5j0RO+ODlImareTAd8WQVe
         EWqChjnq2u/ojmwcYYfBm3rEvyFD0vEmmvp2TMNlwrI3vv9LbNJApPAtre667ry27az4
         bIMf8rmdNeXg463YDQ3YYk7L15D+5xRaErt0maXGRMVUWtPkm8SD22kuCrlibEGIdC0H
         3mr6rL8Kfd1FYrWvs7p3YgvLjxSE1679O9B+/HgRNhn4w7Bpvq9IEORvPh5KZoRWoUAt
         hc2w==
X-Gm-Message-State: AOAM533pSDUcg6byCI6Cw61rx/U7PdmmDDiOn3OvMX8ZJ6siHk17i4As
        LD/ys4bDfFPlcnFqmUZFvAzQjBQeZvY=
X-Google-Smtp-Source: ABdhPJzTr+uvcNkptOs34udM7mfT+B14s08iYIxU585rhdBeyZLeRDtASILST6RNeJ5IXxSMKFIdbQ==
X-Received: by 2002:a05:6638:214d:: with SMTP id z13mr6691818jaj.7.1597344117686;
        Thu, 13 Aug 2020 11:41:57 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm3041838iow.21.2020.08.13.11.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 11:41:57 -0700 (PDT)
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
To:     Jann Horn <jannh@google.com>, Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20200812161452.3086303-1-balsini@android.com>
 <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c135d701-4455-95c7-e58a-82e8075d2ea7@kernel.dk>
Date:   Thu, 13 Aug 2020 12:41:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/20 12:29 PM, Jann Horn wrote:
>> +       passthrough_inode = file_inode(passthrough_filp);
>> +
>> +       iocb->ki_filp = passthrough_filp;
> 
> Hmm... so we're temporarily switching out the iocb's ->ki_filp here? I
> wonder whether it is possible for some other code to look at ->ki_filp
> concurrently... maybe Jens Axboe knows whether that could plausibly
> happen?

I looked into the io_uring use case, and we're using req->file (which is
the same as kiocb->ki_filp) after submission for the polled-IO case.
That's IOCB_HIPRI, not poll(2) related. So it's not safe for that case,
but that probably isn't supported by fuse. But something to keep in
mind...

In general, kiocb->ki_filp is used for setup, and then at IO completion.
That use case appears safe, as long as the ki_filp is restored before
->ki_complete() is called.

Only other exception should be the poll handlers. They arm at setup
time, which is still fine, but re-arm if we get triggered and the file
is still not ready. I _think_ this case is still fine without having
seen all of the bits for this use case, as we haven't actually called
read/write_iter at that point on it.

But in general, I'd say it looks a bit iffy to be fiddling with ki_filp.
Maybe use a new kiocb and stack them like that instead?

-- 
Jens Axboe

