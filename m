Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87788206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCXfmTIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgHCOHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgHCOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:07:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1FCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kdcQuA84bDYzt3Pn3twP/6378QILuDVrjd2r/hgiBWg=; b=fCXfmTIhLOUcz6YOYNtcaYJeor
        /U+gINyMC2qBx1qpnfTI4VeKAsB1n6X3VJ6TzVchO1ms+AHbwtPcw6Hudd1pGkmIbPazo5/HfEer6
        XjJ8heR2nl2aoiY0Wi3qusDuBamqBmnzIuQJj1fB7RW6b2xDzNj84REqL3acxMxf/WPcdCsGd9+0C
        pxAuVzLPclHnOEwRJmUtw0qLvSsevguYM/E35WEHfpbbdOGRBCj6wi+yELMlPfS4jIBUnh6zKi0/z
        QbGVRfZykk/kxwgNZ/qnM0db6QYGGYBCFd+AS/8cthifhpruLWbBvc620whf93/RVGNI40gtKgdd1
        HkHQOG0Q==;
Received: from 93-43-212-104.ip93.fastwebnet.it ([93.43.212.104] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2b7f-0002na-Dg; Mon, 03 Aug 2020 14:07:27 +0000
Date:   Mon, 3 Aug 2020 16:07:26 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs updates for 5.9
Message-ID: <20200803140726.GA752014@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5714ee50bb4375bd586858ad800b1d9772847452:

  copy_xstate_to_kernel: Fix typo which caused GDB regression (2020-07-19 17:09:10 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.9

for you to fetch changes up to 059ccbfff8a826c0e7bfe5d69a55e1179672d8f8:

  configfs: use flush file op to commit writes to a binary file (2020-07-20 15:00:08 +0200)

----------------------------------------------------------------
configfs update for 5.9

 - propagate binary attribute errors (Lenny Szubowicz)

----------------------------------------------------------------
Lenny Szubowicz (1):
      configfs: use flush file op to commit writes to a binary file

 fs/configfs/file.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)
