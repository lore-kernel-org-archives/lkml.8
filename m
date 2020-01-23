Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5EFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6529020684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jz7U7Z/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAWOF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:05:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36113 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgAWOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:05:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2671095wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wytPjSbZC28y5B3ceuqDy/iL3OfZmgStcvzlcuSAif8=;
        b=jz7U7Z/aYyl8I5OSU0ios0qBeAUM43v1yJBlrTsJeQnJf/BqqPAi504z8WeRVosieu
         TGl20Q1wWTGKIpZDTmwc4fmX5d98SdZB8vZwyg0MmvLcU7BA21gZuXxDYHglgHcoLn1l
         0CsM8wWhJpiToA6HmyXmQJwI7EELoSU/84WzinqKAEfOWi2I0/LiJSVNpEQlzMy4zwcN
         TRiHuf/TLcWwrEH6Fk/rClK/3nxDXGxmxumZhLWxztZiz6Ewn/5p4zC6fMmO5+w3C6eC
         c02hEdXgp/XuU7AItL7Hxem/lIHf9MPseyoFE8MY18hggH7+eww5AXB+1G8xX++lRksZ
         mW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wytPjSbZC28y5B3ceuqDy/iL3OfZmgStcvzlcuSAif8=;
        b=TKb4U6s7XVeLdpvFh/lzSD2ej1yfObEcSJCIncRTNx+6sI/39npMca7GCFqdd7UfcS
         FZDcmxNh6wv0uiTbsp6rKbMMTkh0m1eqrYG8E9+ELqeF7ReOLImyYj+GJKmfhrDy61DM
         jslGCDJeJPMtVaRM3M0vcqiJaK1vEw/lahcLn4gIfRJWmShJjPIP6d4mlDw0QVe75AvT
         03cBrt5ZuAmZB4JOKOMKjIbL8aO0SxDYchwoleKGfmvHgYn0bqatlLo0SrcBX/paUq3g
         cnfEJ9tx8i8CpWLxTtVNaU+nA1nG4GveAlosz93M2khwqVHEQk5QLDqXMlITMBpte5Al
         16dg==
X-Gm-Message-State: APjAAAVVhiZH/HwizImsIn7wi09o2F2NAPjbcAMv7PQ0fLPUJwFAmCRW
        Xvh5LqTsJ+y8nnCqndSFdm9mNg==
X-Google-Smtp-Source: APXvYqxKdnB/MOVQ0NHV1aEKZe2TS/5dzPNMUejZk9TvQG1pWykD8vOwwEBFhGAmXaLEmvllCQgrLQ==
X-Received: by 2002:a1c:5ac2:: with SMTP id o185mr4381705wmb.179.1579788322758;
        Thu, 23 Jan 2020 06:05:22 -0800 (PST)
Received: from localhost.localdomain (amontpellier-652-1-53-230.w109-210.abo.wanadoo.fr. [109.210.44.230])
        by smtp.gmail.com with ESMTPSA id n16sm3100963wro.88.2020.01.23.06.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 06:05:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefani Seibold <stefani@seibold.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 4/7] gpiolib: emit a debug message when adding events to a full kfifo
Date:   Thu, 23 Jan 2020 15:05:03 +0100
Message-Id: <20200123140506.29275-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200123140506.29275-1-brgl@bgdev.pl>
References: <20200123140506.29275-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently if the line-event kfifo is full, we just silently drop any new
events. Add a ratelimited debug message so that we at least have some
trace in the kernel log of event overflow.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43c96e7cdc48..6b5d102dfb13 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -987,6 +987,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 					    1, &le->wait.lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
+	else
+		pr_debug_ratelimited("event FIFO is full - event dropped\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.23.0

