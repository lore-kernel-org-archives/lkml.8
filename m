Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24DE2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRekUtaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgEUMtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgEUMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:49:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B08C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:49:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q9so2981464pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ThicM2MINEcLmZzXQZhlZBSaO4KVfv3Uo4/fCOM5QbM=;
        b=nRekUtaW1++FK1DM8dhcPPdCGdgFZMRJQshCPLZ1SbxcqEzPFkK6IIaRe6CHJuhj0V
         c3X9OdUqHHn9T75yReCLaYm2z/NY9bmNplKLhDj5YQxXw851VQZULFxU1DbJQW365BSH
         s0xzs6LKpqORMynObYwnRUNbXcbmImuw3AWgooyozs1Agne5cMm6WTUzN8iW7FnJBPOk
         VHlzl2WAQZ2X1ebO3BJ2YzrSS0ulaov9j/c64miMmH3HwdrGdP+1VKP0oR2rHwJ4Qyev
         ZhtVaN3gCebGT10uiXLE3yp/LBv6jdLbHcItA5MTAmnKSRC3sb7MHTt3bvKB3IkA3i8k
         pMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ThicM2MINEcLmZzXQZhlZBSaO4KVfv3Uo4/fCOM5QbM=;
        b=f/BEcuEtCBHUo5DrnJ6bcuJStAnl2xBaDMOGecqTCjRFlxO5ToLWy7e8fPzd2sQYVN
         hR56jI+ZofYHlTdHpBdv2YBJ/7ULhA6JVzcokip7sMIAEKwDxYSjv7UuK45EOXZ3ynpN
         jL3p0XOauRWDZuAo1GsWHl3G8fsKh2NkpiFi1SsoWQIb6MQAlXfTZJ+asuDKcSRL7L6g
         jiGmdkltEd4k3zDAViygFxMqcP7d4rd6/vvDWqaeHabWftDIi2z6+0Y6taMSt3Ai7mpV
         N6DNWBV6/gstyn+PN0RXZCa9FtJLOCY0FNXBkp95EpedS/SYKlKRpundPp05HfDjQCXf
         DMjg==
X-Gm-Message-State: AOAM5307wwnANZYCf5V6bYH2a+x7q9II+ly89mxJJXDC3gN51skCPYWg
        qOHnJYmF8gLuqetLwb5bB44=
X-Google-Smtp-Source: ABdhPJygYBJKYJFujhKJtGYj/sIM/7VF9BtAYwJyYx2TAp9yLJhnpvaLsSTl3wqkiacMVMNw2Kp/zQ==
X-Received: by 2002:a17:90a:734b:: with SMTP id j11mr10996145pjs.108.1590065339983;
        Thu, 21 May 2020 05:48:59 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q189sm4680196pfc.112.2020.05.21.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:48:59 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 21 May 2020 21:48:56 +0900
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521124856.GC755@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
 <20200520044127.GB938@jagdpanzerIV.localdomain>
 <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
 <20200520121000.GF520@jagdpanzerIV.localdomain>
 <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
 <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
 <20200521043628.GB755@jagdpanzerIV.localdomain>
 <20200520214007.86f36f61e1fc0329b66758ed@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520214007.86f36f61e1fc0329b66758ed@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/20 21:40), Andrew Morton wrote:
> > On (20/05/20 18:00), Andrew Morton wrote:
> > [..]
> > > I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
> > > puts() a string of any length.
> > > 
> > > I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
> > > ...) which could perhaps be converted, thus saving an argument.
> > 
> > Can you point me at some examples?
> > 
> 
> ./arch/powerpc/kernel/udbg.c:           printk("%s", s);
> ./arch/powerpc/xmon/nonstdio.c:         printk("%s", xmon_outbuf);
> ./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
> ./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
> ./arch/um/os-Linux/drivers/tuntap_user.c:                       printk("%s", out

Hmm, interesting.

	output = uml_kmalloc(UM_KERN_PAGE_SIZE, UM_GFP_KERNEL);
	read_output(fd, output, UM_KERN_PAGE_SIZE);
	printk("%s", output);
	kfree(output);

> etc.
>
> My point is, if we created a length-unlimited puts() function for printing the
> kernel command line, it could be reused in such places

A function that prints the kernel command line is a bit different
in the way that we can split command line arguments - they are
space separated, which is very convenient - so we would pr_cont()
parts of command line individually. This has an advantage that we
won't \r\n in the middle of the parameter.

Looking at examples, it seems that most of them simply do a single
printk() with arbitrary sized buffers that contain random data,
not necessarily space separated. So same problem - we truncate
messages (maybe?), but needs a slightly different solution (?).

	-ss
