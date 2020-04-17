Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C1AC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCF520936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WETNw5cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgDQPQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgDQPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:16:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F89C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:16:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a22so1192393pjk.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YXR192pJ0exfYgl5biCYmiq8w0qm6d+pqJxZoijZXpM=;
        b=WETNw5cjPKEZXdPr4UHoLTfslN5t+iZ3Lz4PInGXGGIn0Rq4Acr8uQ5HigeEMhJ2fO
         mgbRUONJMqlCM0fEKUu5DQgokOZVPlfxZFvZ1cA4SsAYFxyQ5B8ovjpz+zcCFn4ygZeS
         3NBv/N+NIgt3jpUwFE7REfsOvZIDLS2yt3S6VmFGFrB+5ScAU7py0F64usy65mYrB6qY
         RT1cgbB/EdVBaiKxxCln6Ax052S1xRURHWkDUy0PF59h/LILN9IT46sb/psv9N4rh+GZ
         ulRnqsyz8b+jwyeqSPdRocao6Uy0al72x9f98632KSYV8NJifn3+qqu3NeqcqKFwGPKM
         E7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YXR192pJ0exfYgl5biCYmiq8w0qm6d+pqJxZoijZXpM=;
        b=j42Ll+Aju+oTWfYj2NeBIvVFYH2IkL2WhAhRXdAzCXH5HtH1U2z4doUuDEo1KRsmKM
         ZrWUU2jfzkAZAwx7Y1vFR6NX7Bk+0kNxCiF2fQhyTQdRWxc3rmyJfz0Fnpapl5Scf0xz
         DQntT8kX8JJJDvw9wSc8m0hI9c55RsPr1Wi/XGCsb9gXtvGSqnWPglXvSAPFtTNeofFn
         9U6sJqo65T5QxHhGdCZNdH95HdC1B6Y+nhb99iZJpSo4yMmHtZUJnkXcPu1D4Wf51A62
         iibWMGpbp79DgAVmI1h8wliJFgXEgSnM5dNOFGd8BUHd7T9B90+Nhx+w8TQvWxLzQffd
         sG+g==
X-Gm-Message-State: AGi0Pub0YJFP19pqxES0eM2qxvtcRiV2XsDna0N1W/gKDrn4Qq7NlUrB
        iFlg5R4T25HfyBbi3MSY+dK6SA==
X-Google-Smtp-Source: APiQypIYts3zNYQ2qzCLlhtBdzBnl1UQdUdvk2IzdQmqGvmKKz/8pfPFk+wflUPTHjShsmnV/NqJwQ==
X-Received: by 2002:a17:90a:af8c:: with SMTP id w12mr4948192pjq.37.1587136600941;
        Fri, 17 Apr 2020 08:16:40 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y26sm14710926pfq.107.2020.04.17.08.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 08:16:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.7-rc
Message-ID: <2750fd4f-8edc-18c2-1991-c1dc794a431f@kernel.dk>
Date:   Fri, 17 Apr 2020 09:16:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

- Series from Pavel, wrapping up the init/setup cleanup.

- Series from Pavel fixing some issues around deferral sequences

- Fix for splice punt check using the wrong struct file member

- Apply poll re-arm logic for pollable retry too

- Pollable retry should honor cancelation

- Fix for setup time error handling syzbot reported crash

- Work restore poll cancelation fix


  git://git.kernel.dk/linux-block.git tags/io_uring-5.7-2020-04-17


----------------------------------------------------------------
Jens Axboe (4):
      io_uring: correct O_NONBLOCK check for splice punt
      io_uring: check for need to re-wait in polled async handling
      io_uring: io_async_task_func() should check and honor cancelation
      io_uring: only post events in io_poll_remove_all() if we completed some

Pavel Begunkov (8):
      io_uring: remove obsolete @mm_fault
      io_uring: track mm through current->mm
      io_uring: early submission req fail code
      io_uring: keep all sqe->flags in req->flags
      io_uring: move all request init code in one place
      io_uring: fix cached_sq_head in io_timeout()
      io_uring: kill already cached timeout.seq_offset
      io_uring: don't count rqs failed after current one

Xiaoguang Wang (1):
      io_uring: restore req->work when canceling poll request

 fs/io_uring.c | 301 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 162 insertions(+), 139 deletions(-)

-- 
Jens Axboe

