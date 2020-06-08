Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F64F2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660278;
	bh=xaKaHoYc/W9XElwQ0MqMdSYCMVYe5Jt6cQyWuW9Y+lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=okPz8V2BULcxBX5ODnTJ5m+yb6K2P/xeMUiM1bq74CcUyETN50iOwPy7hmafgLW37
	 L2A+wuZcMYOnBGcEQUGk9JdDxORR4CR4UjU+VjdvOrPSF7Jz8C5aGSsND4TElDzQRP
	 AbCLT5j/Wm/ULu4esD1kUyQfm0luvoQdz0yR7tSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgFHXvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbgFHXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:25:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BDA820897;
        Mon,  8 Jun 2020 23:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658708;
        bh=xaKaHoYc/W9XElwQ0MqMdSYCMVYe5Jt6cQyWuW9Y+lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ms7oRhv6j2wvkcQWCH5k7XrMMXmzIFfoXiFJJAY2cpLIXdzoJjJKOoXQ4Up04Qoao
         tgvEh7+lTkxREk8stYfUUFrtRw+JV6udYDiEzu+Q8KLdB1+wDQHM55d9FPcd+rWPAj
         dxoegwBG3NiTqCHxYqyoMi9Q3gKNJS78CbksyG64=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 06/72] objtool: Ignore empty alternatives
Date:   Mon,  8 Jun 2020 19:23:54 -0400
Message-Id: <20200608232500.3369581-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
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
index 5685fe2c7a7d..247fbb5f6a38 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -778,6 +778,12 @@ static int add_special_section_alts(struct objtool_file *file)
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

