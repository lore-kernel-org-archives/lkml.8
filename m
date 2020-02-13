Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F217C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409F822314
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581627779;
	bh=7IE9/WMRPONwDCcvnNaBH+XFX97Ki6SZkrLbQP1EiX8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=M0jo4fhMIDor25l0mp+StCabalgApVjvsQZoR+RwIruKY+sYFHX5VaH6OeZYyke94
	 hXI/4PlHOloD/Npg3Wo0054LUfcPli1FsB7nNe4hSaPg8YDZjI5WfDA1eMiVw7ApnJ
	 FZHw1wGWH0sqxzAhae/WSiKqF3hGWH5EfGvgvwV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBMVC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBMVC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:02:58 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B4920848;
        Thu, 13 Feb 2020 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581627777;
        bh=7IE9/WMRPONwDCcvnNaBH+XFX97Ki6SZkrLbQP1EiX8=;
        h=From:To:Cc:Subject:Date:From;
        b=AX9BVUo5QwUK+Y9wNS9gGZ5tnFvIrxw24J+z+xbp8n7jf4sk99+biUfGfo2MGU6Kc
         c2eu2OO3ozTDKzeDcPaE83btt4IEyVimCf2Hdm3mhmpv5hfi4uC5vyPQcdZ1WyGFOG
         R1szadXYJiP5fEpk0qPvyNYfwHQQ02l2Jx7Z9+pg=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v4 0/2] vfs: have syncfs() return error when there are writeback errors
Date:   Thu, 13 Feb 2020 16:02:53 -0500
Message-Id: <20200213210255.871579-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- switch to dedicated errseq_t cursor in struct file for syncfs
- drop ioctl for fetching the errseq_t without syncing

This is the fourth posting of this patchset. After thinking about it
more, I think multiplexing file->f_wb_err based on O_PATH open is just
too weird. I think it'd be better if syncfs() "just worked" as expected
no matter what sort of fd you use, or how you multiplex it with fsync.

Also (at least on x86_64) there is currently a 4 byte pad at the end of
the struct so this doesn't end up growing the memory utilization anyway.
Does anyone object to doing this?

I've also dropped the ioctl patch. I have a draft patch to expose that
via fsinfo, but that functionality is really separate from returning an
error to syncfs. We can look at that after the syncfs piece is settled.

Jeff Layton (2):
  vfs: track per-sb writeback errors and report them to syncfs
  buffer: record blockdev write errors in super_block that it backs

 drivers/dax/device.c    |  1 +
 fs/buffer.c             |  2 ++
 fs/file_table.c         |  1 +
 fs/open.c               |  3 +--
 fs/sync.c               |  6 ++++--
 include/linux/fs.h      | 16 ++++++++++++++++
 include/linux/pagemap.h |  5 ++++-
 7 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.24.1

