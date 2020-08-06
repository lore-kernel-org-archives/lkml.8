Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E5921744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUKhqieF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgHFD2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:28:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730582AbgHFD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596684481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fv3CnjYaDNIHTU7CqIhzqNedLZ06zeIgR5EU/DfXL/4=;
        b=hUKhqieFBa5J57whBZbx609Apal04a/P/dfRsi4TPyyJOROdnKTG0krj/QlI+NMYBcJZku
        ILY04arSSsf5z1keXUVGPmeCchra49SmxXT7ZAH6Gx5HJ1PSxWAuJ+UsbQFvnfeptZQlSM
        jBdKWYPy0WXowVn4DW//7+PCSIoLQeQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Lc2dETV0Pz6ttQwf1XgJeg-1; Wed, 05 Aug 2020 23:20:32 -0400
X-MC-Unique: Lc2dETV0Pz6ttQwf1XgJeg-1
Received: by mail-pg1-f198.google.com with SMTP id h2so32713083pgc.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fv3CnjYaDNIHTU7CqIhzqNedLZ06zeIgR5EU/DfXL/4=;
        b=U+/5nbjy1HuG7vnnHzjI5LHIsfL9UJJO+SQgEZoqWsMh39JsJngbLmxG6Lp+aGSVUX
         pAhqV+Pg4otH/G/UrbU4B0lm/jJgr/LHKHORKMe8xVOKbYbKR2blhCeTMTkRQUvoq/AT
         APi82vCsK8Unv0TaFVWPv8IGUBA28Wf7P1SCzsmiVumU8bRGUEJBRmvW6y4R5GxPUdrc
         PlISjG8+yhGwJI9LfgcFNxoRn0U0Ph6khpj2SIRzmYdcVeKXW5wgobDjtEc71peqkpEd
         wiVqnwzAMY5LPB7NzdNKmgfZM9vWwWfpQUOVc05Og/SEsQvocK0mA8GcDK6tRDSkoS1F
         COyw==
X-Gm-Message-State: AOAM530VnLRX/GgUs6D8KndXYAiBjnn3qIlIpizVQHBphDaA0+cw8831
        Wf5RtH/3kjDUp8SCKT3bDj/WcfDZ7sTFTCrfKea3dzUpqjNo4EBgoWvhXJqVhmA/VpRtCjZ7R6Z
        J6PIDT5p12phqSK3YxJ5snAr7
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr6170203pjj.164.1596684030848;
        Wed, 05 Aug 2020 20:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1dO1CoIriHlooHe7iPiLtnA9/a4o5ehfwXRyowc0cEPLGbBaMduX4YaDzusso9AlMTbBwLw==
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr6170176pjj.164.1596684030608;
        Wed, 05 Aug 2020 20:20:30 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g4sm4971772pgn.64.2020.08.05.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 20:20:29 -0700 (PDT)
Date:   Thu, 6 Aug 2020 11:20:17 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [GIT PULL] erofs fixes for 5.9-rc1
Message-ID: <20200806032017.GA4442@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.9-rc1?

This cycle mainly addresses an issue out of some extended inode with
designated location, which can hardly be generated by current mkfs but
needs to handle at runtime anyway. The others are quite trivial ones.

All commits have been tested and have been in linux-next as well.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.9-rc1

for you to fetch changes up to 0e62ea33ac12ebde876b67eca113630805191a66:

  erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's (2020-08-03 21:04:46 +0800)

----------------------------------------------------------------
Changes since last update:

 - use HTTPS links instead of insecure HTTP ones;

 - fix crossing page boundary on specific extended inodes;

 - remove useless WQ_CPU_INTENSIVE flag for unbound wq;

 - minor cleanup.

----------------------------------------------------------------
Alexander A. Klimov (1):
      erofs: Replace HTTP links with HTTPS ones

Gao Xiang (3):
      erofs: fix extended inode could cross boundary
      erofs: fold in used-once helper erofs_workgroup_unfreeze_final()
      erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's

 fs/erofs/compress.h     |   2 +-
 fs/erofs/data.c         |   2 +-
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/dir.c          |   2 +-
 fs/erofs/erofs_fs.h     |   2 +-
 fs/erofs/inode.c        | 123 +++++++++++++++++++++++++++++++-----------------
 fs/erofs/internal.h     |   2 +-
 fs/erofs/namei.c        |   2 +-
 fs/erofs/super.c        |   2 +-
 fs/erofs/utils.c        |  16 ++-----
 fs/erofs/xattr.c        |   2 +-
 fs/erofs/xattr.h        |   2 +-
 fs/erofs/zdata.c        |   6 +--
 fs/erofs/zdata.h        |   2 +-
 fs/erofs/zmap.c         |   2 +-
 fs/erofs/zpvec.h        |   2 +-
 16 files changed, 100 insertions(+), 71 deletions(-)

