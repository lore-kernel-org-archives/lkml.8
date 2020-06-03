Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88007206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhWE4ojU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFCNEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFCNEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:04:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC0C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:04:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so1267921lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYWB9Zc3GNDA4PRS107hK9DQMWjbBQkU88I58XoczKY=;
        b=lhWE4ojUzpHFe0O0OFM1+zVIveUHYY38pcA0z39T4ZeQiTaWDq06IUxMPk46J1Br/4
         0gXS6KKVZIt3ZexlCUdiSXGQ8gI7mOjAN4zALqktUyBFC7rrQ2JtAAkBOKKXwbwVsQ39
         WuUSMocOxHGEB6QTcB/EJHqm2AERLgmkHs3UFfuzACevExI187V+6o4dPvJIKBTIk3Fh
         p+F1WHJmzDTb2tzBc9BQ7wjUOFeP2HQk4LEBQkX7MNUXl6aSCQaxswFD8tnyk3Tr52+Z
         iEx/Hg4xqaEExhLUMj02mO6HcOKD2lqz0tgebuT3V7G/MUt3aR0agCByDAlsp8E0n9wD
         Fjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYWB9Zc3GNDA4PRS107hK9DQMWjbBQkU88I58XoczKY=;
        b=MV+SmK66rYsepCBBWqCN1oZVPLe0Vb3cyO01M1iKBmbTiAdoB5CLDsoVbT/MEJLh18
         MwB4cQP53ezWWktaiNWWOgiwJvro5St/AGPfYC9eIUCpqH3bCAJ1XeeFd7jdg/hGuhVr
         SzhecW9QyDhfyFJ+44zgoZFXFr+bDW4gRDshb1jNvmrI+jBJARk0ifePApsY0kMvIWsZ
         DXDu2q/LxBuusSaGqSd3eiyiEAQJ4ENZu6KaDvPxAuH/sPdj11ooPGachFckhOVV/Aq+
         YDqnYkn0ZSzxw9OA+dylA6CeQkC79yoKeQ3FPBCsVLWRbmp1z0Q9DI2fZzYfcvH/3M9M
         9LFQ==
X-Gm-Message-State: AOAM5338pcy/ZVPB4H4zsZXocmVxHZUIJhRbGOjc6bcQo4JWqqk3Sgd3
        3T1zadVh3tJSqOmqeOxCW8Ne03rvVRFk2tVtzdTz4A==
X-Google-Smtp-Source: ABdhPJx/SFywugEqHpP1CjXoO4eyWzcQB1nCnB+lfviUAqy+jN9TG4KQexDUYMcx860SBT8bJ0bto+LzPC4vG0wngHA=
X-Received: by 2002:a05:6512:2027:: with SMTP id s7mr2389351lfs.15.1591189471737;
 Wed, 03 Jun 2020 06:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602232602.156049-1-rajatja@google.com> <20200603053008.GR247495@lahna.fi.intel.com>
In-Reply-To: <20200603053008.GR247495@lahna.fi.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 3 Jun 2020 06:03:55 -0700
Message-ID: <CACK8Z6GmUBwRV0=DFLdRDWR7vVTCvX8zAGzP8Xpu+hb+YPD2fA@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Alex Levin <levinale@google.com>,
        Zubin Mithra <zsm@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Todd Broch <tbroch@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 10:30 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> > +static bool risky_device(struct pci_dev *pdev)
> > +{
> > +     if (pdev->untrusted) {
> > +             pci_warn(pdev,
> > +                      "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> > +                      " PCI link. Please check with your BIOS/Platform"
> > +                      " vendor about this\n", pdev->vendor, pdev->device);
>
> You should not break user visible strings like this. It makes grepping
> for them harder (see also CodingStyle). You can write it like this instead:
>
>         pci_info(pdev, "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted PCI link\n",
>                  pdev->vendor, pdev->device);
>         pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
>
> Also I guess pci_info() might be better here after all. Your call :)

Done, sent the updated patch.

Thanks,

Rajat

>
> Rest of the patch looks good to me.
