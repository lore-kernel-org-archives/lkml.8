Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF48520644
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smLxfdnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDFJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:25:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDFJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:25:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id w15so10286418wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tWjzg+BVrz3TNNIkAGcAPM3G1GTTyThKxry/5V7utII=;
        b=smLxfdnrwlbOaIv5M/k3oW4eMRWpaErrmcjTYxdTlW6dTt4uoklsAsspG0o+iKjoEr
         6IX1hf3EMvtGOa2XM9/WtTl3RgRIv2RQbXtuMZbE4IIyZc8Vt9JVEAwh5fWAeRhjQf4F
         43pkmDEhlo1bViU/N2Q4/9YATxjB6ix6DfZtAh5z8UdyfojtrQk7nnPYuhLmG21OwUb6
         Iwnn1KdAvEZyVXGp3avOU+cg/VmrNttm6GqiZps0YzwI+kGupXCrTPJOJpGYGaHvlvyG
         DMQzYvoaCtQP8ww1Qy/r6CO6QlCGUfhC9sddAn2khZCgzUsw277rkD8DuupgSVt36y1A
         agJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWjzg+BVrz3TNNIkAGcAPM3G1GTTyThKxry/5V7utII=;
        b=KCxlmA3RDJxzY4aSWO6cRCt2df+/kCzO4yS6DjQI7xo8L0sbLCLvetA+9GwF+sbaaB
         GKwPremBwcoBkDKKrb6/03vsfLkNZ7WhXih0+apbMrjQG2noDxWEvQh4myp3y5qOF+F7
         onUDUJ2Ao3MrVsNdj0VXUySH5iTGwh1P4T20+OSwxVAaqAxyuuy4H1zTLoTPYGd1VGTc
         TBptyV9IaV5S6Fjy47p2D7OZRH+FKGwL0r1d+3zf7PNZyooPLoerO7vA6rJFHOQsHKPI
         M/CGhNz27SGXIIx375gVWO1PO4O0G6ASLgt5vsrCk/bEidql95o46KrMB8dJdorTD1kX
         OZsw==
X-Gm-Message-State: AGi0PubYUewLgLn7wPr66gLIXTDZha5kX4YRCAMgqYss+jv7TS5q4utD
        VBR0aD8dYpZFaGhU7zu6IINHh0kN
X-Google-Smtp-Source: APiQypJr80FWnUWhXdf19n79QpElYuaGdiscr01AfN/mEfARb35P67bfTbUVDJCeH2vTKkDWoE+6aw==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr23069597wro.68.1586165142423;
        Mon, 06 Apr 2020 02:25:42 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v186sm24100784wme.24.2020.04.06.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 02:25:41 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:25:40 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200406092540.GB31279@Red>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406091600.GF25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:16:00AM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> > But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> > So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> > 
> > But kexec 2.0.18 fail to work:
> > kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
> 
> What happens if you omit the dtb argument?
> 

No change without dtb

I have also tried to add --mem-mim and --mem-max without any change.
I given mem according to what I saw in /proc/iomem
20000000-9fffffff : System RAM
  20008000-207fffff : Kernel code
  20900000-209a0c87 : Kernel data
So I gave --mem-min 0x30000000 --mem-max 0x9fffffff
Anyway, the result is always the same.
