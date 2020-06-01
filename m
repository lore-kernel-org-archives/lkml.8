Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B66206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LA9cO1QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFARzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFARzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:55:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670BC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:55:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a45so176140pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TmGom53SZQSrKvwXINTQU0o5hFoM+HRNDvC2pYiq5Wc=;
        b=LA9cO1QE8Wq2gx3uj8BPAZL6Kf+mdnR06sTaLe8Jrx7DVvxZinQmcNHUi9+R94OpA2
         468ryRQ1sc0FuNSuk+a2YoxEoJVBfxBawiclmT1oQiCrR3dwavYyQza0PRH/OOJJlWIT
         B8I1Ryxw/ahgye6QwKVRd8ujjuS6mFQvyFuKkdAtJC6KNzb5SYADMPPgR5G1mgg8l3Rv
         qPT46qO27y21yCHjtA7KTGrDeVksyV+pb6KoLhU4kqJ4skH0FEcbTLL2KC+3cPzhiAyX
         ogkeypoynayRDK+pukt+8xyJVMk9Bw7fQ6a2VORUPr7yXKe6j2CWDFEgxNU5tF/6NUFj
         vMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TmGom53SZQSrKvwXINTQU0o5hFoM+HRNDvC2pYiq5Wc=;
        b=PdfLrn/4jjuzoXrtteOd7BZeb1LRsGjcnW3xV9C+ye5p8jnJe+UiYoumBnjwbfqn4o
         iKdjbibGutmFNTEnExyox427F1uOuB9MoiLuOU+J83Hx3VlngiL1McwE1joViNhjNAeC
         bfkkYHTEsxzfemi/vqN2FK65fYtXTY6x6apvWA4UzOez18w3iY54j6FnWyIlLLARr+dL
         L6RzBZ7FCUQhAff2gu1YyUFqjUYplF4kFksxAxFT2vTp0AlgtildRZ2zCNCQfGpUImt5
         UrNNYDUZrCFwiy23kvRJLGX+NizfBiCoXXsYTNz+GGq7xJNdu5SOnuAa8ov7ecUi0bs/
         ukZQ==
X-Gm-Message-State: AOAM530sSoMqn2Uz9XKG+Bgb8HQsCqNsfkvoIqkp2q6NkjqdBt3kPGol
        hK+YXam3ALULEga4Ia4Hf7sey8WEKSwO5w==
X-Google-Smtp-Source: ABdhPJypz3d4j4B4HEuE5flI851EOzUZUHyWL2j4FWfMxrXaBlT2jUWTtFEETPhatuFKOIwrZw60gA==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr21552690ply.256.1591034117939;
        Mon, 01 Jun 2020 10:55:17 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h11sm103888pjk.20.2020.06.01.10.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 10:55:17 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring updates for 5.8-rc1
Message-ID: <dacd50ff-f674-956b-18cd-9d30e2221b09@kernel.dk>
Date:   Mon, 1 Jun 2020 11:55:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A relatively quiet round, mostly just fixes and code improvements. In
particular:

- Make statx just use the generic statx handler, instead of open coding
  it. We don't need that anymore, as we always call it async safe
  (Bijan)

- Enable closing of the ring itself. Also fixes O_PATH closure (me)

- Properly name completion members (me)

- Batch reap of dead file registrations (me)

- Allow IORING_OP_POLL with double waitqueues (me)

- Add tee(2) support (Pavel)

- Remove double off read (Pavel)

- Fix overflow cancellations (Pavel)

- Improve CQ timeouts (Pavel)

- Async defer drain fixes (Pavel)

- Add support for enabling/disabling notifications on a registered
  eventfd (Stefano)

- Remove dead state parameter (Xiaoguang)

- Disable SQPOLL submit on dying ctx (Xiaoguang)

- Various code cleanups

Please pull!


  git://git.kernel.dk/linux-block.git for-5.8/io_uring-2020-06-01


----------------------------------------------------------------
Bijan Mottahedeh (4):
      io_uring: add io_statx structure
      statx: allow system call to be invoked from io_uring
      io_uring: call statx directly
      statx: hide interfaces no longer used by io_uring

Jens Axboe (7):
      io_uring: remove 'fd is io_uring' from close path
      io_uring: name sq thread and ref completions
      io_uring: batch reap of dead file registrations
      io_uring: allow POLL_ADD with double poll_wait() users
      io_uring: file registration list and lock optimization
      io_uring: cleanup io_poll_remove_one() logic
      io_uring: async task poll trigger cleanup

Pavel Begunkov (13):
      io_uring: remove req->needs_fixed_files
      io_uring: rename io_file_put()
      io_uring: don't repeat valid flag list
      splice: export do_tee()
      io_uring: add tee(2) support
      io_uring: fix flush req->refs underflow
      io_uring: simplify io_timeout locking
      io_uring: don't re-read sqe->off in timeout_prep()
      io_uring: separate DRAIN flushing into a cold path
      io_uring: get rid of manual punting in io_close
      io_uring: move timeouts flushing to a helper
      io_uring: off timeouts based only on completions
      io_uring: fix overflowed reqs cancellation

Stefano Garzarella (2):
      io_uring: add 'cq_flags' field for the CQ ring
      io_uring: add IORING_CQ_EVENTFD_DISABLED to the CQ ring flags

Xiaoguang Wang (2):
      io_uring: remove obsolete 'state' parameter
      io_uring: don't submit sqes when ctx->refs is dying

Xiaoming Ni (1):
      io_uring: remove duplicate semicolon at the end of line

 fs/internal.h                 |   4 +-
 fs/io_uring.c                 | 752 +++++++++++++++++++++++-------------------
 fs/splice.c                   |   3 +-
 fs/stat.c                     |  37 ++-
 include/linux/splice.h        |   3 +
 include/uapi/linux/io_uring.h |  12 +-
 6 files changed, 447 insertions(+), 364 deletions(-)

-- 
Jens Axboe

