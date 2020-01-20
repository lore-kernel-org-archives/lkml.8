Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B207C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3D8206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgATDEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:04:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:20356 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:04:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 19:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="374206765"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2020 19:04:20 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, richardw.yang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
Subject: [Patch v2 0/4] mm/page_alloc.c: cleanup on check page
Date:   Mon, 20 Jan 2020 11:04:11 +0800
Message-Id: <20200120030415.15925-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set does some cleanup related to check page.

1. Enable passing all bad reason to __dump_page()
2. Extract common part to check page
3. Remove unnecessary bad_reason assignment

Thanks suggestions from David Rientjes.

v2:
  * merge two rename patches into extract patch
  * enable dump several reasons for __dump_page()

Wei Yang (4):
  mm: enable dump several reasons for __dump_page()
  mm/page_alloc.c: bad_[reason|flags] is not necessary when PageHWPoison
  mm/page_alloc.c: pass all bad reasons to bad_page()
  mm/page_alloc.c: extract commom part to check page

 include/linux/mmdebug.h |  2 +-
 mm/debug.c              | 11 +++---
 mm/page_alloc.c         | 87 +++++++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.17.1

