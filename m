Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE07C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 02:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DE72071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 02:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkxDWTfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbgAYCMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 21:12:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42140 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbgAYCMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 21:12:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so2044195pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 18:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXFe/vfnLkzT3mAWRy5NBHmIc8Oyyk9Ad0WMoNwuPt8=;
        b=TkxDWTfMZU8Eqr69fjAxX4wvjaAyxwoq2CL2Bwlr1AgGV5D4EqkcCvbwxqxtk5oWQ7
         Vu3iQLbxn7OwbKzTe4BtiWx7Bvvg/IeY5IAdi7Ep3DVIs6SknDPSxgtbYjPOKkFOA9vy
         x1TB7CkGJlRbp0gzWpmXSkdZjh1hUhNKqoS0ZI9xK2qxCiNwtuYiAc1T7ywm7J2boTXa
         Tv6qkmoVmv2ZmykEokMRBxmoaGc+RIaJSM0dV/GnsSeGscoWaVB3Y7CcmRsz4HdsSgGR
         XWDLWKezF32jOsGs4kkhN3bUgl2Kd6ojl3ufz90tx6eQvHHL80yzoBsAUbi7t9WCXnAw
         6Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXFe/vfnLkzT3mAWRy5NBHmIc8Oyyk9Ad0WMoNwuPt8=;
        b=dBjYOLAYQ5NVnLZI1THx1kv2cP946BKIJ4HG0hQf7AEDbu3jtXY4Hlw/IDb+gOEvy/
         IbwwVRlhSahkUnI8IFgu1cllRFAmFTJkTPDV/iYwkJJlKIw0TCJMiXeCumJS1gkH2Jm9
         Fr4Zd2eoCuplQn6hOOHBomvy8rf7AB7tCGGIAYVHbisjDrkLFrAe+IsyxxMntU86AfE7
         uxV/FPWmkiQEJR2k0p32pRA2cPdvtcgJB3X8qsEzXKSAucTP9uqQ1iLBMrqa3k5tes6r
         GjU8Altwv09cVvr0mdRByRNYNmlvaCBeEm47UBpQRjr2vCgBU6x78ijxpn3T/nLR877z
         KCPA==
X-Gm-Message-State: APjAAAXIJqzXBUko50ldwYJMblf19DfVhNJ+gJTUs7QMbioNZCzlNAzq
        KH8kf1XjlrXy+0EFPvF7cIs4Fy6OumcbTaHJzLA7pA==
X-Google-Smtp-Source: APXvYqyW0SmPK4KpuQbLoeF3vRxy+R+++4XuYWmuDeTZM4oxe/ppV3OLeGSF+O7JLzqqRY0RxLFKybydDDRXm7DDRfA=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr7565027pgi.159.1579918343489;
 Fri, 24 Jan 2020 18:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-3-brendanhiggins@google.com> <20200109162303.35f4f0a3@xps13>
In-Reply-To: <20200109162303.35f4f0a3@xps13>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 24 Jan 2020 18:12:12 -0800
Message-ID: <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:23 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Brendan,
>
> Brendan Higgins <brendanhiggins@google.com> wrote on Wed, 11 Dec 2019
> 11:27:37 -0800:
>
> > Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
> > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > the following build error:
> >
> > ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
> > drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
> > ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'
> >
> > Fix the build error by adding the unspecified dependency.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Sorry for the delay.
>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

It looks like my change has not been applied to nand/next; is this the
branch it should be applied to? I have also verified that this patch
isn't in linux-next as of Jan 24th.

Is mtd/linux the correct tree for this? Or do I need to reach out to
someone else?

Cheers
