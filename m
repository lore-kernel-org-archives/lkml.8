Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43FD206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOS+cGlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgDCNbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:31:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38511 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgDCNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:31:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so2695810plz.5;
        Fri, 03 Apr 2020 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:to:cc:subject:from:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5T4dr5Yj+Mhb55fdklnxhoPtZWRWoLnIoAzNL4iVzc=;
        b=YOS+cGlm77/Ojm1G7l/cgTl+O9eIf7FvOdio5AmN0XCQNvKAlcgfvAA8nPvEnxc60/
         UeEutpFvnmnXG+k29rtqTnWG5wKEeF3nsoh2YIN4w/zdDLmDz/pzID+bWlKrATeRO7Vs
         ORor44JDozSzkP6XSEBEV9XPa6Na0AzTRvvS1mKtrxZdgBEVYhVhT1E6mE5CXk58rX77
         vuceNkSa7MJiYMFrSLXmivaptAQP+unrQloq5ziJE4kzFvfuRxNcdSYbiWONymUpN6B0
         3/vEaKHhqNFIX1mg37gDSq7EP5OEuxqcpQzuxHN+fHrGr7sfeAUpoZTvfTOTvbPc+71p
         /xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:to:cc:subject:from:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5T4dr5Yj+Mhb55fdklnxhoPtZWRWoLnIoAzNL4iVzc=;
        b=kjMHNMi4FcAVjSh3pBRFs2JUJx/HNp3YhAxfWev7dOnwAAdkNXgqxTeMTjfG/O2buC
         vbMJEu1KB5AWRNQhPoLEpzyR3tuEJEIYp9yVF2fk0kmCHdqW7J4SylinwTi3jUrjwO+S
         Z0fY2wKUKeA4sfeZu8LkAKdi8iNmvISzXr57ClvwTjOxsLV/gsbH5STVMKJsITecrJtu
         xnOM6S2RIMAxyVvmj9sTvSteJMpeI0ZgTK0H1rCEswwyiJVUZXMov1Oh2d1BuktMONOe
         9S+OLtFiMVgjEPj6GSE8Jjj6dOSUG7XvTiHmNZif/u+MKDmu8kVSB5GWX2mm+5yqQEjP
         HN/g==
X-Gm-Message-State: AGi0PuY5JsDWB+3uyz1N7gzoVM1hegvrdo7CBXYNAHecBkNlVsWhsG3J
        oeICbgUhaApr6BDUmiPoS6aDXVejtOc=
X-Google-Smtp-Source: APiQypL9R84PWZWHAn0JmtowlAh8L8t7ApLHj3a0Vm48F2LFZDmxruE35v0ryZK/9TKxTRMYhRCS5g==
X-Received: by 2002:a17:90a:9417:: with SMTP id r23mr6544890pjo.192.1585920711341;
        Fri, 03 Apr 2020 06:31:51 -0700 (PDT)
Received: from localhost (i118-16-243-73.s42.a014.ap.plala.or.jp. [118.16.243.73])
        by smtp.gmail.com with ESMTPSA id 8sm5873017pfv.65.2020.04.03.06.31.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 06:31:50 -0700 (PDT)
Date:   Fri, 03 Apr 2020 22:31:47 +0900 (JST)
Message-Id: <20200403.223147.300007237674208339.konishi.ryusuke@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nilfs2: Logging style changes
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
In-Reply-To: <cover.1584894497.git.joe@perches.com>
References: <cover.1584894497.git.joe@perches.com>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 09:38:09 -0700, Joe Perches <joe@perches.com> wrote:
> Reduce object size and use more common kernel logging styles.
> 
> Joe Perches (2):
>   nilfs2: Convert __nilfs_msg to integrate the level and format
>   nilfs2: Use a more common logging style

Applied. Thank you.

Ryusuke Konishi

> 
>  fs/nilfs2/alloc.c     | 38 +++++++++----------
>  fs/nilfs2/btree.c     | 42 ++++++++++-----------
>  fs/nilfs2/cpfile.c    | 10 ++---
>  fs/nilfs2/dat.c       | 14 +++----
>  fs/nilfs2/direct.c    | 14 ++++---
>  fs/nilfs2/gcinode.c   |  2 +-
>  fs/nilfs2/ifile.c     |  4 +-
>  fs/nilfs2/inode.c     | 29 +++++++--------
>  fs/nilfs2/ioctl.c     | 37 +++++++++----------
>  fs/nilfs2/mdt.c       |  2 +-
>  fs/nilfs2/namei.c     |  6 +--
>  fs/nilfs2/nilfs.h     | 18 ++++++---
>  fs/nilfs2/page.c      | 11 +++---
>  fs/nilfs2/recovery.c  | 32 +++++++---------
>  fs/nilfs2/segbuf.c    |  2 +-
>  fs/nilfs2/segment.c   | 38 +++++++++----------
>  fs/nilfs2/sufile.c    | 29 +++++++--------
>  fs/nilfs2/super.c     | 73 +++++++++++++++++++------------------
>  fs/nilfs2/sysfs.c     | 29 +++++++--------
>  fs/nilfs2/the_nilfs.c | 85 ++++++++++++++++++++-----------------------
>  20 files changed, 254 insertions(+), 261 deletions(-)
> 
> -- 
> 2.24.0
> 
