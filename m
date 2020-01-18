Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C17C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 12:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C7F24698
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 12:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAFpoYuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgARMtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 07:49:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43426 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgARMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 07:49:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so13056385pga.10;
        Sat, 18 Jan 2020 04:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JHmtsXex5qIKbDtJ3Fw3qCcLL6Lf1FbLj7MwTYPydhc=;
        b=GAFpoYuzsgIz34hnlAIcM5SL0XhVBy4AeIoJwVM+59zo+BbXQAr+Cx3MqF12UuX+u5
         LYQHQWTJCt62j226CfI6phuSFjY6VRDkybRt7Sti+6lX9A1ebWbu9y0N+8e3TtOZ7kyC
         l0h+hjkxYR4TNBkAyJ50tOuu9tkohCGrlUfgqvWSqe27tqmt/4WZ83CWFauPYtizrJ/5
         heCpYLBl7uNF5ZTgbrdOftR3k5AnXiutHrzjm8nBQU/wGOVVCHe7vjN4BYVbCxL5Zxcl
         PpKQH7B9XvBI+kA/1L556fwZtg/nkcajuqPJDWYIw36yhb1QHShtlI3N7hfaK2fQ4WY+
         oatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JHmtsXex5qIKbDtJ3Fw3qCcLL6Lf1FbLj7MwTYPydhc=;
        b=VhLeftcVgAAbyrEskjeZYlAvBmQr/ljGxTYyxJ3US6P2S/0NnIH4YIu88XCyKnHkM+
         0n4XNTN9GScGO/XSPhuU2g72PAAMaNgSNKxXfQG9qQ3D0/cI/c60iqHiGQ4jV2ZKe9KL
         5j4ya7BYA/7kDL4G1uKEKTFRRLzjgALMrCDzbfWBCHtmId7FOML27W2qxwHESTQHRDR+
         4lLckmSpXG44/QnvUfoO28TL3TqDaRiIstXL+dkf65X0IXLl/BFOCk0BWEPqKvlJ9MeA
         67B7pri0+9/in+NF2Tx//KVJgdYZv0cRH0pnn/1blC3Zs8g4CGE5YVBb5j5o40gxF0bi
         cFhg==
X-Gm-Message-State: APjAAAVWq/94XWNd2JIy1q7oYuEpA+35kzkzOdyM3V3JgXvqYKudUAjB
        yysSgflOvzeZ5Tf/B2JCpMg=
X-Google-Smtp-Source: APXvYqwEkLv+vkCoCPQQQ+vlbrAaE6HdohlAvpKYWqBIKpcY4hRqkenfisvSMr+j09xbaNB5q4qqRQ==
X-Received: by 2002:a62:6407:: with SMTP id y7mr8228738pfb.49.1579351747767;
        Sat, 18 Jan 2020 04:49:07 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id s18sm32848011pfh.179.2020.01.18.04.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 04:49:07 -0800 (PST)
Date:   Sat, 18 Jan 2020 18:19:00 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: renesas: rcar-sysc: Use the correct style for SPDX
 License Identifier
Message-ID: <20200118124856.GA3421@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Renesas Soc driver support.
It assigns explicit block comment to the SPDX License Identifier.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/soc/renesas/rcar-sysc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 8d074489fba9..0fc3b119930a 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Renesas R-Car System Controller
  *
  * Copyright (C) 2016 Glider bvba
-- 
2.17.1

