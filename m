Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317EC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9B6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DS3zpTry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBMLnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:43:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36903 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgBMLnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:43:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so6224024ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 03:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6T8aX1QwpqyjQv/4hfG4t4Fh7mCih0byLL8inV4cnE=;
        b=DS3zpTryUgnzBtAdqVV7n63dtHxdb6Au6w9LFVVa1fjwRigYHtRhKD4An3wUxMW5+b
         gpv2S14ouzj7WK0Qh+ae0v0Y4ADDEjpvu6vSyGDwTy9y3o+Xo2Wnm79I5SW4WGtzmyTm
         a5a7AcPPNP2avTOI9njhZ4ikyfRy4p+V6V7Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6T8aX1QwpqyjQv/4hfG4t4Fh7mCih0byLL8inV4cnE=;
        b=n2033hIiZWlxTxKp1e7dYA6GNsbvgotAxoqDRSe1u7GeJi1iwUJUM+iI2Sk44qhaiI
         S7BFVQ+LHmcV5qa1H9o+V2XEzXjT3h4TQbMy1+xdhCnsORJ3BkQagORsUVSqtVtONxea
         sb+GSbbRQMAzEFNUC3hgO162bR/Q870WdaKvvaUcUNC+1vBMB8bHJIiRcEyvjGvN4HnW
         ouehn8Z1uAV7B6jLQXkoPrxNXtHElH6Oau3NY+ML7UDSDKDqyJgHko9iM27wR/k4LocH
         H4tLpcwtJy/qomRSn8N6QiX9LHYkrPDD5ND/lLu2VNldHJEREbO+blrLQ6bcRuKl8Tgk
         3GLA==
X-Gm-Message-State: APjAAAXntIM2PwQEq5Vaz2JT7lls2Q4lq8lRcwOuZXwq6HSYYRGpPKHF
        H3yJjLaNQnsjCumUh49WwPT/qg==
X-Google-Smtp-Source: APXvYqzihrRuQYzokfC8tH0BWwAQtZxAEN1Rf+GsEvokD8opRwS5tRNLeqUyWw/2APcjeVRtq7ZRiw==
X-Received: by 2002:a2e:9052:: with SMTP id n18mr10774826ljg.251.1581594229111;
        Thu, 13 Feb 2020 03:43:49 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q13sm1603535ljj.63.2020.02.13.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 03:43:48 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: cpm_uart: call cpm_muram_init before registering console
Date:   Thu, 13 Feb 2020 12:43:42 +0100
Message-Id: <20200213114342.21712-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe reports that powerpc 8xx silently fails to 5.6-rc1. It turns
out I was wrong about nobody relying on the lazy initialization of the
cpm/qe muram in commit b6231ea2b3c6 (soc: fsl: qe: drop broken lazy
call of cpm_muram_init()).

Rather than reinstating the somewhat dubious lazy call (initializing a
currently held spinlock, and implicitly doing a GFP_KERNEL under that
spinlock), make sure that cpm_muram_init() is called early enough - I
thought the calls from the subsys_initcalls were good enough, but when
used by console drivers, that's obviously not the
case. cpm_muram_init() is safe to call twice (there's an early return
if it is already initialized), so keep the call from cpm_init() - in
case SERIAL_CPM_CONSOLE=n.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: b6231ea2b3c6 (soc: fsl: qe: drop broken lazy call of cpm_muram_init())
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Christophe, can I get you to add a formal Tested-by?

I'm not sure which tree this should go through.

 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 19d5a4cf29a6..d4b81b06e0cb 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1373,6 +1373,7 @@ static struct console cpm_scc_uart_console = {
 
 static int __init cpm_uart_console_init(void)
 {
+	cpm_muram_init();
 	register_console(&cpm_scc_uart_console);
 	return 0;
 }
-- 
2.23.0

