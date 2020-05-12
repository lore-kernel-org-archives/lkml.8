Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA16DC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD120206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgELAJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgELAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:09:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D88CFAE68;
        Tue, 12 May 2020 00:09:22 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, oleg@redhat.com, paulmck@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -next v2 0/2] kernel/sys: reduce tasklist_lock usage get/set priorities
Date:   Mon, 11 May 2020 17:03:51 -0700
Message-Id: <20200512000353.23653-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following are two patches that deal with removing the tasklist_lock entirely in
getpriority(2), and reducing the scope of it in setpriority(2). This also aligns
somewhat to what we already do with io priorities - although there both set and get
rely entirely on rcu.

Details in the changelog but this passes ltp tests. Please consider for v5.8.

Changes from v1:
 - split get and set into two patches.
 - improved changelog.

Thanks!

Davidlohr Bueso (2):
  kernel/sys: only rely on rcu for getpriority(2)
  kernel/sys: do not grab tasklist_lock for sys_setpriority(PRIO_PROCESS)

 kernel/sys.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.26.1

