Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0518EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF82166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4UC+0ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCBOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:36:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38492 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCBOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:36:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id q9so2747139pfs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2QInZVdkPBk5bmMRIvmTp3CQChg52fcaaVfT0rxH9V8=;
        b=Q4UC+0jiKeBIj7k9TTcLV9aXFcDlOALrOygJTTrgQjpZ8hUM/VgrBtrciiZD0VGt7K
         Th/fju3nQjqaSvmeXdlZGBKHPCZR3066Y4FqvzCbYIK/5JL1Wjexc+vGCpIYO0V7unsh
         MJo9UjixifoZ53oY3QZXIf2xqEgF9BTl0RtqNkNlo0Y2xk0biIUX6xCvohkQFRCuhdzw
         EP1bTgdY3JImBvnbVjJzG9XgjYnio9kr1riezk+XvQ2CKhJVmgbhVH0WuAp+EUHXtyOd
         /73GNsCC/MOafsKpHY1a+SXAvKdBhR4G+YXSk7G6e+3F0iRZ5OcfqXMQqsHNJqsQjuN3
         TFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2QInZVdkPBk5bmMRIvmTp3CQChg52fcaaVfT0rxH9V8=;
        b=b5jv11woxqL7OYG4Vr2E7tSETl0LhTn7wpKXxrIOIhXc2CTCoRdPTeb9lJEImZi0r/
         t319c+nl/9//PQPP/L6U0S5BwhWFI+v9bOOJ0TaEmGjrH+Qmwo6CHS4k+0N8muJXBVkh
         DCfL4NJJcHWTvl8d6TQMGCvqwcYBaruQjo7+wkNGwcC6EMw/+UzWJX8/cZu2qucLo0FL
         2w2WH9+l4FLpk0F0i5COmnOLChIl3NHxBt4DisGGJC7VnDP74meeFQ4rinXPHWm2iiYs
         ElgQn+5QuN/s0giQHH+tyUccQpBaNW5LytgOxj7aHBhOzLND0rlfysRgI0K6yqI4shsd
         JgFQ==
X-Gm-Message-State: ANhLgQ2wQTdbK9NnTNXMyEseHPUljroSPf10w8uwnL0vwYz7ViDVORvf
        0Y3Xdvz4EK8rcfs61bIR+6o=
X-Google-Smtp-Source: ADFU+vvPM5+O35B1CzUIuEKmIqM4cdmmFBKb3ps3peBwYwuRg5MYTPMgZBpFe00X/BMmtI/qsYa/rA==
X-Received: by 2002:a62:a518:: with SMTP id v24mr11286088pfm.77.1583159812930;
        Mon, 02 Mar 2020 06:36:52 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id p94sm12857231pjp.15.2020.03.02.06.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 06:36:52 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:06:46 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: Use the correct style for SPDX License Identifier
Message-ID: <20200302143642.GA3335@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Kernel driver API to route trace data.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/tty/n_tracesink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tracesink.h b/drivers/tty/n_tracesink.h
index 1b846330c855..7031d515a700 100644
--- a/drivers/tty/n_tracesink.h
+++ b/drivers/tty/n_tracesink.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  n_tracesink.h - Kernel driver API to route trace data in kernel space.
  *
-- 
2.17.1

