Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72410C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC7E20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RTA0Qpoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEGVoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgEGVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51AC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so6739199edv.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P/Uxm8WJTzq78ynhVicYHDZPtqRu1XH16x/cAF/+cO8=;
        b=RTA0Qpozn0gf5IlvdzhJe9faA2tLyc+M18gYbapWmEybjegaUApJHd/BozIGf0VNuC
         toHUgjug/NLRp2smPMRTlVhR2Rwtio5qBJTXsCb5EDWeMTYm6ozlWAkzzCzp7jVl6DOU
         6ncrW3w9rHSrbrjhxz/hvbmiE5+boJzTeXGHct1PiNJiKP3kYfIf4axpm6MMII9mLhYF
         eliOYBRbyDXIGWFxSApJHuxto1X+uEbFNOTBDS7KR0HWstCFFfdd2m2LBTrVM7x6aQ9c
         BkLbCAcf8z7cnnl2mQ7doiREcsx2z4wwpje++yIBHqFx9n2omFLL0ncNMH/do0DH8fks
         lvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/Uxm8WJTzq78ynhVicYHDZPtqRu1XH16x/cAF/+cO8=;
        b=WzwP8wuM8SE1muqU+krZz/kMYdoZLpzFj9XW9pZPa4vkY44CD7e3PsfM1cHaNmQrTG
         vAlQLIMafOiTLwdAtdiBadEcxunb5IEUGjw7XlHdC25cfYBIj+KTkH7aXqAIpJ3Tap3b
         nb5bKrM/fFlGPo91si1ls81oIZkS8s54aHVhjNB0mUkP0Xg9cBvdZspToewGmX1jU4z6
         pF9YN93g2/fcNerPjxn3laIibIIdFIIQeb29fHNPQO7vcVSAnY3WUS7iVF4qP9E8GIVk
         0qnCLc/hODwcC1EC+BwNkaJyIhsmlDE0AmXnvACQno4H6Al4Yhr9WtB3eid/Q1zAXxFF
         0mHg==
X-Gm-Message-State: AGi0PuaJnCLC7YIZqJYBCu5Qt1a6OJlgertV/ZNtGoyme9l7sjBBnc/5
        JrfhkEIC+0Fwq5Le7bsTn1jikg==
X-Google-Smtp-Source: APiQypLCk1OU9FRlIMNCpJvBaEgq8st+iAcnPir0Yd+Gt2UqsyC+O4XA6UhV8pJWiHK1w5UEtqE9yA==
X-Received: by 2002:a05:6402:3129:: with SMTP id dd9mr14179355edb.121.1588887856645;
        Thu, 07 May 2020 14:44:16 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:15 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [RFC PATCH V3 0/9] Introduce attach/detach_page_private to cleanup code
Date:   Thu,  7 May 2020 23:43:50 +0200
Message-Id: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on the previous thread [1], this patchset introduces attach_page_private
and detach_page_private to replace attach_page_buffers and __clear_page_buffers.
Thanks a lot for the constructive suggestions and comments from Christoph,
Matthew and Dave.

And sorry for cross post to different lists since it modifies different subsystems.

RFC V2 -> RFC V3:
1. rename clear_page_private to detach_page_private.
2. Update the comments for attach/detach_page_private from Mattew.
3. add one patch to call new function in mm/migrate.c as suggested by Mattew, but
   use the conservative way to keep the orginal semantics [2].


RFC -> RFC V2:
1. rename the new functions and add comments for them.
2. change the return type of attach_page_private.
3. call attach_page_private(newpage, clear_page_private(page)) to cleanup code further.
4. avoid potential use-after-free in orangefs.

[1]. https://lore.kernel.org/linux-fsdevel/20200420221424.GH5820@bombadil.infradead.org/
[2]. https://lore.kernel.org/lkml/e4d5ddc0-877f-6499-f697-2b7c0ddbf386@cloud.ionos.com/

Thanks,
Guoqing

Guoqing Jiang (10):
  include/linux/pagemap.h: introduce attach/detach_page_private
  md: remove __clear_page_buffers and use attach/detach_page_private
  btrfs: use attach/detach_page_private
  fs/buffer.c: use attach/detach_page_private
  f2fs: use attach/detach_page_private
  iomap: use attach/detach_page_private
  ntfs: replace attach_page_buffers with attach_page_private
  orangefs: use attach/detach_page_private
  buffer_head.h: remove attach_page_buffers
  mm/migrate.c: call detach_page_private to cleanup code

 drivers/md/md-bitmap.c      | 12 ++----------
 fs/btrfs/disk-io.c          |  4 +---
 fs/btrfs/extent_io.c        | 21 ++++++---------------
 fs/btrfs/inode.c            | 23 +++++------------------
 fs/buffer.c                 | 16 ++++------------
 fs/f2fs/f2fs.h              | 11 ++---------
 fs/iomap/buffered-io.c      | 19 ++++---------------
 fs/ntfs/aops.c              |  2 +-
 fs/ntfs/mft.c               |  2 +-
 fs/orangefs/inode.c         | 32 ++++++--------------------------
 include/linux/buffer_head.h |  8 --------
 include/linux/pagemap.h     | 37 +++++++++++++++++++++++++++++++++++++
 mm/migrate.c                |  5 +----
 13 files changed, 70 insertions(+), 122 deletions(-)

-- 
2.17.1

