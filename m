Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C6C11D40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738442465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TNlFJ47j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBTGXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33908 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgBTGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so1400737pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZSYj4kTVX2QKNO4qM/GL6talXd67o8KZVFc5Pes8+c=;
        b=TNlFJ47j/n51UH7nhg7ZSP2xl6mjw5Z4eJZvo6/HIrlLllt6vipeXtnR8qIihoe4/2
         dk7uD4LbivJMR47wpyp9uAKtrxNZfakAu+Xsz42GokveoHCVPFcSKmm0LufYf6rKC1fz
         8Sr5ZOjdnxz4YGQtkqAS86nJuJKbR52TL9mNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZSYj4kTVX2QKNO4qM/GL6talXd67o8KZVFc5Pes8+c=;
        b=LZbpk/I0ABOf2e3wEZY4ZsV8YRF3WC3D/GK8OXwtz46ofeXfXfgAY2KyZp7zYKz+rk
         UOKaaJnO+O+uW/mneOgRcFb1CL2/iepq8axzU/9bWYi2FOUSb+ANu+AvYuhfAUHYaprJ
         2pmWs4hdeXHiybuo0gEbGPQC2GUQtoKBLiT9L1k6aGIzVJAP2OjzwzwI7W6JUF8/xV8r
         SpLa65O5YHhthFhfyR+T/4+IQnR0MP27QWqqhMGOg0/91XrVyj2YQD6bjQT7MzrRE/DU
         xsCIIBcFf4LMrKzHC7kOBZN3uzPGW064pscUnQjSjQXZ/CMWH1suSZcWuVWX3OzFmmeg
         yeLw==
X-Gm-Message-State: APjAAAVRKLztzt9EYdcn+2TuqewCg4PNejRKbjbRfOqDCySaD0nZ+lGu
        z61sbybJiYqH/K8wI5KLxKSynw==
X-Google-Smtp-Source: APXvYqwq62M/efZaqT2+1rrIrwer9ELCsk9xh7WiMNuBgusEoV/hmWrLZ/SGmXZZ1a4bqmDfl4jLPg==
X-Received: by 2002:aa7:914b:: with SMTP id 11mr31556085pfi.69.1582179791494;
        Wed, 19 Feb 2020 22:23:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm1786855pfb.116.2020.02.19.22.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:10 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harald Welte <laforge@gnumonks.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:08 -0800
Message-Id: <20200220062308.69032-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/char/pcmcia/cm4000_cs.c: In function ‘monitor_card’:
drivers/char/pcmcia/cm4000_cs.c:734:17: warning: statement will never be executed [-Wswitch-unreachable]
  734 |   unsigned char flags0;
      |                 ^~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/pcmcia/cm4000_cs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 15bf585af5d3..4edb4174a1e2 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -731,8 +731,9 @@ static void monitor_card(struct timer_list *t)
 	}
 
 	switch (dev->mstate) {
+	case M_CARDOFF: {
 		unsigned char flags0;
-	case M_CARDOFF:
+
 		DEBUGP(4, dev, "M_CARDOFF\n");
 		flags0 = inb(REG_FLAGS0(iobase));
 		if (flags0 & 0x02) {
@@ -755,6 +756,7 @@ static void monitor_card(struct timer_list *t)
 			dev->mdelay = T_50MSEC;
 		}
 		break;
+	}
 	case M_FETCH_ATR:
 		DEBUGP(4, dev, "M_FETCH_ATR\n");
 		xoutb(0x80, REG_FLAGS0(iobase));

