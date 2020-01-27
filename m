Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA24C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36CD206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5HfwAsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA0TAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:00:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39777 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:00:45 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so569203pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 11:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AB0PKGPgk+OAWxGRQvMX+/paMO/D7dA9y2T7+EixdKE=;
        b=o5HfwAsqGXTSjB5v2j0w44xMU45J5gCPHpXhNHVbF77cDX0u/ojB8kcOccXNFHkIJH
         wETo1GSrgJv+RrfiQoug7qs2j2JUSIl8msE3H4tUvnBdu4YSLMD6eT///yfwxVam4bi0
         N87IaLB9n5zpJ5vBtfm0Zhd3TV2iNvmHg8D+uAQbh1Zt/iiUTznQrwxH74Liep4wj+QB
         VBnzDEQRc6aBQ6eG/70zfcrgeR8cZyljTRR5shkTqaR+buB/7MrHiIGnVfL+qOsVvrP3
         QGs8cbD4AN4eLC1Vlxo7EPK+cWTZxgvckIzL5czhbCTJeCaHAoGaStTy4Bw0xTduuHWU
         8N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB0PKGPgk+OAWxGRQvMX+/paMO/D7dA9y2T7+EixdKE=;
        b=KrHh1wu3dUpQAiD1UeofPhwdy2A0zyM+hgwC9x/qfPRJMz+PkJt5JbBowcmOymJTqO
         fpSAyQZ1xwI9aGy7xPCRZVk7S32v21qNNVmUZ3lRDfb5RW8KkQ8J8hkULPs3e8Xyzuwi
         0lwQHoZ+0XBXFqqYNOj38Ca0u7dIyNB6YxgnnPvdma+n7HdWmNurj7PBBuVBY4NYbthW
         79sNdCIdTqJn5qB5+hwuv/ujsPhXQ25rKr6hL+F54F24EDyXGxYNqvTObF/EOtrLDMy/
         kOPrsqMUZ09MGIpUqV/kks7KfhhQfUKZ6v82pw0wMvRH6vthM1NuIzUsewVci9RhCGte
         RiqQ==
X-Gm-Message-State: APjAAAUYZNh6/oOzdrO/2mfFrA+xzNbJoPzjXCeV0KU7tOj63JRyAP5c
        /cjfSs+reiUEAVwCv+Y3fm++PWpVXb+7/9jzeuw94w==
X-Google-Smtp-Source: APXvYqzqcSpnQLS4YBrBxX+5WnYA0mCqhKkRwurmQsEvW/gmHzac5uy/I5+nlg5nXNCcbRA/naDWHt4t2Hoq8N9Dnbo=
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr54935pjn.117.1580151644562;
 Mon, 27 Jan 2020 11:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-3-brendanhiggins@google.com> <20200109162303.35f4f0a3@xps13>
 <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com> <20200125162803.5a2375d7@xps13>
In-Reply-To: <20200125162803.5a2375d7@xps13>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 27 Jan 2020 11:00:33 -0800
Message-ID: <CAFd5g46=wDEMVHqQ-iq31qCxoH_X+4g=+MMx_vA=ujWrF2mfEw@mail.gmail.com>
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

On Sat, Jan 25, 2020 at 7:28 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Brendan,
>
> Brendan Higgins <brendanhiggins@google.com> wrote on Fri, 24 Jan 2020
> 18:12:12 -0800:
>
> > On Thu, Jan 9, 2020 at 7:23 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Brendan,
> > >
> > > Brendan Higgins <brendanhiggins@google.com> wrote on Wed, 11 Dec 2019
> > > 11:27:37 -0800:
> > >
> > > > Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
> > > > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > > > the following build error:
> > > >
> > > > ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
> > > > drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
> > > > ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'
> > > >
> > > > Fix the build error by adding the unspecified dependency.
> > > >
> > > > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > ---
> > >
> > > Sorry for the delay.
> > >
> > > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > It looks like my change has not been applied to nand/next; is this the
> > branch it should be applied to? I have also verified that this patch
> > isn't in linux-next as of Jan 24th.
> >
> > Is mtd/linux the correct tree for this? Or do I need to reach out to
> > someone else?
>
> When I sent my Acked-by I supposed someone else would pick the patch,
> but there is actually no dependency with all the other patches so I
> don't know why I did it... Sorry about that. I'll take it anyway in my
> PR for 5.6.

No worries, thanks!
