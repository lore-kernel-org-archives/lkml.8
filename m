Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E339207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgE0Vew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0Vev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:34:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49959C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:34:51 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1je3hH-00GVt8-Nv; Wed, 27 May 2020 21:34:47 +0000
Date:   Wed, 27 May 2020 22:34:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [git pull] coredump infoleak fix
Message-ID: <20200527213447.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	xstate note on boxes with xsaves support can leak uninitialized data
into coredumps

The following changes since commit 4e89b7210403fa4a8acafe7c602b6212b7af6c3b:

  fix multiplication overflow in copy_fdtable() (2020-05-19 18:29:36 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 9e4636545933131de15e1ecd06733538ae939b2f:

  copy_xstate_to_kernel(): don't leave parts of destination uninitialized (2020-05-27 17:06:31 -0400)

----------------------------------------------------------------
Al Viro (1):
      copy_xstate_to_kernel(): don't leave parts of destination uninitialized

 arch/x86/kernel/fpu/xstate.c | 86 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 38 deletions(-)
