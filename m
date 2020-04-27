Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048CC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5C720656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iclky+Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgD0Pir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727115AbgD0Piq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:38:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF5C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:38:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y26so9423484ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iTidgto46X3PBcLh/NZ3p3EEGIHyStvrrt3xBRoiKAg=;
        b=iclky+Goj+8nLqDIQ9Ej9kG/1gbh8zknNJ9GmTUliHSJgJ5stv396dgtpB+rMqC4zZ
         OJfs7amekuelbG/oMXztZT8Jl6YV6bWv+mrJhxijOTC9XjkyjtUG6tsZ6jNrrAZnzUyL
         kDZUtOqhR8D/Mmk8lgh8NT/SIzQAXbeTjoivRgkBvquFc9wLYLShf8hjK+xoY0zXQppB
         AryBNHQYJQrkFZw7tjNeXM2axUnxnbWiynSNZD32Rerl7FAyQWShoVYUEITchlW797t8
         BKb+6Mx4czi/BhJZ9+jnreBdBys0CUobKXhPasjgVZU46bC53QaabmEX06VkKfPk5M4q
         NB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iTidgto46X3PBcLh/NZ3p3EEGIHyStvrrt3xBRoiKAg=;
        b=KBhiGpQIkHFS8hQFzhNdU8SDlbo4h+BMpjQSF6WGzgfC7xJENglH6jYPGjfSfbaDp3
         rl1p1tU4tsPNnZzDznfHFkufipfeZb234QQpt6MrfdZnYWBkW74R9LfThLrge5Dbm5hr
         rd/eUnVZbc4y3dL8kGMWVgnRNo2FflCRENLaTuDMr5aZAvMcA/JwKvNGsfuDOaNjC2vE
         NhzI3SAkkmR7YPCRbArJ9uKblBrdi7XYt9+dsxlBB9fBOQI6qxxKvWFUqddqaqRmSvIq
         iRLIg5I6GcnrkfAx+Ev49Mq6Iwmtph+bYzgMGdHK60Nyp9JzxL6xlR1spnBOB0xYPvSZ
         KVKw==
X-Gm-Message-State: AGi0PubS6/tkMy4zyefJqXVCyUg3EuoZMd0Z0KCTx2TyoyAvvHxitAdt
        l5xYOmEz2UOeIraFpsQQCCHjnzKrGxy8LRNWzSA=
X-Google-Smtp-Source: APiQypK2OeOQ1R0yIPyYwvW+TSu4zZdULykTH/FcCZ3v/uXwLwvDPknpzq77avRB2FvKMNHPW7arFhiGUwk804z30mM=
X-Received: by 2002:a02:8666:: with SMTP id e93mr21477338jai.0.1588001925361;
 Mon, 27 Apr 2020 08:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200417101129.35556-1-yuehaibing@huawei.com> <CAC=U0a2VfQBmHdS4eL0Fbm==aVCS0FWoBnZi7tRHzNKmm=SDVQ@mail.gmail.com>
 <20200427164336.5df4650a@xps13>
In-Reply-To: <20200427164336.5df4650a@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 27 Apr 2020 11:38:34 -0400
Message-ID: <CAC=U0a1zWmKFVJVfYLJOnwcB_voqFqWFZJCZxo78Zby=PbhAiA@mail.gmail.com>
Subject: Re: [PATCH -next] mtd: rawnand: brcmnand: Remove unused including <linux/version.h>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "R, Vignesh" <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:43 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 17 Apr 2020 14:40:51
> -0400:
>
> > On Fri, Apr 17, 2020 at 6:12 AM YueHaibing <yuehaibing@huawei.com> wrot=
e:
> > >
> > > Remove including <linux/version.h> that don't need it.
> > >
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> Can I suppose you meant "Reviewed-by" ?
>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

>
> Thanks,
> Miqu=C3=A8l
