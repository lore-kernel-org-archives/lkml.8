Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B29C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E3C206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596788120;
	bh=J9duKWyeOyOKHNDJBkw8pd+V78yf4jhjxIjZeJvKBt4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=im+RKxcpz+m2Cyq/qmPRbyyVUCKFe3IArEU/amtBsBpJZskIxYeEYGCcnZym0/o+S
	 HznT9PJEkzhl5KDjA+mljnT/oPAd6F+Lbs56XN06E2gl56V+Zmwfu8ES9i0NsykbMQ
	 ieFs6/ZKH8dwcG8ZurApn1OIK0z3mRXem8Wr5uQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHGIPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgHGIPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:15:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDE922C9F;
        Fri,  7 Aug 2020 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596788115;
        bh=J9duKWyeOyOKHNDJBkw8pd+V78yf4jhjxIjZeJvKBt4=;
        h=From:To:Cc:Subject:Date:From;
        b=Q+QzuV7/5Ij7fyqFskHquCB1Ck1X2QM2I4FMZY5t94HMoXV+3ODlsNKIpm0maa/Xm
         7iE6rftAqSOJKu9gVlitJXGkLbbBpFmDDWhBhFUHvAzBl5JhWP9QIT1F4dzoFAjszN
         8xCHGwPbPEFpPDaHPS3UxJNoSDfqn++eSuwVMjyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.138
Date:   Fri,  7 Aug 2020 10:15:25 +0200
Message-Id: <159678812524753@kroah.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.138 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                      |    2 -
 arch/arm/include/asm/percpu.h |    2 +
 drivers/char/random.c         |    1 
 fs/ext4/inode.c               |    5 ++
 include/linux/prandom.h       |   78 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/random.h        |   63 ++-------------------------------
 kernel/time/timer.c           |    8 ++++
 lib/random32.c                |    2 -
 8 files changed, 100 insertions(+), 61 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.19.138

Grygorii Strashko (1):
      ARM: percpu.h: fix build error

Jiang Ying (1):
      ext4: fix direct I/O read error

Linus Torvalds (2):
      random32: remove net_rand_state from the latent entropy gcc plugin
      random32: move the pseudo-random 32-bit definitions to prandom.h

Willy Tarreau (2):
      random32: update the net random state on interrupt and activity
      random: fix circular include dependency on arm64 after addition of percpu.h

