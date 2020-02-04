Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E83CC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547942087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Em5+Jugv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBDC4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:56:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44133 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgBDC4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:56:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id y5so8645155pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCoXerpkibNMJc6Hgw89GNrbvkXQaydO3ktnkMY7ZuE=;
        b=Em5+Jugv6xehllNNi4uXLdPgJKITfVmMdCMwbomGAaIkpILIy4eYQPGKhp1NtWjVq2
         ye3lOS2fg8bMbgh/kA3dW/ky3AU7lYGliacB1ILU4nhkHM7LknL91+8RTQs/a1qXo8tp
         kDP78o2Z4gdEWplfC18X7pnQJfBZITHEHcoQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCoXerpkibNMJc6Hgw89GNrbvkXQaydO3ktnkMY7ZuE=;
        b=lyBVbE55XfjwX0isvSw2JVVaTVH9l1+Bm+rNEPDLn2TR9TRymORMo9iWc7avBSfM5y
         ZTbVSmD/frFx3gZ+wo30VIhJwqjwKEugpXia8bK8N7yTq9+I8F8RyvLLNvAeCz69x5Vx
         Dx5Ulkn2OS22IrqQs4HdViFBeOLaLGTT3gwbMgR93rePpvhXVaCPfhByECaQwhhfGdn+
         oipAkTjB1wLWFqrZ2q7pRGMTWbqKXypdYmjy+4gd9Pt0+Yn9HwsXnL0S2S5YkPiHz8d/
         Zt/E3TYxjE/rHCL5qr43DIFVAKXsXNanS5WDwaGcdRzjfmn6lTbugpStYmzXcxJ+5deL
         AxuA==
X-Gm-Message-State: APjAAAUcuzivpy1wKnsFL9ywspCu26zlrwCsErmbSiMK/bxpJ9tQn2xu
        tBBcfk+auciKLAWifMFhGD8z6Q==
X-Google-Smtp-Source: APXvYqzrHo6Lx8inQHoBqC92w70TYwWYudny/6+lO98FORxU86UKTPmvJKWhS25QNHxrDMpyvwaiQA==
X-Received: by 2002:a63:cd15:: with SMTP id i21mr23171308pgg.453.1580785008498;
        Mon, 03 Feb 2020 18:56:48 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:56:47 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCHv2 00/12] Implement V4L2_BUF_FLAG_NO_CACHE_* flags
Date:   Tue,  4 Feb 2020 11:56:29 +0900
Message-Id: <20200204025641.218376-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	V2 of the patchset, reshuffled, added more documentation,
	addressed some of the feedback ;) Still in RFC, tho

v1 link: https://lore.kernel.org/lkml/20191217032034.54897-1-senozhatsky@chromium.org/

---
        This is a reworked version of the vb2 cache hints
(V4L2_BUF_FLAG_NO_CACHE_INVALIDATE / V4L2_BUF_FLAG_NO_CACHE_CLEAN)
support patch series which previsouly was developed by Sakari and
Laurent [0].

The patch set attempts to preserve the existing behvaiour - cache
sync is performed in ->prepare() and ->finish() (unless the buffer
is DMA exported). User space can request “default behavior” override
with cache management hints, which are handled on a per-buffer basis
and should be supplied with v4l2_buffer ->flags during buffer
preparation. There are two possible hints:

- V4L2_BUF_FLAG_NO_CACHE_INVALIDATE
        No cache sync on ->finish()

- V4L2_BUF_FLAG_NO_CACHE_CLEAN
        No cache sync on ->prepare()

In order to keep things on the safe side, we also require driver
to explicitly state which of its queues (if any) support user space
cache management hints (such queues should have ->allow_cache_hints
bit set).

The patch set also (to some extent) simplifies allocators' ->prepare()
and ->finish() callbacks. Namely, we move cache management decision
making to the upper - core - layer. For example, if, previously, we
would have something like this

        vb2_buffer_done()
          vb2_dc_finish()
            if (buf->db_attach)
               return;

where each allocators' ->finish() callback would either bail
out (DMA exported buffer, for instance) or sync, now that "bail
out or sync" decision is made before we call into the allocator.

Along with cache management hints, user space is also able to
adjust queue's memory consistency attributes. Memory consistency
attribute (dma_attrs) is per-queue, yet it plays its role on the
allocator level, when we allocate buffers’ private memory (planes).
For the time being, only one consistency attribute is supported:
DMA_ATTR_NON_CONSISTENT.

[0] https://www.mail-archive.com/linux-media@vger.kernel.org/msg112459.html

Sergey Senozhatsky (12):
  videobuf2: add cache management members
  videobuf2: handle V4L2 buffer cache flags
  videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT flag
  videobuf2: add queue memory consistency parameter
  videobuf2: handle V4L2_FLAG_MEMORY_NON_CONSISTENT flag
  videobuf2: factor out planes prepare/finish functions
  videobuf2: do not sync caches when we are allowed not to
  videobuf2: check ->synced flag in prepare() and finish()
  videobuf2: let user-space know if driver supports cache hints
  videobuf2: add begin/end cpu_access callbacks to dma-contig
  videobuf2: add begin/end cpu_access callbacks to dma-sg
  videobuf2: don't test db_attach in dma-contig prepare and finish

 Documentation/media/uapi/v4l/buffer.rst       |  27 +++++
 .../media/uapi/v4l/vidioc-create-bufs.rst     |   9 +-
 .../media/uapi/v4l/vidioc-reqbufs.rst         |  22 +++-
 .../media/common/videobuf2/videobuf2-core.c   | 110 +++++++++++++-----
 .../common/videobuf2/videobuf2-dma-contig.c   |  39 ++++++-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  30 +++--
 .../media/common/videobuf2/videobuf2-v4l2.c   |  59 +++++++++-
 drivers/media/dvb-core/dvb_vb2.c              |   2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   5 +-
 include/media/videobuf2-core.h                |  17 ++-
 include/uapi/linux/videodev2.h                |  11 +-
 11 files changed, 273 insertions(+), 58 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

