Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6558C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B3C206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CXs8wayI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHCOMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgHCOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:11:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D5BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:11:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so14475910wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAnP6E5TPeMdf1SeFFPVmgwF97w2X2IThLR1O4ARXkc=;
        b=CXs8wayIt9gkwiEND6J4tnORfRlfqI4dBUO/SU872gahC4Q4k7r7xqgNDX3DmyeY6U
         XXNdebKUqyc/PObSAdx2U+RvTVU2VvDDBYxb6g+gotbon53TQBPj7Dr/N8jE94OOF9zd
         VS7FBulmM5S8s6FeqX/9x3wG82TCUOcfYiAqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAnP6E5TPeMdf1SeFFPVmgwF97w2X2IThLR1O4ARXkc=;
        b=PoWp+XoZ25CRoTYsi5mS6cVjycYocvkHwRZM/zIOJSOeGZ4gD+sopKTGlaKS+aH+AB
         nWKQlSnrCAFtzfTP5gUOKo4eKU7lyQmcLpHHk3paKV5H0S49PNVbxaga/C7EuXO0rTPT
         oBaz2EG565gspGvo69Vf5afNwQFLPr7MlgQhi7Yk9GmWYAJ499EAv2JqxlfTvuplLNkr
         kclVGS722K3YJAh3NTQ6LIrKpCDXKurZFnrWOP/XBbNfI4h4SmGwl/LynpKQ2HumJIDc
         nazcGJmHtyE9CM+u+J8V29SQS8FlNOzF55kZg3Z23+mmEwNYvsIZRqIxPC3lmi1kpr9d
         vdVg==
X-Gm-Message-State: AOAM531bM2y0+yhG505J1NaZ0EB/EnwdQomqnN/K6j24tyomrZI5ovm3
        IrrHMWjSXbQmwPEL+o/HOsLqz3seDOU=
X-Google-Smtp-Source: ABdhPJw8ovdXsMle2mqTETLoD1e1Q8sFNlfkx9e/fXxnzUHfWMx2Q/5woZYfJ03+EnQGocc0EknlCQ==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr227846wmm.90.1596463916859;
        Mon, 03 Aug 2020 07:11:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l18sm25376005wrm.52.2020.08.03.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:11:55 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg KH <greg@kroah.com>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] MAINTAINERS: enlist Greg formally for console stuff
Date:   Mon,  3 Aug 2020 16:11:42 +0200
Message-Id: <20200803141142.1606661-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did a few greps for main console data structures, and there's a few
places outside of drivers/video/console:
- a braille driver
- a sisusbvga driver
- fbcon, but I think that's fine if we leave that officially under
  fbdev maintainership
- lots of stuff in drivers/tty/vt, which is already under Greg's
  maintainership.

So I think this match gives reasonably useful Cc: lists for the files
and places I've tested.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg KH <greg@kroah.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab94723c0cae..8084d118892c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4343,6 +4343,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/connector/
 
+CONSOLE SUBSYSTEM
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+S:	Supported
+F:	drivers/video/console/
+F:	include/linux/console*
+
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
 M:	Li Zefan <lizefan@huawei.com>
-- 
2.27.0

