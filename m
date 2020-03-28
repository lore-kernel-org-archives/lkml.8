Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA2C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE4220578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWmrFk6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgC1Koj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:44:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1Koj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:44:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id e1so4503234plt.9;
        Sat, 28 Mar 2020 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ouG1QY0qEMnZsx9axFtA5PJ3qqXCyWz4Z878kZyIyXU=;
        b=QWmrFk6rJhJ66dZ3Q6pNdG4k7c3y+b22qyBgXmgt28mn3H/6K1NhfgwwZ8MNtZv5La
         ksmbBtfwQJlPj6EoUlFyoGSsGQsRDT+25E0zJ+zeGh8oLH075FCURsGcdUR2zWpQlETT
         th2wKHCzlMNbax1n/UlWPDK5yfY3QY23ofx8aLJMV4GYnawoFAKPdz2/nKMsoktxS+25
         ggwsK+Ljb18UshMXwsXsOs3FsFp6lDV0tm1LgGH6Qpyc5l1e440WfczqjYWtoQ4+paWw
         kAcFAcA+CqxpybQm9fBn3kqESl4u4lWRDh7ZczrQko1In7TxluBwn8lBb4xIOpdBAzG4
         tLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ouG1QY0qEMnZsx9axFtA5PJ3qqXCyWz4Z878kZyIyXU=;
        b=WKZRYT0Z/ttukys54iXvHxVHwQ3P4i+7zd+wEhP67JCReaazRcu3RViAA7wPsc1vT2
         j60Z1hrlHKkzGTi60ix3ovGv1GTZvWnLXljJM1ZFPQ755ASj87wjQxT39zuQK3LnZO/9
         oD5K4+20w8arc4xtZIRtnU3DteKRtokht4qZBhMN4TmVuE/l/9JS+h0s4bMuY6F4FCln
         FkfPsnMMhD4n6E69Z+KBwqnWvgT1V7H2VauohQPNtOR7fVIC4jTCH4Lmc6gzj3+tC6zL
         kBakrTwX6jkdVwddWUYLFI3cIxVhyXdgpSA/Dm6w0LuTlKQsg08hgG9WkStaCV/GTEeu
         xgMg==
X-Gm-Message-State: ANhLgQ07o02y8szE4WtWZN2iVF1T/aES1W2rMlVmoWYSnOJuhpG7M2tD
        XiyZSKhqx8KO7vw82LzJQ6E=
X-Google-Smtp-Source: ADFU+vs5Yqyictzn/xZDgA5Cnm0ZHrVxULQf0p0R/mcpNnx9zHkjPpAmVbMPotGlO+/aaJMZGJ6b9Q==
X-Received: by 2002:a17:90a:36c7:: with SMTP id t65mr4176271pjb.182.1585392276220;
        Sat, 28 Mar 2020 03:44:36 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id h11sm5944360pfq.56.2020.03.28.03.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 03:44:35 -0700 (PDT)
Date:   Sat, 28 Mar 2020 16:14:30 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: early: Use the correct style for SPDX License Identifier
Message-ID: <20200328104426.GA6401@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to early USB devices.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/early/xhci-dbc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.h b/drivers/usb/early/xhci-dbc.h
index 673686eeddd7..9fb6a9f2548a 100644
--- a/drivers/usb/early/xhci-dbc.h
+++ b/drivers/usb/early/xhci-dbc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xhci-dbc.h - xHCI debug capability early driver
  *
-- 
2.17.1

