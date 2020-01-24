Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E9C35243
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67774206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876262;
	bh=B6Dk8xn/uBzWrLbdX1gWUgO9ftBCd/W5Llg4eiJ+9qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qIC9weHp/iNTe0aH2E4s9yaP8mAksyJE4O02gVomwsm1BCTmshMovjVwPL75at/mH
	 IcypYoJGJNKqhWw2xdyMkU1eH3qOp9Yq/SfZERKW94wzcgNqrYMMCaBB+Q2VSCY1IX
	 ORhAcMK6f0sk05QVMXjt3YLBElpxAUE22vjHNj7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392150AbgAXOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404784AbgAXOUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:20:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9687A22522;
        Fri, 24 Jan 2020 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875622;
        bh=B6Dk8xn/uBzWrLbdX1gWUgO9ftBCd/W5Llg4eiJ+9qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbwQei3Q9qgzh+SuU0GY5xY56HyT3HsjrVHUJTEItb4lODaqx3vJjVJbUH90AJPHi
         XUUHDaoYqWtMognZrGc3NuYSvndcnwrG3oUUpkCThfMYJzJ07j/JScVjkdlJtbUrMv
         gGNjhaXLT1OncnhY+ZtyQNB7Wy0zweCWcyFEWag8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hewenliang <hewenliang4@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Feilong Lin <linfeilong@huawei.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/56] tools lib traceevent: Fix memory leakage in filter_event
Date:   Fri, 24 Jan 2020 09:19:24 -0500
Message-Id: <20200124142012.29752-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hewenliang <hewenliang4@huawei.com>

[ Upstream commit f84ae29a6169318f9c929720c49d96323d2bbab9 ]

It is necessary to call free_arg(arg) when add_filter_type() returns NULL
in filter_event().

Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lore.kernel.org/lkml/20191209063549.59941-1-hewenliang4@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/traceevent/parse-filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 2700f1f17876e..27248a0aad84a 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1227,8 +1227,10 @@ filter_event(struct event_filter *filter, struct event_format *event,
 	}
 
 	filter_type = add_filter_type(filter, event->id);
-	if (filter_type == NULL)
+	if (filter_type == NULL) {
+		free_arg(arg);
 		return TEP_ERRNO__MEM_ALLOC_FAILED;
+	}
 
 	if (filter_type->filter)
 		free_arg(filter_type->filter);
-- 
2.20.1

