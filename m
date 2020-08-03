Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78477C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEBA206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9b/cfqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHCFoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHCFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:44:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D58C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 22:44:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so13187342wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PN5+rQdxipwRYGd0bZB78DCdMTDyfQAqtzm2D6N2q10=;
        b=N9b/cfqL8A1i0wJFuvAz+gETz9VTgcesPoZ9MfuH3E9QYFRwg7BF319dNgKzl3XkI0
         t1CxZv830tU9A0hrsddAIYwW22Q0L7mTGXuOVYLiUx4ecdK3dJLZW5LEeHzC+zRrUBrT
         yLjvHZVmkMvACHR5stG12UDIa0pLxPqYQKYtUaDAuIy21DV1FBI6dSwohE3jlbTr9YJ/
         Tesa0UbDIJJmcGyBwz1I4G2hLbkG8+xH6KMPlMcJNLtj0PDvcriJCwGs/9AdiW17AaHl
         FezVvP0zvC1DkRCAWg78m100qEceqLiZyqUlKuETJNx6qzFoYH7Hzz9+RePW9WNik0gi
         yTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PN5+rQdxipwRYGd0bZB78DCdMTDyfQAqtzm2D6N2q10=;
        b=INGWveqj1cSLZ2XS+CmCPK2M5f2hap6rXbow+/MyQ6uOZAsqGh5L5N4UpMf+DemYLZ
         ceHa/UV3Hbiww67fl15wuqGYjtepHAvojTjSDsKjHg1D9ugR9QF4CsNqbPGRfGxKbn0s
         qoBgrBAkQ7RHCt3ZoCnG0Fuu4dFMoOWP7R5aM66NyxHrI9WBYSX01oR/JuhRXSiduc5V
         toP7imX0iPjO45SSCsfhN4vnI0uQHajZCw4Um7xsvofj9KWzagqzwJI8dNF5ruei17tL
         OGfL10Z1wg1VcRH6zq7Y7gznKIlnMRUrFz2esbfHcuv4PiuM1gGp3EXL0VuGgzquBg8q
         bc2w==
X-Gm-Message-State: AOAM533yolqU6b+GIbRzvH3QTQSiAhUuryZKq8H49WFlSDWdKtz8felM
        7Xed2kdhb4MQMzeB+wf+40lZa+T9
X-Google-Smtp-Source: ABdhPJzbVJypvn2iB5oR66uKNh1Hsbkxu7RPg/X9GPJ4AYYY+dVQyTrdIMCJJoDLFUvnz29++bsn6Q==
X-Received: by 2002:a1c:286:: with SMTP id 128mr13486150wmc.37.1596433452358;
        Sun, 02 Aug 2020 22:44:12 -0700 (PDT)
Received: from basti.fritz.box (p200300d1ff010e00192801079fbed9c8.dip0.t-ipconnect.de. [2003:d1:ff01:e00:1928:107:9fbe:d9c8])
        by smtp.gmail.com with ESMTPSA id o4sm20870480wmc.13.2020.08.02.22.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 22:44:11 -0700 (PDT)
From:   Sebastian Fricke <sebastian.fricke.linux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sebastian.fricke.linux@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] include/linux/miscdevice.h - Fix typo/grammar
Date:   Mon,  3 Aug 2020 07:43:45 +0200
Message-Id: <20200803054346.4285-1-sebastian.fricke.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the clarity and grammar of descriptive comment on top of the
minor number assignments.

Fix a typo within 2 comments for macros.
s/This helps in eleminating of boilerplate code.
 /This helps to eliminate boilerplate code./

Signed-off-by: Sebastian Fricke <sebastian.fricke.linux@gmail.com>
---
 include/linux/miscdevice.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index c7a93002a3c1..0676f18093f9 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -7,9 +7,9 @@
 #include <linux/device.h>
 
 /*
- *	These allocations are managed by device@lanana.org. If you use an
- *	entry that is not in assigned your entry may well be moved and
- *	reassigned, or set dynamic if a fixed value is not justified.
+ *	These allocations are managed by device@lanana.org. If you need
+ *	an entry that is not assigned here, it can be moved and
+ *	reassigned or dynamically set if a fixed value is not justified.
  */
 
 #define PSMOUSE_MINOR		1
@@ -93,14 +93,14 @@ extern void misc_deregister(struct miscdevice *misc);
 
 /*
  * Helper macro for drivers that don't do anything special in the initcall.
- * This helps in eleminating of boilerplate code.
+ * This helps to eliminate boilerplate code.
  */
 #define builtin_misc_device(__misc_device) \
 	builtin_driver(__misc_device, misc_register)
 
 /*
  * Helper macro for drivers that don't do anything special in module init / exit
- * call. This helps in eleminating of boilerplate code.
+ * call. This helps to eliminate boilerplate code.
  */
 #define module_misc_device(__misc_device) \
 	module_driver(__misc_device, misc_register, misc_deregister)
-- 
2.20.1

