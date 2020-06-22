Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C5420767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592868431;
	bh=VjnZP0UJkWtMoh9mmcu3OkA3Gx/ME5wU7WbuTuzTSAc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bIv4bNiZU65hDB007YvPWQ/OHyeIKRzqaTjm/WUSBnn1FhBCC+H89vkzbG0UhbpLO
	 SCA2a+txsD/3vuZLTNX7FCKNvS6qHqU59RsIdAuSzpC0ITVpHzZ/6jyGkeLfBZADXt
	 QIcufxJOJuZkmFp+zZmdlG/8T9yz/pOnf6CIDwvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgFVX1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgFVX1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:27:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BC720720;
        Mon, 22 Jun 2020 23:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592868429;
        bh=VjnZP0UJkWtMoh9mmcu3OkA3Gx/ME5wU7WbuTuzTSAc=;
        h=Date:From:To:Cc:Subject:From;
        b=hgFD1DX6czqgIEETk2kVqM+1UIrM+d7Mrklck6xgMzPEBxJXgiKHMuQNMKxk1Gg9M
         vvNdhwCabDH4RWBK4ixED2gLoynkSXtVYF42Qyi8rA2sXENDPyYiyMMNtvIP9fRYVA
         T5VtVluO7ZzAcLS7jdvFIftPWWHXVaoGPZm200vU=
Date:   Mon, 22 Jun 2020 18:32:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] libperf: Use struct_size() helper
Message-ID: <20200622233239.GA12892@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _size_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/lib/perf/threadmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index e92c368b0a6c..86d9dabd7fe5 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <asm/bug.h>
 #include <stdio.h>
+#include <linux/overflow.h>
 
 static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
 {
@@ -17,10 +18,9 @@ static void perf_thread_map__reset(struct perf_thread_map *map, int start, int n
 
 struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, int nr)
 {
-	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
 	int start = map ? map->nr : 0;
 
-	map = realloc(map, size);
+	map = realloc(map, struct_size(map, map, nr));
 	/*
 	 * We only realloc to add more items, let's reset new items.
 	 */
-- 
2.27.0

