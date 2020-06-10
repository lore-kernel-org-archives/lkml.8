Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D091220760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFJU0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgFJU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:26:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A4C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:26:06 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj7IR-006d2U-12; Wed, 10 Jun 2020 20:26:03 +0000
Date:   Wed, 10 Jun 2020 21:26:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [git pull] sysctl fixes
Message-ID: <20200610202602.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Fixups to regressions in sysctl series.

The following changes since commit 32927393dc1ccd60fb2bdc05b9e8e88753761469:

  sysctl: pass kernel pointers to ->proc_handler (2020-04-27 02:07:40 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysctl

for you to fetch changes up to ef9d965bc8b6fce5bcc0ae76a4a5b3ed91ee81eb:

  sysctl: reject gigantic reads/write to sysctl files (2020-06-10 14:11:33 -0400)

----------------------------------------------------------------
Christoph Hellwig (6):
      net/sysctl: use cpumask_parse in flow_limit_cpu_sysctl
      net/sysctl: remove leftover __user annotations on neigh_proc_dointvec*
      random: fix an incorrect __user annotation on proc_do_entropy
      trace: fix an incorrect __user annotation on stack_trace_sysctl
      cdrom: fix an incorrect __user annotation on cdrom_sysctl_info
      sysctl: reject gigantic reads/write to sysctl files

 drivers/cdrom/cdrom.c      | 2 +-
 drivers/char/random.c      | 2 +-
 fs/proc/proc_sysctl.c      | 4 ++++
 include/linux/ftrace.h     | 5 ++---
 include/net/neighbour.h    | 7 +++----
 kernel/trace/trace_stack.c | 5 ++---
 net/core/sysctl_net_core.c | 2 +-
 7 files changed, 14 insertions(+), 13 deletions(-)
