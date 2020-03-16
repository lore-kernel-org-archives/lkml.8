Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9635C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1820658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YzwA/Eft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgCPTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:13:51 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36756 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbgCPTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:13:49 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so3347260qvw.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyO1rZabDWL4zYr5NEoM7UySObvndH4J9mOHghZ7eWU=;
        b=YzwA/EftTv+ZfSdrE1t15eyNk3OiF3B+bzstIn3J58vjROhIoqEAmMkiaehM3MArOW
         P+ofXL7CDQqMZVvIN8il489zO3B4hMcw5jVoW6wxyNAwmba1KNuJf8o9eDsTVVyVQ8/c
         1yETge5Z0N+vxayHMn91EBPGQNgtjKnQ7PUeQDa1E/YGhSjDwUouWfJWeZk8L1jdT3ot
         KpsfifLZ4VPAqXDDtXs72NyQh9/SxHH9fT0Uo4sCMNGmnnZWIavUt1nfKCIjliYsrXTC
         nzXvgse2a1GB7qCaQoJ3uByubc6wRrTDO8EQZE/D/KOoSfkX535+V+K1BTewv42dmN29
         r4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyO1rZabDWL4zYr5NEoM7UySObvndH4J9mOHghZ7eWU=;
        b=tD1wW++m2Aft8WVCySKYye/MLJe2th2/DSpf8I9Ic7b0z62ccjbH+i41b3wV94hx3h
         LDwjKjHkubmZRo2X0iEnAvN4/Ze0DJ5VXPhVbM+kgqfaKIWeBJKidl0aylteLhSuwoGH
         FgJTtij6FkVg4s1XetOPh1XxfB8UUrM7ogeVBtR3AIORmAv79VwOcY7lV9a3N90T0Rwf
         BIIdfHhb6D0ZNRXKf4r9mfefLStBrUgSR7m1pLkTF++eplzZWJ50nsZUDy3ImUgx2tcg
         i/IwBkFROQwp/O+HaIvXgJ+Q5UbzCHII+iQo+IkuBvkQs+DXEpDEGjg3ZsdGKBt+SAwW
         hKAw==
X-Gm-Message-State: ANhLgQ0mEvqKNz82vC82wdkw0+yE5WRm39MFDcYfoPArAZ+htX6AOwaN
        86QRMJuIz6HvfPkIWVDIg1AYJjsYiAg=
X-Google-Smtp-Source: ADFU+vuj/ymUvPEcfYt/yq5fpI6Dc2luJE4SeE5pW1WfdKnBApv4Qf5OUQAAnMzfG2ivA/7smwoLqQ==
X-Received: by 2002:a0c:b757:: with SMTP id q23mr1280036qve.213.1584386028667;
        Mon, 16 Mar 2020 12:13:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f40d])
        by smtp.gmail.com with ESMTPSA id g7sm375489qki.64.2020.03.16.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:13:47 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/3] MAINTAINERS: add maintenance information for psi
Date:   Mon, 16 Mar 2020 15:13:33 -0400
Message-Id: <20200316191333.115523-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316191333.115523-1-hannes@cmpxchg.org>
References: <20200316191333.115523-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a maintainer section for psi, as it's a user-visible, configurable
kernel feature.

The patches are still routed through the scheduler tree due to the
close integration with that code, but get_maintainers.pl does the
right thing and makes sure everybody gets CCd:

$ ./scripts/get_maintainer.pl -f kernel/sched/psi.c
Johannes Weiner <hannes@cmpxchg.org> (maintainer:PRESSURE STALL INFORMATION (PSI))
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
...

Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18cb5d18..6d9684b931cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13515,6 +13515,12 @@ F:	net/psample
 F:	include/net/psample.h
 F:	include/uapi/linux/psample.h
 
+PRESSURE STALL INFORMATION (PSI)
+M:	Johannes Weiner <hannes@cmpxchg.org>
+S:	Maintained
+F:	kernel/sched/psi.c
+F:	include/linux/psi*
+
 PSTORE FILESYSTEM
 M:	Kees Cook <keescook@chromium.org>
 M:	Anton Vorontsov <anton@enomsg.org>
-- 
2.25.1

