Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F4C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710522076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p37iL8wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDVPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgDVPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:53:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F5C03C1A9;
        Wed, 22 Apr 2020 08:53:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so1296012pgi.5;
        Wed, 22 Apr 2020 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DXOAVnHR/JBy0Y4uPJ7GHHi938/y6M1uaE+uBo8UB4=;
        b=p37iL8woIBWNU97EnJMT9VwP7l2RKgc8soMSx4IV+IX62SYlHIqQdpGySbCjARcv7D
         qDHkwJRGOOhe5LB/rrzCnEOCGZrjk8QWB0EE52Sp0aHSY13nrTMj3aX4A59ll4UidDsO
         IVGCKAZ/VSuHoDsim1ZSp1O8r3x7kkkFQIfiWPsMLYHAOwAEQw9dfuBPZLQXeLe8OxBB
         AfAEET9OzEtDYHMI5c5tecVubReXE3btLphVRcTBTOxwA362MdDP7/LsMtArPvYySZxp
         vB4ufq7h+xTpZmo3zmohx4Efzthsovh+DjhsL4tZIvQKPeCoevAXisI2BmTEHKgrR+l4
         1DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DXOAVnHR/JBy0Y4uPJ7GHHi938/y6M1uaE+uBo8UB4=;
        b=gdv7SpbfPa0XP3MyccLQlL2DV4OX/HUhr/lFgi1Nq+GEsyQ2Radw3RV4BvpenIB+eE
         w3rNMi8krloklgBmAjd6t+xzeB9ETFgBsPg9KGT3hkwKx6JAHArWZA/07bvrFeyd8kG3
         S9Ju/zXPxdC8NozCUi6VlwfJ4cfkDLZZDRXChhu8wHmVrzl5upwXiTk3kO33Sk5wgIK3
         kUYBHdM/odioDYwh+6wHd/iXPhNvPQ9rLP+2SGGfvpooVsTHmnXZE/iwHUMfmaflLoZa
         PhQK+JrCovFUTwVwdTbzMj4KPz2y0fgAa623zBSJQwHllrpNzxp6QVz6j2cOJ6Vu/JTH
         NBbA==
X-Gm-Message-State: AGi0PuZF08QGihepy8OLYVZ1d6e3/+KvCbmZF0wavUGiG87cWgzaf0bZ
        IR9fon2PRF+BU1E94QJPJTw=
X-Google-Smtp-Source: APiQypLhyEB4b+85IkZPJo2ASXh+Y/49d68Z1e97PBFqQn5TiO1hKIDkGgZIzkquqVbKKzf4UK/c8g==
X-Received: by 2002:a63:594:: with SMTP id 142mr26040751pgf.418.1587570817396;
        Wed, 22 Apr 2020 08:53:37 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id 36sm5529103pgs.70.2020.04.22.08.53.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 08:53:36 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     b.zolnierkie@samsung.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, tsbogend@alpha.franken.de,
        FlorianSchandinat@gmx.de, ralf@linux-mips.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1] console: fix an issue about ioremap leak.
Date:   Wed, 22 Apr 2020 23:53:28 +0800
Message-Id: <20200422155328.27473-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if do_take_over_console() return an error in the newport_probe(),
due to the io virtual address is not released, it will cause a leak.

Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/video/console/newport_con.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 00dddf6e08b0..6bfc8e3ffd4a 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -720,6 +720,9 @@ static int newport_probe(struct gio_device *dev,
 	console_lock();
 	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 	console_unlock();
+
+	if (err)
+		iounmap((void *)npregs);
 	return err;
 }
 
-- 
2.25.0

