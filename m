Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B9C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AF4206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584044770;
	bh=vmlywmWW8FlCqtdKZYPB4p+qg2Yc9/wvdR6ciyYMRck=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=o84fcvINhnEJUg9tqnXWvmfhj3pL0ehVg6y2AbBrvaZ4TdD1etEZclAa9cx5iZe4p
	 4W/pPMx+kLFLXfKBsQqAKw/MPllr/VvDyHTTR4IKelN62kyvyovKWg5l4ov0uMSvul
	 /kBcZp9Rm8finyIO/+G4X0deQ8rkAuNx+BDOvG0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCLU0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLU0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:26:09 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37074206E2;
        Thu, 12 Mar 2020 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584044768;
        bh=vmlywmWW8FlCqtdKZYPB4p+qg2Yc9/wvdR6ciyYMRck=;
        h=From:To:Cc:Subject:Date:From;
        b=kaMJReLkG9B80bO43e3SW7tinoaz5XFql2AWSlboon8a8oz2WE81dWkqQxJMwRa7p
         zVNlkZk2ZtUGpADolHibY8yGzosWDlmBBFfxQBk1IZRlZtRpTxcU6sR0Bs/3WyYmVg
         LujLE6k4iNe0lTpAik8EvbjU968VsG8DzeI/IjKY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: [PATCH v2 0/4] module autoloading fixes and cleanups
Date:   Thu, 12 Mar 2020 13:25:48 -0700
Message-Id: <20200312202552.241885-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a bug where request_module() was reporting success to
kernel code when module autoloading had been completely disabled via
'echo > /proc/sys/kernel/modprobe'.

It also addresses the issues raised on the original thread
(https://lkml.kernel.org/lkml/20200310223731.126894-1-ebiggers@kernel.org/T/#u)
by documenting the modprobe sysctl, adding a self-test for the empty
path case, and downgrading a user-reachable WARN_ONCE().

Eric Biggers (4):
  kmod: make request_module() return an error when autoloading is
    disabled
  fs/filesystems.c: downgrade user-reachable WARN_ONCE() to
    pr_warn_once()
  docs: admin-guide: document the kernel.modprobe sysctl
  selftests: kmod: test disabling module autoloading

 Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++++++-
 fs/filesystems.c                            |  4 +-
 kernel/kmod.c                               |  4 +-
 tools/testing/selftests/kmod/kmod.sh        | 43 +++++++++++++++++++--
 4 files changed, 68 insertions(+), 8 deletions(-)

-- 
2.25.1

