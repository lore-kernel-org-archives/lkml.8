Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58703C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCD420774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KD96iiW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgHKHQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46444 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbgHKHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597130166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xrv8XZP8H/ArYsyMct/psi+RXUwQ58EUZbmfZHuJsQY=;
        b=KD96iiW7TtRROg+YmLBdRODQG95b0wcP5+/5o2baJfGFS03jNPcVvGGHmrjRiTBmEY5ODJ
        94AOeeQOi0kE5C5keAybIAtcrrrEYcpmg/IJJu4teGhjUEpIxkGYM9zhfF737J525o1mq0
        bquuBFpKhLF6z7Yn7deXU4VAvHHncUA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-ZEhZZmvZN_OMSlu-RaTilA-1; Tue, 11 Aug 2020 03:16:04 -0400
X-MC-Unique: ZEhZZmvZN_OMSlu-RaTilA-1
Received: by mail-pf1-f200.google.com with SMTP id t11so9774566pfq.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xrv8XZP8H/ArYsyMct/psi+RXUwQ58EUZbmfZHuJsQY=;
        b=RX+AH/IfII+c5T88Fi7Sg8LHOh8pifMfypRsaiBfE3hbbJj/GsThfjR3IccsXWpAqE
         5UTmzFy1RmK2SlhGrg0HzY5A7Zvj4UCygyHKTJzMLzFFPECjFVyUOqhjqS1q7U2HqqVy
         4RSRYCPAmE3BkkYDFIsGlIEnX/5AHw+nWcrAqCvzxLcfz/J+Ot38MCQo84wxi0DzuvQA
         Ha6KJY8Bjr+6wrpVdUMPR3T2ABaafo5/mYhOmIlQYSWGnrW19FtayVFJna9uYi4rp41V
         k5C4Qf9m4Uz1lJteHPGlX9G7iz3eofKOU53l8iyAEfqN/DDU6OhFxXcc9BBkpgk9DiI4
         JrOQ==
X-Gm-Message-State: AOAM530BHuaRRJ8p/8+f3EXiDg8vu7lR2+C1+DO1j5dMtC+zZMHPNWTh
        kKLU0rCJcsntviZW4kKJdE/UcXItStT9R/iQlA5g+J9Rmn3bRz99yr8VJCo1+isyXt6QvK118QD
        vqwd/9d6KqE96OhWEY9NEbLQj
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr4736671pfd.181.1597130163789;
        Tue, 11 Aug 2020 00:16:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf1G31CFvGYO57m79ydCITVqNOalSz5r3SbZByWQFEL0s50DMTAQKFGbGKQ3vkFoGu7rqr6g==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr4736653pfd.181.1597130163573;
        Tue, 11 Aug 2020 00:16:03 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n13sm1685916pjb.20.2020.08.11.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 00:16:03 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:15:52 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change virtual mapping way for
 compression pages
Message-ID: <20200811071552.GA8365@xiangao.remote.csb>
References: <20200811033753.783276-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811033753.783276-1-daeho43@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> By profiling f2fs compression works, I've found vmap() callings are
> bottlenecks of f2fs decompression path. Changing these with
> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
> 
> [Verification]
> dd if=/dev/zero of=dummy bs=1m count=1000
> echo 3 > /proc/sys/vm/drop_caches
> dd if=dummy of=/dev/zero bs=512k
> 
> - w/o compression -
> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
> 
> - before patch -
> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> 
> - after patch -
> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s

Indeed, vmap() approach has some impact on the whole
workflow. But I don't think the gap is such significant,
maybe it relates to unlocked cpufreq (and big little
core difference if it's on some arm64 board).

