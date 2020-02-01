Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0AAC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A652F20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580544246;
	bh=fGcR+uQkQMIuxgYHsCSQ51Y1wInONtPDndh2ILTCYiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4A2Zt1buTGdo7fTjtdMJVtxvldyVgLezoo2l6CVJINo4doRH6m+uHS6jh8oczhqL
	 Fwf6vhPavBKZUkZGlkTYZ00pHL3PM+rBn2T1NXf1VK4eLjrF4GLrlw/EZKdNXig1Uk
	 zaqoKYB18hQcQH1/B5M7bfUOwiv/nIL2E1XHlyDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgBAIEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:04:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBAIED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:04:03 -0500
Received: from quaco.parlament.guest (catv-212-96-54-169.catv.broadband.hu [212.96.54.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A5120728;
        Sat,  1 Feb 2020 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580544242;
        bh=fGcR+uQkQMIuxgYHsCSQ51Y1wInONtPDndh2ILTCYiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjJ3qMQo9k6chC3UmZdLRxFr47MgtnOicgTdYMBwPsFEk3YK7kblbejcFUJF/VGus
         Gm0KiHGvvC41wtwHDO9GHBeW/lRm7DGzrtgMJ8h+uIjZc3zbGnZDokmtwjtjIVD68U
         RYY1uUgoKqt6BdcuIz3vZJK14y7tZUi3j/FtahUk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/6] perf maps: Add missing unlock to maps__insert() error case
Date:   Sat,  1 Feb 2020 09:03:30 +0100
Message-Id: <20200201080330.13211-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
References: <20200201080330.13211-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cengiz Can <cengiz@kernel.wtf>

`tools/perf/util/map.c` has a function named `maps__insert` that
acquires a write lock if its in multithread context.

Even though this lock is released when function successfully completes,
there's a branch that is executed when `maps_by_name == NULL` that
returns from this function without releasing the write lock.

Added an `up_write` to release the lock when this happens.

Fixes: a7c2b572e217 ("perf map_groups: Auto sort maps by name, if needed")
Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200120141553.23934-1-cengiz@kernel.wtf
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fdd5bddb3075..f67960bedebb 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -549,6 +549,7 @@ void maps__insert(struct maps *maps, struct map *map)
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
+				up_write(&maps->lock);
 				return;
 			}
 
-- 
2.21.1

