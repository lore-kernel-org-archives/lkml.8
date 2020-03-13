Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72356C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4038E2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EApjgvHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCMVW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:22:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:22:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so13859653wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u/As81EyZrntuNgJKlbKQgyjl02SHiQYq3mu31UtGaM=;
        b=EApjgvHkraPqTujXYIeIs7uddFGQHVktFG9/9WMHetJkGfd65z0Ej4D33C8XwxQm7i
         oEcauFIN3G42Iq/jdr3vgB9ZGYdBjIHfxzuB1uU49LwZfu2lZSVmFXrnuJQJEREAJsDN
         WLjuWjTw9XocO9tfm/LqsWCWBaOWTG+4uHS70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u/As81EyZrntuNgJKlbKQgyjl02SHiQYq3mu31UtGaM=;
        b=OdmInvdKfo6N+9tFzmL+Il/9tg7jVnHuKU/iFKDHR4ReOrzbJjk/SM7sz0rGYeKl/E
         YUs9jqBwVXzD8/wULEvqUzla91GVhOvxn7P/Xol3X6/Yuq51TbTVxqv0dRf0kasWW7bJ
         vRSPLVx937MQdAhZD4e3H+OudEow0bvUEgo/NoDUKM36xtxaV1ySxlPpBAso+BYoVYzR
         h+VK86wZgxIHCL0rXg963EpLGkedUiD+0TR2FPyJPqAmdXGQ85QiPqyrW2wPRjRwpGsW
         tVYphByJ/Zcnlw2VWTrupggmHgWkY0x9o7mPVc2IwtHZln34hF2xeucNpoSBzSVXo2gt
         vEGg==
X-Gm-Message-State: ANhLgQ2Ryvn/S4Bss45Ww1hdJxHOKNfj/JBNO9iPftbvBZUjNNKR9glH
        /vID3KSLAo5u3cvAJ/qv0VmhG3zLf4w=
X-Google-Smtp-Source: ADFU+vs2LTPEPBmNY4UbQfY1yiOeCJumZuSexjeMELStR2bv6c3DS8UBgz737MqbwVjhuEF0q568cg==
X-Received: by 2002:adf:f289:: with SMTP id k9mr13459520wro.220.1584134545757;
        Fri, 13 Mar 2020 14:22:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id q13sm30222861wrs.91.2020.03.13.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:22:25 -0700 (PDT)
Date:   Fri, 13 Mar 2020 22:22:22 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.6-rc6
Message-ID: <20200313212222.GD28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc6

Fix an Oops introduced in v5.4.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: fix stack use after return

---
 fs/fuse/dev.c    | 6 +++---
 fs/fuse/fuse_i.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)
