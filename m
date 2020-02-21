Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE57C35660
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2122072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBUTde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:33:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:38294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgBUTdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:33:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9CD7B2F3;
        Fri, 21 Feb 2020 19:33:32 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.6-rc3
Date:   Fri, 21 Feb 2020 20:33:31 +0100
Message-Id: <20200221193331.6580-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6-rc3-tag

xen: branch for v5.6-rc3

It contains 2 small fixes for Xen:

- a fix for avoiding warnings with new gcc
- a fix for incorrectly disabled interrupts when calling _cond_resched()

Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c | 7 ++++---
 drivers/xen/preempt.c       | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

Juergen Gross (1):
      Merge tag 'for-linus-5.6-rc3-tag' of gitolite.kernel.org:pub/scm/linux/kernel/git/xen/tip into __for-linus-5.6-rc3-tag

Kees Cook (1):
      x86/xen: Distribute switch variables for initialization

Thomas Gleixner (1):
      xen: Enable interrupts when calling _cond_resched()
