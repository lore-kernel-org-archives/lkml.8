Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F77D2073D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TS6g9754"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgB2Q7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:59:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgB2Q7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Fr3LLA7hoC6OINimhylplHKCBIaTXKc/1CdIw/ZigZs=; b=TS6g9754Iv6c/zQu3ldLOI/AdG
        GPWcHOblIcimQtU9pmvLbe6zelp8XsqHXikgXAPFKA1kZMQ363/8R/2ztW6fuCTyjbpNrP3u+LUeW
        BZoZcVWOBlmNAiP2HeZfC4uN+ksQtnEIMOMSdoZ2XGXK8DGXd7acRcVQuyUahpgvYhvc0W3Wz0iCJ
        b7Sn9+ty+Xh69r4InW2ip/LrbHsCXVeg7teaJ4W2NrZmTs1NEknmFWsA56bhvbZjidFRxbjiSw/Ro
        3/H190C0drlaEp5X1+of0VEcSlOiyJ5V/t2IE1998ltNvjD7w74JbISzf6MXnZGIZRRWmcU65DDJH
        f8IVY30A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j85SJ-0006Pa-8r; Sat, 29 Feb 2020 16:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Simplify /proc/$pid/maps implementation
Date:   Sat, 29 Feb 2020 08:59:05 -0800
Message-Id: <20200229165910.24605-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Back in 2005, we merged a patch from Akamai that sped up /proc/$pid/maps
by using f_version to stash the user virtual address that we'd just
displayed.  That wasn't necessary; we can just use the private *ppos for
the same purpose.  There have also been some other odd choices made over
the years that use the seq_file infrastructure in some non-idiomatic ways.

Tested by using 'dd' with various different 'bs=' parameters to check that
calling ->start, ->stop and ->next at various offsets work as expected.

Matthew Wilcox (Oracle) (5):
  proc: Inline vma_stop into m_stop
  proc: remove m_cache_vma
  proc: Use ppos instead of m->version
  seq_file: Remove m->version
  proc: Inline m_next_vma into m_next

 fs/proc/task_mmu.c       | 95 +++++++++++++---------------------------
 fs/seq_file.c            | 28 ------------
 include/linux/seq_file.h |  1 -
 3 files changed, 31 insertions(+), 93 deletions(-)

base-commit: d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
-- 
2.25.0

