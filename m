Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78441207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok8D520l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESI0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgESI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:26:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:26:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z80so13875293qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhMQZWg1pZCDpzS4WQU/mgYpG86rpDRUHsX26JcW/Z8=;
        b=ok8D520lGjncFUrVo4zv1FrWZHZZgrDX/6hRgaeN4veYDko1YMNM1UQY9yR3VD+LMT
         5uOEiAwJVW64jbUPhEEqh7Z0QXzscIV87PbBJDXlaoQyh9ZQI5kKaVnovgGgXo7tbyHZ
         ZtQVXaRKDAzAvVha21YdN4+KRxbEbKcoAEBmH6qyaHCvrmpN5An8lwemtjt+H4xyvoly
         pQ31NEQ5MLSQ2Zg9FhPmsvXF9IacgJkAF4Qs9lvC9FuKvEBB/VSQH3rGsXUBGRSSVwZh
         Ai53LR7qevoaOgZpaN2bcMboXpjHQYZ5N/m442SUNPVkP0V8GgMGcmvYFitpdSD7DRnI
         0/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhMQZWg1pZCDpzS4WQU/mgYpG86rpDRUHsX26JcW/Z8=;
        b=huwX5nynzeMDLTJF1AkG82lPN93eRRUI+kSNJa/F6VQpEN9xLwYjNeisDI6UogarpD
         4z9kRKCVooxyIWof+3zUX32m49AcKxsGJhT51crZO0UGDtep1F+wtdXl2374U7p4Eo3U
         qKPYbxd69rE4E4VO1frl+TN3LS1AO47n/E4Q7eOAwd9O1QUM7R6m5TB3OR/bdrZF4qoe
         P0TmpBa2j72M/B1jhBfRLYY4zJv+HrzPBvGlLmLRsRv5an6R+VSMJReZtr7MGeFGj9ez
         AuSnjNFoJv2lfotqsqwOMJl1+yKdTj4FZT4cAr8HqtQSJP9IfBmZ7cgYuY6fVScph8fI
         K6Bg==
X-Gm-Message-State: AOAM532s7g3EkiMM7xqtc00/lFqEErXmA6psbANGs2lF6ZR4ASDH8uvW
        n8JJ3A6FHRfYbJDh9VbrqxPzWprfAOE2S/siryMwcQ==
X-Google-Smtp-Source: ABdhPJzPCaVyZbcye/H+Kda8o2N2ulYqcfk5cLzzJIhka2wdjBSqmYfJdxc5tg5VWkzQo9xCyqKVqomGY/QYy+lJtf0=
X-Received: by 2002:a37:7105:: with SMTP id m5mr20541969qkc.370.1589876812015;
 Tue, 19 May 2020 01:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200502204137.37134-1-kdasu.kdev@gmail.com> <f0e781e6-a7ac-37be-13c3-885eb65a0921@gmail.com>
In-Reply-To: <f0e781e6-a7ac-37be-13c3-885eb65a0921@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 19 May 2020 10:26:41 +0200
Message-ID: <CAFLxGvzFHzcMnWx35mzvMrj=Y1CxGDAb+3YXNbYCOnyMDEXc2A@mail.gmail.com>
Subject: Re: [Patch] mtd:rawnand: brcmnand: Fix PM resume crash
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 10:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 5/2/2020 1:41 PM, Kamal Dasu wrote:
> > This change fixes crash observed on PM resume. This bug
> > was introduced in the change made for flash-edu support.
> >
> > Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> --
> Florian

Applied for fixes, thanks!

-- 
Thanks,
//richard
