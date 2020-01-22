Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D273C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAVBRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:17:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:21618 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgAVBRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:17:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 17:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="221088258"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jan 2020 17:17:05 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 0/4] cleanup on do_pages_move()
Date:   Wed, 22 Jan 2020 09:16:43 +0800
Message-Id: <20200122011647.13636-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in do_pages_move() is a little mess for audience to read and has
some potential error on handling the return value. Especially there are
three calls on do_move_pages_to_node() and store_status() with almost the
same form.

This patch set tries to make the code a little friendly for audience by
consolidate the calls.

After this, we can do a better fix.

v2:
  * remove some unnecessary cleanup

Wei Yang (4):
  mm/migrate.c: not necessary to check start and i
  mm/migrate.c: wrap do_move_pages_to_node() and store_status()
  mm/migrate.c: check pagelist in move_pages_and_store_status()
  mm/migrate.c: handle same node and add failure in the same way

 mm/migrate.c | 57 +++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

-- 
2.17.1

