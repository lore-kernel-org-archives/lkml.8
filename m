Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C0C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228322223D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgDQPRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:17:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgDQPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68C39AD2A;
        Fri, 17 Apr 2020 15:17:36 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.7-rc2
Date:   Fri, 17 Apr 2020 17:17:35 +0200
Message-Id: <20200417151735.30600-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.7-rc2-tag

xen: branch for v5.7-rc2

It contains:
- a small cleanup patch
- a security fix for a bug in the Xen hypervisor to avoid enabling Xen
  guests to crash dom0 on an unfixed hypervisor.

Thanks.

Juergen

 arch/arm/xen/enlighten.c           | 2 +-
 drivers/xen/xenbus/xenbus_client.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

Jason Yan (1):
      arm/xen: make _xen_start_info static

Juergen Gross (1):
      xen/xenbus: ensure xenbus_map_ring_valloc() returns proper grant status
