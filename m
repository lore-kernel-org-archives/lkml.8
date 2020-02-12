Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC38C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815EC217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgBLUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:00:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37425 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:00:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so3292223oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQdM7QBHmlDS0OUFVBlwMq3kXCUqy/frsiXVn9/S5OI=;
        b=KPmCtnK+OeBw1vpxr8+1yeylRmJA/IGReRkPUxgmwtrct3kAjvHll8cJ93JyVru61D
         C2VFAof8h+oy1S7o4k+KgH0IGqFQrtcT46BydRI6qXQw6tED+M0eFWdDYiJ0y/pN5fC+
         lRO+bQq/TEmdQtgVE8N3dS4/jKUZGdV4qvJ4niSKMxgq2CiAjqxjGOTdNp95xb3aT/TC
         tmM86DKQVIaS5BiBkz+8dguMaWI3HmhjoFQ220E/3K+jKF/7Rmo6s0lDKQisQ5bJlOOw
         6jMFmRZZFLU23J+1xdbom3W4p+AgpIEbPrev+h21vNWVdkiSzKum/KUpkTXmKjV+CNxh
         JBKQ==
X-Gm-Message-State: APjAAAXRGsI2ivlzN3UWy9gFPrZNK4CAgxZdW6co44O50BTFc0pDXXln
        ODpH2Ak6ED/G64Ign+e0M9vRdZQM
X-Google-Smtp-Source: APXvYqzKDxCQVxKjz3dwmxfdwFsIgBYwbdZfvsa6PdjoqSYis5B/ycr6exVmvgyCIr2Cpl68QqBYKw==
X-Received: by 2002:aca:af49:: with SMTP id y70mr534824oie.162.1581537598779;
        Wed, 12 Feb 2020 11:59:58 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id t21sm497315otr.42.2020.02.12.11.59.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:59:58 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id q81so3306789oig.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:59:58 -0800 (PST)
X-Received: by 2002:aca:6749:: with SMTP id b9mr500523oiy.13.1581537597909;
 Wed, 12 Feb 2020 11:59:57 -0800 (PST)
MIME-Version: 1.0
References: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com> <20200212104902.GA3664@willie-the-truck>
In-Reply-To: <20200212104902.GA3664@willie-the-truck>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 12 Feb 2020 13:59:46 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ-FcA-xdjp02ybsYeU9UFxCZU5dpf0wHThTmLHcjovCQ@mail.gmail.com>
Message-ID: <CADRPPNQ-FcA-xdjp02ybsYeU9UFxCZU5dpf0wHThTmLHcjovCQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name to be consistent with
 older kernel
To:     Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 4:50 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 11, 2020 at 06:37:20PM -0600, Li Yang wrote:
> > Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
> > introduced a side effect that changed the module name from arm-smmu to
> > arm-smmu-mod.  This breaks the users of kernel parameters for the driver
> > (e.g. arm-smmu.disable_bypass).  This patch changes the module name back
> > to be consistent.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  drivers/iommu/Makefile                          | 4 ++--
> >  drivers/iommu/{arm-smmu.c => arm-smmu-common.c} | 0
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >  rename drivers/iommu/{arm-smmu.c => arm-smmu-common.c} (100%)
>
> Can't we just override MODULE_PARAM_PREFIX instead of renaming the file?

I can do that.  But on the other hand, the "mod" in the module name
arm-smmu-mod.ko seems to be redundant and looks a little bit weird.
Wouldn't it be cleaner to make it just arm-smmu.ko?

Regards,
Leo
