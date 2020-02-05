Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01550C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F4720730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ua+yzHj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBEWSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:18:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39814 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:18:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1595076pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEzN1Nr3XiQi/juytTwGJNmYcodSF75VNv82D15zU7s=;
        b=Ua+yzHj1ekndzoKgVM+Cn/Saemfiq/5aCzU0AqiDegTYL+yBN6eNkczqTqN8WOZeMd
         zL35aaPPF0e+FDHC/b6ZY6wpp8GJR156ImTOxzEoG0shGfwfHA61jAKyIDxqvTYkO/5r
         cfGmORe5BHpRIt6vygXshgtdd/eAzyMwW4iqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEzN1Nr3XiQi/juytTwGJNmYcodSF75VNv82D15zU7s=;
        b=IcpbzI7zJg3E8CAo16Kuyr21rthakVQVDaDNVdBfTvu3JOREDMAWh+dJ+YTPL9OJOp
         unJAUkiFzA5Zh0+58C8Q65fPb1arEEZ7yWrJzgxVLutaj+n4woyG8+lBDd7jKoQ1p9TD
         7Hto4C5NagxNOoZQ+fLjtgBi7JpvJbCL28lIHkK7balOvXRbV0/I/+Dcs8l+evzU/jwy
         gEkcfGCvjtvWU6OyyQlIAVYVpGZCscYBuoNMbpm0VnwuwoLPjn3xiI7Hb5V6AP05Ybm2
         3ljPBgwZHURf6pGCfCtjH07wnJ+0fwwllJV0/jh0kpa9iMZ1Lf+bdZ4jpLpFJNWlubeh
         S3Fw==
X-Gm-Message-State: APjAAAURixXsK1pgHsZMalc88vtBzpjxSth39s+v3SEJhAwmbYAjmQhv
        aXGojQnMwSmhRLn/nH/hKGvGq7EBMBM=
X-Google-Smtp-Source: APXvYqzhxZD8M5KCGlAijeTHvdgak0YMZQr3fsBJ7lGFQAV0yMy3bVL0XHXViN3jIKW741NXe1kuVg==
X-Received: by 2002:a17:90a:e996:: with SMTP id v22mr403228pjy.53.1580941101745;
        Wed, 05 Feb 2020 14:18:21 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r11sm787950pgi.9.2020.02.05.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:18:21 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        madhuparnabhowmik04@gmail.com
Subject: [PATCH] kernel/trace: Use rcu_assign_pointer() for setting fgraph hash pointers
Date:   Wed,  5 Feb 2020 17:18:08 -0500
Message-Id: <20200205221808.54576-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_ftrace_early_graph() sets pointers without any explicit
release-barriers. Let us use rcu_assign_pointer() to ensure the same.

Note that ftrace_early_graph() calls ftrace_graph_set_hash() which does
do mutex_unlock(&ftrace_lock); which should imply a release barrier.
However it is better to not depend on it and just use
rcu_assign_pointer() which should also avoid sparse errors in the
future.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 959ded08dc13f..340d30557a10e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5477,9 +5477,9 @@ static void __init set_ftrace_early_graph(char *buf, int enable)
 	}
 
 	if (enable)
-		ftrace_graph_hash = hash;
+		rcu_assign_pointer(ftrace_graph_hash, hash);
 	else
-		ftrace_graph_notrace_hash = hash;
+		rcu_assign_pointer(ftrace_graph_notrace_hash, hash);
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-- 
2.25.0.341.g760bfbb309-goog

