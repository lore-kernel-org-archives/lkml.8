Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0349C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B121835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtjmCRcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAVQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39528 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgAVQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so54347pfs.6;
        Wed, 22 Jan 2020 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2FX8hkBQRIVKzLF6fak6RVFFu8mh4YpGVmgXJ4QJ8+A=;
        b=BtjmCRcQGgLG13JNbyQcqvw1d7FncnhmmlfC7BrwLI9SgdarBtkD34Jd2dMzxApQBa
         Lu5NLN23Kvn0jUjppIXAGI+ziK8vPs8aUi2os3EzZXhqgYCwuUfdyUDmTy8Vmii/CNVa
         +y9QiGmYJzb9Bl1DZNxMQDmWQs9QgdCj2DSt2PCMZsDFJ9k1EbkoxQ1H9o+f0Pb0hiv1
         DskLBrXzVdwE9nZ9sdzknvyqKLZxvGPpfQQd2wWMkjS5Ye2HzsoY0nqsINgjnAWXshOh
         YXERG6SAaJjsN2fgt7+LJWkNAck0Ab7RyZiIXtW3J2csPXqTag7Ca3tOVlnwlzTFGtRM
         QSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2FX8hkBQRIVKzLF6fak6RVFFu8mh4YpGVmgXJ4QJ8+A=;
        b=oD1NIMSD6nP/83f0ErPnwS5cU4ZY2tXiyusDaRS4cU7krgeSk3yt2gZysiPyeLxDze
         q59t561ouxJWfdOBECIBNkJIlq2BG/dPFjaweHoZ9kL5PMoK6U7vzDhi41s6OXDhHMWp
         ao+5flrMh3z+yQBio7uxaOpCJ3ZmvfdtnPhoPhMXTOqnf2WYr8bxACmCalfRLk33CRjM
         kznEhsjqrv926pcJ8ApYNjsAWVwLoBr/nNw8RauPUeJ+8GWr9irj2Y72YVsuKCyakFn7
         OGhPRAaWPxZQxgi9Kwi+EYo7gXXq8miED8T4rt2cPx7qgh4agX8lg1EzdUkqJiKPwQha
         xqrg==
X-Gm-Message-State: APjAAAUWKIy185gDpeZ422iLVkFO/dvRwIjaSobTqEbHZl9jwwdx5Vjv
        CPbLDzGKLZpwJK3lq1hSaUtTdRoo
X-Google-Smtp-Source: APXvYqzubpsOibWHX6h3gEkcxRlpMdFDFfMz5ojFlsp+mQPhITeIB/+oTr4V7DEDALhO18xls1oGDg==
X-Received: by 2002:a63:63c3:: with SMTP id x186mr11883635pgb.294.1579709294552;
        Wed, 22 Jan 2020 08:08:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d4sm3869191pjg.19.2020.01.22.08.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:14 -0800 (PST)
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
Subject: [PATCH v4 5/6] hwmon: (k10temp) Don't show temperature limits on Ryzen (Zen) CPUs
Date:   Wed, 22 Jan 2020 08:07:59 -0800
Message-Id: <20200122160800.12560-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum Tdie or Tctl is not published for Ryzen CPUs. What is
known, however, is that the traditional value of 70 degrees C is no
longer correct. On top of that, the limit applies to Tctl, not to Tdie.
Displaying it in either context is meaningless, confusing, and wrong.
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
index b961e12c6f58..4a470b5195ee 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -355,7 +355,7 @@ static umode_t k10temp_is_visible(const void *_data,
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

