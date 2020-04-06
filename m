Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03048C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D798A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhpKxJPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDFUK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:10:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDFUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:10:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id v5so996965wrp.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7m04/RQydC05lMdwFzvqDrhS51YkIpWaYRwOu8BZiw=;
        b=VhpKxJPfkPEOFMUFhDw7AIgwNKbEy3WIlk/4P99t/ywfNvy5PYbqWzYc6pJ95ZC0/K
         QxNJljDjWn+XUlGscu1TN6fSe0iuHAUoAqA9xC65cKn5NzRaldqvDvsUM12HtW8KC3e1
         HolrruDn3bNVpj/RgWCUCQxo1wn7jkXR1aSOENbG3ye3Xh0/GFWWvMjSHmmkYrpxwaTN
         82naDkM7QvYfBokhgqyYWli9uRNhAAgRmv011RcZS12aaFf5jj5NtnFeSJP1aJAw+JZf
         j2I3x8l5pZkMSwYjuiZVGrX+4wo/nU/EvJ+d0kdmTw0FkQ8tzHWWurHzh+7oECZHwK+7
         6zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7m04/RQydC05lMdwFzvqDrhS51YkIpWaYRwOu8BZiw=;
        b=G6yc7rE3KclLOcMmkjhnXVXK4ssquho2ZOC+7k57xMXKb8bldK/+rFlUIqM6da/yfJ
         dw71Cq9qB2KEs23NfRqa2HLERX4kxeNnnjaQtxjgsJEWNT2IiU6mxhf7gaTmWEq/I8st
         igmQ0JUBA12dBPzAS5pFfRMObg8xhznIE+E/gzGJUmud4I9Ob3cFYmZzwKvtOHc8KL/m
         kWBtWSCMfbUDJMfu7Mz7Jke7Mc5Zkyr2k00S8JegbgFIPRZkw6oknS4IDabHQsfrsu58
         Y025VYOgOpq9wtcpsukQUzshD2TkOzSeW6Rzu+FmefEjxgS0wonds1fWQI6mKV9RjejX
         NZfQ==
X-Gm-Message-State: AGi0PuYDwlpTKS7oTiqpWlDqnFIFLHv5DYnHt+w6/XrbLhEwXWBQ4Uxm
        Ltp8UAIwdlIPkz8tm8Cjj+A=
X-Google-Smtp-Source: APiQypKS1KZuF0Y6bJWDK84a832JwPLWyZ706L64ZntZUnsCdvv4UgFSB9mODdX75JRUmEK5dO8Qjw==
X-Received: by 2002:a05:6000:e:: with SMTP id h14mr1084034wrx.128.1586203855805;
        Mon, 06 Apr 2020 13:10:55 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id z21sm727473wml.47.2020.04.06.13.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 13:10:54 -0700 (PDT)
Date:   Mon, 6 Apr 2020 22:10:53 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200406201053.GA10931@Red>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406093729.GG25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:37:29AM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Apr 06, 2020 at 11:25:40AM +0200, Corentin Labbe wrote:
> > On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > > > Hello
> > > > 
> > > > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > > > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > > > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > > > 
> > > > But kexec 2.0.18 fail to work:
> > > > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> > > 
> > > What happens if you omit the dtb argument?
> > > 
> > 
> > No change without dtb
> > 
> > I have also tried to add --mem-mim and --mem-max without any change.
> > I given mem according to what I saw in /proc/iomem
> > 20000000-9fffffff : System RAM
> >   20008000-207fffff : Kernel code
> >   20900000-209a0c87 : Kernel data
> > So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
> > Anyway, the result is always the same.
> 
> The next step is to enable the early debugging - first in the
> decompressor - add #define DEBUG to the top of
> arch/arm/boot/compressed/head.S
> 
> Also enable DEBUG_LL in the kernel and use earlyprintk to see if you can
> get anything from the new kernel.
> 

I dont know what happened, but now I always get "Could not find a free area of memory of 0x86c1c0 bytes..." (even with kexec 2.0.18)
Furthermore, I have added crashkernel=128M to the cmdlist
I have verified that the reservation is working:
20000000-9fffffff : System RAM
  20008000-207fffff : Kernel code
  20900000-209a0c87 : Kernel data
  40000000-47ffffff : Crash kernel
But even with this reservation, no change.

