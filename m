Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE02C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084D12187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAOGlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:41:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51458 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:41:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ircMV-008YwC-Jy; Wed, 15 Jan 2020 06:41:07 +0000
Date:   Wed, 15 Jan 2020 06:41:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs fixes
Message-ID: <20200115064107.GF8904@ZenIV.linux.org.uk>
References: <CAHk-=wgdsv1UA+QtgiJM8KQAG7N7_9iK_edchnzZYyj+nxmfLA@mail.gmail.com>
 <20200113195448.GT8904@ZenIV.linux.org.uk>
 <CAHk-=whn5qk-e-KnYr6HNe5hp45v+XyDbsA2+szXvK3gC06A2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whn5qk-e-KnYr6HNe5hp45v+XyDbsA2+szXvK3gC06A2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for mountpoint_last() bugs (by converting to use of lookup_last()) +
autofs regression fix from this cycle (caused by follow_managed() breakage
introduced in barrier fixes series).

The following changes since commit 1edc8eb2e93130e36ac74ac9c80913815a57d413:

  fs: call fsnotify_sb_delete after evict_inodes (2019-12-18 00:03:01 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 508c8772760d4ef9c1a044519b564710c3684fc5:

  fix autofs regression caused by follow_managed() changes (2020-01-15 01:36:46 -0500)

----------------------------------------------------------------
Al Viro (2):
      reimplement path_mountpoint() with less magic
      fix autofs regression caused by follow_managed() changes

 fs/namei.c            | 90 ++++++++-------------------------------------------
 fs/nfs/nfstrace.h     |  2 --
 include/linux/namei.h |  1 -
 3 files changed, 13 insertions(+), 80 deletions(-)
