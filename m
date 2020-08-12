Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D0BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB21D20829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249431;
	bh=zzcEfPpXUWOTed4d4mVex3qbxr2uA7ufM9PH/cbPyPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hj+yx37NNMhnUEzhYFn5J/Ny+ylLqLxp5agi+AIJqNcb+16zlwJv5AekUQeeK6tyD
	 lQe12dxue/kn20PBfiWnDmuKQ6hnX31v6xeNL7vWCXNaBHNBH4u7vQxt3P+XPzSjS+
	 jqZ90MVVzKuXImBvYQG2E1YXSFyVVresgQClBXUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHLQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:23:48 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7680320829;
        Wed, 12 Aug 2020 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249427;
        bh=zzcEfPpXUWOTed4d4mVex3qbxr2uA7ufM9PH/cbPyPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WeCmyNTgy0TGvHq/qQlJxRtZEnj8sbyEqLNaDci74QZquNc3CBXTLr6g1voNvdHzg
         FtXaeOzA0/ixiK/Kvt26h9w7UTU5JFXuZjoJmUUuIGsGsjkFA5+nA9pKttXk/7Efcm
         49IMksgtLpTGcKBi75JjzIH/BOFRdCdjhrMTYXdk=
Received: by mail-ot1-f51.google.com with SMTP id q9so2406294oth.5;
        Wed, 12 Aug 2020 09:23:47 -0700 (PDT)
X-Gm-Message-State: AOAM531fY2OuH1y+dRfz5qKkFDYY+JNlFOsDsq0gPjHgzqMN0gQQxchW
        ZAxxG4rNOItv6FIGilwyZUFvd0BtLRWsM9xmGg==
X-Google-Smtp-Source: ABdhPJxXiUQctFJVCMzLRHDqibNx+2QHTNK4UA2TdS4gzGCX7J/pDzx6ZUBFe0INnhM8BWwZ64T5nMHz4daqTy56PTY=
X-Received: by 2002:a05:6830:1d8e:: with SMTP id y14mr429275oti.129.1597249426769;
 Wed, 12 Aug 2020 09:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200810140615.6113-1-colin.king@canonical.com> <812ec088-999d-3b95-4ce6-c84cf3565ea0@canonical.com>
In-Reply-To: <812ec088-999d-3b95-4ce6-c84cf3565ea0@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Aug 2020 10:23:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiyStFwPOKKVvkekzt1tUcek3_r39Rxt4OUCx+=r_t-w@mail.gmail.com>
Message-ID: <CAL_JsqKiyStFwPOKKVvkekzt1tUcek3_r39Rxt4OUCx+=r_t-w@mail.gmail.com>
Subject: Re: [PATCH] of/address: check for invalid range.cpu_addr
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 1:32 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 10/08/2020 15:06, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently invalid CPU addresses are not being sanity checked resulting in
> > SATA setup failure on a SynQuacer SC2A11 development machine. The original
> > check was removed by and earlier commit, so add a sanity check back in
> > to avoid this regression.
> >
> > Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/of/address.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 590493e04b01..764c8b94ec35 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -985,6 +985,11 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
> >                       /* Don't error out as we'd break some existing DTs */
> >                       continue;
> >               }
> > +             if (range.cpu_addr == OF_BAD_ADDR) {
> > +                     pr_warn("Translation of DMA address (%llx) to CPU address failed on node (%pOF)\n",

The original was pr_err, and this is an error which shouldn't happen.

> > +                             range.cpu_addr, node);

text says DMA addr, but this is the CPU addr.

> > +                     continue;
> > +             }
> >               dma_offset = range.cpu_addr - range.bus_addr;
> >
> >               /* Take lower and upper limits */
> >
>
> Hi there, any follow up on this fix? (reviews. etc?)

It's been 2 days and it's the middle of the merge window...

Also, is the DT in question upstream and fixed?

Rob
