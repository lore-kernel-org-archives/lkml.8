Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F21C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3FB2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp3JofzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFCBVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:21:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40340 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgFCBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591147313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XdDMefqXtQvKSOdzOeB1WlYYzqhxoSpy5ZSfBxK1NQg=;
        b=Yp3JofzX3apEr6yGC7T+536eaX32sYTranhsaNPenlXSer4NTuqk7ro/VtLIPrQQ3iQx7Z
        b2EzCkrJ6iGScaROKNuCJpyZULgdH04GWCykkxGc+75YEAsugF1CvKjJSRLkgSJ6brYxXO
        pC2LbIeYMSKEDpTZG+hAkWBWs0aOdpY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-rAwiExZMMRuOOxcu2R9GIQ-1; Tue, 02 Jun 2020 21:21:51 -0400
X-MC-Unique: rAwiExZMMRuOOxcu2R9GIQ-1
Received: by mail-pf1-f198.google.com with SMTP id p18so381703pfq.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 18:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XdDMefqXtQvKSOdzOeB1WlYYzqhxoSpy5ZSfBxK1NQg=;
        b=CKCYUdzDipWoCPi7XXylH9Zh1cIaX7XTc+tnUiTXC75IHdqzB/ApRG6Xq0dx33zYCm
         PEKmc4tL496hM03GFyE+P8Vh3A1jkK2wBBoU5F81jID7d6n5jLVLgoy8veHmPJsfCt9u
         0Wxkdl3wPTnDhN2BoW7THmrLvUg3edsknUC2FQfU6eqWqXlGUw4a0oOgeHcSNQ949xPN
         ZSnoQhK6bCj5snfiSP0vhGADV5SxpzzmQhPNdgDF6p7/mr9KXB+SqVKZe1olHm5btbAs
         hYQ0g6mOFOkrKfaP/Hd1TrmhJaMIL2FEhBf4t8sIyrNTH9RKouWiMQOg1KmeLGQ0eMbU
         ai+g==
X-Gm-Message-State: AOAM531Vh3eAH23HDNlq0BUXAx+IfLbMJmFohR0eDAxO285+jAkpeRZG
        Kwv/1ygqQ/M1WPCwrjoFTNtQQaZJkPvIVhOKkvcx4jNxa+Q3a8S0Z5Obqc5yuaYie/spn3m6C0n
        bjs8omcuAImBeHAAaIksbvaW3
X-Received: by 2002:a17:90a:e42:: with SMTP id p2mr2386128pja.53.1591147310045;
        Tue, 02 Jun 2020 18:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPMydSMfAwxsz807LOdY6kxveiF7ybQspwnpgsWBnQQbndEvdOz0VtdnW7wZHgW/WYK+7fIQ==
X-Received: by 2002:a17:90a:e42:: with SMTP id p2mr2386097pja.53.1591147309784;
        Tue, 02 Jun 2020 18:21:49 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j7sm292288pfh.154.2020.06.02.18.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 18:21:49 -0700 (PDT)
Date:   Wed, 3 Jun 2020 09:21:37 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [GIT PULL] erofs updates for 5.8-rc1
Message-ID: <20200603012137.GA12304@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.8-rc1?

The most outstanding part is the new mount api conversion, which is
actually a old patch already pending for several cycles. And the others
are recent trivial cleanups here.

All commits have been tested and have been in linux-next as well.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.8-rc1

for you to fetch changes up to 34f853b849eb6a509eb8f40f2f5946ebb1f62739:

  erofs: suppress false positive last_block warning (2020-05-29 18:58:13 +0800)

----------------------------------------------------------------
Changes since last update:

 - Convert to use the new mount apis;

 - Some random cleanup patches.

----------------------------------------------------------------
Chao Yu (1):
      erofs: convert to use the new mount fs_context api

Chengguang Xu (1):
      erofs: code cleanup by removing ifdef macro surrounding

Gao Xiang (1):
      erofs: suppress false positive last_block warning

 fs/erofs/data.c     |   4 +-
 fs/erofs/inode.c    |   6 --
 fs/erofs/internal.h |  27 +++---
 fs/erofs/namei.c    |   2 -
 fs/erofs/super.c    | 255 +++++++++++++++++++++++-----------------------------
 fs/erofs/xattr.c    |   4 +-
 fs/erofs/xattr.h    |   7 +-
 fs/erofs/zdata.c    |   4 +-
 8 files changed, 136 insertions(+), 173 deletions(-)

