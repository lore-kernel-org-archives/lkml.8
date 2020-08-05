Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E94C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8444220738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586287;
	bh=jfx2EaUOV1yDHfNYCBbBUlexOUEaFjS07JZF9xs2rmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ku+XOR51vYmTyCualKcr4bItHC3NgVGgFjubVyD1OPZgymRrGIOb3mvzWi7vQEr7M
	 8Ii3Ys4tIjZrtaNcUvV8rzAqABIBrTZgCUs0XbEYoWbKoM0kDUqHuzkPAPPWhgAp09
	 DpuvvN0MXKTZozlc6OnoajELFvaHWof6T7+XAzIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgHEALQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgHEAKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8742520738;
        Wed,  5 Aug 2020 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586253;
        bh=jfx2EaUOV1yDHfNYCBbBUlexOUEaFjS07JZF9xs2rmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwDKTye/c6TlVWrbIcq2L5Ybt22JvQj1FxZ2+n3SLQfbdsOuVfCFaniM/+QUwdqm8
         oz9WNImPPUy4OqRaP1ZAkAyNC392rdBo1cOZAlPUbNOdZae/p/swVZaRe4la03Jkm3
         AJv5d2pSGhx46GomgrTPwTTXxz81ZIBUZRz+E1Wo=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 08/14] tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
Date:   Tue,  4 Aug 2020 20:10:37 -0400
Message-Id: <20200805001043.3331907-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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
2.25.1

