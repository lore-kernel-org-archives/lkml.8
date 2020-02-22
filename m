Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABBC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7560620702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ro51XH06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBVRFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:05:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38948 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgBVRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:05:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so2204758plp.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ar43/pIEDTuzXkqZAaJR3YM1BZfZyVYtyTj0Sx88Fts=;
        b=Ro51XH06xPU2FxAhIjNX5OSNDvjJkYl9w9QUX4+23kDBCaGRB2hd3uxOay0J5dfcaX
         4JBzuFgRWGnO0Of8H7FYnllj4jj3s14+f/vQ7L+nf5vh70/6EJ3QKrz9ir+H8K1D7MMn
         S3vLxRNvsTXuCOZdF4/lCFIcLxLdWrdx0khle71GBGuTKIuBtnqUsYwwMVM4C4/u9MHi
         FgXJ01bzGAXgUixp+fNoK51Fg0XzXtqbAHwVA2izAovyf5q785LmWBNQ2F3jiZSU0ZJZ
         5GSihRmZAY5hix+RxNZiHTfkCJgLX22TQwsuooIrgJxKbiEOlZv6KFZp5JdqF0i9tgOY
         a+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ar43/pIEDTuzXkqZAaJR3YM1BZfZyVYtyTj0Sx88Fts=;
        b=AqzsBdxVEq/PNVRh50tf1DtB8FpcL8O7sh/RaeQGW95JJoHR+YuIhDjiLbJD5EXIeE
         C0+kxADKB0C4p/psWZQRRI1A44loQhb0/bXIG9NntyQVtaATzyhLjhRNrn0I/z1ODV0a
         eeRlW09RUeQupSGg8BxsZ6EPwEShh4SVzIjebHcAoMT4xRepsCELy617wAQ0cnuyp0YQ
         XeHwP/b3B0YWr1zw4q1FLodcZLeQdZdUe6PcTZX45HoUtJPW+0KpcVHpK+7hk8HuQYpJ
         CbfQh/lW1m+1H4cXVin74KJxPDKnKfSfzlZ0HRHlzDdSR5le7CfXqD3spvJEXbgRhKqF
         M3CQ==
X-Gm-Message-State: APjAAAW3gZ/nsgFE30wm4DNUYZuQxv9X3L3cOigWbET6WWbjsyYy445x
        C2l9zzAxsG4/kLLPl8Mf6THYt3wnvjM=
X-Google-Smtp-Source: APXvYqy4MdZ9sr7ap6ZA6+hwn3NQQbOGOOi/z1blhPzoD8hhWy8LO5RhzOkrYC3+nJWQWCqFh4JzMw==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr10064966pjn.39.1582391132757;
        Sat, 22 Feb 2020 09:05:32 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a99e:da38:67d8:36ae? ([2605:e000:100e:8c61:a99e:da38:67d8:36ae])
        by smtp.gmail.com with ESMTPSA id c15sm6786491pfo.137.2020.02.22.09.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 09:05:32 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.6-rc3
Message-ID: <fdbadf53-2421-d0a7-8883-059c34608cd0@kernel.dk>
Date:   Sat, 22 Feb 2020 09:05:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Been mostly away this week, but here's a small collection of fixes that
were queued up for -rc3. This pull request contains:

- Remove unnecessary NULL check (Dan)

- Missing io_req_cancelled() call in fallocate (Pavel)

- Put the cleanup check for aux data in the right spot (Pavel)

- Two fixes for SQPOLL (Stefano, Xiaoguang)

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-02-22


----------------------------------------------------------------
Dan Carpenter (1):
      io_uring: remove unnecessary NULL checks

Pavel Begunkov (2):
      io_uring: add missing io_req_cancelled()
      io_uring: fix use-after-free by io_cleanup_req()

Stefano Garzarella (1):
      io_uring: prevent sq_thread from spinning when it should stop

Xiaoguang Wang (1):
      io_uring: fix __io_iopoll_check deadlock in io_sq_thread

 fs/io_uring.c | 65 +++++++++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

-- 
Jens Axboe

