Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08472075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437891AbgE2ADs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437853AbgE2ADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:03:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3BC08C5C6;
        Thu, 28 May 2020 17:03:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSUz-00HEIm-5o; Fri, 29 May 2020 00:03:45 +0000
Date:   Fri, 29 May 2020 01:03:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess __copy_to_user()
Message-ID: <20200529000345.GV23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Similar for __copy_to_user(); patches that didn't
fit anywhere else (e.g. into readdir series).  The goal,
again, is to get rid of __copy_to_user() outside of arch/*.
We are not quite there (e.g. there's regset crap, some
KVM/vhost-related callers that want different predicate
instead of access_ok()), but it's getting fairly close.

	Branch is #uaccess.__copy_to_user, based at
v5.7-rc1.

Al Viro (2):
      esas2r: don't bother with __copy_to_user()
      dlmfs: convert dlmfs_file_read() to copy_to_user()

 drivers/scsi/esas2r/esas2r_ioctl.c |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c             | 33 ++++++++++++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

