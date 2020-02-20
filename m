Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA62AC11D40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C5024656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TfabCTw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgBTGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35914 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgBTGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so1396160pfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZkFzAyiQkuIY4OgoadL7s02yLv9HXFDGuWlNHtkrNfw=;
        b=TfabCTw33Y600VFVjLJV55rlwc33y6kKvX8TxXWbijlsTVqlUba5Niwa/JBiutCthO
         jMad8OfeGUwcatRkh3D4/F8geoUT1j1vGoWoXOMFaxYqopiShU7z6BH0/8Wu1hWV5snZ
         D9GLXv/rKLZDksCs9Gf7zKZu5dfxicbTn6ZjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZkFzAyiQkuIY4OgoadL7s02yLv9HXFDGuWlNHtkrNfw=;
        b=ukhENwYp6C1FUw92ORz9RbBJmVx55WAly1erMTBCHKS8Tbzx8tklC+x851tN/TqeO+
         qcDgsOEOvqw/DEaoy0iBuJDrwU4cU4lIR5Rj3ZoIVTKt+53o0lyLbwvC7m4SUyp2r+SP
         vE+Nl+CILo2femO5HSgaOKTqFGF7S48RAhMB9PiOX8ucTIXfAbYqOGOIDxmQi6RHKgUP
         mmn/tad5qfhV0LRKC1xpfP7MjOZ1xiZWrxwxj4YiVH7MDNTmR2w7LDOKWY1R3TiG44p+
         roU2YSw3Rtrhx4E9M/C+3p489YeL0FO9JQQpNKxqSv3KYODlXCI7X9+mL8zKpyfImUVD
         K00Q==
X-Gm-Message-State: APjAAAXgHAVCCfIkzJo2hmHdZLJCa7VG9J2eF8e37hm8Y/I2KdA2d4K5
        4paM+Iniaha1deOYgNeEdCdhbQ==
X-Google-Smtp-Source: APXvYqznyjp0bqgxF8BOP7nJzR51Bm8TnwobNo/7tVCUWQIVuW7jGT233SsDd/qGjC3WqFim/atHcg==
X-Received: by 2002:a63:7453:: with SMTP id e19mr3912580pgn.50.1582179796667;
        Wed, 19 Feb 2020 22:23:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2sm1818190pfi.30.2020.02.19.22.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:15 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] n_tty: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:13 -0800
Message-Id: <20200220062313.69209-1-keescook@chromium.org>
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

drivers/tty/n_tty.c: In function ‘__process_echoes’:
drivers/tty/n_tty.c:657:18: warning: statement will never be executed [-Wswitch-unreachable]
  657 |     unsigned int num_chars, num_bs;
      |                  ^~~~~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/n_tty.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f9c584244f72..1d1a398f4981 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -654,9 +654,9 @@ static size_t __process_echoes(struct tty_struct *tty)
 			op = echo_buf(ldata, tail + 1);
 
 			switch (op) {
+			case ECHO_OP_ERASE_TAB: {
 				unsigned int num_chars, num_bs;
 
-			case ECHO_OP_ERASE_TAB:
 				if (MASK(ldata->echo_commit) == MASK(tail + 2))
 					goto not_yet_stored;
 				num_chars = echo_buf(ldata, tail + 2);
@@ -687,7 +687,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 				}
 				tail += 3;
 				break;
-
+			}
 			case ECHO_OP_SET_CANON_COL:
 				ldata->canon_column = ldata->column;
 				tail += 2;

