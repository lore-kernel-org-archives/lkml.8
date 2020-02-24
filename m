Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8336EC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A4F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NLvGifZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBXPf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:35:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38316 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:35:56 -0500
Received: by mail-io1-f66.google.com with SMTP id s24so10671707iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zddawmptTj8O/iOFAeDEIVRJudMFVZUKfFGPqjx1LMk=;
        b=NLvGifZF6nw+IxiFIhrBLRrajvZsnwn1tkIxXaXebNAqQHMSuIBDN2uVpU6oYpef8H
         YcAsxc1k6I4XLVgnP/rr3t6/nGF8DUpFgf0RBC3eDBl1skBwR2b+XcQNzsmb9DkMPk/h
         kTQZaRz76MdM/7+E9AgkSMHFh1DMeJCljGydy2AB6sd75EozDgzhpGd4fszRSu6MkPoH
         d3qbbRezx8I+B8ILIZtOYrllU3XNFtpUiBsIMaZckU4xZ1qaE0AW6VKNpzPzKEyWnE9c
         O9s3ovM1lZjclsudzHwkv1PmmFUUwFjX24yERfq0Bn0s9xZhQkYW4EVxMMsan6OxCF3y
         tHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zddawmptTj8O/iOFAeDEIVRJudMFVZUKfFGPqjx1LMk=;
        b=pqnTpaBMpkBRrtampGwz7st0PxGUiyqaU7JrVa73FXkKwWkB9w8gysI9iwsN90UGnU
         otynP44UFdgRYJkDl8/Psg3l9tWWWYVaicatjHJeT2+PFwlfqiAV+TWT2EJj9UFXLYJB
         XkeY6cig8svtHlEMI/NwCDs8tLMP49vqGjA4IVpnWi201wQresfYY25TdbpeaLVwydf2
         em0f1xpJL+4PnKObsTZ3HllDtbAOfxcCrurbnfNd8tcdVBFJae/OBb9nW7+LIzki+M3k
         Xlys683UuQloU84Vyod5k7rWmZrkKl2/kdmCZTEdjk6mg00Xpi1byw+DF1lFKGo/kWfm
         XG0w==
X-Gm-Message-State: APjAAAWa7dKuToTdyXIQhxNrN78YBOlJDhLchVIPBchU0evSuKNOudHd
        T6mYec2MFC2zyoqrD9gCge6bApNBtPg=
X-Google-Smtp-Source: APXvYqxJLYN7KxGZRPJQFZnCFWyWjTrI95KeI9Mk/yjMubZC8gJzK/dCmDDDpmGRE3GeVaB1yZIXeA==
X-Received: by 2002:a6b:6604:: with SMTP id a4mr54584788ioc.300.1582558554596;
        Mon, 24 Feb 2020 07:35:54 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v5sm4426550ilg.73.2020.02.24.07.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 07:35:53 -0800 (PST)
Subject: Re: [PATCH v4 0/3] io_uring: add splice(2) support
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1582530525.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <923cc84a-e11f-2a16-2f12-ca3ba2f3ade4@kernel.dk>
Date:   Mon, 24 Feb 2020 08:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1582530525.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 1:32 AM, Pavel Begunkov wrote:
> *on top of for-5.6 + async patches*
> 
> Not the fastets implementation, but I'd need to stir up/duplicate
> splice.c bits to do it more efficiently.
> 
> note: rebase on top of the recent inflight patchset.

Let's get this queued up, looks good to go to me. Do you have a few
liburing test cases we can add for this?

-- 
Jens Axboe

