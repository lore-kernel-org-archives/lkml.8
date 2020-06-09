Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58772C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDF520734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EddfEhvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFIUvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgFIUvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:51:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC18C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:51:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m32so12291287ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/y9dYR6ipsrXxfQFlRgDb6aikKjjg5AsYUdNwg7G6sQ=;
        b=EddfEhvE3n6EoBqklkZnoc3heML5SxW0Q+mXWNhL0spxNvhg+HnsGT4LuyMyfjrX5u
         2EWLmDb4lNZ8mrhJqqRlntEmD9wqscmDdaO16IHTpi+PfAZZ/nBnxyHzxSrlQ98XtCQL
         irOToCGfike8Wke7l6PzOZ8RkntnqqLlAazfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/y9dYR6ipsrXxfQFlRgDb6aikKjjg5AsYUdNwg7G6sQ=;
        b=jVv0Oa48g412XgCi/UCQhClvU43CUXM2EtQRjqPtzzX9s5TqkF/grPA4HOVKRW12hj
         BCEXOfQSmY+pzIh3Kd9VXb2ehIbHNwSl73tbrKqtg5sXwgBM98Kgj+fD609igcDJ9Kn1
         u+x10JoOm7QsnhKOgiEtjxTvLrg/TG4xOUz3bqkpM0ufEjbFL8tClf3tF02o/y74/9UL
         QjyrOk2LpP8+ZpLQ/N53sylAKBeDHfi8gBOH8GxI4zu21hbdAQmIOAKtRypo7tN6b7Mh
         saEKGVwsFX4mnAtuuKiCehtTm63QfY/fZiMaCzEBvapXR0AiQUrj8UTDpvQ9fgUBRbAW
         It+g==
X-Gm-Message-State: AOAM530sGB6Pqbqv1dHU5oYzEdlwZqGSBBG4CeL+lcSs+HVmu7RwQs0p
        2k2kr7zyOdqXlQi/b9444h/pvkvKCH5rEg==
X-Google-Smtp-Source: ABdhPJw5eBUufWX6FXjVIySHAIIRUYEWfyi9EQ8br9v22WGMqbnAyfy1SGFbOSqFLStqfonzwBmX4Q==
X-Received: by 2002:a50:cd17:: with SMTP id z23mr27695991edi.326.1591735880762;
        Tue, 09 Jun 2020 13:51:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j11sm13805170ejk.67.2020.06.09.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:51:20 -0700 (PDT)
Date:   Tue, 9 Jun 2020 22:51:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.8
Message-ID: <20200609205118.GC6171@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.8

 - Fix a rare deadlock in virtiofs.

 - Fix st_blocks in writeback cache mode.

 - Fix wrong checks in splice move causing spurious warnings.

 - Fix a race between a GETATTR request and a FUSE_NOTIFY_INVAL_INODE
   notification.

 - Use rb-tree instead of linear search for pages currently under writeout by
   userspace.

 - Fix copy_file_range() inconsistencies.

Thanks,
Miklos

---
Eryu Guan (1):
      fuse: invalidate inode attr in writeback cache mode

Kirill Tkhai (1):
      fuse: Update stale comment in queue_interrupt()

Masayoshi Mizuma (1):
      virtiofs: Add mount option and atime behavior to the doc

Maxim Patlasov (1):
      fuse: optimize writepages search

Miklos Szeredi (8):
      fuse: always flush dirty data on close(2)
      fuse: always allow query of st_dev
      fuse: use dump_page
      fuse: fix weird page warning
      fuse: don't check refcount after stealing page
      fuse: update attr_version counter on fuse_notify_inval_inode()
      fuse: fix copy_file_range cache issues
      fuse: copy_file_range should truncate cache

Vasily Averin (1):
      fuse: BUG_ON correction in fuse_dev_splice_write()

Vivek Goyal (2):
      virtiofs: schedule blocking async replies in separate worker
      virtiofs: do not use fuse_fill_super_common() for device installation

---
 Documentation/filesystems/virtiofs.rst |  14 ++++
 fs/fuse/dev.c                          |  14 ++--
 fs/fuse/dir.c                          |  12 +++-
 fs/fuse/file.c                         | 120 +++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h                       |   3 +-
 fs/fuse/inode.c                        |  26 +++++--
 fs/fuse/virtio_fs.c                    | 115 ++++++++++++++++++++-----------
 7 files changed, 219 insertions(+), 85 deletions(-)
