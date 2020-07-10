Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A3820708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJCDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:03:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55171 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJCDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:03:53 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jtiOE-0001KK-EI
        for linux-kernel@vger.kernel.org; Fri, 10 Jul 2020 02:03:50 +0000
Received: by mail-ot1-f71.google.com with SMTP id z23so2419496ote.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 19:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQxlxH8w1XRv/PIUz5GYKxBrNAiYJPuPTh1GdFkqGIs=;
        b=R1SsomCbWD0FtkQ82r6U7c0fb4WPmA6LSZMGrs3+BY/WQAd8YCM1noxSWEMP24+TWc
         S/jbQ6tiSETwtbM5rPDESByyy7Q5fj5SPAmV/qjl13NmPIMCQg93DojIBlqTnDw6+awk
         iUW3tYXLoXg1qHS4rFQxcVkXiD5yiKv/xWKIt1aESQ8qEpkq8LXlDPMLEEfeDNoqEsxX
         ZLO4gzbAG0cP+nYzAHgYzQDv6pAKv88X7vdFbzYN3zZPAr7KQkvgUMRZe/RkvrwCaBIB
         lKcI5RrKjMmWcw1ZtBAFri9KnJYi8cgf3oXpEkJCSf4oTKIBa0GrTXQ863DxXTyQIvkW
         enew==
X-Gm-Message-State: AOAM530M1FvR8B5MKwnR+AjrBUjRyAqLZsDQYvk5ebi99HWJtUOk3hR2
        fkxTo1sE5gEQ2ms8p2/QKcUVUeJjdBOxhAVdZXWjVyJVyPiNEa6ROl9yXIxgPPkEqiAdq4W0UrO
        naIU76Q45IY97v/II6fs7wtPm4m2KLQXm2TzFq3YbwFwf0SFggcErJR5vMw==
X-Received: by 2002:aca:53cc:: with SMTP id h195mr2497084oib.49.1594346629475;
        Thu, 09 Jul 2020 19:03:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz90EXEBZzxChOGSMn3vAPnhPKqsDehoEfZ24XLl6I6F50PLmaY8HIRbNnEjkQ9CdqtwnBSbeAYwTS32c6cGEs=
X-Received: by 2002:aca:53cc:: with SMTP id h195mr2497064oib.49.1594346629211;
 Thu, 09 Jul 2020 19:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+VcHvYWngtMVHw5f_XaqA4i4T61yt=h7YvuD=eo3y7Rog@mail.gmail.com>
 <DM6PR19MB2636E5A28FB655C2F657FDF8FA640@DM6PR19MB2636.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB2636E5A28FB655C2F657FDF8FA640@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 10 Jul 2020 10:03:38 +0800
Message-ID: <CAJB-X+UJx+xTJ05snD9xuf7N-ofvTk3ddeSTtNfrGZ738SRvYg@mail.gmail.com>
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Kellner <ckellner@redhat.com>,
        Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario
On Fri, Jul 10, 2020 at 4:58 AM Limonciello, Mario
<Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of Koba Ko
> > Sent: Sunday, June 14, 2020 10:47 PM
> > To: David Woodhouse; Lu Baolu; Joerg Roedel
> > Cc: iommu@lists.linux-foundation.org; Kai Heng Feng; Linux Kernel Mailing
> > List
> > Subject: [Issue]platform/x86: iommu: System can't shutdown because iommu
> > driver keeps checking the status of DMA_GSTS_TES
> >
> > hi All,
> > I have a machine and there's only intel gpu.
> > the secureboot and vt-d is enabled in BIOS.
> > On the Ubuntu desktop, I do s2idle first and restart the machine.
> > The machine can't restart successfully, so I need to press the power
> > button to shutdown.
> > I tried  each of the following and the issue can't be triggered.
> > 1. disable secure boot in BIOS.
>
> Just to explain why this happens, on many of Dell's systems VT-d is only enabled
> when secure boot is enabled.
>
> > 2. intel_iommu=off.
> > 3. intel_iomm=igfx_off.
> > 4. nomodeset
> > 5. i915.modeset=0.
> >
> > After I investigate further, find inte_iommu keeps checking the status
> > of DMA_GSTS_TES.
> > During the procedure of restart, the driver would disable iommu translation
> > and
> > check the status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> >
> > If you need more information, I can provide it.
> >
> > Thanks
> > Koba Ko
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> This is reported on TGL pre-production system, but actually same symptom is also
> happening in ICL production systems such as XPS 7390 2-in-1 and XPS 9300.
>
> Details for the ICL issue are available here:
> https://bugzilla.kernel.org/show_bug.cgi?id=206571
>
> A user did bisect it back to commit 6c3a44ed3c553c324845744f30bcd1d3b07d61fd in
> 5.5.  Glancing through the code and comparing the suspend case, I would ask is it
> just a case of missing a flush at shutdown (IE iommu_flush_all)?
>
If dma translation doesn't be disabled during shutdown, the machine
would be powered off successfully.
I have tried to flush before disabled and this can't affect the result
of the issue.

koba ko
