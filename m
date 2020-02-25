Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64375C35E15
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36759222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UoHTD/6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgBYUyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:54:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgBYUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:54:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so284975wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=28TDunclJ0ED67dbx8CkZqbh/7wdN9qJRWSOtwdsi1s=;
        b=UoHTD/6+hk2QYtP059qZLw3RRZ16mc3CjCh2ZZwsu0a7xHxNMua3zoubg3FnJlMpfT
         h9ft7NT72oICgPc9WavKnXNoQg4dLsDOs92lfQDDJOEaG24d44X339XfYqFwcRKl1+hz
         FaPA+pFgOHmZtoFQij9N6yoY6Gloe1pEwStUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=28TDunclJ0ED67dbx8CkZqbh/7wdN9qJRWSOtwdsi1s=;
        b=PWcTMPrBPfL1LgId4GUtGBMv+R1QztdDUGi+f15fHdBJSgPAMdwTupk4MSFq4Zubk9
         c7QfmgwOiDwsSH4PhcoIqcQPb6iFdQS65jGTspjPys0FtKxcqB28XOPfB4VsWUapJZ8U
         jYm4M4G/wYHlZ4MDZ/uXHSOlRmC6g6an3S+DUOTjxUexVigR6xXAbD3nyO6uktKiEwKT
         8LaFvcEHvCOAnpg9lmws6LltwUw0JrKXAN2p8ETg+HPnuKYhND8wtjJhDqGqZyAlu5hs
         lHNIxfxj13Ifhx14izk3yQFXr2IJWEJmuo/QjGfqAqNhnWpuDYojvJ/6nkD5MUUgCg7g
         WSEg==
X-Gm-Message-State: APjAAAXRB+LDxSaNbCIeJzBN8JZ5Dp0iT6HzddiQ1crDuajuZul64crB
        Hxqi02reU9/i2zPA/LuZRPiFmw==
X-Google-Smtp-Source: APXvYqxs5Dht7wCnHgNaDyHKMXo95ql8ZEwhG4lxizSll22ZJBzPc0J3TZ9jyuOGIAHL1lrfaQwGNg==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr932096wrm.89.1582664082855;
        Tue, 25 Feb 2020 12:54:42 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t13sm104852wrw.19.2020.02.25.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:54:42 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] scripts/bpf: switch to more portable python3 shebang
Date:   Tue, 25 Feb 2020 12:54:26 -0800
Message-Id: <20200225205426.6975-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "/usr/bin/python3" to "/usr/bin/env python3" for
more portable solution in bpf_helpers_doc.py.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/bpf_helpers_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 90baf7d70911..cebed6fb5bbb 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Copyright (C) 2018-2019 Netronome Systems, Inc.
-- 
2.17.1

