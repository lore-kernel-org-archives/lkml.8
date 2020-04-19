Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4FCC38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E7421D6C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587261500;
	bh=jKP7uD9q3zWYsTKN99FjfTgw+Et5XfVoMV5WtjjFR04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OyiRqC0jOA1U71lUoZE4avN1oNN0OekfgQC8HPs9yx2FYJdBFzZsP/2Ln79wow9S+
	 7fq/9eHOoQRJ3WktVufGjnl/4w/xLwfA+BkXLh9zbGz2i3Q2+d2aSbxmWQixdZBTp5
	 OeQEjgwMbH4gk88F5XrTL7JdJRZ/Uvb02o/5EMXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDSB6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgDSB6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEB7221F4;
        Sun, 19 Apr 2020 01:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261489;
        bh=jKP7uD9q3zWYsTKN99FjfTgw+Et5XfVoMV5WtjjFR04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otgADSGhhNLMIcu9cPdiJRTJBnm/YwEWq6DvuEIUonTNPGfD3lyW/ZbSzKoQ3cBbZ
         VTa57OocvDkqtKfBBO92t0sdRUB4swriNCSx2dDotXpkbKNkvvLu7uNTeP/qeKeRlB
         4LFi0eTuUPZqKwpzPaOG8W7yQz9kripUshJHFXvo=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 09/12] tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
Date:   Sat, 18 Apr 2020 21:57:51 -0400
Message-Id: <20200419015754.24456-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
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

