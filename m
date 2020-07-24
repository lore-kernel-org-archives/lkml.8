Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD7C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BFF20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGXKAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:00:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXKAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:00:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 82496F1AC66C4039B8E5;
        Fri, 24 Jul 2020 18:00:33 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 18:00:26 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <rostedt@goodmis.org>, <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH -next] tools lib traceevent: Remove process in finding plugin options
Date:   Fri, 24 Jul 2020 17:59:57 +0800
Message-ID: <20200724095957.48159-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function load_plugin, we get symbol loaded address from symbol name
TEP_PLUGIN_LOADER_NAME, whereas the symbol name TEP_PLUGIN_ALIAS_NAME
is optionally used for finding plugin options which is not used after.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/lib/traceevent/event-plugin.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index e1f7ddd5a6cf..c6435087b5b6 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -275,7 +275,6 @@ load_plugin(struct tep_handle *tep, const char *path,
 	struct tep_plugin_list **plugin_list = data;
 	tep_plugin_load_func func;
 	struct tep_plugin_list *list;
-	const char *alias;
 	char *plugin;
 	void *handle;
 	int ret;
@@ -293,10 +292,6 @@ load_plugin(struct tep_handle *tep, const char *path,
 		goto out_free;
 	}
 
-	alias = dlsym(handle, TEP_PLUGIN_ALIAS_NAME);
-	if (!alias)
-		alias = file;
-
 	func = dlsym(handle, TEP_PLUGIN_LOADER_NAME);
 	if (!func) {
 		warning("could not find func '%s' in plugin '%s'\n%s\n",
-- 
2.17.1

