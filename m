Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FECC8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A272073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcCq3sCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD2EVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgD2EVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:21:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC6C03C1AC;
        Tue, 28 Apr 2020 21:21:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so820206wrq.2;
        Tue, 28 Apr 2020 21:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mCtLbL6Zr88D4dLaHGj83fov+fdvmqInAbjfmiya5zo=;
        b=KcCq3sClZpqJ+2xt78xBXZ2HjIAMNDO9niYhUn/bcXUsDen5XtDase8Ia/KrNMEauM
         s7/M9EiQBCHZmekYkS6aMFhwUA59/7+vV2Eu57BotW9DRWB/4dnvhDQ2FrnNlqj7wz4z
         n3X15y2VRcuo0NXNM044Q2+KSEl94m5XamGtRFzpzcq3XlfKBGxhAsJ+BUzSAtKMDQaz
         QHtM+sNfE0ggxsEaamQmf+YmMBCK9j9cbz2T0QxduqEGJXxG7xZwVbEU5L0edwPIF4sz
         CS1xhppM3/KnbXJxBemdcHj0Jv+B4TiXpCjPvIyJZzqYZStoOVsJ0BMG85Sr3NHOLpk7
         FTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mCtLbL6Zr88D4dLaHGj83fov+fdvmqInAbjfmiya5zo=;
        b=Hm2vtrDclal0pL99Bu9RUqtw6v22V4WmM4HLVr5pC9MIxeNRn9N7BA8ErZt070p5mH
         Glva7GNl/Am1dLtI7UBNTc4+I1Cd9uOwSymNmBTxxc88cN5Z5dYij4lsPrqX9EwgdgyP
         ZJ5pJps5NpQOHqpgVPYS4F/SqSpgzAC0uJC724nGrFs5pinVyr9NRcrXv6Yd5zaiGuiC
         Mj19l9hGPhQAo459QZIxrkftDg1lCgwrrzJ3QQYuy9xzcxONIN2hZbngWnjFGsK/YaTd
         3CFbQq2Vcf8GTdTYwVU9YJM4cGRCCTbm4JqkgwsSvd8d1BRnPWqcII9BI/JFC04zjwGi
         hm0w==
X-Gm-Message-State: AGi0PuZdO91er4T1drKUkfl7Kg00dQs+F6dv7bgT6N5JdFZACaJGAe0Q
        zgpRwzRIFr1FyRtVM4Dj6Sc=
X-Google-Smtp-Source: APiQypIsyheNKE+yUYPn7h7Lh02qj284R2B2KtXNfFSBoHmveI6gKwv0q4UjlWp33+buDZ1Wr5yXuA==
X-Received: by 2002:adf:f604:: with SMTP id t4mr37208925wrp.399.1588134101564;
        Tue, 28 Apr 2020 21:21:41 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d97:3d00:e147:2f5e:e04:2e01])
        by smtp.gmail.com with ESMTPSA id z1sm5958897wmf.15.2020.04.28.21.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 21:21:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: remove entry after hp100 driver removal
Date:   Wed, 29 Apr 2020 06:21:16 +0200
Message-Id: <20200429042116.29126-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a10079c66290 ("staging: remove hp100 driver") removed all files
from ./drivers/staging/hp/, but missed to adjust MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches F: drivers/staging/hp/hp100.*

So, drop HP100 Driver entry in MAINTAINERS now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Greg, here is a minor non-urgent patch for staging.

applies cleanly on v5.7-rc3, current master and next-20200428

 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26f281d9f32a..41e2b577488f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7746,11 +7746,6 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
 F:	drivers/platform/x86/tc1100-wmi.c
 
-HP100:	Driver for HP 10/100 Mbit/s Voice Grade Network Adapter Series
-M:	Jaroslav Kysela <perex@perex.cz>
-S:	Obsolete
-F:	drivers/staging/hp/hp100.*
-
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
 S:	Maintained
-- 
2.17.1

