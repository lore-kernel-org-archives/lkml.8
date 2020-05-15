Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F3FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46997206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT1ZT2vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgEOFp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgEOFp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:45:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0E1C061A0C;
        Thu, 14 May 2020 22:45:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so468781pfd.4;
        Thu, 14 May 2020 22:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YKNgbrCrtsp73wH3ijLVKsZS1VGL/SGIGZIS5Pz8KDI=;
        b=KT1ZT2vnSB5m3N1G+mLJmw6ct6+s+ULMK1g4qYBWyXyfU+vZ2qrL2BTGVswLS8Cry0
         zylnFAGMV5hrhEsPMQ1E4O4ypsjuQOdFj6E8pj4M0a44VXtfr8z6QZQpsqVUvVyxt/ab
         GqGV0hFX91RecC/wabKRE+MOkcB158DFMBFIjAwf9UCFU6Gyvy7TF5Ir+6vEw8iERjFs
         SL6vvarVoqddS7QZH2KdP3V0BnmarKzmZEFr/fvmY+pYTOW79I8tPlpTcub3u3sO+G3a
         T5/FM3/0EjhIrweWmkoyWSU+og9bUclOVKyAgxGK8y+cR/XrogzFdQX8pwKwrWkCaEwg
         G36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YKNgbrCrtsp73wH3ijLVKsZS1VGL/SGIGZIS5Pz8KDI=;
        b=o/Uv76UKIk4JUEzz4i0Rdz2H3jsmKW8a1NP72COK7fyUZf3qgCy+DSiHgB7HCrptco
         CBwZAHZcrwQJ8QXBliorIHJIqW9W+Yc104x2qI6xf1LsX3XZo3r97k56vZ3f0Lixxkdi
         n9ygwvRtnDlU0whcBxYkcYshXCRANhrPw2ltZE44c4mk+mXRQqXD5nQx2YAhp8YLzfNw
         82Jqeua8U6iLW5qOrVnSubehLOwYOCasFjgfptWCMwWmyvOnS2oxIIQP7J/w3aD+yHxm
         uC1QvTN2CMrteVsf/WC/LpzuWbu8pUGVsWlxF6HjKesE8+LBqBOGr/kp9swJdeFbRhXZ
         YM/g==
X-Gm-Message-State: AOAM531YhwXDrGqVWx8lE8XBGHu2yxOoxKDXEFQF+Af3RzaRQ6/PZfCP
        IGZ/4DllTV+7M63ZJOfC/Cw=
X-Google-Smtp-Source: ABdhPJx8/gZ60F9y42V1cBBw3QlCYAeaaOAlxmA7Ui1kW1Xyu8rmPAL4oNE1M/2DfGzyxIOMAiHBMA==
X-Received: by 2002:aa7:938c:: with SMTP id t12mr2099411pfe.139.1589521556869;
        Thu, 14 May 2020 22:45:56 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id gv24sm621110pjb.6.2020.05.14.22.45.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 22:45:56 -0700 (PDT)
From:   jiahao <jiahao243@gmail.com>
X-Google-Original-From: jiahao <jiahao@xiaomi.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        jiahao@xiaomi.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: Fix log mistake of xhci_start
Date:   Fri, 15 May 2020 13:45:06 +0800
Message-Id: <1589521506-19492-1-git-send-email-jiahao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is obvious that XCHI_MAX_HALT_USEC is usec,
 not milliseconds; Replace 'milliseconds' with
'usec' of the debug message.

Signed-off-by: jiahao <jiahao@xiaomi.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bee5dec..d011472 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -147,7 +147,7 @@ int xhci_start(struct xhci_hcd *xhci)
 			STS_HALT, 0, XHCI_MAX_HALT_USEC);
 	if (ret == -ETIMEDOUT)
 		xhci_err(xhci, "Host took too long to start, "
-				"waited %u microseconds.\n",
+				"waited %u usec.\n",
 				XHCI_MAX_HALT_USEC);
 	if (!ret)
 		/* clear state flags. Including dying, halted or removing */
-- 
2.7.4

