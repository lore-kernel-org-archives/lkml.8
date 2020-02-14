Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0654DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8C22314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZeJR0XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgBNUsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbgBNUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so12451691wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbKpGMSoVKA6ipuIlX/H9vVMKswet6nu7tSTBdHVCw8=;
        b=oZeJR0XKxsoiCnEdTnBkwNVH6KmYLfcqU7z64jO6jr7N3n52TyE4Cq4oK7pVw/o2sQ
         06VwqKCHMrca6/WQZRQG2fwZioTw7mqPXoqdiKQ3xQDiUEPKVOVPjoHtc9Sns9TJphH+
         bmqSY9OQ+hOShC1PmmM3lzsOgqyDUcbxP2zxYpWJyvdZ1Mj2HWJ5kF0HoBdYGXL3zC3q
         DdeOqTHCghWARj+ZeXcQLv/CHlO/QQ2OaP14+Lu7Xky6BokK1Fi8eWBsjQlKdNx69ndM
         dQrQKBBqA9YBpLHuGN1mJczWIVDKZOTCxZdZIoX/6zMawKiL0DLOky+BWTcijCzVXe/d
         6fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbKpGMSoVKA6ipuIlX/H9vVMKswet6nu7tSTBdHVCw8=;
        b=uLlQuOKEDxHhFTkCEwOr+sLn++6tbSXbo8ewP++CMu/oHKNBiFCu1PfE9RR1s4TODw
         Jm3i+CbG0ofPCj01FUbWLl7hCtD2wfWJJNR71V61k4AR4Vngp8I5S8BQSbXNSWm6jDQa
         yX5Jmm9iISuBwlnaR4h36JnMzZRVwhKv9a17H1SeVWLYev+4lbUSDLGeZbRLEBTYekCE
         DSNZUKseGg9ygxNIq5rh3FEhrAdQdN9o8uuv5infGdNzcSE/29cm1vFi3uOW1muVuQBv
         4R1npNk95h9Ij7agR767nmjSqDQE1N8cfXZ6J+Hjm4tPMtnd/WClqf8ZPQvB5fZxUFiu
         tS1g==
X-Gm-Message-State: APjAAAUr86fTDKXpGTi+wr/WBbZL13TlIce6S0u9svnaQLWuippdCVJg
        Zp97tAShqav7oI8YVVhq6DVpKCimaFn1
X-Google-Smtp-Source: APXvYqwg1zEvpLppPv48XcPxsw0JHpyCYusTyLfwPpJ45dQ0QL80sG2mxc6YvD/rz4Re9m7Pmpbzww==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr5840055wro.80.1581713322047;
        Fri, 14 Feb 2020 12:48:42 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:41 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH 07/30] mm/mempolicy: Add missing annotation for queue_pages_pmd()
Date:   Fri, 14 Feb 2020 20:47:18 +0000
Message-Id: <20200214204741.94112-8-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at queue_pages_pmd()

context imbalance in queue_pages_pmd() - unexpected unlock

The root cause is the missing annotation at queue_pages_pmd()
Add the missing __releases(ptl)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 977c641f78cf..bb0755228150 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -442,6 +442,7 @@ static inline bool queue_pages_required(struct page *page,
  */
 static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
+	__releases(ptl)
 {
 	int ret = 0;
 	struct page *page;
-- 
2.24.1

