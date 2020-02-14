Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4685FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205542187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ycrObv7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406316AbgBNQps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:45:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35397 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392989AbgBNQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:45:29 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so11237531iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AjDTQ++9QAUeFd+rM3tBuggZ7ZACTbI+xzsIgBMTRTo=;
        b=ycrObv7TUf+k9MpCwzfm6tpUYr91Ogua7iMMx/VPIyahPd051i0e8Zamp2+sJc+N8E
         MWpaXBeFRSxAIxjhBIfwlmJ9Utg1WcZFzLFLnGzOTp253vcU4bYZtK/b/xhIKCacawsC
         pTXpDNMaiGidQ5WERxCg9jlO1UvXIF+LkGZQUkpfPaoVfWXxa3ML5a8Ugg8b19dMzAdX
         a0L1qnU4FiUCktmkrosHUiA8C+oKvv1qXOJftnyzBiAoQ6BAEiYP0y77C91rHeryrnYn
         RORh0OoP+qRXz/gK3nZBAbvCPPGW2LqwsQy7WpzUV1diTJlqLQnYYDHhawlkODozl+Hu
         TJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AjDTQ++9QAUeFd+rM3tBuggZ7ZACTbI+xzsIgBMTRTo=;
        b=PTFN2NBNK54P1EpwN6DnUhE17ZvnDCSqk2X79jFJC7dwlaUC0iCPCPSSO/2zyp2Tnx
         3ALmk/3bnTok5Am3pEQjsgdhhL8fFMQuRxojWX5yg4xJr2lAnU9LcZA15DSsi0QRrP9t
         AcvqsXhrmBYMBHekpsm29FZxukAgt4yHQCBsfGLd7KjYbzV6sAqC9bc++kwxXHfrqcz5
         t6Y0MoDfgbu9arFWnPwRUu4XnpuGzhht4CrMdeIfcZq+X77MiDo5KQ5q68WL4voCkaNx
         kMuMAzosi4/rmEzO34I6Vlx/+UXioIbDE73KS9ayXBkBKFv+iOzlhdge+5/QtYUz88j6
         99PQ==
X-Gm-Message-State: APjAAAW1Xzciu6pdkbPXezt/XnLhVI78PdHr6jilbEUcle9sMreU+B9E
        DvclqxBxWQb71n9y3hleVhaz4JCx7ag=
X-Google-Smtp-Source: APXvYqxWJ3CWx/BsESTmCh48/BdVAfeJ6FBaTCG5T4yzDJV8DfeGgXGXDGP+viVJlJzScdgBgSHEEA==
X-Received: by 2002:a5e:c803:: with SMTP id y3mr2905152iol.116.1581698727961;
        Fri, 14 Feb 2020 08:45:27 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q90sm2127344ili.27.2020.02.14.08.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 08:45:27 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.6-rc2
Message-ID: <d72d51a9-488d-c75b-4daf-bb74960c7531@kernel.dk>
Date:   Fri, 14 Feb 2020 09:45:26 -0700
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

Here's a set of fixes for io_uring that should go into this release.
This pull request contains:

- Various fixes with cleanups from Pavel, fixing corner cases where
  we're not correctly dealing with iovec cleanup.

- Clarify that statx/openat/openat2 don't accept fixed files

- Buffered raw device write EOPTNOTSUPP fix

- Ensure async workers grab current->fs

- A few task exit fixes with pending requests that grab the file table

- send/recvmsg async load fix

- io-wq offline node setup fix

- CQ overflow flush in poll

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-02-14


----------------------------------------------------------------
Jens Axboe (11):
      io_uring: statx/openat/openat2 don't support fixed files
      io_uring: retry raw bdev writes if we hit -EOPNOTSUPP
      io-wq: add support for inheriting ->fs
      io_uring: grab ->fs as part of async preparation
      io_uring: allow AT_FDCWD for non-file openat/openat2/statx
      io-wq: make io_wqe_cancel_work() take a match handler
      io-wq: add io_wq_cancel_pid() to cancel based on a specific pid
      io_uring: cancel pending async work if task exits
      io_uring: retain sockaddr_storage across send/recvmsg async punt
      io-wq: don't call kXalloc_node() with non-online node
      io_uring: prune request from overflow list on flush

Pavel Begunkov (8):
      io_uring: get rid of delayed mm check
      io_uring: fix deferred req iovec leak
      io_uring: remove unused struct io_async_open
      io_uring: fix iovec leaks
      io_uring: add cleanup for openat()/statx()
      io_uring: fix async close() with f_op->flush()
      io_uring: fix double prep iovec leak
      io_uring: fix openat/statx's filename leak

Randy Dunlap (1):
      io_uring: fix 1-bit bitfields to be unsigned

Stefano Garzarella (1):
      io_uring: flush overflowed CQ events in the io_uring_poll()

 fs/io-wq.c    |  92 +++++++++++++++---
 fs/io-wq.h    |   6 +-
 fs/io_uring.c | 299 +++++++++++++++++++++++++++++++++++++++-------------------
 3 files changed, 284 insertions(+), 113 deletions(-)

-- 
Jens Axboe

