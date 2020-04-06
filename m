Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E22123126
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgDFOkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:40:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54392 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgDFOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:40:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSvQ-00CECr-PL; Mon, 06 Apr 2020 14:40:32 +0000
Date:   Mon, 6 Apr 2020 15:40:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] regression fix in namei
Message-ID: <20200406144032.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Dumb braino in legitimize_path()...
The following changes since commit 9c577491b985e1b27995abe69b32b041893798cf:

  Merge branch 'work.dotdot1' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2020-04-02 12:30:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 5bd73286d50fc242bbff1aaddb0e97c4527c9d78:

  fix a braino in legitimize_path() (2020-04-06 10:38:59 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix a braino in legitimize_path()

 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
