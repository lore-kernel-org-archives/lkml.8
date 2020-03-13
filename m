Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3594C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE992074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Vs5qpx/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCMVQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:16:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42432 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:16:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so13875682wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RybIaAfwi42rMEkdDuMaPC6Ik8KsuIdgCBAZyLZRGtI=;
        b=Vs5qpx/x/9mxLreknEJDK/qKbsOrTJnfTgQMWs2P519evhcjsoxm6sZfYuVJpipmUA
         4AerZDGhlbpAhGYH6xqVpGrh4FHUIzbYKo6GAcPVF3HqSo2cLUmgWtn9z+RcKOhtabYn
         a93iwjsQXRR7ABmZs/2E/86fNrgPA2Wb+ptqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RybIaAfwi42rMEkdDuMaPC6Ik8KsuIdgCBAZyLZRGtI=;
        b=N1cZLCYqZYekiAfh28xpMk4qeJVq4Ei7RGWqg5qnaAqJYTrorB0lLxbXuwDsDnRIYo
         8dx7Z8FGgOFy+WCWkhqpkb4lZ92LkMoIlNR7+6jUQstWZ2sJHMha9cfHRaKfRh+JuQqw
         I8/HKjIn0w+tNBubWtI8hpi1qa6p7IAzer8qWhfPzgS7Oglg7VzyYjbYgErteYCSbHA0
         XXkjxcgAH6vSP6fB4Eze/4OkW+GURUQrMiUOMnxMepr+VPX6rLNaAvkfCYq/XadTAfKm
         z3ACLMiAKtp9yyNYLWjUlIbBeOyYn2Xwy5/nP73hGOwLP/ltTaeeyXTfdrnoMo+I6hJh
         LbcQ==
X-Gm-Message-State: ANhLgQ12o7xEojpSkdbIOsupcEeuEXhzz/1XkEIEB6OswLYKwwC6lbz6
        BGP4FhWiIPLPu0UnaE2dN5wPIoNFd1A=
X-Google-Smtp-Source: ADFU+vugL6WKsIhIgeibrHLUO8PqfqQCSSG+PKiEL3An3Gd+kXB7lBjGshynRzcAs7uiEYsYIm0+nw==
X-Received: by 2002:adf:f285:: with SMTP id k5mr5319352wro.175.1584134187646;
        Fri, 13 Mar 2020 14:16:27 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id f17sm73907565wrj.28.2020.03.13.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:16:27 -0700 (PDT)
Date:   Fri, 13 Mar 2020 22:16:24 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.6-rc6
Message-ID: <20200313211624.GC28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.6-rc6

Fix three bugs introduced in this cycle.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix lock in ovl_llseek()
      ovl: fix some xino configurations

Miklos Szeredi (1):
      ovl: fix lockdep warning for async write

---
 fs/overlayfs/Kconfig     | 1 +
 fs/overlayfs/file.c      | 6 ++++++
 fs/overlayfs/overlayfs.h | 7 ++++++-
 fs/overlayfs/super.c     | 9 ++++++++-
 fs/overlayfs/util.c      | 4 ++--
 5 files changed, 23 insertions(+), 4 deletions(-)
