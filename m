Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B355C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0620873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FlIJQpSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgBJOpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43216 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgBJOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so4014646pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuO2IkdkjwWHPvSG9VBskf/C4nOl3qfp8n5KLjT5Zaw=;
        b=FlIJQpSgRTYTssAIJhWpRf4Fl0HTO1/RO1yTUPom/MKZBpzDKwTWlZDqyFX0GY7ucd
         FTDVq9iAHeJGv9eVaWvlztf7JalRml4cu2z2KHSTm9sCG3OQDGRikl0PDB9mXjayItXR
         xkkYYzLKBmXVwgzxuYIb0ska/0xivx4iby7Qt2JEsoMSeanU7ZMdORGSWfTNX8sRN0ef
         Wez5ABmV3aYpk1g95WMxY9n11/G/E9ikvftUQ6O3DHJQdBnOmiSeet29SQTgUitEfqBX
         vOUdwod+OUuNG0ajlpfykmpDGDfngh4JpxV/b28xoK5iQl6jM4vj575QqRHDzWEDk9Ud
         oEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuO2IkdkjwWHPvSG9VBskf/C4nOl3qfp8n5KLjT5Zaw=;
        b=m4yojruZXVqHSwYQHag1LFIo3Nr4tvc5OvyJX8OrnNMMrp7M/kDmzLsiFyN5eLVxIi
         bKc0Rq+ci5NFt2llMMyPVdCW/b783/MFVOz/BJ0Z3YinE5iWu4/pOd83YiJoxOYG5q8c
         ccmAau+PRsSgKrl9ure4EwLElwgFR1ogL+GYKjCV52Eeovfe2KE0cd2Ogq1Fgj5eDxoC
         dSznqyewbrukRMBC/Rfk1VsI6IcyPIo8byk9UtkAYtPX2ppJRTHtkHfU3ItZKSJB8Fza
         5cPklYMjaXHhTXpfVNKkHTj+8zwXeZnAn8lnWSO5Zp/JbjkTgFR0jV7CvsCtQReIGTQ7
         uv4g==
X-Gm-Message-State: APjAAAUP2csUgA2YrRFO4vjcE+J4pxPgWl2Rn2zEJKfUrVM/UeEkKn8J
        aZWJ44Y5oz+T6yyY58ZM8oQUZI8KmXs=
X-Google-Smtp-Source: APXvYqyQxLhhhF/JUCZBHnZgjOdOafV+kZtzuIXlgvK3uYFGBh7qAW4UDrTh/B8IkXY/tW7qVjqXNQ==
X-Received: by 2002:a62:160a:: with SMTP id 10mr1544912pfw.7.1581345944824;
        Mon, 10 Feb 2020 06:45:44 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id dw10sm552079pjb.11.2020.02.10.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:44 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/4 v2] random: rng-seed source is utf-8
Date:   Mon, 10 Feb 2020 06:45:04 -0800
Message-Id: <20200210144512.180348-4-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200210144512.180348-1-salyzyn@android.com>
References: <20200207150809.19329-1-salyzyn@android.com> <202002070850.BD92BDCA@keescook> <20200207155828.GB122530@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 428826f5358c922dc378830a1717b682c0823160
("fdt: add support for rng-seed") makes the assumption that the data
in rng-seed is binary, when it is typically constructed of utf-8
characters which has a bitness of roughly 6 to give appropriate
credit due for the entropy.

Signed-off-by: MArk Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Kees Cook <keescook@chromium.org>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8b..ee21a6a584b15 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2306,7 +2306,7 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 void add_bootloader_randomness(const void *buf, unsigned int size)
 {
 	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
-		add_hwgenerator_randomness(buf, size, size * 8);
+		add_hwgenerator_randomness(buf, size, size * 6);
 	else
 		add_device_randomness(buf, size);
 }
-- 
2.25.0.341.g760bfbb309-goog

