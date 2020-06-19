Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5156320DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578117;
	bh=xaKaHoYc/W9XElwQ0MqMdSYCMVYe5Jt6cQyWuW9Y+lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCrc0OMwM1Wu7ycW5ehssSMVVl7Gkz0ZAsesd5PO96LRZ7VepupxliZtoLnhbwFPv
	 JUMHZEpMexK48TmTtOOFZNOEmUDwyAyqMnY5UtyurHRDvHXKmdybJtbkoG9+yNAoNf
	 IeGn45U+0SAbx9DrR59s4lM0GLgNMGAcPcIcqlUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbgFSOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389060AbgFSOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:48:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D9E2083B;
        Fri, 19 Jun 2020 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578093;
        bh=xaKaHoYc/W9XElwQ0MqMdSYCMVYe5Jt6cQyWuW9Y+lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3jS9FTb96dCAiYWWDhOMnw7Jwd9FH5HEwQrW1bC+dpTSxUlMgjubUUxJj/tYmXdN
         MjXTh95lbBOnH5GYqOfv42FpSSCvq+UWaYna9qB9AhdlSSZEc8jwfmDRSBpDofJ0tj
         1+T3QOwUmYxhnWaczdSzPVl0t8dSlFGAAaXwXPts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/190] objtool: Ignore empty alternatives
Date:   Fri, 19 Jun 2020 16:32:04 +0200
Message-Id: <20200619141637.534899943@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



