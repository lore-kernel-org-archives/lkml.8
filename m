Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091CCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC41620679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgFCK0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:26:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33695 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:26:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id j12so985451lfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 03:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q3i8iHAWRTVeWsH591QqSI2WbWXngN4h48VEgDqsaHE=;
        b=UivT4tEnbkOC4zuqQVHOmZ4Xc7fFUQ+mcnlccDEm/UMn7SRiNTOt47aE20WHirMLAs
         zGhXeFi+xSkKS2so0fe1pC+NitI5q1WVnaeUNkysORlwZlKfJ6uokgUhJYBgpxGLDyQL
         OqcGhWjhP9hgkSvJZx8fVcvgI+HKfmmIOcejKJJEEAaaiECOlbj8/D5qx09I21AEONsm
         3RdjHu5GFWfoOkoIIpZF2nwoSCZxY5FNv9fG9nl78+l4pdPBLnELTvOqYNPNlBwOq1/H
         kI6jnTd1jwU333l82nXCRuxhRlhqMJM1c+wrrdFYJ7qe+fKsuHvn3vPRl0/WcNTMm5B7
         iJMg==
X-Gm-Message-State: AOAM5338ddgQFjHPVcf9B41/1gMP59Il3T85Xgp7Dkh5TWQRmkSK/G+Z
        i/yJ+lTR2ADiLsXlbAvV9lTTcktb
X-Google-Smtp-Source: ABdhPJz1tTxi4/AdvzHDS4Z4q/MD54xYnc7tJjiMz8ZkjFPs0WHtN68gBSGSUlnO1XO3M9TeMHx8Fg==
X-Received: by 2002:a19:7605:: with SMTP id c5mr2053668lff.213.1591180000620;
        Wed, 03 Jun 2020 03:26:40 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id o19sm357385ljc.23.2020.06.03.03.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 03:26:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] tty/vt: check allocation size in con_set_unimap()
Date:   Wed,  3 Jun 2020 13:28:04 +0300
Message-Id: <20200603102804.2110817-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmemdup_user() function has no 2-factor argument form. Use array_size()
to check for the overflow.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/tty/vt/consolemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index b28aa0d289f8..32acea9e8270 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -542,7 +542,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, ct * sizeof(struct unipair));
+	unilist = vmemdup_user(list, array_size(sizeof(struct unipair), ct));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
-- 
2.26.2

