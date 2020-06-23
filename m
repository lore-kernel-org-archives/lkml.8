Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076B920720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRnduxVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgFWBdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbgFWBdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:33:16 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009FFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:33:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w9so3892935ilk.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x99pYwa1dnOzvMHARyvq3wdM6wF3B15xvFgvTOgiQu8=;
        b=hRnduxVYqOiY+fbFT+FYlxtB/hvdIuvh15lxw6gyLq9tvdyWE35P6IsXTkt3CHRKcw
         L6d/lGdHY5APNXYzl048L4v7VjtF2KpgzRQwt0yIv70P12j/VpdfLtsTrMAK+VqH1yCI
         QBAB2p3E7d4I/1OYHetRPqgcrRrID1POtWkCvnNwnSOnAJKfr9FyRgGdcEhEOIoZFSBW
         /2ukft/5XB7tkhWi5R7ToB5Q54QtaZqU80QrEKbyvsTItDKkXl3HbrwryBHvcayJxZgY
         vbSzg8VzneA0g95IcGaiZTdg8rTf3MvIJjkZcLLw/62eQlHlmei4aU9UACQOJ/aSh971
         RfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x99pYwa1dnOzvMHARyvq3wdM6wF3B15xvFgvTOgiQu8=;
        b=W1md7mcZ3cvWtPIrLOpIKFsGiv5OkOmtZha4ecR6iIz4IU2qdpAt0/5w3exvghTgUz
         LsvjWaZiJAsGBk5hF7phYeMxXxgF5o369XG4rmzTWUL4LLe5zbP0CxJeBsGlzgOnsBrz
         VwV27J5TPkClDLUvgg9OtbycZK0mj/WbtRrZq7gcS3he2NkBeDGpq3OpIgsFQy35NpdQ
         NC20kLvg99lyPCU4wby8CqtUta2ER11lU5qTIgevi8zAaIJ6igOqrWJflnjtwFdYxugq
         +poQWQn8JfacqJibQmi5oi5BSY0dTmpqktFXetR7GAm6DqGcDwqvCKYNKDHqc1wVxkRs
         c50w==
X-Gm-Message-State: AOAM530/gObcaSUbKLV8QzevrXuNQGhlng51PYc62gOwSKb+HLC4Spnz
        t2NYFxdRLyF9CXBnnTIcVSM9paCEDf+yYbzmJjI=
X-Google-Smtp-Source: ABdhPJzTfCb2U1e8nQgyWrE1u/wEZVkPKLluhndGJCrScd8Q+8irkUc7rvtTbu1dXLAuNwS0lxI2YsHNSSavOLFQ4S8=
X-Received: by 2002:a92:da0b:: with SMTP id z11mr19094462ilm.149.1592875995226;
 Mon, 22 Jun 2020 18:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200619050619.266888-1-leobras.c@gmail.com> <20200619050619.266888-4-leobras.c@gmail.com>
 <51201582-efe5-85df-7e65-a998e91ab63f@ozlabs.ru> <ccf7b591f2bf61ba4705699b2e2b050c3cf48d99.camel@gmail.com>
 <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
In-Reply-To: <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 23 Jun 2020 11:33:03 +1000
Message-ID: <CAOSf1CEC-tYH1so5b4P7dQ7s8v1o4qy_u5CG7LKtKNnRQvC4-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] powerpc/pseries/iommu: Move window-removing part of
 remove_ddw into remove_dma_window
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:12 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> On 23/06/2020 04:59, Leonardo Bras wrote:
> >
> >> Also, despite this particular file, the "pdn" name is usually used for
> >> struct pci_dn (not device_node), let's keep it that way.
> >
> > Sure, I got confused for some time about this, as we have:
> > static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn).
> > but on *_ddw() we have "struct pci_dn *pdn".
>
> True again, not the cleanest style here.
>
>
> > I will also add a patch that renames those 'struct device_node *pdn' to
> > something like 'struct device_node *parent_dn'.

I usually go with "np" or "node". In this case I'd use "parent_np" or
just "parent." As you said pci_dn conventionally uses pdn so that
should be avoided if at all possible. There's some places that just
use "dn" for device_node, but I don't think that's something we should
encourage due to how similar it is to pdn.

> I would not go that far, we (well, Oliver) are getting rid of many
> occurrences of pci_dn and Oliver may have a stronger opinion here.

I'm trying to remove the use of pci_dn from non-RTAS platforms which
doesn't apply to pseries. For RTAS platforms having pci_dn sort of
makes sense since it's used to cache data from the device_node and
having it saves you from needing to parse and validate the DT at
runtime since we're supposed to be relying on the FW provided settings
in the DT. I want to get rid of it on PowerNV because it's become a
dumping ground for random bits and pieces of platform specific data.
It's confusing at best and IMO it duplicates a lot of what's already
available in the per-PHB structures which the platform specific stuff
should actually be looking at.

Oliver
