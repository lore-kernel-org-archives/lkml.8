Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A87C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D3B20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lga1hOFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDIPhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:37:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgDIPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:37:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so4265960pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TKFnQAFnWMn5UFO/EsT8tWgGf+HCjIiBBNg90hYT500=;
        b=lga1hOFHT5t3yzVksB9hnoe2kAuFoEzho/Zc8pWQ6LtnWHCZHvxUYE+dwHGH3Cb4l+
         9mXDNgwnQa6KrPgiFMVidW2OK6NDUR49Amb+OnCRjMzCXmcFIYRNsfkjx6Slp+mp+9Uq
         6YKMmVgED+mHqRWPcC1YPil3URqlt0vpiROdDBde138nV6FxAKocB1A15j6i+x8Ypf/y
         1lfHRZ5B7cGWtjsGgf34CgbaTxv2jJR9a55vpGjN61SNltMO6zKAomIzfimGlMqO3Gl9
         KB2zGdZsvBLM+Fvp0d0yJJ44wAyjp7OOCnExK+PVcX/GWNzVuLs5DTWANqGFyv8eaBAU
         qVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKFnQAFnWMn5UFO/EsT8tWgGf+HCjIiBBNg90hYT500=;
        b=ahnTSa3cAVZHJVuy6aRJoOKLpGQLWmig1FRSsKrYjOlDdF0Kh59QRgoziJMb2zxMdO
         k7wEn0+phTvbJqpRc4OrDC2a8yF56UjxeV9HpV3AjBekT6CmaHIchYcK4kFb/6MUNsk5
         +Mh6UxCdbZ9rC/BlyT1Lvi71jlrz3/fvge5oUBD5/HRBbOsuHOPA88wNLmtZ2JxWfjAR
         9EQ8PlNcaxh1X5KUN68o03kRwyvqz/GJxja7J2iPjXTnrPhK2KDYZQdhFuwf7GaaLrCU
         li4BY7FRtlwkuxAJt9MTb/r1SH7b1meH0Pb9JbrmLw9MEJT+P8be6YhXWcdeq3zvlx/K
         46kw==
X-Gm-Message-State: AGi0PuZDyMBh8kP8UiZH13K83nAVmc7/BBfZ14/MpOJgUSL7IKXC5YDy
        1xEFkrRVgIz6bOtfxOHX5x2DFQJY+sJWxQ==
X-Google-Smtp-Source: APiQypJJXDVaBg73bN6pbtNxwbnerQqzdEtz0q+Hs/6NEjKe32fg774SNnlOm1U/FnOJpCNDokWo5g==
X-Received: by 2002:a63:c504:: with SMTP id f4mr45266pgd.292.1586446656554;
        Thu, 09 Apr 2020 08:37:36 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:70f8:a8e1:daca:d677? ([2605:e000:100e:8c61:70f8:a8e1:daca:d677])
        by smtp.gmail.com with ESMTPSA id u13sm2531508pjb.45.2020.04.09.08.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:37:35 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix fs cleanup on cqe overflow
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <72e624af63743f265e25da90c322bd45b9d4feeb.1586409373.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8571766-1ae3-00e5-045d-6b7d5ef2c72b@kernel.dk>
Date:   Thu, 9 Apr 2020 08:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <72e624af63743f265e25da90c322bd45b9d4feeb.1586409373.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 10:17 PM, Pavel Begunkov wrote:
> If completion queue overflow happened, __io_cqring_fill_event() will
> update req->cflags, which is in a union with req->work and happend to
> be aliased to req->work.fs. Following io_free_req() ->
> io_req_work_drop_env() may get a bunch of different problems (miscount
> fs->users, segfault, etc) on cleaning @fs.

Good catch, applied.

-- 
Jens Axboe

