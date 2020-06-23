Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACBAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5843520772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895503;
	bh=T63QfVWsesHoyV6zzr5QVsOJTp+Vw2gQvjO+CWEzkSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OawXlRSa/KK5TjghEHjyPpVGwqLFoD5oS80Dc7iv1nrC29YHrZiRX1C8wGWLjfQvt
	 m0Ebe16jMUB/FrodC9/nRsIVf+AcUMzolwazzOEd6WLvKdr0HOdblCNypA4vxa07vz
	 0kVG1daz5ji4RDgEdkZ5DjDYiSy5JAnqun+/tAp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgFWG6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731144AbgFWG6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:58:14 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C6E20738;
        Tue, 23 Jun 2020 06:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895494;
        bh=T63QfVWsesHoyV6zzr5QVsOJTp+Vw2gQvjO+CWEzkSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d800Rz+ThU9u1DH+75qaJfAQfLve+SBAnIgTRiX8vB4KiGaxTWyzwCOGkDf7/OFag
         zpRKxF3jVXh2WNDeWjcTb7xtgdfahW/dYlVbu8rNK544W/oUxnx1cjRvX1jClYSgVy
         ILXXLBjD7//z2IXzAw63NFbPkhnoOajdxfxOjwTs=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 8/8] MAINTAINERS: remove "PKUNITY SOC DRIVERS" entry
Date:   Tue, 23 Jun 2020 09:57:44 +0300
Message-Id: <20200623065744.18393-9-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
References: <20200623065744.18393-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There no PkUnity drivers left, so remove the MAINTAINERS entry.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f347469e4891..d30a417ad90a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13580,12 +13580,6 @@ F:	drivers/block/pktcdvd.c
 F:	include/linux/pktcdvd.h
 F:	include/uapi/linux/pktcdvd.h
 
-PKUNITY SOC DRIVERS
-M:	Guan Xuetao <gxt@pku.edu.cn>
-S:	Maintained
-W:	http://mprc.pku.edu.cn/~guanxuetao/linux
-T:	git git://github.com/gxt/linux.git
-
 PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.26.2

