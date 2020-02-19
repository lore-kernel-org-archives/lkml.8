Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2212C761A1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C002465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gowdgx08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBSWOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:14:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38808 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgBSWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:14:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so811093pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TWI4qCqMhEw1k6KAKhbqnH5AxNi8DQe8QpDA2F+2Frk=;
        b=gowdgx08ONSh35NJGdAHXGTosBs3S9E8JqmodD8dWAoGkWtezQQSFKUzC67dNWtv23
         KzhIDrHsK3H9KMW4ZtXg39qY9wANloeIKW3+6/j6CAfAAnaZ+n2zVBjccNj93s8ibvJq
         8xEPi3vm7Z5JWCs47CXt1gCyp1Tc1kzr4/h3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TWI4qCqMhEw1k6KAKhbqnH5AxNi8DQe8QpDA2F+2Frk=;
        b=iaZA6+uMpytMC7uwr9lylHn6te8hL/SOJfkrX92sNu/rOQXMDZ8U3VYz8OBdFCfMqh
         RjSo8WeOPFvosqvi3CbYf7wZYn/OV+RuO6u2VYBI97jnoXjn92xv7mAs4oqaXmKh3ITX
         QUB4kHU22QJDElhikgPELoNgU4c+OYAgy5+rRvch4iTmeWas2CO3ox+C7sV/u4isCpA9
         givzzIiYdAfAe7NmM9bvAv2LtJSDB5mKUsgOfAd0faZz7ZRXvnMmwrp1wrU5ohUmFm9S
         UGob1uMFjmetZ9cuRHrCu3IohoQPv4eWeU8U5JOdl02E74YSusYJXOyhyypPKDCOZea8
         pw2Q==
X-Gm-Message-State: APjAAAXrGIkwe5JrsC4yyLXSG3H+NXQTIyNlPyiz3L1OTu4ROfpUPZ8T
        9UzPCHLV6/Da+NkJP9uW/JWHNg==
X-Google-Smtp-Source: APXvYqw4uvtiO4n3G17rwQUbo02TkzNpy6L/IWvWcQw3KdjXAzbBj9fgqxQitCAt4fbZbLU89Ec+sg==
X-Received: by 2002:a65:468d:: with SMTP id h13mr3298099pgr.359.1582150448869;
        Wed, 19 Feb 2020 14:14:08 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k8sm723327pgg.18.2020.02.19.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:14:08 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] docs: arm64: fix trivial spelling enought to enough in memory.rst
Date:   Wed, 19 Feb 2020 14:14:03 -0800
Message-Id: <20200219221403.16740-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivial spelling error enought to enough in memory.rst.

Cc: trivial@kernel.org
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/arm64/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
index 02e02175e6f5..cf03b3290800 100644
--- a/Documentation/arm64/memory.rst
+++ b/Documentation/arm64/memory.rst
@@ -129,7 +129,7 @@ this logic.
 
 As a single binary will need to support both 48-bit and 52-bit VA
 spaces, the VMEMMAP must be sized large enough for 52-bit VAs and
-also must be sized large enought to accommodate a fixed PAGE_OFFSET.
+also must be sized large enough to accommodate a fixed PAGE_OFFSET.
 
 Most code in the kernel should not need to consider the VA_BITS, for
 code that does need to know the VA size the variables are
-- 
2.17.1

