Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E90DC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DE72176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtAbwH3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgBYIHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:07:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38551 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgBYIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:07:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so15202015edr.5;
        Tue, 25 Feb 2020 00:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hpxymrnMFLY6A9AjiKv5IjjdyYwWAfmtWtkwbGf9b7c=;
        b=LtAbwH3NCYO0hWAIqgRNZKiofeQ4oKb/QJbzNpSuP2noOsBHx/TBWPmdeiNrmL4I3O
         D57p+otGx35oQdxExJ4wHGkLurcdMy8rq0M4oxSCSlF+DYYJXWfeFzK0+QoIN+geQi6g
         L27sIFmSQjWxZiAezZxWpOJ+b3o06ajFUIrEieVsw9IBTV3fHUdQQDIQE+VVXULpo+EL
         DemhoGAjEuLXv1kMk20msEPMVL+YDL6ObdkNepzCgvIOcV+E/aFwDcZpMMjLa0XPI/ft
         op+3kVP0ALKp38eMJVFkotxxAR2SbGbcue+nll17Cu36osstHt0DFjVH8lbh6Zckv4T2
         +GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hpxymrnMFLY6A9AjiKv5IjjdyYwWAfmtWtkwbGf9b7c=;
        b=eI1wORLNT3zaLO8+XJfAP8jSP7BclYW1AUsZSaHaEJOCz/eS7OEqEt6nT0lf5DSwr3
         7LPquq5RrvxoVUt79IegX4PzSIcYkxiBAu9I7d3fkqbgh96h1wjY/SVHjy0WCULDfXHM
         N9Uh/epMmFvFBXggEpjtdIIgO53/d/44G+UkmXLxZVRxwzuOm+DDHHJ7GPfmefkVfajD
         1v2Z9G/BVnlorA7f0rToqJCMy//zRCasC1ppOx7o6B5SoWtkwbaSnhAl8pYWUGGY2drD
         Z0nnV+iDbwruaC+cfUy49Ag8N79XO+LZPXSuaa5IQrqr3MGHm69qi6KFiR/jfNjUYMlh
         Ihxw==
X-Gm-Message-State: APjAAAXRWgsytHgsfI5pKVf8iyuf/W2dFOJahL7xS2u/0CstFnKWE2OT
        Jev4zFPvBveJ6d1TILMdGvUScXgvuRg=
X-Google-Smtp-Source: APXvYqyz1rM9kGZ2yKQKtBdZegqxArEcIfrkYZ1vi8wcL7rT+x4CQ95yAutuOXs0cIHPPNLUbA1SEw==
X-Received: by 2002:aa7:df09:: with SMTP id c9mr50386890edy.133.1582618058417;
        Tue, 25 Feb 2020 00:07:38 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d75:fc00:5586:e036:dd7a:89bd])
        by smtp.gmail.com with ESMTPSA id u9sm1188510edt.91.2020.02.25.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:07:37 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify MMP SUPPORT after moving cputype.h
Date:   Tue, 25 Feb 2020 09:07:27 +0100
Message-Id: <20200225080727.5687-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
added a file entry that does not point to the intended file location.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: linux/soc/mmp/

Rectify the MAINTAINERS entry now.

Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lubomir, please pick this patch.
applies cleanly on current master and next-20200225

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcd79fc38928..ed62b3eba75c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11197,7 +11197,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
 S:	Odd Fixes
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
-F:	linux/soc/mmp/
+F:	include/linux/soc/mmp/
 
 MMP USB PHY DRIVERS
 R:	Lubomir Rintel <lkundrak@v3.sk>
-- 
2.17.1

