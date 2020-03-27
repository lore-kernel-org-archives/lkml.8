Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E21C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED3B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVAprFxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgC0P3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32118 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727585AbgC0P3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0e2gzI0zL8XByBlkSwiBaCp0t23LVKYL2OhRMw6s5og=;
        b=cVAprFxUVzzyzy9hBcBBXWnr7cdz5M/0O0to1N9XZb1sVXGd4G6eP5H7x1+hxyCasKfsIn
        pukwrlIghGbEDqVMTCFRtyuBCEPjv/mzTw5tjQDnxC63AZXZEg+NaDPydAS3qsQoTLcH3P
        ETChfBMF+a/sypGzILQaP4ShW7RG0CQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-6m3Mj9f3PTGlXloi3zzpSQ-1; Fri, 27 Mar 2020 11:29:08 -0400
X-MC-Unique: 6m3Mj9f3PTGlXloi3zzpSQ-1
Received: by mail-wr1-f72.google.com with SMTP id j12so4679738wrr.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e2gzI0zL8XByBlkSwiBaCp0t23LVKYL2OhRMw6s5og=;
        b=SARU+awfHp5Ov38qPvWHD/W2jJ6dDlZDpgn2+jDEA/GX8fL4Kzfggla6/wCgeJAIA/
         JA+L3RhMECZ7CeYO7uFE7r/G2lQn7XchEdGkLN7vD1XgvAlDN0OPY6X2SFnGToaijHi0
         dlbhkTrr7W2hnhf7QZU2nmyA9edgd6f3aFCyixoCcK2HOl87857CQmisKv5O2/xnw/q/
         JNF+gUJVekagqw11UplCNrKFPYkN/8jkceAtbp4QQknkCDRX+yRp3IvxyjhQfsJEVN5h
         8GZBLCc8MIABzlmNrbrjhlp7nZcogfTsI8GSK+fzebv+LiTuWHw/qhDRI7346site8WJ
         uI9A==
X-Gm-Message-State: ANhLgQ0VYybn4EC2s0cKInXkB6+lSUiT2f1z5ifXl9UVF3rSfDnPyp3Z
        xwNNu+DE89YbdjimahbL8YvHSypJLE7ThMWtp8vKDHkP5T+KKNsahrfn9D2o8HwCis3IqHHwSKm
        gQT3vvWMi8rptttSg65qobKPw
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr1910528wmm.137.1585322946665;
        Fri, 27 Mar 2020 08:29:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vskxWCMdzihQgLNWpL95Ru+jpwwVkl7YaHb4zV8lJjwwIrvBBDgKMT08Tapo8NTXMC6guc3WQ==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr1910506wmm.137.1585322946483;
        Fri, 27 Mar 2020 08:29:06 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:03 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 05/10] objtool: check: Remove check preventing branches within alternative
Date:   Fri, 27 Mar 2020 15:28:42 +0000
Message-Id: <20200327152847.15294-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While jumping from outside an alternative region to the middle of an
alternative region is very likely wrong, jumping from an alternative
region into the same region is valid. It is a common pattern on arm64.

The first pattern is unlikely to happen in practice and checking only
for this adds a lot of complexity.

Just remove the current check.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5c03460f1f07..6af14a55490d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2037,12 +2037,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
-		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
-			  sec, insn->offset);
-		return 1;
-	}
-
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
-- 
2.21.1

