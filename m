Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10CFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6083B2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh59lmVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIJEu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJEuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:50:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:50:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so6709726ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QJSgFcvIQ5vDKUIqkMJ8sm4Fjp/NF/hAyXoZs+L4M+w=;
        b=Kh59lmVjbCoXzGkLrXhlAoSCWy5K3pwfkMlJ1o53lWOEJLtN4v4Y3TeYS0VFjU5Xg6
         qB/VEPEVDVV0JLJ8SmMT1EU/0wyxEMbhcBRB0tD400EbrLJf9q3K8te6YjhYOYeNNmqA
         /IArM+w2hvgICAPCROoZnzR+tGInT+YBKbgnc6npvWZ5eTvVTLwnKYLgxdvPnrqmTepg
         x76iAu9Jwk4vP1SoRcM7PZ5urx5a8KFzLd2zwvUKxtxXbQSTgfb2P6fbqQoel7yRE2iK
         hu88exli9bK4vrkgZ/ioRYwv3noLj0nUe5r5NO6PLNvuKKDAMp/ueuenLgrGOKFgoQp6
         aJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJSgFcvIQ5vDKUIqkMJ8sm4Fjp/NF/hAyXoZs+L4M+w=;
        b=RhI6NxXe+NohnJ1lRonxYUuLAS6PemR9Bd+dRpzNheKnVqeaCsr6YOQRxD5xhaWGra
         z4q5lCp+qixA9YYhbh4vw1IM9lVec2GYqy/mGNeB9za1HG9cv6kPqTO9upsbq+uZYKQf
         mgF4sodip+DRDVjUj4ICUygoiDDDVINSlBejY2/mcP56yynEt2vuxXIfATMQPtZoWyoT
         yzps5ZW96L8A56euiXgmVpXyPHDAuOQf+q3ksV7tkgs21rUDv/oFtPM2WXk8J7vNP+aX
         0fBxobWU1PoOCjD9c3eGEHkTTPYEF/Yl9b27gRSvdSj9gn+DrKqRd/zooIrzo5XdBvpi
         WrFA==
X-Gm-Message-State: AOAM530ctrQ/MJHqicLlgH39uTb4jtk9/PMgCS944TQpJxO0lwDY8A96
        oYtD332qu0zKUBZa3/yLOMQ=
X-Google-Smtp-Source: ABdhPJykGeUVnYO0c2CJ4fwkSltqKjM94+PRslqX30QQdRqDjjimfbvar2hB+EtZuikbqVRBYkm2ag==
X-Received: by 2002:a17:906:a101:: with SMTP id t1mr6751694ejy.203.1599713417617;
        Wed, 09 Sep 2020 21:50:17 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y21sm5115877eju.46.2020.09.09.21.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:50:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A93B227C0054;
        Thu, 10 Sep 2020 00:50:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 00:50:13 -0400
X-ME-Sender: <xms:g7BZX_UppKnBoXZXjaldleAKook404YB1olmoS9Knsk5YRwiwF7tiw>
    <xme:g7BZX3kXaiQXdRKUcY4NMhvAl5RC2Me1fB4J5CXjdxVK6aySCf7hxPL9lCtbVJntf
    A6jdGKPRkhsVt-E7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeeuteevieeghfegvdeluedtjeejfefhleefueetieeghfeggeetueeivefg
    ueffnecuffhomhgrihhnpegrphhpshhpohhtrdgtohhmpdhgohhordhglhenucfkphephe
    dvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:g7BZX7YML1sPq3Hmp70fbKN5F5Q5LzDVdoMaP56qXF_-N1RpSFYeUA>
    <xmx:g7BZX6VZH-nVGNFqeKfYW6oBOQiFd-R_6RGPkRs4-66eOqLSH0sUiw>
    <xmx:g7BZX5ktQ2NrajG0QOQoXMYjocy144y_G5jiOPfmwSRAwE62IizGyQ>
    <xmx:hbBZX89owGMrLktZXNQpup6RLJR3eoBZsEUZ6pC9-5zinMYjX0Kj248qR3Y>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id E63893068C6A;
        Thu, 10 Sep 2020 00:50:10 -0400 (EDT)
Date:   Thu, 10 Sep 2020 12:50:09 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     syzbot <syzbot+561a74f84100162990b2@syzkaller.appspotmail.com>
Cc:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        arnd@arndb.de, baolin.wang@linaro.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        paulhsia@chromium.org, perex@perex.cz, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de,
        will@kernel.org
Subject: Re: possible deadlock in _snd_pcm_stream_lock_irqsave
Message-ID: <20200910045009.GE7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <0000000000002cc32605aedd876d@google.com>
 <00000000000017994005aee4d82d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000017994005aee4d82d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting.

On Wed, Sep 09, 2020 at 10:33:04AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit e918188611f073063415f40fae568fa4d86d9044
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Fri Aug 7 07:42:20 2020 +0000
> 
>     locking: More accurate annotations for read_lock()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112dc243900000
> start commit:   dff9f829 Add linux-next specific files for 20200908
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=132dc243900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=152dc243900000

From what I see in the output, probably this is the new deadlock
possibility we find with lockdep, basically if we have:

	CPU 0:					CPU 1:
	read_lock(snd_card::ctl_file_rwlock);
						<irq disabled>
						spin_lock(snd_pcm_group::lock);
						read_lock(snd_card::ctl_file_rwlock);
	<interrupted by softirq>
	spin_lock(snd_pcm_group::lock);

, because the read_lock() on CPU 1 will be a fair read lock(IOW, not a
recursive reader). And if there is a third CPU is also waiting for the
write_lock(), CPU 1 cannot get the read_lock() due to the fairness:

	CPU 0:					CPU 1:					CPU 2:
	read_lock(snd_card::ctl_file_rwlock);
						<irq disabled>
						spin_lock(snd_pcm_group::lock);
											write_lock(snd_card::ctl_file_rwlock);
						read_lock(snd_card::ctl_file_rwlock); // fair read lock, can only get the lock if CPU 2 get its lock
	<interrupted by softirq>
	spin_lock(snd_pcm_group::lock);

That said, I'm still looking into the code to find whether there is a
lock combination of CPU 1. Given I'm not familiar with sound subsystem,
I will appreciate any help on finding the lock pattern on CPU 1 ;-)

Regards,
Boqun

> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
> dashboard link: https://syzkaller.appspot.com/bug?extid=561a74f84100162990b2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1209e245900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154b15ed900000
> 
> Reported-by: syzbot+561a74f84100162990b2@syzkaller.appspotmail.com
> Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
