Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C82207D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482626;
	bh=+yB8NAXvhlYkOZe9oqnQrrDCnWaEgp9K7qrE3bWQmbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QN/3CmlJj4FXogfulLi4VDf8o8kme9xvEepWTl4/OHh9asH70RyXy5eHgvIJLHcZe
	 lhyZRkPh+zxPKvS6fmUIe09qMqo+80AYLOACRzv8EOAQlTX1OQBD0Rs5pp3bdiN6il
	 BlQAkIDB2FnerHSU6w5yr5H0uh6xX1j54HivtiUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgENS5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgENS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2123C20823;
        Thu, 14 May 2020 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482602;
        bh=+yB8NAXvhlYkOZe9oqnQrrDCnWaEgp9K7qrE3bWQmbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsgWsdxeB6p5Mt+NVZHNefq9UQuN+qG2E50wWaP4Ag7Ld7lt8ZY+0jRnLOnXVqqoz
         v390wP+EyLXMN+Tyffxzz0Cxqk/6k6dmj6wvsXlH/pQWddzinf8Yabo8qSYRZNT/E+
         HupuVrCL6gtzTTMKPGye2HrvlJ3UbRoEXKl+b6wU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Delalande <colona@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 14/14] scripts/decodecode: fix trapping instruction formatting
Date:   Thu, 14 May 2020 14:56:25 -0400
Message-Id: <20200514185625.21753-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185625.21753-1-sashal@kernel.org>
References: <20200514185625.21753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Delalande <colona@arista.com>

[ Upstream commit e08df079b23e2e982df15aa340bfbaf50f297504 ]

If the trapping instruction contains a ':', for a memory access through
segment registers for example, the sed substitution will insert the '*'
marker in the middle of the instruction instead of the line address:

	2b:   65 48 0f c7 0f          cmpxchg16b %gs:*(%rdi)          <-- trapping instruction

I started to think I had forgotten some quirk of the assembly syntax
before noticing that it was actually coming from the script.  Fix it to
add the address marker at the right place for these instructions:

	28:   49 8b 06                mov    (%r14),%rax
	2b:*  65 48 0f c7 0f          cmpxchg16b %gs:(%rdi)           <-- trapping instruction
	30:   0f 94 c0                sete   %al

Fixes: 18ff44b189e2 ("scripts/decodecode: make faulting insn ptr more robust")
Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/20200419223653.GA31248@visor
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/decodecode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index d8824f37acce9..aae7a035242b2 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -98,7 +98,7 @@ faultlinenum=$(( $(wc -l $T.oo  | cut -d" " -f1) - \
 faultline=`cat $T.dis | head -1 | cut -d":" -f2-`
 faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
 
-cat $T.oo | sed -e "${faultlinenum}s/^\(.*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
+cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
 echo
 cat $T.aa
 cleanup
-- 
2.20.1

