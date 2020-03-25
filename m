Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB466C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71F920714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585131748;
	bh=0jc2gQJlyp6t7qnzvKEUEHdB24QoBYSDB2QoCfzXjVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nZHlzWv+Nehl1ZNeBH89rOsttAp1at7UAwd4cYR9kYFdqSNcOWFPjnRO4txAsaTc1
	 vtraZ7gEylwdoFe9oCufoeuPiwoHta5+QyxP+pgzaMdZI65aH5V63viSGqwO9COZMC
	 B9CZZGvfIPnD8/gAuKNMRNofRnX5KzrdHPRmO8Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCYKW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:22:27 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62524 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCYKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:22:27 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 02PAMGQx028925;
        Wed, 25 Mar 2020 19:22:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 02PAMGQx028925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585131736;
        bh=oKV4gkaGjA8JUJ0R19IwiELg1IvohIMnv7gyVQFEv8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xy87udG48Uqlz1ouCY/JCBjnyVTjON2Ra05VsF8gkizOyqx0vrwUGOGoRgk2y6yoT
         f34+RcZiuNNxC5QmSTgpDaDcBNWtBQkovq0517Mdih8WzMOgVieUR6gj70vsl6OYBr
         2L5EVf26gs/5mI/Ed7r8n3kN6PKk9EhXs0KYXBTupldY/0tyh5J3VGUdoOOM24ssN4
         yKRkA6eUh+MkNXLv7cDbhdAuI9RybZk+vr4j6Ml05L6ZdNZ0IkBnXVc387egPpRrxq
         BB1juIwc6LBW9dLVjfon00pdN0+GBvV4nhJhnJ7syoaZNP0Mh2sm7zlULME2j/+zlR
         QhwDcZcR4QF8w==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id o16so523878uap.6;
        Wed, 25 Mar 2020 03:22:16 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1NHx6ju7XiN0slUernAEhDOuTEU9uJvv0PYUq3PpQem48L9F+M
        lXv0/BqdQC9Uxjzz/IAGLTt6KpAGtS+93K/Igb4=
X-Google-Smtp-Source: ADFU+vulOrH4nh/j/MQxVkE4DfCZT//dWVxt1fewODMBiEhlfJUPE3Cgci+RGQ7TVq1ud7qHRP44QHrIEw5As28k7VY=
X-Received: by 2002:ab0:28d8:: with SMTP id g24mr1599988uaq.121.1585131735496;
 Wed, 25 Mar 2020 03:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200303133600.9263-1-masahiroy@kernel.org> <20200303133600.9263-2-masahiroy@kernel.org>
 <CAK7LNARZUpDKXpniNZ+_=G5Gskebc0HEHT5TKbaz2Xs_Ni6u4g@mail.gmail.com> <20200325101838.GA3084128@kroah.com>
In-Reply-To: <20200325101838.GA3084128@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Mar 2020 19:21:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtxwXzmHXr6GMm_BrEvittoUHJkrROVFX02if5BTCgGw@mail.gmail.com>
Message-ID: <CAK7LNAQtxwXzmHXr6GMm_BrEvittoUHJkrROVFX02if5BTCgGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] .gitignore: add SPDX License Identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 7:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 25, 2020 at 07:10:03PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 3, 2020 at 10:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Add SPDX License Identifier to all .gitignore files.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> >
> > Ping?
>
> Ah, I just assumed you would take these through your tree, sorry about
> that.
>
> Both look find:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Or do you want me to take these?
>

Yes.
That is why I sent this to linux-spdx ML,
which seems a valid path.


-- 
Best Regards
Masahiro Yamada
