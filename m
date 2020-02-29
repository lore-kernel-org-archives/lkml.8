Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5902FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA512467D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 19:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R4z/DKbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgB2TAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 14:00:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43866 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgB2TAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 14:00:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so3259116pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sac+PmgYd9Ne11i2xBwpQkfiU9kowkipYWbptuvvnFw=;
        b=R4z/DKbtXdeAv/OuQ9d9v1ISo1ATLBmrv2aWuysEW6ooe9h/rTPgAsDKZ2YC/SI2qN
         MQzEDeoyWr9YLkRgu2iMAlzPXKvIs4/CjfAq61jcEa/CievVDrR/url1Bb+Rin1TSzU1
         u+Cm0F73kwxd1TyaVA4Xb8DLPHSJoEUJ18h83f8DqYsirz+SnSvlvpfLUOyFldACkYbF
         6F87gV4d9DhZ4D/mvb35oAPn6GgBhAti0rvCO0XtrVwKd8pazmiJ89kDrFIcRQ4e0ON5
         hU1kGTLpQ8c1YF9C4N2odM2ewfayyryKsJexxp5nENCpyvJAt01Ye47aO4ZH8oLHjW4+
         TgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sac+PmgYd9Ne11i2xBwpQkfiU9kowkipYWbptuvvnFw=;
        b=WoPLdjoVuCpXAitXPEEUjTjek9Q7xBycLZB6r6FrNEIV1uO8Rz0abNyWZF9A82pNpR
         kpPhQCnrGt4T+3TyA3Bc0KDNFVkxNM5w+C4BaggHAcsOeriJ8McCb2MDd9UE5jlHWD60
         4vKQM04Rp5J2J5532hRVE2rNs07aT7AuBWz9ngrfPxwOM5Xm0F1GFCbnHIs0QaLxFE9I
         sJyDIy5zuSkpVi8A3LqsiimovDfg8Egzu+mZI85bTGf9gDTsHCaOpn4vyGFip1Q3ah0z
         3hCcmkwKAvBIvhKFuEHYTJcPeRxoqONx6A+rQRVW6wS7rJbe3e77jA7zT0R6zgPKnWLq
         Zv4Q==
X-Gm-Message-State: APjAAAVRNVagrkT7GOvkaCwb61MYSak++he8qESG7CBmjio3G4G7irCI
        b2cC4t9E5UOIZI52zTjWiX76XAe0wkQ=
X-Google-Smtp-Source: APXvYqz90h5w4fCAbtOaE+wTOBQxEsX0PHZKmmlOg/XiBkFXddKf8Ow0liaSJQeYrTlCAmaJcIIPpg==
X-Received: by 2002:a63:214e:: with SMTP id s14mr10713408pgm.428.1583002814148;
        Sat, 29 Feb 2020 11:00:14 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q12sm15368255pfh.158.2020.02.29.11.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 11:00:13 -0800 (PST)
Subject: Re: [PATCH REBASE v2 0/5] return nxt propagation within io-wq ctx
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1582932860.git.asml.silence@gmail.com>
 <fc951f93-9d46-d94d-35af-4c91a2326a0b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b366775-6d00-3353-995f-d284d78e9a4e@kernel.dk>
Date:   Sat, 29 Feb 2020 12:00:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fc951f93-9d46-d94d-35af-4c91a2326a0b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/29/20 11:44 AM, Pavel Begunkov wrote:
> On 29/02/2020 02:37, Pavel Begunkov wrote:
>> After io_put_req_find_next() was patched, handlers no more return
>> next work, but enqueue them through io_queue_async_work() (mostly
>> by io_put_work() -> io_put_req()). The patchset fixes that.
>>
>> Patches 1-2 clean up and removes all futile attempts to get nxt from
>> the opcode handlers. The 3rd one moves all this propagation idea into
>> work->put_work(). And the rest ones are small clean up on top.
> 
> And now I'm hesitant about the approach. It works fine, but I want to
> remove a lot of excessive locking from io-wq, and it'll be in the way.
> Ignore this, I'll try something else
> 
> The question is whether there was a problem with io_req_find_next() in
> the first place... It was stealing @nxt, when it already completed a
> request and were synchronous to the submission ref holder, thus it
> should have been fine.

There was only a problem with it if we have multiple calls of
io_put_req_find_next(), so it was a bit fragile. That was the only
issue, but that's big enough imho.

I'll ignore this series for now, you can always rebase on top of the
other stuff if you want to.

-- 
Jens Axboe

