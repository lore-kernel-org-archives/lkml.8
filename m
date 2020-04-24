Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2126CC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED12420767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731104;
	bh=P6COJXlg+XrogRLwKkmQLM6lAh9swg2P6Cnpjkt0cPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IxdqK6p+yjCYl93A2Ea4dtZXOPhwv0erVH1EUjZNguiOFvqdJtEcOGL80ppf2FgU1
	 EADU/jDy812tQ7Q/4QE9kwkcRCSxTJCqIpbG5PNSkMNALUw2Y/215duPdjdQDStuwN
	 pXiPwaozycYJyIoi7pcet89UF/U+fK96tPwKDK68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgDXMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgDXMY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4864E216FD;
        Fri, 24 Apr 2020 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731097;
        bh=P6COJXlg+XrogRLwKkmQLM6lAh9swg2P6Cnpjkt0cPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNmURlFZVYhhprVeLVe7MRd4GgnBjVdCR8p9aO5dK4cuGVyQN1cOJii2JbrFlNrK6
         P+1wIEuJ0rwxfiObkuhXl5CYlqbDznahmQRZKHDMyGIJrEN2pusf2BRHwooIyWeimJ
         o+vjPy+9oD7IVbZw1M24fy/T4vq2kY9t7ltheob4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 08/13] objtool: Fix switch table detection in .text.unlikely
Date:   Fri, 24 Apr 2020 08:24:41 -0400
Message-Id: <20200424122447.10882-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122447.10882-1-sashal@kernel.org>
References: <20200424122447.10882-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit b401efc120a399dfda1f4d2858a4de365c9b08ef ]

If a switch jump table's indirect branch is in a ".cold" subfunction in
.text.unlikely, objtool doesn't detect it, and instead prints a false
warning:

  drivers/media/v4l2-core/v4l2-ioctl.o: warning: objtool: v4l_print_format.cold()+0xd6: sibling call from callable instruction with modified stack frame
  drivers/hwmon/max6650.o: warning: objtool: max6650_probe.cold()+0xa5: sibling call from callable instruction with modified stack frame
  drivers/media/dvb-frontends/drxk_hard.o: warning: objtool: init_drxk.cold()+0x16f: sibling call from callable instruction with modified stack frame

Fix it by comparing the function, instead of the section and offset.

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/157c35d42ca9b6354bbb1604fe9ad7d1153ccb21.1585761021.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a4b157dc1c45e..360845926f665 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -914,10 +914,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list != &file->insn_list &&
-	     insn->sec == func->sec &&
-	     insn->offset >= func->offset;
-
+	     &insn->list != &file->insn_list && insn->func && insn->func->pfunc == func;
 	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
-- 
2.20.1

