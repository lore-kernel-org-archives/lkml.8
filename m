Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03AB2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591027901;
	bh=i8rLEHODDpX2hGyWbm18htA6Oxfm2IJm4d0yFE34T3A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=er0g0z8H4pl7C9lCAV3kIkd+Y9rjSnUbqqmAC7x1WGv+D7BOB5J1Tyn7o8rCp7hsJ
	 iyNEEO0Y8anV/NZpuu2EM0YpsPZl+3NYjwsp9kjHacmnqXaBamjZM41EZGKIi3CNwK
	 pztS3vOapuCYF2DJbT4OZxIAklPLpZmkVba6c56k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFAQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:11:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:11:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so377822wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8qFaK64hS4g5rfY9YQT58tu0XfC0Zg7+zirXKgXBnb8=;
        b=RrEZFQhmVC8D5+e5JqdY8f5jsxyZ5lXdWcljjKFagxqxHkhkuzsyxEFrg+WZ2ndxwE
         zBrHWYiTyKbg3aeEnuYCBNnyhItOeFk7wtBzIY3N7+LpDNkT1UdSOBfh+mjR3D83P2vC
         ZpNJXeQShXdWvtdhdriP/7QJLIy6ooD5Eh8+PkJSXb6ft/UeZZPw5+I2VkighGjZuNrG
         0E+fvBcsebbQFamq0arIYDR/hQcaQyy2wJ8nAN8JTl40opkEl2lvQwKPSybZ1GzjTpq/
         MKvQQyIHmvKGkiABJayuRYsBxcgYcHgXUfWNdwpxhEUaMYlS/hDdnbfYbLJ2tsNGCIL+
         6R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=8qFaK64hS4g5rfY9YQT58tu0XfC0Zg7+zirXKgXBnb8=;
        b=LA16Mn353xX5ILVVWjgm8Dxxq83Pv1MQ1SibWAhg6KDVC002WHMHerblaJPc/ukvRs
         8hMoa+Xb4MplQVdpJ7kYSnGBAfNWDhxRgaJ9cWu1OY9vGUYnrqkBXDgU3GlMQfjcfzeC
         +QrY9+qSp00QtTRcQWYbltqjNoNV+dHqIsVGMS2h63B6DECmAlBVU0jx/zbnXL53AVNh
         eXaBnK0PrtB1XJD7ui9E4R6XhzcKqhF7yE3qi7RL64VL9xpesLiIXOBbidsrujk8gBTd
         LamUPcbKsbjXoRNbU2QQ/B8adae8l0cHAoQyvPvmTtQ1ciFZI11T9XNFBkCYOlql66AR
         Q7aQ==
X-Gm-Message-State: AOAM533uppm5KjauvoDr0P1D9bU4aHYIfecdwifuzzrGDHjIKlXqrCpm
        GXrakS2l/FMVY3Ce9ARUWU/1Ne/B
X-Google-Smtp-Source: ABdhPJxfNNH9691bg9R+YIukIlfP74Gwlj2gZLNYtgoZ5iv4xWeUPfMWYXOFPwZqnQpSdmhwnMnOEQ==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr23225273wrx.148.1591027898958;
        Mon, 01 Jun 2020 09:11:38 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z9sm15608wmi.41.2020.06.01.09.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:11:38 -0700 (PDT)
Date:   Mon, 1 Jun 2020 18:11:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] smp/core changes for v5.8
Message-ID: <20200601161136.GA1094087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest smp/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-06-01

   # HEAD: fb7fb84a0c4e8021ddecb157802d58241a3f1a40 cpu/hotplug: Remove __freeze_secondary_cpus()

Misc cleanups in the SMP hotplug and cross-call code.

 Thanks,

	Ingo

------------------>
Ethon Paul (1):
      cpu/hotplug: Fix a typo in comment "broadacasted"->"broadcasted"

Kaitao Cheng (1):
      smp: Use smp_call_func_t in on_each_cpu()

Qais Yousef (2):
      cpu/hotplug: Remove disable_nonboot_cpus()
      cpu/hotplug: Remove __freeze_secondary_cpus()


 Documentation/power/suspend-and-cpuhotplug.rst       |  6 +++---
 arch/x86/kernel/smpboot.c                            |  4 ++--
 arch/x86/power/cpu.c                                 |  2 +-
 include/linux/cpu.h                                  | 19 ++++---------------
 include/linux/smp.h                                  |  4 ++--
 kernel/cpu.c                                         | 20 ++++++++++----------
 kernel/smp.c                                         |  2 +-
 .../pm-graph/config/custom-timeline-functions.cfg    |  2 +-
 tools/power/pm-graph/sleepgraph.py                   |  2 +-
 9 files changed, 25 insertions(+), 36 deletions(-)
