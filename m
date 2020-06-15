Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B46D2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgFONCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:02:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42122 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbgFONCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:02:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id y11so19087488ljm.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9kSSTxyPh85kVvOo6maTc8rLC2WWVwxqEzTRiJwKx0=;
        b=PoFceHT/f9sNkVkc0UL4UWU82b9WcwNGKvajyCHV5fhPMcQ9AuxVU3auF6WR5QhEVs
         DwsbuFgiGXkgPZfgnMNyyh3722wXPBecoRejz9zYOHqtSK1NyatbZiZTsVcWa67Uc3w9
         fIuD9hP4wZaVzUaVsrpJqXKBYiHyLc4sFMI0/dTchhC1vId4+5IgRj7VLBoh+yUHukg0
         eee1rKhNQe0ma16FNOXWBsBPTrS3MLoY+gJOBeJ9xn8TjYpOOXmmarq4ASJuIE/pl6su
         YxKg/fyn6uyu+SHu9tW+c9YeU3enN4w4q2gBaKqsg8H5w83pWI7/13ytVE1EVAeXQy7a
         JOCA==
X-Gm-Message-State: AOAM533ApKr19Z43gZLZ8D2NQrLReOXj/4heguBDdrFuzIQhmkAQ1aLR
        +i/Rvwag3L92TKxMkUrHlnY=
X-Google-Smtp-Source: ABdhPJyK1JHuTlXvPOFk8NgbU1HL0MIpvqofgxnk8qHo3E7yCHzViANb2kLHco5d6KxHNPWsXWVcfA==
X-Received: by 2002:a2e:8043:: with SMTP id p3mr11906174ljg.217.1592226159211;
        Mon, 15 Jun 2020 06:02:39 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id f19sm4548072lfk.24.2020.06.15.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:02:38 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH] coccinelle: api: add device_attr_show script
Date:   Mon, 15 Jun 2020 16:02:42 +0300
Message-Id: <20200615130242.11825-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation[1] show() methods of device attributes
should return the number of bytes printed into the buffer. This is
the return value of scnprintf(). show() must not use snprintf()
when formatting the value to be returned to user space. snprintf()
returns the length the resulting string would be, assuming it all
fit into the destination array[2]. scnprintf() return the length of
the string actually created in buf. If one can guarantee that an
overflow will never happen sprintf() can be used otherwise scnprintf().

[1] Documentation/filesystems/sysfs.txt
[2] "snprintf() confusion" https://lwn.net/Articles/69419/

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 scripts/coccinelle/api/device_attr_show.cocci

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
new file mode 100644
index 000000000000..d8ec4bb8ac41
--- /dev/null
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// From Documentation/filesystems/sysfs.txt:
+///  show() must not use snprintf() when formatting the value to be
+///  returned to user space. If you can guarantee that an overflow
+///  will never happen you can use sprintf() otherwise you must use
+///  scnprintf().
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual report
+virtual org
+virtual context
+virtual patch
+
+@r depends on !patch@
+identifier show, dev, attr, buf;
+position p;
+@@
+
+ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	<...
+*	return snprintf@p(...);
+	...>
+}
+
+@rp depends on patch@
+identifier show, dev, attr, buf;
+@@
+
+ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	<...
+	return
+-		snprintf
++		scnprintf
+			(...);
+	...>
+}
+
+@script: python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
+
+@script: python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
-- 
2.26.2

