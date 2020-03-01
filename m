Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E604C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC16424680
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFGvJNcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCAREk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 12:04:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33785 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 12:04:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so4360621pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RkkxF9rbxL5TO4VtQqDvZ6QeVGq/gOE8OHFbri98OUA=;
        b=hFGvJNczcHauEnaBu3G3gkJ/h5Fb30779r6ALQuRTI0ju2iSspmmlDrPvD5ADvutAt
         9vkwl/kUI7X0BhC2r6BNGlpRVNloRvM/6drDS5MiA02Nh5r2gK7LOOHYkjelM/XWHkfs
         vszxOTv2SwCAmxWrV2aDJcgd7SKV6K/p74fg7X/TtDbK9SB3QDJtwFQPwA2G7VyNf/Uu
         /NWcYGMSfzOisR1cJvwzfVK9rhBvCm2doO1SsSsxIcgUJP+Ws7JKPElfg7c0K3Woaapj
         fPaLpj/gnS/QfYGJPXaR4LOoOC8B6OBKyT2WfK/B3dWdgYdmsBAWrIknnnibbz3cSvNu
         ubwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RkkxF9rbxL5TO4VtQqDvZ6QeVGq/gOE8OHFbri98OUA=;
        b=fAzLbpzeGghnxHph+lt0WqcscBjMgsBgBwHtNsQUE9ls7FtspN1W4v+IuVQnNoba//
         wzfchYYubkKFaJ4Z1JKTnX9R5/jdyjhojVpTtEAkHAGN0nbf6dtrsVz5Px5A6UJwuNaj
         sQD6md8oGTxlUB0xDgnqWmGn5B3LMKlcBmKjA6px6mmy6Uh57hONYZvI7KrTpfvprkIa
         11aWa0XXRFxKdov8f5MxRccfDcANSJi2bjdF5QfpvyzfDa9YeERFl5dBxqApD/ka8mAJ
         hpH2u8ozXtC8glSxGrLUfORcu4NO2n8Z7UvBSnUkSZP9j5GIdUsHSl7q/Q6SJgwOgTpF
         mnHg==
X-Gm-Message-State: APjAAAXbXrblnefY3nW88Ce8vDtu3z26Yl7aOHXCnBdrvjP6l297q38U
        jO8sRr3Xy4X7kgj7QGI6DPs=
X-Google-Smtp-Source: APXvYqxQNZPrKDJN42DK5dYLBtrf4X2yMiJdhbaQA9IGdgoo/pchvXju7W0AhhEzM3tNLn9c/LDhAA==
X-Received: by 2002:a65:6846:: with SMTP id q6mr14674941pgt.352.1583082278724;
        Sun, 01 Mar 2020 09:04:38 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id o12sm542942pjs.6.2020.03.01.09.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 09:04:38 -0800 (PST)
Date:   Sun, 1 Mar 2020 22:34:25 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: hvc: Use the correct style for SPDX License Identifier
Message-ID: <20200301170419.GA7125@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to the HVC driver.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/tty/hvc/hvc_console.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index e9319954c832..18d005814e4b 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * hvc_console.h
  * Copyright (C) 2005 IBM Corporation
-- 
2.17.1

