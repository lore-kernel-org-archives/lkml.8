Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D7C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A240205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xgAlfPF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgCOCb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:31:56 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39009 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgCOCb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:31:56 -0400
Received: by mail-vs1-f66.google.com with SMTP id p7so6750739vso.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SdOYsMZFDHe9vqNvSdxRkcSwQBXCi2657j9Xa2tK9oA=;
        b=xgAlfPF/jH19mCf3oilauqnvertvFGN4reqpz1II3RvLTUdEG1XjtuLT8GB+7rw/DG
         ZzU1/5ECQCzgWimMdZiq5PqAGKOk28z0eOks95Ksf0BVFzH+8qujmfqN9KJ3Cl4iKO3h
         5Ca0xO2QG14yS0E6801I5dT6odvBnpqmEDYRU6fZC0ZwEvPRNrxJ5vG+99jI/DBYxSUN
         KdG2cWMcoWd6plprhdjoQZD4Y0jM9jZFSvU73u33d7mEyvCpLxv3pOSAL9tRBVI8E1DK
         hZ3Lwvu41Jm6NJsEL8pA/aqJsnZwC3AenvE05fCvwm+llph+hEg+oC7T4/CjW8PzaiY1
         +6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdOYsMZFDHe9vqNvSdxRkcSwQBXCi2657j9Xa2tK9oA=;
        b=CCEphJP/u16SeV5YQebSbkTvaONJVh1VY4B3O+FRuW/J8Q5FnK6arixEeCgMCxnpKt
         NRPHyctgHE4tnWcVK3DxMFzZcwMYN6yFzgmbcBYLlhn8J5bunfSfDO2bdTGJe+wpnDVr
         CeIV2Icwjyr18q2r1grkjWgi0Tb00/P34wN59Ab2ZBZ7j4yVhnluSBCAJRFBqfsYOU6R
         FQn25ZJ7XiAYimcWZjScSBot0vVbv/QIzXNNlJdIVR275pfH/Ie6lVq6wXOlvo0iGqEV
         yrWqPZV1wdPbI9mYAAYGL2u5kamEUa5tnIo0RR42A5iPdzMUPOdBGvrFJKO+L9W/bnIq
         aVYQ==
X-Gm-Message-State: ANhLgQ3E8WtkYTtGwwPCq80UTk4rY0a7DnS0CHktjZTIDxa0lnbovCdx
        mq0sR+6urk3eDW+82LNsxQPmtjLgGlozEA==
X-Google-Smtp-Source: ADFU+vv8d06cooYnEyYmyLwJ5MAPGncbMbhQYSytgYgCc67JuVz17NdDF+7aY/joqlDV2aEOjDBwZw==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr20495125pla.326.1584227898541;
        Sat, 14 Mar 2020 16:18:18 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u3sm15469459pjv.32.2020.03.14.16.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 16:18:18 -0700 (PDT)
Subject: Re: [PATCH 0/3] support hashing for linked requests
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1584130466.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6af1ae2-dfdc-00b3-4b33-f6d5a2f63f0c@kernel.dk>
Date:   Sat, 14 Mar 2020 17:18:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1584130466.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 3:31 PM, Pavel Begunkov wrote:
> That's it, honour hashing for dependant works in io-wq.

Looks good to me, applied for 5.7, thanks.

-- 
Jens Axboe

