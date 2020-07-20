Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1231DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9BF22BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGTBqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:46:34 -0400
Received: from foss.arm.com ([217.140.110.172]:40784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTBqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:46:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2D10106F;
        Sun, 19 Jul 2020 18:46:33 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9035F3F66E;
        Sun, 19 Jul 2020 18:46:30 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, hch@lst.de, dhowells@redhat.com,
        lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [RFC PATCH 0/2] vfs:9p: fix open-unlink-fstat bug
Date:   Mon, 20 Jul 2020 09:46:20 +0800
Message-Id: <20200720014622.37364-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

how to reproduce:
in 9p guest:

struct stat *statbuf;
int fd;

fd = open("tmp", O_RDWR);
unlink("tmp");
fstat(fd, statbuf);

fstat will fail as "tmp" in 9p server side has been removed. 9p server
can't retrieve the file context as the guest has not passed it down.
so we should pass the file info down in 9p guest in getattr op.
it need add a new file member in "struct kstat" as "struct istat" does.

Jianyong Wu (2):
  vfs: pass file down when getattr to avoid losing info.
  9p: retrieve fid from file if it exists when getattr.

 fs/9p/vfs_inode.c      | 9 +++++++--
 fs/9p/vfs_inode_dotl.c | 9 +++++++--
 fs/stat.c              | 1 +
 include/linux/stat.h   | 6 ++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.17.1

