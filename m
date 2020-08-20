Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A69BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E086D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehZtgn4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgHTKra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731270AbgHTKQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:16:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09708C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:16:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so1848969ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7IDsCs3O3XVq6Oo36ltfbQDp/qQH17B8kNCHrYYi58=;
        b=ehZtgn4/AxsmBi4CkUnsCHo/q6bpQxXO/GGgvrCHjALePJV0mY03gGKLtDpnr62vq7
         KV3mdnnS1aNkayPfMEd6+kiXUtw5pXZFUZ/dq+zcrKhOGKgl7b3lXQNmHHz0Fv8waUXO
         bUcyInFMwIZHXpvW8Pcz/o4WwKo7iyfKJp3kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7IDsCs3O3XVq6Oo36ltfbQDp/qQH17B8kNCHrYYi58=;
        b=npF/AWBxmeYs21YVnmVk7n66DiRiZDWTxIzkl8MaFg4hwx7VN8wdXYlKTutT1TmVPI
         u6SfHFsoQLkH3Z/z+hs9FgOnc2zB3YKd1YnSDSfDXzl49E3HfHMbOvAkRDWtUi7IZA7y
         BfzO/RI1p0APO4y6upVT4yUG84K/o7vJmQZCvj2VckYwbF1RmPhBIJoDPlDhpk7lb7+a
         K4GM+Tl579JyTpln7YOkqu9u10XXPc1+8xcSr40gSgf4ZZYbNFQfrDIILnoLl/702WCl
         j19sTISval2Rkvw/TbMbqjeNGillGzIEuraB8YQlIt9qgWJuAJe7CCVjEEivB85qHvpe
         xwYw==
X-Gm-Message-State: AOAM531ljYfDwPBnmefC0qPMlpt6b7EJjJsqDdrKJNYvljo9yJDBS8W3
        jXuR9E1tC22e2uH4U+oO0t939FLetuhLmEaa
X-Google-Smtp-Source: ABdhPJxT02rO0ThewNyNt+6tIaWdfDPEhVw0HeBKdtYl+IoPSr6anOxbPoDSEuZgZbokDECCNP4dEg==
X-Received: by 2002:a17:906:7108:: with SMTP id x8mr2433827ejj.447.1597918558415;
        Thu, 20 Aug 2020 03:15:58 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id f20sm1165340ejq.60.2020.08.20.03.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:15:58 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id p14so1090357wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:15:58 -0700 (PDT)
X-Received: by 2002:a1c:5581:: with SMTP id j123mr2797156wmb.11.1597918188072;
 Thu, 20 Aug 2020 03:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de> <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <62e4f4fc-c8a5-3ee8-c576-fe7178cb4356@arm.com> <CAAFQd5AcCTDguB2C9KyDiutXWoEvBL8tL7+a==Uo8vj_8CLOJw@mail.gmail.com>
 <20200819135738.GB17098@lst.de> <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
 <20200820044533.GA4570@lst.de>
In-Reply-To: <20200820044533.GA4570@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 20 Aug 2020 12:09:34 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CEsC2h-oEdZOPTkUQ4WfFL0yyYu9dE5UscEVpLyMLrCg@mail.gmail.com>
Message-ID: <CAAFQd5CEsC2h-oEdZOPTkUQ4WfFL0yyYu9dE5UscEVpLyMLrCg@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, alsa-devel@alsa-project.org,
        linux-ia64@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-scsi@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pawel Osciak <pawel@osciak.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 19, 2020 at 04:11:52PM +0200, Tomasz Figa wrote:
> > > > By the way, as a videobuf2 reviewer, I'd appreciate being CC'd on any
> > > > series related to the subsystem-facing DMA API changes, since
> > > > videobuf2 is one of the biggest users of it.
> > >
> > > The cc list is too long - I cc lists and key maintainers.  As a reviewer
> > > should should watch your subsystems lists closely.
> >
> > Well, I guess we can disagree on this, because there is no clear
> > policy. I'm listed in the MAINTAINERS file for the subsystem and I
> > believe the purpose of the file is to list the people to CC on
> > relevant patches. We're all overloaded with work and having to look
> > through the huge volume of mailing lists like linux-media doesn't help
> > and thus I'd still appreciate being added on CC.
>
> I'm happy to Cc and active participant in the discussion.  I'm not
> going to add all reviewers because even with the trimmed CC list
> I'm already hitting the number of receipients limit on various lists.

Fair enough.

We'll make your job easier and just turn my MAINTAINERS entry into a
maintainer. :)

Best regards,
Tomasz
