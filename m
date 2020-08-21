Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDD7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3417820791
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y1no10iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHUUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:53:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D82C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:53:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q75so3058861iod.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wRTJWUU8fSzdhDfTq0BRzaQ/zjJqQDUaBrIo5OOWnZk=;
        b=Y1no10iGfPv/2PVXz7+f8kv9kimyipKF+8J21cdt6AVsvfhvcbTWi+Q/Il3iLSbRT8
         xdV1npsf/jUHz0DAUJgSUS1++08kiCBtAuYBJ/EHkVnUTpsDRcA6QGvcEvy0/m5VeMPD
         M3G+GIo7m5sVH2xrsn0rCX1VesZS1uSteBgINUWJA2Y7lcuB/LCJbDKj4MytVIpVZV34
         GOy8jn7P3xLjUOx2A9qNwkklqWS5hDyQQj3J+Ity8LhjWZHlut1MsepeQg0sgQXvzExh
         so7P6NqcWi+twAOuJppn53WXMRrDTvg4dIk8XEed3QN80Nsbi2Vt8paqB2PkhmG5BRZl
         U8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wRTJWUU8fSzdhDfTq0BRzaQ/zjJqQDUaBrIo5OOWnZk=;
        b=Sdiz+oDOKLecQjPIA+e2ia+XSbqR3BYTibtSLZCCy4wMcY53rFjjbbcMfkaWvl9SM9
         7s2M0oLk3dWvKBblIucmnrkz5MxQGsRst6EEZJlAuKAadTpWKcT9HGLqvkHQ5RvM9obc
         82zk9l4ADiHTc3yw+GRCo3Gsq6f2Hb4gAvsZ46+pwhD/+9hGmJ2XuNTqJaxev3P2yuB7
         ieNjxfPsdLUKXGjvFVqD+ShaGDjt5dnrB87mPwws3dOCESSTHKjS922/a+Syx0UOsnT5
         CL3ok+DRlA5C8/PK+ijeC+s5LrMM5eb3xRcHy5hSPfu8t1nQNN6M03QLFkHzAotfB+ZY
         C7Sg==
X-Gm-Message-State: AOAM530wpnLkWMyS0fbMsR2HZdZC4BuiOtT/dZ8olK+70+BC6AMNhmcy
        32yC4OluGwOwtW6iV8QVAtxM0aG6yqgXXPF7
X-Google-Smtp-Source: ABdhPJzkU9I7orNoDSyQBLDxcjJ5TqMUrGlGqWH1hdqCZEWFKCj3T0JherXQr1TQIy79H19xWM6xig==
X-Received: by 2002:a02:7786:: with SMTP id g128mr4046748jac.45.1598043219195;
        Fri, 21 Aug 2020 13:53:39 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n7sm1835848iop.45.2020.08.21.13.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 13:53:38 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.9-rc2
Message-ID: <82c089ee-4f2e-ad68-efb4-e90e3a0c543d@kernel.dk>
Date:   Fri, 21 Aug 2020 14:53:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few io_uring fixes:

- Make sure the head link cancelation includes async work

- Get rid of kiocb_wait_page_queue_init(), makes no sense to have it as
  a separate function since you moved it into io_uring itself

- io_import_iovec cleanups (Pavel, me)

- Use system_unbound_wq for ring exit work, to avoid spawning tons of
  these if we have tons of rings exiting at the same time

- Fix req->flags overflow flag manipulation (Pavel)

Please pull!


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-21

for you to fetch changes up to 867a23eab52847d41a0a6eae41a64d76de7782a8:

  io_uring: kill extra iovec=NULL in import_iovec() (2020-08-20 05:36:19 -0600)

----------------------------------------------------------------
io_uring-5.9-2020-08-21

----------------------------------------------------------------
Jens Axboe (4):
      io_uring: find and cancel head link async work on files exit
      io_uring: get rid of kiocb_wait_page_queue_init()
      io_uring: cleanup io_import_iovec() of pre-mapped request
      io_uring: use system_unbound_wq for ring exit work

Pavel Begunkov (3):
      io_uring: fix racy req->flags modification
      io_uring: comment on kfree(iovec) checks
      io_uring: kill extra iovec=NULL in import_iovec()

 fs/io_uring.c | 173 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 79 insertions(+), 94 deletions(-)

-- 
Jens Axboe

