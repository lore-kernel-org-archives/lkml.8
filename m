Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46914C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27033208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV8MyBfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHUDpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgHUDpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:45:05 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FBC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:45:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k4so301690ilr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pjb3qXMqNGgbJ/lSuknPKaxC91VgiCH9RpbBjdcDS+8=;
        b=mV8MyBfwdtBHyzYdMge8jfhsn0YXfWoqfrEOge4JH25XoMui3ok4QyrAfAHSRsxDUD
         BbFoOhjLpPdqki5bLodj0gyNJif5RCd8HiuIHXg/rtUVRQfOaacVwr1i7upVDHR7DV47
         ABbgHTY/zwpTVpqbyL2Rccs5IRsNy4N2lC2NMl6a8U1FTWRInZlBE0gv7Mf8fE83Ea60
         bvmlXqd4QCjdqXHPvlv83QOdA1U4U/JgS3aS7rF4GCoNF0hg/sXgFB9bk08YuZ/PZbnw
         Lj24IFQ3UUP1UNc7Fr5GwdXe8BoIMFMFVfqI4bTsaH4y2/VSJQPMj8BotrkS+lv3C8v7
         dZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pjb3qXMqNGgbJ/lSuknPKaxC91VgiCH9RpbBjdcDS+8=;
        b=jQg6phyKf0EYlfS+Z/wu/ifzUH6F0S4mf4rj7xQKfGbhfNgEa+uDzuntdkZnNo3/6k
         U+ca+KbclDYvQHwT1ygkmBxeOEVGJ78KLU/Dl41JcYKKrIKsbd4VnjxmRajxVY7Tjo99
         f+o6lVHqnmKNJmjKVtyg8Vx37RtbcY4lFjUBkR1llMSC8dkD18GdkDKw3diEXIoBys3k
         2HzvdIuJDp3dUXqsefpld6T9XSXP5/up0LinXrY0fhc8XrkbnOAu+1H3V7MmrB79Fva/
         kfsSYcKIYIz/XunTqx2kCqsoFvNUB1ubrY1wtlgYX7os8ynas/x1MuYinSVd8Zpi+VH5
         c+0w==
X-Gm-Message-State: AOAM5335seHIY+F4qfLo+ZZvYNyAKmi2rjnxYiHhEcRUtN3xURNymCsU
        oqQGQ1hzsrFWGHTqQUUI0qA=
X-Google-Smtp-Source: ABdhPJyQO2gsgp9hegbJXCRacpvIWQr1eAIAyQvGnHxGPvbmUrWyvaCsC/lHY6qQXi/ljXI9Zed6fg==
X-Received: by 2002:a92:2901:: with SMTP id l1mr949385ilg.306.1597981503759;
        Thu, 20 Aug 2020 20:45:03 -0700 (PDT)
Received: from localhost.localdomain (x-128-101-215-112.reshalls.umn.edu. [128.101.215.112])
        by smtp.gmail.com with ESMTPSA id c90sm390227ilf.30.2020.08.20.20.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:45:03 -0700 (PDT)
From:   George Acosta <acostag.ubuntu@gmail.com>
To:     acostag.ubuntu@gmail.com
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix get device imbalance on error
Date:   Thu, 20 Aug 2020 22:44:57 -0500
Message-Id: <20200821034458.22472-1-acostag.ubuntu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the imbalance in mport_cdev_open.
Call put_device in error path to balance the
refcount that increased by the get_device.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: George Acosta <acostag.ubuntu@gmail.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index c07ceec3c6d4..3b68e00eb40f 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1908,6 +1908,7 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
 			  sizeof(struct rio_event) * MPORT_EVENT_DEPTH,
 			  GFP_KERNEL);
 	if (ret < 0) {
+		put_device(&chdev->dev);
 		dev_err(&chdev->dev, DRV_NAME ": kfifo_alloc failed\n");
 		ret = -ENOMEM;
 		goto err_fifo;
-- 
2.17.1

