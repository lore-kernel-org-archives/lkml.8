Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D03C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72E22073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598891047;
	bh=vsrdDuWYzlRAyai5kNV5vEX7NWYYL7zK60ylR2mxyOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ErgI2nmxC3pwzkh0lnC8qq7NBXrs+bXVNVeqCBcfZRRo2whQ3X398qHLp6OhA8mSB
	 JtBFmvgMLzm0n2/JlQe/UKSm+OuFdoyrNBYxvjLRxDVBI7m9LStEROSq160i20yJMo
	 sAbasVq8kqkqUFC7O/mqM1BApWsMID57io9FQ7sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgHaQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:24:04 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56248 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgHaQYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:24:00 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 07VGNZZ7016778;
        Tue, 1 Sep 2020 01:23:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 07VGNZZ7016778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598891016;
        bh=uUcsyqZDKAQ6xGbI3RAQBs3fS7e2bNwrk6S95QtzhpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pcUpnayMvhkZgjUY+8ns0sdwk5LzDTxIupwE5AnHDdWggN2PYDWp8ENti7+GtAKAP
         WAEv0mnB0itqwmcwlvushikAWIre1fw1gBDOT6HLwK60PvvvRG83RajMuAUxY6Q89W
         ppYnB9y95U95bPwWNilHW329Ib60I2M6nmbGII+5Mv8qkVu62rHCAYtezdwTlN1gHh
         J+XTD4XZNr602qdQrd47ZOOSZQLwkiI2vwofL6FGft7QbwO8x2eadEFLK99+p6ivPr
         CWjR+KOVt22JK78Zi9Lzi+pcK1CaXFBvOOPhx8vC6TRIqhj7zs/jeyds3QQUmtb4nz
         GUM0qPAFxc0Wg==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id ds1so59323pjb.1;
        Mon, 31 Aug 2020 09:23:36 -0700 (PDT)
X-Gm-Message-State: AOAM533rRduCb3QYvYq4+lTHJ6o5KGBOABuECPvZE/Ow+H3zD+sLxO0t
        ssV19IoAolkLp90ozBQK5dn1QoA8LJ1r/akKzCU=
X-Google-Smtp-Source: ABdhPJw/wW+HoPpD1Y0aNq5rforujMD07F9426DN8VgFqb0A2SlEH66iKtvZ23FwJAjy1Hnb08J7huAkQXXvNWjQljk=
X-Received: by 2002:a17:902:ee0b:: with SMTP id z11mr1573839plb.268.1598891015159;
 Mon, 31 Aug 2020 09:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <21eddfa7-2b7c-00c4-ad5b-40878036f987@infradead.org> <f7ce291e-47be-549b-7163-0744e7ea35d5@xilinx.com>
In-Reply-To: <f7ce291e-47be-549b-7163-0744e7ea35d5@xilinx.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Sep 2020 01:22:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfGY_o25mfB-QyQ5ezQW00OMPpbsN+be8LF_mojX39yA@mail.gmail.com>
Message-ID: <CAK7LNARfGY_o25mfB-QyQ5ezQW00OMPpbsN+be8LF_mojX39yA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: fix kbuild redundant file warning
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:01 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi,
>
> On 28. 08. 20 20:35, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix build warning since this file is already listed in
> > include/asm-generic/Kbuild.
> >
> > ../scripts/Makefile.asm-generic:25: redundant generic-y found in arch/microblaze/include/asm/Kbuild: hw_irq.h
> >
> > Fixes: 7e8f54cd4e26 ("microblaze: Remove empty headers")
>
> The patch is fine but this commit is wrong one. At that time
> asm-generic/Kbuild didn't contain hw_irq.h as mandatory
>
> The commit 630f289b7114c0e68519cbd634e2b7ec804ca8c5 added it.
>
> Masahiro: Can you please check?
>
> Thanks,
> Michal



Michal, you are right.

$ git merge-base 7e8f54cd  630f289
7e8f54cd4e2628fada942fe9ba1fc46e99e94218


630f289 has 7e8f54cd
as an ancestor.


You did not do anything wrong.
Me neither.
Both sides submitted correct patches.


One unfortunate thing occurred
when 630f289 got in via akpm tree.

Andrew Morton manages patches by
quilt instead of git.

He rebases patches before sending them to
Linus in the MW, but does not check the
rebased result.


You can replace the tag with:

Fixes: 630f289b7114 ("asm-generic: make more kernel-space headers mandatory")


-- 
Best Regards
Masahiro Yamada
