Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9DBC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536220836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993723;
	bh=jKP7uD9q3zWYsTKN99FjfTgw+Et5XfVoMV5WtjjFR04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kQAPA7G3ann/2CacnaPZN7Q7RiZhgYnpiR8lDZG+bX2x2oMPnNh2kKcJ601/gLGY6
	 xTt3HlpBYQsCAJN/92ecYzRDhA9IClSt9JpK1pAo1jV4uRMzKr0Iaa31Z9HMu/j/c+
	 UJ2i46iI5k13lp9OPrkbPuEtr3mQSGcw1zWzGiKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBRCmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgBRClz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00142176D;
        Tue, 18 Feb 2020 02:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993715;
        bh=jKP7uD9q3zWYsTKN99FjfTgw+Et5XfVoMV5WtjjFR04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giua7SBlU4MpEaEuvfPgIuIxe5wthdQojB6mafYK6TRAJneODlJHEVTCcA9lXqTsY
         1jcr9DDDA6iz9nlSjsYXfWBNdd3342848OdQnJ7o+Ho9/CXh6chie/X8VrMTwEQTF3
         ht/KX7nktPservWEbm/unvFNUUEkkTWZElUwLvOE=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 09/11] tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
Date:   Mon, 17 Feb 2020 21:41:31 -0500
Message-Id: <20200218024133.5059-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point it's always enabled with CONFIG_PROVE_LOCKING, so it's
easier to enable it in liblockdep as well rather than try and fix up the
lockdep code.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/lockdep/Makefile b/tools/lib/lockdep/Makefile
index 9dafb8cb752fe..efb6b7980a009 100644
--- a/tools/lib/lockdep/Makefile
+++ b/tools/lib/lockdep/Makefile
@@ -78,7 +78,7 @@ export Q VERBOSE
 INCLUDES = -I. -I./uinclude -I./include -I../../include $(CONFIG_INCLUDES)
 
 # Set compile option CFLAGS if not set elsewhere
-CFLAGS ?= -g -DCONFIG_LOCKDEP -DCONFIG_STACKTRACE -DCONFIG_PROVE_LOCKING -DBITS_PER_LONG=__WORDSIZE -DLIBLOCKDEP_VERSION='"$(LIBLOCKDEP_VERSION)"' -rdynamic -O0 -g
+CFLAGS ?= -g -DCONFIG_LOCKDEP -DCONFIG_STACKTRACE -DCONFIG_PROVE_LOCKING -DCONFIG_TRACE_IRQFLAGS -DBITS_PER_LONG=__WORDSIZE -DLIBLOCKDEP_VERSION='"$(LIBLOCKDEP_VERSION)"' -rdynamic -O0 -g
 CFLAGS += -fPIC
 CFLAGS += -Wall
 
-- 
2.20.1

