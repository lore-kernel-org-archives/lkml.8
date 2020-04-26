Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94082C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AB52071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="C6afFiFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDZVtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgDZVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB714C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q8so12479874eja.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B/ch82HyLL2sQr6H4MnBtI01Q2APZPEwf2QyxgsQ6bE=;
        b=C6afFiFVw7S0hp7bZfWbrthZh1ZM4P0cPOjHJRBn6u9FP10tTEn/l9PF9XDRdD8hMo
         FUIrdIh1+RRAC9QGXGHot7NgMt2xGErdp+XECWu7Xzb0EX5KTbKhvF+L50f4kDwIb9So
         4wNDrn75HXesak3RnaipqHpOlJiRhdKeiuEqu3ZpU9WCEMyT6/rejd6XdAW+L4S9lcXw
         YxiK82m+la85q5kQVx+hB6+Da8ZUJgkGasRb1JGDV0i+peuqRo9nQMmkU6z3k1pEH1Yp
         Hw1UA6NpC8Zl8bIXKZaA8x4GfNQ5f/48jy6FByERebcqavePWSRXbVzCkG8ENpvyi7CA
         9GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B/ch82HyLL2sQr6H4MnBtI01Q2APZPEwf2QyxgsQ6bE=;
        b=TNhXLf2gFNMRNdaEn33XbyNS9Q+ZB2qjsrtaX9aHaM5P12ZD0/TbvMh/ZYJ0msYk0u
         fm215WRw4mfksa3AxPZMnjgJmGIA6kMW8YzWntb6b1/bkKvDOzj1DnPRQ//Ys3YU0BBR
         MLoWctgvAkIokr/jwt4vcgRBPhxd+CIjgYRRp1ESJ5VHBOmHCQV4ELzPEjJBuG5FRprh
         VTFb2zPJDHZ6CBAcKqDmitA/CDL3FeHUfhImQ9kS88LSDNchWoouRwRhqrcjPyPCDMqB
         swAXZ2H6ZHoTCgwfy1RuO066//sKevtZbAxg6JNU6llnAz4+M2t1VvX2YtK1KYnjdtLr
         jaxQ==
X-Gm-Message-State: AGi0Pua0Yf0Q27FR1ykf72UKBl+eNI6mJlrS53yGZoGYEcBEkRGaBvCR
        rJw2FlP3kWP0bfSE1P29kHrLnA==
X-Google-Smtp-Source: APiQypJvZ+T3DNh77lS28NFcUDhKHPlb8mG+//KC43nxkgc5XB59Rte8JmfAZ14qijs1rpUFCNHBVw==
X-Received: by 2002:a17:906:74c:: with SMTP id z12mr17510376ejb.87.1587937786516;
        Sun, 26 Apr 2020 14:49:46 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:45 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [RFC PATCH 0/9] Introduce set/clear_fs_page_private to cleanup code
Date:   Sun, 26 Apr 2020 23:49:16 +0200
Message-Id: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on the previous thread [1], this patchset introduces set_fs_page_private
and clear_fs_page_private to replace attach_page_buffers and __clear_page_buffers.
Thanks a lot for the constructive suggestion from Matthew and Dave.

And sorry for cross post to different lists since it modifies different subsystems.

[1]. https://lore.kernel.org/linux-fsdevel/20200420221424.GH5820@bombadil.infradead.org/

Thanks,
Guoqing

Guoqing Jiang (9):
  include/linux/pagemap.h: introduce set/clear_fs_page_private
  md: remove __clear_page_buffers and use set/clear_fs_page_private
  btrfs: use set/clear_fs_page_private
  fs/buffer.c: use set/clear_fs_page_private
  f2fs: use set/clear_fs_page_private
  iomap: use set/clear_fs_page_private
  ntfs: replace attach_page_buffers with set_fs_page_private
  orangefs: use set/clear_fs_page_private
  buffer_head.h: remove attach_page_buffers

 drivers/md/md-bitmap.c      | 12 ++----------
 fs/btrfs/disk-io.c          |  4 +---
 fs/btrfs/extent_io.c        | 21 ++++++---------------
 fs/btrfs/inode.c            | 17 ++++-------------
 fs/buffer.c                 | 16 ++++------------
 fs/f2fs/f2fs.h              | 11 ++---------
 fs/iomap/buffered-io.c      | 14 +++-----------
 fs/ntfs/aops.c              |  2 +-
 fs/ntfs/mft.c               |  2 +-
 fs/orangefs/inode.c         | 24 ++++++------------------
 include/linux/buffer_head.h |  8 --------
 include/linux/pagemap.h     | 22 ++++++++++++++++++++++
 12 files changed, 52 insertions(+), 101 deletions(-)

-- 
2.17.1

