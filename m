Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C2BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0D520717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmYPJrBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgGRRRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:17:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E12C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:17:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so2345628pjd.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x9/2xXqwMMIu02V9Vx1i6FLVJT0HyPCTnfOosfXOgaE=;
        b=ZmYPJrBUjNKjox4NeljunjKcZnnBt381R+Y3talOfWMy350/GqtfWzR+C/0U5VL655
         43SRvWcRjhK+5Mi/BEiOLCbTWf5Wu3G0hqZx5KPtfn9E9IaCJrMMnl1XyxSh79vSFcTP
         9VzUagMa36hnuLwHjTAbCOQVNEhkEmV77yV2LB2WouQ4ecnWJgVJLGETFa/ElAHeUE26
         H3xABIR+F8PswuSXDNENHnFy7B0XnW4QvowXg3TbSNg7vyhZpX5UClydnK2haFsnP93g
         Cuhmw3SsOEyFckbVyg+1uV7gl9N3cZNy7um3aP+3k0UuqKO3wktU0eGUMav8D9677/6p
         8seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9/2xXqwMMIu02V9Vx1i6FLVJT0HyPCTnfOosfXOgaE=;
        b=JGigLFCBcBRoAelOZYQkqH6LwSlbD5D/Pt4ZtOKAqFfwh+R+3sR/ol0/s3Xg2c7K6A
         HmgGvPVZpCyP2D39vkTTxmTjspu7/Qzk5haxr/KYEMAkMp9rWSIl6EPthtyLJmVKEYYs
         pgof853jqb6XqlF27LOMgBa+lHLH5dASqsdC0xLOeZBZXDVAFlhdLLXi1a09BLop3SyY
         ac5zlO0UOyT7rbMpwz9+E2UOAIwuNjSlLdJ7znKt83+YKcLnuocuAf3qHPTqareE1lXU
         9/PluclMGJq1i5DiD9xHAXNGMxxeA20xFex3zifELKWMvg27Qtr2i+mncHeCC4gRcRKt
         9Wbw==
X-Gm-Message-State: AOAM531uUE/BOtG44x9DJYu0B6QPZvFqN5VqlqHvojl4u8QcxHByp3bw
        UoWnDSBwh5Qmt3rWOVIjetk=
X-Google-Smtp-Source: ABdhPJzA3RY/xQJRaNa31hOIDeekxbCxvMbScjxAzsMkHADaeWF07zK6Wn7kuGT9XTzSZOBRC47OSA==
X-Received: by 2002:a17:90b:24a:: with SMTP id fz10mr15055235pjb.36.1595092636134;
        Sat, 18 Jul 2020 10:17:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d18sm6080726pjv.25.2020.07.18.10.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 10:17:15 -0700 (PDT)
Date:   Sat, 18 Jul 2020 10:17:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] dma-mapping: make support for dma ops optional
Message-ID: <20200718171714.GA237687@roeck-us.net>
References: <20200708152449.316476-1-hch@lst.de>
 <20200708152449.316476-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708152449.316476-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:24:47PM +0200, Christoph Hellwig wrote:
> Avoid the overhead of the dma ops support for tiny builds that only
> use the direct mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For ppc:pmac32_defconfig and other configurations, this patch results in:

Error log:
drivers/macintosh/macio_asic.c: In function 'macio_add_one_device':
drivers/macintosh/macio_asic.c:393:16: error: 'struct device' has no member named 'dma_ops'
  393 |  dev->ofdev.dev.dma_ops = chip->lbus.pdev->dev.dma_ops;
      |                ^
drivers/macintosh/macio_asic.c:393:47: error: 'struct device' has no member named 'dma_ops'
  393 |  dev->ofdev.dev.dma_ops = chip->lbus.pdev->dev.dma_ops;
      |                                               ^

Bisect log attached.

Guenter

---
# bad: [aab7ee9f8ff0110bfcd594b33dc33748dc1baf46] Add linux-next specific files for 20200717
# good: [11ba468877bb23f28956a35e896356252d63c983] Linux 5.8-rc5
git bisect start 'HEAD' 'v5.8-rc5'
# bad: [4d55a7a1298d197755c1a0f4512f56917e938a83] Merge remote-tracking branch 'crypto/master'
git bisect bad 4d55a7a1298d197755c1a0f4512f56917e938a83
# bad: [49485850238eb3fc72aac951e47e33e367aafbab] Merge remote-tracking branch 'hid/for-next'
git bisect bad 49485850238eb3fc72aac951e47e33e367aafbab
# bad: [4406fe306759d700f2b2aa8adf890a7d7ef064ae] Merge remote-tracking branch 'tegra/for-next'
git bisect bad 4406fe306759d700f2b2aa8adf890a7d7ef064ae
# bad: [27f18f0e00ed1f15ee55d479216c874561b6b70a] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad 27f18f0e00ed1f15ee55d479216c874561b6b70a
# good: [a23a793b03f465cf2222fa29e7f81d732a6f6fdf] Merge remote-tracking branch 'usb-chipidea-fixes/ci-for-usb-stable'
git bisect good a23a793b03f465cf2222fa29e7f81d732a6f6fdf
# good: [05d94a2de41e8d9840d9749d553febdcf99cb0e5] Merge branch 'arm/drivers' into for-next
git bisect good 05d94a2de41e8d9840d9749d553febdcf99cb0e5
# good: [5fef5dc17f097794288acb098ccc80eb91142bf4] Merge branch 'for-next/mte' into for-next/core
git bisect good 5fef5dc17f097794288acb098ccc80eb91142bf4
# good: [3c7f84b2248457030a903813e4af71d80141d663] Merge remote-tracking branch 'fpga-fixes/fixes'
git bisect good 3c7f84b2248457030a903813e4af71d80141d663
# bad: [88ff79e455afa3ac90739da27e24f655a965e3cf] Merge remote-tracking branch 'dma-mapping/for-next'
git bisect bad 88ff79e455afa3ac90739da27e24f655a965e3cf
# good: [7c4d50d4973b40c53ef6c592b41b0473127e6762] kbuild: do not export LDFLAGS_vmlinux
git bisect good 7c4d50d4973b40c53ef6c592b41b0473127e6762
# good: [c45db534668104ed5112ed371526db6096ac5742] Merge remote-tracking branch 'kbuild/for-next'
git bisect good c45db534668104ed5112ed371526db6096ac5742
# bad: [249542813648f7a278895ad25674d3e147f49ad6] dma-mapping: make support for dma ops optional
git bisect bad 249542813648f7a278895ad25674d3e147f49ad6
# good: [b4174173005972f8f6497883d08d87e0aba1b604] dma-mapping: inline the fast path dma-direct calls
git bisect good b4174173005972f8f6497883d08d87e0aba1b604
# first bad commit: [249542813648f7a278895ad25674d3e147f49ad6] dma-mapping: make support for dma ops optional
