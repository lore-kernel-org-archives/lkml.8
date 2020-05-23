Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76627C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B41B207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590239883;
	bh=Lybl4km5e8t9nqcWeMTA+kU6IvkA77daO+iOUBK18KA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=e+T7gsfc4ZbQANr8AyWjI51NFioX52c9e/li29xTddYRYiG3PDvCR4M/qdeLaii5g
	 1UcQG9tBVaNFXnf2cnALTkJlDCmPUulGyTXmaAjoD1MSx0QyyAoiT9PlRMxgtQzxP4
	 uZ1v0Yf1FTIjF/njR9EmIxat0TZiyZVNcUKQfEIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgEWNSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbgEWNSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:18:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891F0207F9;
        Sat, 23 May 2020 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590239882;
        bh=Lybl4km5e8t9nqcWeMTA+kU6IvkA77daO+iOUBK18KA=;
        h=Date:From:To:Cc:Subject:From;
        b=lZtVq/bDFuwtqtzKroN/x+7LVP9he8ErQgnRCPXTURCZjfV9n5xwVHGkZDwhaESsG
         kxYshdI3osPrjSZI1BTKAF+kb4MkugJHr3aEJvFRob/4W80BX2SPZLtSLOFHkPMBhT
         21CiudhRiEi3pb9pJiyYmU951eqLyfgvgRUxFmNY=
Date:   Sat, 23 May 2020 15:17:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.7-rc7
Message-ID: <20200523131759.GA55886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc7

for you to fetch changes up to 4ef12f7198023c09ad6d25b652bd8748c965c7fa:

  kobject: Make sure the parent does not get released before its children (2020-05-21 11:01:27 +0200)

----------------------------------------------------------------
Driver core / kobject fixes for 5.7-rc7

Here are 3 small driver core and kobject fixes for 5.7-rc7

The kobject fix resolves a bug that the should not normally ever be hit,
but the kunit tests were hitting pretty regularly.  It's been reviewed
and tested by a bunch of people and stared at by me for a long time, so
it should be good.

The driver core fixes are small ones for reported problems with the
device link code that came in 5.7-rc1.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Heikki Krogerus (1):
      kobject: Make sure the parent does not get released before its children

Saravana Kannan (2):
      driver core: Fix SYNC_STATE_ONLY device link implementation
      driver core: Fix handling of SYNC_STATE_ONLY + STATELESS device links

 drivers/base/core.c | 55 +++++++++++++++++++++++++++++++++++------------------
 lib/kobject.c       | 30 +++++++++++++++++++----------
 2 files changed, 57 insertions(+), 28 deletions(-)
