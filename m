Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0796BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F6120872
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590247765;
	bh=GgPL1PlXilJKBqepCf41mbtwC5++0EQWD3D9sqThfrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pdjwaWMl6en/aV7EaLSy4POOrqDWpK5HCFSjCq8SQ8cnWGS+2wb+E0izwYtQXH/+3
	 aO2PL09SaDAr1KLrQ/cROAjxf/s/6x2cz/DCtX4TrdB8CdsQvRTI/wsB7RVSDzux6V
	 9BiAaiAuMEc6pm1bBQpkcggQN8Dr4JjFDBZ5bnFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbgEWP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbgEWP3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:29:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D676A20870;
        Sat, 23 May 2020 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590247764;
        bh=GgPL1PlXilJKBqepCf41mbtwC5++0EQWD3D9sqThfrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spspcCfuiv/a2hy7XF6rIcA37LcFRCrFUSzL3S/Ji/FygAyf6NQ4sOVPe+9GP+MKz
         IFpHLIXbk3NkZ25xnjZHxnyZuxAPuMHuSCau0UkjhzC6t3ivzlG6f4MP0cY67H+Lr3
         sRhJ94JZQkERX2OGnkK7T5xo1OZt5yD4g4UI66V0=
Date:   Sat, 23 May 2020 17:29:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200523152922.GA224858@kroah.com>
References: <20200523131759.GA55886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523131759.GA55886@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc7

for you to fetch changes up to e6764aa0e5530066dd969eccea2a1a7d177859a8:

  Revert "kobject: Make sure the parent does not get released before its children" (2020-05-23 17:11:11 +0200)

----------------------------------------------------------------
Driver core fixes for 5.7-rc7 - take 2

So, turns out the kobject fix didn't quite work, so here are 4 patches
that in the end, result in just 2 driver core fixes for reported issues
that no one has had problems with.

The kobject patch that was originally in here has now been reverted, as
Guenter reported boot problems with it on some of his systems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "kobject: Make sure the parent does not get released before its children"

Heikki Krogerus (1):
      kobject: Make sure the parent does not get released before its children

Saravana Kannan (2):
      driver core: Fix SYNC_STATE_ONLY device link implementation
      driver core: Fix handling of SYNC_STATE_ONLY + STATELESS device links

 drivers/base/core.c | 55 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 18 deletions(-)
