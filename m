Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D8BC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A09722522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBPXNp3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgAUCau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 21:30:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35735 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:30:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so682302pfo.2;
        Mon, 20 Jan 2020 18:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15Ev+vhTYmEGrxqjsxkzwNHnzWlaEO3FV3/3cfAruV8=;
        b=eBPXNp3S203JS4dGarOV3mfwZ6vV2RF8OYLGYHZYIlw19Fkn3LZdHSfQo4gUqqb0Uj
         TDkkhge6Cd5/mSOw/p23s0c7ZCzp9PYOJm5/OiO0yUGwmttr5X0VRRC6Z2KboyXj9QX7
         wUnBQruiZT03frAsBZtfpJf5wN2qnyVapXXBa0MlRWAzrJ8OFEyg9Q7oUyNsA5zO6TxM
         U5R9zrE3Av34TzLgUIgPliezWPVg1yPOBvEHvx+WeF19WrnNM7U9Ea1coQ6u2MIDbpE/
         nKcHhGi5z/K7lS725x5NfAizb8hgS9geLKrsCV/OhYMKM1Z5pwZJMgGWQt3ajA6LTQTA
         QqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=15Ev+vhTYmEGrxqjsxkzwNHnzWlaEO3FV3/3cfAruV8=;
        b=EQqWlhRfcr5JstVyEuliFM4++yME22B1LPUcxMQ6EwCUlO7RpYXZEprPhefzuw/vcv
         YZTJEO7994xQp3Z0dwdw7d0DwWl3AMQD+TM05p1cdzgMgKc0ynOHrMahWPwuEwfLUzk9
         1ifffgcdMLStfN8lh+dPUesooBP0tpli3a+Yp2snH28GX7PgOJOppbam2Zu5vx0z+eaW
         J/NmNgo5mEgPkM2O6fiGis/N0exwvkmPYFSaxlqDFssN0sc58dPiRJBTN4idfgzC8LvQ
         WsBdaVuLY18cm7LdXLmCTksI0ZuhKL9PiEzMH2m977+YJCx+1hIOP4Tf1+uRMzdju1iJ
         yaBA==
X-Gm-Message-State: APjAAAV4FWVPVUg6FET5R+BEluPGbG22/mSgEU9K9HwiN+PFcBhTtQLj
        AQxgpXmHP/gCSsOgOR0SPIJtfbjr
X-Google-Smtp-Source: APXvYqzvaq+qKUe1377GVvmrk9hGDVCMRXbBlCMFtDcES3exf/pfY7RNXElmdI3YrvQmLgTWpQIa9g==
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr2855098pgd.231.1579573845746;
        Mon, 20 Jan 2020 18:30:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e1sm41055426pfl.98.2020.01.20.18.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 18:30:45 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 5/5] hwmon: (k10temp) Don't show temperature limits on Ryzen (Zen) CPUs
Date:   Mon, 20 Jan 2020 18:30:27 -0800
Message-Id: <20200121023027.2081-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121023027.2081-1-linux@roeck-us.net>
References: <20200121023027.2081-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum Tdie or Tctl is not published for Ryzen CPUs. What is
known, however, is that the traditional value of 70 degrees C is no
longer correct. Displaying it is meaningless, confusing, and wrong.
Stop doing it.

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Michael Larabel <michael@phoronix.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Ken Moffat <zarniwhoop73@googlemail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 9e8b1c1bcbbd..6076a84cb3ae 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -349,7 +349,7 @@ static umode_t k10temp_is_visible(const void *_data,
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

