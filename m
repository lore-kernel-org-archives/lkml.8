Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD645C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2DE21744
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCcft+2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgCDLIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:08:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33910 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgCDLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:08:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id c21so325639edt.1;
        Wed, 04 Mar 2020 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3yy/OH+uOLzdanIeOX7H2H64xTV/u4qsSGbI1/KJzyQ=;
        b=LCcft+2QE7nFkT9X5HUWblXU5lWrxdJypIWyYJo3inXIcHdt0vKgmcK+IrS9h2dwro
         qa7BWl8WjLE+T1r4EH2PRleIDulCN2puooKxfs9ZtRPiobwqs0Rb14VwbEkOfZTQwgn3
         Ym2McuhANF2g8pWsych3r5aHBj0SN82uOP+vIjjbbxaGd2vuRnflMoCii7XWmOL8Pntg
         0kyjp8rMjMYu2VnATJ+qoj1OpV3MibWfyDVuzupFeE6OTslpD0bWvABzyXRWRPpBKdDf
         9s5HmswIkdR9d95fiOLl6UW6VAB91iHxRMXHr9NKD7UEr7PPjl7YdfdDHHjf4YTIRtXy
         Hn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3yy/OH+uOLzdanIeOX7H2H64xTV/u4qsSGbI1/KJzyQ=;
        b=WPuwKFF1v1IoXaBQrqvhCH1PyZel58q6BG4jIJuhGLI2wavTk1WW3HtCpHMxfA4CSk
         wmlWoZeZMVGQbtMdwa8AzRw6p6DKT1Owmsj96ZW2WmAUwS64EHogGlbiI2Y9Aoesl1Be
         xFedDvlkxvcBB6zGFciWpkdRBSYs4+13Xbobmo91jTxfHlymsouxIzMqO2QwNmIUIfCb
         G8P0fsFst1TmRwP51YBxqMd2XfusEWX8m9ArwJwHytNvV9zZLwFgtul/ky2NnBM1QKnc
         pD50iLJuLpC/hiotHvl+v4wXF63NkHEKe12tjBnQ80LwLv3Z1X4kK6KpdZkbDn52hdk4
         +ZbA==
X-Gm-Message-State: ANhLgQ1E0H9zZpthsw2WlHpJd8k2Gfnr31VToiLyHGBeEaly6/P/tgwz
        u3mhS9EXhDvZelgf++RATzYHEbm8qL8=
X-Google-Smtp-Source: ADFU+vt49WpWk/Ua0NarpmOvy2WnwfqwmQwVx6samXjJI6itrKgzgZfzc16xKdY/y/XcYduymMXYBw==
X-Received: by 2002:a50:fc85:: with SMTP id f5mr2142948edq.294.1583320109377;
        Wed, 04 Mar 2020 03:08:29 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:3093:39f0:d3ca:23c6])
        by smtp.gmail.com with ESMTPSA id d1sm425796edc.71.2020.03.04.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:08:28 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Sameer Rahmani <lxsameer@gnu.org>
Cc:     linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to kobject doc ReST conversion
Date:   Wed,  4 Mar 2020 12:08:21 +0100
Message-Id: <20200304110821.7243-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5fed00dcaca8 ("Documentation: kobject.txt has been moved to
core-api/kobject.rst") missed to adjust the entry in MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: Documentation/kobject.txt

Adjust DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS entry in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Sameer, please ack.
Jonathan, pick pick this patch for doc-next.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d064049aad1b..998d56e61a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5213,7 +5213,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 R:	"Rafael J. Wysocki" <rafael@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 S:	Supported
-F:	Documentation/kobject.txt
+F:	Documentation/core-api/kobject.rst
 F:	drivers/base/
 F:	fs/debugfs/
 F:	fs/sysfs/
-- 
2.17.1

