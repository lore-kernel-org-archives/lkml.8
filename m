Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A8DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D722080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ7ok0HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFZNGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgFZNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C8C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so9429520wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgIF2Tzx4eGBueCHKg86n/uEbujpF9PDzYcT2/3mg20=;
        b=IQ7ok0HF4tKRxVuvEs17kkX6k+cf/VouH+TSqbBr+XLgYtS7BRaQowsbrDttWVuvPc
         E7AqbgsIs9MIqUKO4193FmdzsBWz8ZBRtnrfrFwXv9VjBGww9Xq9ha+/iMi7Njv3vtJl
         ICkZlU0pFyjugJPCj9LXhEoMytPjjDR0Uvwj8IV1ndWViuTfybwqOsxvx1WrTqd7cH06
         W1TO2mrjQZ1h2pQ1vGmACWESyt5q4Me02Zj5yjlbJc3n6wF5P2WuR3SkSAlD79Lf+dBA
         O71OZrslrwEWGs3Nav792wgk1CsCAzUtRJrHod5wrFXh8JN0dvN8M4ZlrlAY5j30+AIp
         125A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgIF2Tzx4eGBueCHKg86n/uEbujpF9PDzYcT2/3mg20=;
        b=AAKz1PPngXkg0eiGU9bBHeqxVxIAp62HhszbbMMxkxftcPvHtF3zd0VkIa7ml3rYS2
         Hk9fKw+GuktPpK1Vm9uXLdi7WShNQ4h4AJ9EFNXHzS/GgMQfUwmFE47DEqD5mpMd4CWn
         THm3kauh0Brj0S3mWj+/hVmqd8tIdR4C2DRW2UUnKeEaU10IEpZGR5c1Y6KgWQqNUlry
         oX51VlO9O02nt4RlMx4Qg0SzGr876jyTM1WsKu6jH/I21NxyTGiW/FL4Uwhn/AI2NERa
         EZHk5zJ8KChTZsSrkH1nUa6Xzr0lsMA3GJJ7hwEa3EQVIxqGrUzaxa6hXSRLkhd6JgTt
         NunQ==
X-Gm-Message-State: AOAM533A60R/zwRttYE8U/PehH+EGju0CWrrPiBTFrhDHPMiQ5RYzWm9
        kh44ExLKIzXJAD4xUkD1IjUsLQ==
X-Google-Smtp-Source: ABdhPJwgQ+N90JMO76E5nSShh82EMIgdI+DtTpbaW3v6JMh6ZlktTQ/YpvCCbUfSm6baoLg6e4CgEQ==
X-Received: by 2002:adf:e884:: with SMTP id d4mr3582523wrm.176.1593176740964;
        Fri, 26 Jun 2020 06:05:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        J Freyensee <james_p_freyensee@linux.intel.com>
Subject: [PATCH 10/10] misc: pti: Fix documentation for bit-rotted function pti_tty_driver_write()
Date:   Fri, 26 Jun 2020 14:05:25 +0100
Message-Id: <20200626130525.389469-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The API has moved on since the original function header was
authored.  This changes brings the function's documentation
back into line with reality, complete descriptions of the
latest arguments to be used.

Squashes the following W=1 kernel build warnings:

 drivers/misc/pti.c:510: warning: Function parameter or member 'tty' not described in 'pti_tty_driver_wr
 drivers/misc/pti.c:510: warning: Function parameter or member 'buf' not described in 'pti_tty_driver_wr
 drivers/misc/pti.c:510: warning: Excess function parameter 'filp' description in 'pti_tty_driver_write'
 drivers/misc/pti.c:510: warning: Excess function parameter 'data' description in 'pti_tty_driver_write'

Cc: J Freyensee <james_p_freyensee@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/pti.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index b7f510676cd61..07e9da7918ebd 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -496,9 +496,8 @@ static void pti_tty_cleanup(struct tty_struct *tty)
  * pti_tty_driver_write()-  Write trace debugging data through the char
  * interface to the PTI HW.  Part of the misc device implementation.
  *
- * @filp: Contains private data which is used to obtain
- *        master, channel write ID.
- * @data: trace data to be written.
+ * @tty: tty struct containing pti information.
+ * @buf: trace data to be written.
  * @len:  # of byte to write.
  *
  * Returns:
-- 
2.25.1

