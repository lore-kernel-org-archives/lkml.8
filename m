Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE0C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737ED20637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700927;
	bh=FSZNZhAOFhYYMThmr+oCAnsLgXdPEgdWYjoPiw6Ulfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kd3CUtSOUuH0RtZZoF+XXsPgzh3ZF2Zt976VxBts+RuOg4f2dXPZ+pZ52VMjFbKeD
	 quKPZrmXMN5qo8JDgJkqiaiIMgnxbS2aP1FwDKXbeXJEAIUOgDyDxhMiVdv6oJX38Z
	 sGirpBwI5uCp1yEfuIRDFwz5+Qlc6A/we27Dzz0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbgBNQKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391330AbgBNQJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB90B24676;
        Fri, 14 Feb 2020 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696580;
        bh=FSZNZhAOFhYYMThmr+oCAnsLgXdPEgdWYjoPiw6Ulfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4xLeLYHON7JbE2AKix7/XxOIPTuFvyONqXCd4UorPxhq4wH6qkiqcGTEQpAqo7Ee
         9D29+TxLPWISG5RzIr1EVvvrBs/uAcwb/eDfJN2OScwtg6n4e8l2vpgddTF7YhB+93
         Qz3thryrRm/9QafI87X/Ti+5xCKewRe70IDshu1k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 369/459] kbuild: use -S instead of -E for precise cc-option test in Kconfig
Date:   Fri, 14 Feb 2020 11:00:19 -0500
Message-Id: <20200214160149.11681-369-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 3bed1b7b9d79ca40e41e3af130931a3225e951a3 ]

Currently, -E (stop after the preprocessing stage) is used to check
whether the given compiler flag is supported.

While it is faster than -S (or -c), it can be false-positive. You need
to run the compilation proper to check the flag more precisely.

For example, -E and -S disagree about the support of
"--param asan-instrument-allocas=1".

$ gcc -Werror --param asan-instrument-allocas=1 -E -x c /dev/null -o /dev/null
$ echo $?
0

$ gcc -Werror --param asan-instrument-allocas=1 -S -x c /dev/null -o /dev/null
cc1: error: invalid --param name ‘asan-instrument-allocas’; did you mean ‘asan-instrument-writes’?
$ echo $?
1

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Kconfig.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index d4adfbe426903..bfb44b265a948 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
 
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
-cc-option = $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -E -x c /dev/null -o /dev/null)
+cc-option = $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -S -x c /dev/null -o /dev/null)
 
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
-- 
2.20.1

