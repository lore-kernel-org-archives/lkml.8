Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29474C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBCF20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMWtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:49:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35753 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:49:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id i10so7978749ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 15:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRuFWtkWuwr1fLeCDAALQlbW5AVE5mdsmWUm923k4q8=;
        b=ejHlbAchen2yZfhO6SClK7cVndRuXmzI9sgrt4kYTYus0aeQLuUyO92bLOnOiaiNv9
         XKqknPtltl3FsBSzlQNxKbCmK8O1zR7xiPv878Sl6QULWPNpuxjQ7/3/nl59hjq+hRsI
         R7UdSkxMtwOR12UeWA8sp8tksKkJPVhwyimlmU1mDbUtTVWsbnQpW70R/oDn9hSpwg3v
         kCEC551dWgm84B2fFDBQSbFfV8m6RqOn3XIeznTgq0s9BoNWvdIPwbHpxyqkhSs22bFH
         DbVnYOfSDjPE6jc6rnIb4RQSqgDJBs8x17oiTkb8+GRbiSpvyIDJLW01B8nyBmuRy7qt
         Lh8g==
X-Gm-Message-State: AOAM531I02+oP6IKpT7tXfo6H7Agm1ZsqqASmK9hwR6Wtk4HyTT4PaM5
        BTgZPRuEdoVKMZUThRhWJWE=
X-Google-Smtp-Source: ABdhPJx3I1oXFuJyHp1H99mgT8ya1lFbn5hsF3jqLcfTg4TI2hcnAqSBv7GcBsPjzql7PfCxh8bLFw==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr4925lji.67.1597358970302;
        Thu, 13 Aug 2020 15:49:30 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id v20sm1375718lji.64.2020.08.13.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 15:49:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: add sprintf() support to device_attr_show
Date:   Fri, 14 Aug 2020 01:49:07 +0300
Message-Id: <20200813224907.447354-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's safe to use sprintf() for simple cases in device_attr_show
type of functions. Add support for sprintf() in patch mode to
the device_attr_show.cocci script to print numbers and pointers.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Interesting enough that with this patch coccinelle starts to skip
patch generation in some cases. For example, it skips patch for
drivers/base/core.c This is an unexpected result for me.

 scripts/coccinelle/api/device_attr_show.cocci | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index d8ec4bb8ac41..1248b8c76cfe 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -30,15 +30,45 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
+constant str;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	<...
+(
+	return
+-		snprintf
++		sprintf
+			(buf,
+-			\(PAGE_SIZE\|PAGE_SIZE - 1\),
+			str);
+|
+	return
+-		snprintf
++		sprintf
+			(buf,
+-			\(PAGE_SIZE\|PAGE_SIZE - 1\),
+			\("%i"\|"%i\n"\|"%li"\|"%li\n"\|"%lli"\|"%lli\n"\|
+			  "%d"\|"%d\n"\|"%ld"\|"%ld\n"\|"%lld"\|"%lld\n"\|
+			  "%u"\|"%u\n"\|"%lu"\|"%lu\n"\|"%llu"\|"%llu\n"\|
+			  "%x"\|"%x\n"\|"%lx"\|"%lx\n"\|"%llx"\|"%llx\n"\|
+			  "%X"\|"%X\n"\|"%lX"\|"%lX\n"\|"%llX"\|"%llX\n"\|
+			  "0x%x"\|"0x%x\n"\|"0x%lx"\|"0x%lx\n"\|"0x%llx"\|"0x%llx\n"\|
+			  "0x%X"\|"0x%X\n"\|"0x%lX"\|"0x%lX\n"\|"0x%llX"\|"0x%llX\n"\|
+			  "%02x\n"\|"%03x\n"\|"%04x\n"\|"%08x\n"\|
+			  "%02X\n"\|"%03X\n"\|"%04X\n"\|"%08X\n"\|
+			  "0x%02x\n"\|"0x%03x\n"\|"0x%04x\n"\|"0x%08x\n"\|
+			  "0x%02X\n"\|"0x%03X\n"\|"0x%04X\n"\|"0x%08X\n"\|
+			  "%zd"\|"%zd\n"\|"%zu"\|"%zu\n"\|"%zx"\|"%zx\n"\|
+			  "%c"\|"%c\n"\|"%p"\|"%p\n"\|"%pU\n"\|"%pUl\n"\|"%hu\n"\),
+			...);
+|
 	return
 -		snprintf
 +		scnprintf
 			(...);
+)
 	...>
 }
 
-- 
2.26.2

