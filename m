Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B16C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC938206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MoDwHO9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBMSAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:00:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33972 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:00:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so274791wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IM6o8NVQDeHS8QF7w0dNqh6FQQqjXCaR+XNTNS4nvcs=;
        b=MoDwHO9KiaUH/rFESW5hrHUe6v4R738SjyRG+ioB0uW53m+A741omymcNbuRb/eaHO
         chIR7BML7ZqSd1DMuvV3Y8e3PexeI5qId7YZTSCGcapAYzl2giUJtrD0vd8RUizvX+9k
         uVkwvuTkXIP/fCXv1/36zEDsCxBeoeUhFjGXsBk4pMf3RqxakZlD1dcGx3wIITxP7WpT
         x3IzcBJy0iyAcNyQsgWqwgr2lxSThhSYeW2g2Gl4ZfV97j0iIIgPzXxYifVoHmpCJLG6
         C3PtpaSWs2W39AbIPTi3+veHiegYzL05DNI/jLppZokLidC8aOXcfXzbncLUofrzxl9/
         5Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IM6o8NVQDeHS8QF7w0dNqh6FQQqjXCaR+XNTNS4nvcs=;
        b=FdaLAwnqCqM3oDLpP2WPaMtWDykHBPbX76ZSKfkYZ84DY2O6fOmtd/L9Pse6E6igEN
         qwS7bnacDgJiu6jHrAzwbolu9fwpQ+G1726LObWTTsfHTeiZiKc+UPbzNHxLBRPB+UMy
         LjK/u0sIiy5W9X7A0e8T3IUs6FQkRcIupofouW4A7zfFln49pBey/DiAfJa7lsOQFi5N
         MrFlRYHKn37e3unnsjjbNps+xEgl0pB33YSCw5TtRggq8Rj6GCRTjAaRaYwf5lB9+m4C
         Ul4DvWRYj+OoUkKr+zPaeL1kdBbGaSUS7apgQDN0lDmlaopu80U7h10FWV/zlA3DBKUT
         wnew==
X-Gm-Message-State: APjAAAUycpOn1XjNrKHWWOPl/cSDjXuIpXHbO0IprP7Ln/IH0jO7T8O9
        Jf4lbZl3B7iyL9f0yOaz/q/UerhYIM0=
X-Google-Smtp-Source: APXvYqz/77uAvbDFxP8E/deYuR68tDru3DVawV19plhpicmeO9etnayOqLvyl7nL1AnjQfDUTaYmxg==
X-Received: by 2002:a1c:6209:: with SMTP id w9mr6674232wmb.183.1581616804754;
        Thu, 13 Feb 2020 10:00:04 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11sm3630089wrv.96.2020.02.13.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:00:04 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 0/2] watchdog: Provide user control over WDOG_STOP_ON_REBOOT
Date:   Thu, 13 Feb 2020 17:59:56 +0000
Message-Id: <20200213175958.105914-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add WDIOS_RUN_ON_REBOOT and WDIOS_STOP_ON_REBOOT to control the
watchdog's behavior over reboot.

Changes since RFC:
o rebase over v5.6
o fixed return code for ioctl()

I've sent RFC a while ago and it probably was very late in release
cycle to catch any attention:
https://lkml.kernel.org/r/20200121162145.166334-1-dima@arista.com

While waiting for rc1, I've changed my mind that it's RFC material and
sending it as PATCHv1 instead.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org

Dmitry Safonov (2):
  watchdog: Check WDOG_STOP_ON_REBOOT in reboot notifier
  watchdog/uapi: Add WDIOS_{RUN,STOP}_ON_REBOOT

 drivers/watchdog/watchdog_core.c | 27 +++++++++++++--------------
 drivers/watchdog/watchdog_dev.c  | 12 ++++++++++++
 include/linux/watchdog.h         |  6 ++++++
 include/uapi/linux/watchdog.h    |  3 ++-
 4 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.25.0

