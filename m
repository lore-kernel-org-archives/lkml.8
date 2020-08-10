Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D52C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555BB22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087375;
	bh=UCwv2B3RnxBQE1V78jAiG0B4yFQiP+JtbIv7enPZNQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kz2BCFt+xQVs5uWlttGxHlwd5xYK/OGLXHJuMKNDhCP2FZXtgO5m7KKHk5nSsjQ6W
	 KkUK95vQ/giKaW9DJuSN70f0Ic0joUwIlRdsljGtfA2Hd0DNPUG0sQe5yqmj6hO+VT
	 +fQxJGjzMYuDPi7TEbka7spV3crq++62slRfLBnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHJTWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbgHJTMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:12:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794A7207FF;
        Mon, 10 Aug 2020 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086773;
        bh=UCwv2B3RnxBQE1V78jAiG0B4yFQiP+JtbIv7enPZNQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2q9oGEmba+65tX7VEFP1slbaHQ76BBlXxe1oHrpizYk4epJDjy2L9tSLl+WoTKogB
         5tShQm+VnzmkwuukW7dcE9E67InHHw5XqTYJUjwSSYj3vxxIesaYTi9yecuOJXLJ5u
         4eZAUBuaqvrzrlSVqBT0v5R4cYtOoNw+0Kty09KU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 42/45] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Mon, 10 Aug 2020 15:11:50 -0400
Message-Id: <20200810191153.3794446-42-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191153.3794446-1-sashal@kernel.org>
References: <20200810191153.3794446-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Cromie <jim.cromie@gmail.com>

[ Upstream commit 9c9d0acbe2793315fa6945a19685ad2a51fb281b ]

ddebug_exec_query declares an auto var, and passes it to
ddebug_parse_query, which memsets it before using it.  Drop that
memset, instead initialize the variable in the caller; let the
compiler decide how to do it.

Acked-by: <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Link: https://lore.kernel.org/r/20200719231058.1586423-10-jim.cromie@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ccf05719b1ad6..344aed3d7e681 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -327,7 +327,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		pr_err("expecting pairs of match-spec <value>\n");
 		return -EINVAL;
 	}
-	memset(query, 0, sizeof(*query));
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
@@ -445,7 +444,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	unsigned int flags = 0, mask = 0;
-	struct ddebug_query query;
+	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
-- 
2.25.1

