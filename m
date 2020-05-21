Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B842C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4414D204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSYO1VsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgEUPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgEUPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:25:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:25:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so2804034wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2MXyaLaRSsQuWfENm44vgzHPCRJEfAycGFg99F3pJNE=;
        b=NSYO1VsH0H9XChSAQaVX3buJRwQSaTVgYvkXKquy5bb58jeMhiDO8o9Vb1hNjuMReQ
         34pq6vsyfjJ7q06KKD9NXVyzSTQyylndX2Bxz7X588Ts5kDVhqvnkpmxfMFbXiGFs+f1
         Jvomx8250fZzdQUWEVUIneimMB6Q10PP7at+8z4C4gl8nMckYYWQvDX6EL7ZA3Ae84RH
         2xsPioCypRu6NiB/8sxmNv4alwgRZTi3ErxW9TGcouSP6AqWT/FUvkMqhvtSS2eKNAad
         K1lYYjYpAHR8sZowk/cgfbRvmu3hgE0TH2QuWMwNsV3OoBc4UKSFN/jE0LafaWiPUOdt
         XFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2MXyaLaRSsQuWfENm44vgzHPCRJEfAycGFg99F3pJNE=;
        b=Z03i39+a8Pr8jco8d0/Du5XeOSmRJby2GnMYYtbky2CW154a2rM817crwyMiQBy1xs
         tltJV5NmCqedSqQgNWUEs/X2f7iPG97bfGb1Eg90j+Te7+e2B0R92u2IoUm3dwec74ds
         Ea/Rt+E/f/qpQUyPCXrvLudP1Or4o8NAWIkV2OVZ/a2DBRZ1zLP5KNo2i6mo8klMh4EM
         nO6CoWcYwAny6w3PVeW/KtQV0Ec6LPgFJWgWGqkaAbDSARwf1+8/q2dHeO/stTDTCyvB
         S2TmVWTFPCHxfJ99qLtant3poVquOKv+nHDU2l+W3MQN06jt7r6lg8v7tjQZCXtoapNi
         eJPw==
X-Gm-Message-State: AOAM5300dW5b7DHmx0jmKuhAKyZLT37WBwWwQJjQZXYvwZ+kOOYipoEk
        g0ZabJN1/dxOWDP++p82fgU=
X-Google-Smtp-Source: ABdhPJxe9BzZH/D/cLQ09xDSH5xKJ+llBaRqNMkRN6aTJKiFQ94C3mMj6q6CsEJV6czohYKvf4PqtQ==
X-Received: by 2002:adf:82b6:: with SMTP id 51mr8946931wrc.102.1590074716021;
        Thu, 21 May 2020 08:25:16 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id q9sm6637831wmb.34.2020.05.21.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:25:14 -0700 (PDT)
Date:   Thu, 21 May 2020 17:25:14 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ajd@linux.ibm.com, mpe@ellerman.id.au,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] relay: handle alloc_percpu returning NULL in
 relay_open
Message-ID: <20200521152514.GA2868125@eldamar.local>
References: <20191219121256.26480-1-dja@axtens.net>
 <alpine.DEB.2.21.1912201100400.68407@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912201100400.68407@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 11:00:56AM -0800, David Rientjes wrote:
> On Thu, 19 Dec 2019, Daniel Axtens wrote:
> 
> > alloc_percpu() may return NULL, which means chan->buf may be set to
> > NULL. In that case, when we do *per_cpu_ptr(chan->buf, ...), we
> > dereference an invalid pointer:
> > 
> > BUG: Unable to handle kernel data access at 0x7dae0000
> > Faulting instruction address: 0xc0000000003f3fec
> > ...
> > NIP [c0000000003f3fec] relay_open+0x29c/0x600
> > LR [c0000000003f3fc0] relay_open+0x270/0x600
> > Call Trace:
> > [c000000054353a70] [c0000000003f3fb4] relay_open+0x264/0x600 (unreliable)
> > [c000000054353b00] [c000000000451764] __blk_trace_setup+0x254/0x600
> > [c000000054353bb0] [c000000000451b78] blk_trace_setup+0x68/0xa0
> > [c000000054353c10] [c0000000010da77c] sg_ioctl+0x7bc/0x2e80
> > [c000000054353cd0] [c000000000758cbc] do_vfs_ioctl+0x13c/0x1300
> > [c000000054353d90] [c000000000759f14] ksys_ioctl+0x94/0x130
> > [c000000054353de0] [c000000000759ff8] sys_ioctl+0x48/0xb0
> > [c000000054353e20] [c00000000000bcd0] system_call+0x5c/0x68
> > 
> > Check if alloc_percpu returns NULL.
> > 
> > This was found by syzkaller both on x86 and powerpc, and the reproducer
> > it found on powerpc is capable of hitting the issue as an unprivileged
> > user.
> > 
> > Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
> > Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
> > Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
> > Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
> > Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
> > Cc: Akash Goel <akash.goel@intel.com>
> > Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
> > Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> > Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> > Cc: stable@vger.kernel.org # v4.10+
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> Acked-by: David Rientjes <rientjes@google.com>

It looks this one was never applied (which relates to CVE-2019-19462,
as pointed by Guenter in 20191223163610.GA32267@roeck-us.net).

Whas this lost or are there any issues pending?

Regards,
Salvatore
