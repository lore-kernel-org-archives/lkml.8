Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94017C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BB32086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8KTiOFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgHDPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgHDPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:17:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 08:16:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so38732576qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LPySzTKUVWScjTIN3cHIfKZzXT4OE86By7kU7hXJQxA=;
        b=X8KTiOFAbSLv2lUM5zEmyLuJ/WrCjl4JDEdDTPrMqThh8xSdY2a6HpCjh4cur4+Ssn
         OqePKqqkWB2W4EHRFlYUzsL1U2BrZC2A2rMxGvQFAs1nPFyFuGp+pyD16sofodKJ39gr
         zTxP+2lBf3r7q8vddytiwbya0G0QlV1bbIV5Nl3eSoWUpsAyviakDdK6P0PVqMxoMhE8
         HJuQwfa08mu5CyxLoAiqWo289C+CrWTOT34h57BPgvOvRG1AZcL/snaUaAyLJdvSZT5y
         5SPATYGLIhVQjg/sDUXDBmHY6vrwAaIQ4GhczhOvFGXmj9VYY5H9qXyzlv6hjGbPAgqS
         erkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=LPySzTKUVWScjTIN3cHIfKZzXT4OE86By7kU7hXJQxA=;
        b=R2JMB7qV0OPphxQ+rlqB+keADNJOjWYFWq7HrpKBJ6Q8YwYSKFt5dKxOGQL/bXJXes
         0/+gR8PWL7P7jnhEtN2e9tL3v/GmouN0Cbb6lZSuYk7IoGFUNDxRx4PJuU+nKW7fCLZv
         pTUYiLF5pyAoUxSS3vuAkr4aI7+8evXD446/0O6VWrcj8wiE0PP4hgrZ3rYLWRKnIo+Z
         UNllmuXsqgH5JGn51klCAGzyzR8ZgAMYS6WUkTfcRo+pdeJ8UfNIWu30hi8HEYTk6N4f
         ddUj0q9upWwPuzo5npwGxkaTVkxlrLICobUZ7zx5oT/sxR50k32Wbp7qEIS8ovGzuNVc
         JaWQ==
X-Gm-Message-State: AOAM533yPSJyBS2403SYArrI0tQoR9OjQLgL3u6yz1bz3FHX0xd8sFc7
        sbeR6KvC9rW/sGvHz2NLPhI=
X-Google-Smtp-Source: ABdhPJxoaX+mmG63xjVdS+ySITiWYt5W/SEz2JCIZFozrUfjLOZbEzaxCztI8bDs8uIa+LZp1fdYdw==
X-Received: by 2002:a37:8047:: with SMTP id b68mr20146223qkd.299.1596554218832;
        Tue, 04 Aug 2020 08:16:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 6sm21098319qkj.134.2020.08.04.08.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 08:16:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 4 Aug 2020 11:16:54 -0400
To:     Pavel Machek <pavel@denx.de>
Cc:     Nick Terrell <terrelln@fb.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Terrell <nickrterrell@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Message-ID: <20200804151654.GA2326348@rani.riverdale.lan>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
 <20200804083236.zjkmfer37z5rn3r4@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804083236.zjkmfer37z5rn3r4@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:32:36AM +0200, Pavel Machek wrote:
> Hi!
> 
> > >> I've measured the kernel decompression speed using QEMU before and after
> > >> this patch for the x86_64 and i386 architectures. The speed-up is about
> > >> 10x as shown below.
> > >> 
> > >> Code	Arch	Kernel Size	Time	Speed
> > >> v5.8	x86_64	11504832 B	148 ms	 79 MB/s
> > >> patch	x86_64	11503872 B	 13 ms	885 MB/s
> > >> v5.8	i386	 9621216 B	 91 ms	106 MB/s
> > >> patch	i386	 9620224 B	 10 ms	962 MB/s
> > >> 
> > >> I also measured the time to decompress the initramfs on x86_64, i386,
> > >> and arm. All three show the same decompression speed before and after,
> > >> as expected.
> > >> 
> > >> [1] https://github.com/lz4/lz4/pull/890
> > >> 
> > > 
> > > Hi Nick, would you be able to test the below patch's performance to
> > > verify it gives the same speedup? It removes the #undef in misc.c which
> > > causes the decompressors to not use the builtin version. It should be
> > > equivalent to yours except for applying it to all the decompressors.
> > > 
> > > Thanks.
> > 
> > I will measure it. I would expect it to provide the same speed up. It would be great to fix
> > the problem for x86/i386 in general.
> > 
> > But, I believe that this is also a problem for ARM, though I have a hard time measuring
> > because I can’t get pre-boot print statements in QEMU. I will attempt to take a look at the
> > assembly, because I’m fairly certain that memcpy() isn’t inlined in master.
> > 
> > Even if we fix all the architectures, I would still like to merge the LZ4 patch. It seems like it
> > is pretty easy to merge a patch that is a boot speed regression, because people aren’t
> > actively measuring it. So I prefer a layered defense.
> 
> 
> Layered defense against performance-only problem, happening on
> emulation-only?
> 
> IMO that's a bit of overkill.
> 
> Best regards,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Why would it be emulation-only? QEMU is just being used for ease of
testing, but the performance impact should be similar on bare metal.

Thanks.
