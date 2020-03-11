Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB2C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DB320736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZaRkYseR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgCKTLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:11:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbgCKTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:11:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id m9so4079295wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5L4TciC+tNkYgT9aNIpRQF0FAoCb9l4BAjFrnNt7nFY=;
        b=ZaRkYseRVuRzovGqfb6Q9Lp+BkDzd4pKaChfeu7h6YDBJId4Bx4/eIO84sTUkVZYQb
         CfzJL8zoOuFkf0W2alkbdRNBhdX+vNtlmvIzC7U5j2QEHYjWw6mS56MoJczgblPaL7Ph
         XfxIteJ3a5kzAnmQUM1M433YpHbmbI8PCuAcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5L4TciC+tNkYgT9aNIpRQF0FAoCb9l4BAjFrnNt7nFY=;
        b=dmuweYsFr1eQLrsOyf/xtDa/ikH2eCfzOThKuE+mPPkGHa5NAchz+VFiGNrzAKTHXk
         YeV1Wry7ZoC4VagK7V/dxLIUbumBdkUlFFvKK/Sr/Tbw2AZVlpc/7PSTVxGoR+/RZr2Z
         MvlvqG0cOF/86eiaogxta6H6ZRWuFzKPIJ2uP14Q38ae+eZbxWg7lqrhMEYSQ+Qm8ytG
         vgM8qunW6S0WKkri6AOSX7YeA/yCElifp8H+9q5fllecALSiHM6C/69XpU2tzzpPXWNZ
         MUJY2K7/A8jSQbmFf9a5sxaGiwaa6KjapoNqg+S3JRqsiy/CLoIZJj7byDCwdNlbgSbj
         5v5Q==
X-Gm-Message-State: ANhLgQ1i70rjNID6adxCl2VoHi9rtWFvRsCETXJuPUfYYDV24Nyzevee
        ZX2ebqR5AkhvXlVl9o17zU2YZA==
X-Google-Smtp-Source: ADFU+vtUQS42bYpju+swHjyc1GLs7Clm0LNLN27Lk3vZkmaYwpX36hgY8X+jZTNmCauYkOFNUAlKhA==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr5611761wrv.4.1583953898577;
        Wed, 11 Mar 2020 12:11:38 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i6sm7073030wru.40.2020.03.11.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:11:37 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] checkpatch: always allow C99 SPDX License Identifer comments
Date:   Wed, 11 Mar 2020 12:11:28 -0700
Message-Id: <20200311191128.7896-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always allow C99 comment styles if SPDK-License-Identifier is in comment
even if C99_COMMENT_TOLERANCE is specified in the --ignore options.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d2..c8b429dd6b51 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3852,8 +3852,8 @@ sub process {
 			}
 		}
 
-# no C99 // comments
-		if ($line =~ m{//}) {
+# no C99 // comments except for SPDX-License-Identifier
+		if ($line =~ m{//} && $rawline !~ /SPDX-License-Identifier:/) {
 			if (ERROR("C99_COMMENTS",
 				  "do not use C99 // comments\n" . $herecurr) &&
 			    $fix) {
-- 
2.17.1

