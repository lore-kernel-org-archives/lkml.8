Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2227C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7D020748
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp2Fr3N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgFTUKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:10:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgFTUKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:10:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so5586265pll.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iRX0OPkrMjtIh+IZlLNQE9USdarPLnAiygVqscVAq+o=;
        b=Vp2Fr3N/AURy1KyePwnHI0cazWHmCk7MDLKFosyoUKWLEXQ4LrxbcX32Ph9y8jhALB
         O/eBIuUuZ0qmZKDed/riTNoDf3lzXfgcFJJIPsJX67XzFHWhQ8G7pJ2wh1zIsrrwEPM9
         CFNTTPMeFY4GYmC9ssoJPAG219oQ0sL245dKghz0ZtDTbatuov8erXjNsQmn382/QRB9
         Gf4dfP2cwRwmarUED3grIFRwO3XE5Cc2FMiQPLm9rnK5lzTeOVM/dZmCUhCsy3shikza
         gGGzSX7coIjsty7LdzyQm3k9ci3UJLghu9NnZ2PrsEZZ6s6qI3Nq7F1vjBzA892DhOss
         uLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iRX0OPkrMjtIh+IZlLNQE9USdarPLnAiygVqscVAq+o=;
        b=krjwYgU7OdMGv3vvdj+2fFWMFqxoiW6LCTrXYLaMlQvTAihzcKukx4E1KHRPuSmtrf
         scGeKmEIlduVxs5+NH0ktGYJLMBCi92XplNmGUFLq2wYbFniZ6/beRh/7kFHrYlFq+k7
         3C84o+tI0lcpRQJV82L8TbaGSknFdPtRuJOq8vwC71fXU7QHwqYi4BZzsxz8mrbV35il
         UPB+Vx38BNy+3TdCZ2Yrf/kDE9n2CU/4gj8A+5Ua0teXMjC/9Zx7sY1/O1VgDcB1C4hT
         Q61802BQquDu0rcDy5iMo/+U2JDiZKQTci8S9DwONT9MO/oSHom7zUsLinmuaMu+EZ29
         +YjQ==
X-Gm-Message-State: AOAM531Ket1zrJyozZlFvMS47whiLSSHDK1u3yiBkmpQ0pzZcBiczw2C
        /r4Pfz1Ls3tIz8hBqYReDvE=
X-Google-Smtp-Source: ABdhPJx2h6Q5/YN8i8jkpnFIy9lAv1yZIZuQJN/Gz8jrg5CMF1XcnAnB82QayyjUt0WXcyX+62s33g==
X-Received: by 2002:a17:902:8681:: with SMTP id g1mr13031314plo.161.1592683777739;
        Sat, 20 Jun 2020 13:09:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm9376740pfe.198.2020.06.20.13.09.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Jun 2020 13:09:37 -0700 (PDT)
Date:   Sat, 20 Jun 2020 13:09:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200620200936.GA106151@roeck-us.net>
References: <20200608132217.29945-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608132217.29945-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:22:17PM +0200, Geert Uytterhoeven wrote:
> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> memory pools are much larger than intended (e.g. 2 MiB instead of 128
> KiB on a 256 MiB system).
> 
> Fix this by correcting the calculation of the number of GiBs of RAM in
> the system.  Invert the order of the min/max operations, to keep on
> calculating in pages until the last step, which aids readability.
> 
> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: David Rientjes <rientjes@google.com>

This patch results in a boot failure in some of my powerpc boot tests,
specifically those testing boots from mptsas1068 devices. Error message:

mptsas 0000:00:02.0: enabling device (0000 -> 0002)
mptbase: ioc0: Initiating bringup
ioc0: LSISAS1068 A0: Capabilities={Initiator}
mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
mptbase: ioc0: ERROR - didn't initialize properly! (-3)
mptsas: probe of 0000:00:02.0 failed with error -3

Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
Qemu command line is

qemu-system-ppc -kernel vmlinux -M bamboo \
     -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
     -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
     file=rootfs.ext2,format=raw,if=none,id=d0 \
     --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
     -monitor none -nographic

canyonlands_defconfig with sam460ex machine and otherwise similar command line
fails as well.

Reverting this patch fixes the problem.

Guenter
