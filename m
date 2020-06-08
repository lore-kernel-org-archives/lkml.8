Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54442C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3292064C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658907;
	bh=/YEJX4/4794rBMCNqysDhVlcMXdUFlMmWWEnYdEx+MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GM1f7WVqWKNKnpe3Etn8AWI7LcaZv/0KCqO+VsIQfc3x8A0wEXHie71Ag63qQDqz7
	 hTUWnpeqzQrsxpE7rlWpk8/2rsBByhQkv5goiAjujApq3VfN31UTfbNKA63DKDi3gK
	 tr9gnlKv5OXTU6sw1GSe2SkBTZhqDodT12DaXLj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgFHX2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731367AbgFHXWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5117F208C9;
        Mon,  8 Jun 2020 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658566;
        bh=/YEJX4/4794rBMCNqysDhVlcMXdUFlMmWWEnYdEx+MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njm8I+dWskswb00cEIw24FSCt/fc5eA2x9ifVFziprDA4XjHx8OdIzXOofuKeDVsR
         Rygl6d1ruo1No39IJ7ZCAPWDXhqlNkxvhmYCNQkiUrVersYxAe+rNV4ev58gotd+E0
         Loslh6+KXqhGbuVGbZxsML/1RT+mTMZhCMPpaP3w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 006/106] objtool: Ignore empty alternatives
Date:   Mon,  8 Jun 2020 19:20:58 -0400
Message-Id: <20200608232238.3368589-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

[ Upstream commit 7170cf47d16f1ba29eca07fd818870b7af0a93a5 ]

The .alternatives section can contain entries with no original
instructions. Objtool will currently crash when handling such an entry.

Just skip that entry, but still give a warning to discourage useless
entries.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4d509734b695..fd3071d83dea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -801,6 +801,12 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		if (special_alt->group) {
+			if (!special_alt->orig_len) {
+				WARN_FUNC("empty alternative entry",
+					  orig_insn->sec, orig_insn->offset);
+				continue;
+			}
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.25.1

