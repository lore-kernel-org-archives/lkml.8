Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23603C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDA7206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOaRnVXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCYImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55423 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbgCYImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULivbGLl6KTUozKoE2Gy/bIJGSFm1/wS+8k3cIB+Rtw=;
        b=NOaRnVXcM3LhOOzp6h4teZvVBQKfHGQx35WXTluKFW1TVfY/DAH5CPImWBk+PYNWSobFxz
        SiSNdLe6YqYsLjIbio7sT6XyoqUsMfk211GHdEI5ZgoJ37BLHiSKCxZYucFsrvA0N+SrZB
        D0QkoERcMT8nidJFGhRHBbAPRg1h38E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-RiZHKgODPYWcoPR_VIi-AQ-1; Wed, 25 Mar 2020 04:42:18 -0400
X-MC-Unique: RiZHKgODPYWcoPR_VIi-AQ-1
Received: by mail-wr1-f70.google.com with SMTP id u18so792435wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULivbGLl6KTUozKoE2Gy/bIJGSFm1/wS+8k3cIB+Rtw=;
        b=lFrp2e4zkxxMjr80E7i8UWXC/kE0x57hvPFDHyg0rveyhfdtpT7eAUQKmzisUj9SHl
         JlLAGEetQWJRYLicLY6CDBAJ+yxr40O1NQWhozCEzZd+Elr8oaeilwkl5S/RGyyLqy5G
         CNzuYxRmIbe80nUts/2qaw1e/1sv9Wdj3w3eSdh9ypGxg/EfnvsQg6pXVOalbmQvWusD
         JhVrwsTsjw3/+NShNdr+Ge8gADQ7IUMaUOx/XLA/xLkINNs41aB9/8eQAd4K6AvDE4bB
         CfEaz1/DNdKcw7zcRTEzc56GrG+Y1hD2sqNu0LeaIgcPKpjjixn0z5p3akA/fjNqiajQ
         G4pQ==
X-Gm-Message-State: ANhLgQ2VpYmbn7eKxmUClkFeYx02Wo9Im6tvecll95ltpd1zuJpXec+N
        y7liksGvyic3p9gI5v3KCHp8/wm4fcX/hS93mRZ+Cv4uCXyllY1MeV4R4YCacBLKMWg70F8GcbO
        N4ywn4hQfFAu8OJX80doGoSiH
X-Received: by 2002:adf:ed86:: with SMTP id c6mr2091121wro.286.1585125737029;
        Wed, 25 Mar 2020 01:42:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs1j8VE04/AKRhD+HSmkabsGG0dF+IBe9t888FWrsiLeSacz0MPxj2x7sEQYxBKOtPfHIfBsA==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr2091090wro.286.1585125736732;
        Wed, 25 Mar 2020 01:42:16 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:15 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 05/10] objtool: check: Remove check preventing branches within alternative
Date:   Wed, 25 Mar 2020 08:41:58 +0000
Message-Id: <20200325084203.17005-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
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
index 75ebaa0a6216..b8c288c02c99 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2015,12 +2015,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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

