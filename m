Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362FC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E03C2469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTMZk0eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgARR0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:26:47 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41843 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgARR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:26:46 -0500
Received: by mail-yb1-f193.google.com with SMTP id z15so7713148ybm.8;
        Sat, 18 Jan 2020 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGtnMvLqd8KblLQCSjj62pBTLLOlWRPKgUYjU1Mw5vg=;
        b=eTMZk0eLA7ad0kMZZgW2TO2XNH0R2yUpWaIDS41ax/gi1mPVxxXKID9V19S6QGSKpu
         sA+un82VhzvE0dN6I9LH9fgpslECLQyM4+WO8IS6rOnoTo8/fPtBpPCpfoqF4Pw06aPU
         lSeQjGYqPI0n5emg+lPlJeAmW1qVgcn2g4j3/YV8uWG/uBaEnbQqq3GITUDjNHqHANqE
         9m7ExnZGqO0MFunXr2Wwg3tKQvL33eaEuiH1QHKKi3AFW5ryyglw2vCP/2p7HK3dM8H4
         C/SF37CPvbrYgSPyNMPDE9IIok4tWj6j5r4wKnDyJ5br/2cU97eCmaEOt907yPTaHMTl
         iyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qGtnMvLqd8KblLQCSjj62pBTLLOlWRPKgUYjU1Mw5vg=;
        b=T4Vo+7NW92O5kdH9Kk1wmu8N+Gm48ot09hfIp0OWGCp8ua4V4IXOYQtkCsEx8r7ZbF
         WXmxD2E6TAgXpSRrpQcRy800MZH1COCoda0BWtZwPNalyTDcAUegvC87ccGIL5XF7OtE
         3TbWKF18nAdb2u3o33dXw+nWr4MYC+nciQ8ZlQB+/6JtTqAL6XyXVsvQYzJd4bMErA6Z
         xpatN8AsyuPlGd3rQRMzofXyPqkB09O77Y5U8NIvhWVjVeLvC/M3fSUHwBuso0sZwk2F
         mNTMROYefnR+PkwCI9Sm2pbVv2IaHC5z/H7oyjnRvyLSv9p0d8lLJJcVgaKZQHsjdSOT
         p9NQ==
X-Gm-Message-State: APjAAAUBjMRAFhaKpGGMZpzOpS3CsLXFLy/eGKlxUCk5tLPXBdnD2tHI
        78naDQBrdh0y3fzZjqQmuedyxQY5
X-Google-Smtp-Source: APXvYqxqu8em7XQ3a1uqmR+KmCMgN4lABhvpUXFM1nzhARFJhPIpJtoJYK/stroUvFDAaTJmkIaiMw==
X-Received: by 2002:a25:9381:: with SMTP id a1mr32840741ybm.88.1579368405384;
        Sat, 18 Jan 2020 09:26:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a202sm11559448ywe.8.2020.01.18.09.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 09:26:45 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/5] hwmon: (k10temp) Don't show temperature limits on Ryzen (Zen) CPUs
Date:   Sat, 18 Jan 2020 09:26:15 -0800
Message-Id: <20200118172615.26329-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
References: <20200118172615.26329-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum Tdie or Tctl is not published for Ryzen CPUs. What is
known, however, is that the traditional value of 70 degrees C is no
longer correct. Displaying it is meaningless, confusing, and wrong.
Stop doing it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch.

 drivers/hwmon/k10temp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index a4313b662a3a..cdfebe435003 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -347,7 +347,7 @@ static umode_t k10temp_is_visible(const void *_data,
 			}
 			break;
 		case hwmon_temp_max:
-			if (channel)
+			if (channel || data->show_tdie)
 				return 0;
 			break;
 		case hwmon_temp_crit:
-- 
2.17.1

