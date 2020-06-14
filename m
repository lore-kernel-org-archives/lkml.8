Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CE22074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592099505;
	bh=UCvSiNcEAKjYHvmz+PZxQfeg/fZ5f8WKDZv8Y+h7Gyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xYB3P/jskSazrkNETvybrIxU6qXHAZYPlDocjIh49t8gg9xhDrvM17bfD8WJ2h/E9
	 wjzmgjY7TN+vHf9Ui5zYrXIUceFPF1kyJJZdg4QGFSpZ8KzEy/8tRe+h7Yl5DHQPaX
	 /iBN58NFIfyvHBuC5GQmGyG1nI3awmBvcSyQaMDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFNBv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:51:29 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26397 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgFNBv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:51:29 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 05E1ooW0015134;
        Sun, 14 Jun 2020 10:50:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 05E1ooW0015134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592099451;
        bh=GQBXDHKG3+vS9ypmfRF2QbuQ9g5OR8ACUKa6sOMPEhA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MUiKpod+J8GKQ9Vhby2Bp/R34t5PGJ2UT1rchgyOwLAkFL/cn6hczn3ijPguE+WZ3
         mvL/2u1YMpn82m2a9gxHD74bFTtN0skWsJuSb0WTE5C+LGT2caVvuHuU7pZ9UmAMvA
         yg/JX5g3oilrmZuaGHZFQHg1m3wwdJMYs2PQuwWa7Cj84EOa4l6lREKtic73NJoyaZ
         UEI7YPV6YHCumqd69mDdXDhl+WRAwdQZIfF7tU+nOjX+JzvRB1CS8ZrrJ+bpPX7CPx
         nV1DEwQbgGEMalggLZ6dbU365tTh5PMxrnlDq1m7XAqz0LMifU+PvARrnv1auRKDSs
         MpoaoSwH7EBBA==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id r1so4501089uam.6;
        Sat, 13 Jun 2020 18:50:51 -0700 (PDT)
X-Gm-Message-State: AOAM533uumdH1unKovZLxF8/4g0dXKl2xfdWsibAU2KaUStHlc0p5syx
        Z+AzbeELdXrO9KGJhLSjv5WLg7oR6FbwjHG+QZg=
X-Google-Smtp-Source: ABdhPJzDZICKzSOdJGg5+sZdTV3oSuKdI+CB+jQCnfg0ayk9ISuG0RRMYEh7pwsjcC0snS22F9GMPYJ0TMuNooi+pz0=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr15381305uae.121.1592099450258;
 Sat, 13 Jun 2020 18:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
 <CAHk-=wh7vRkvFTFFQ_TQioLmoK-HWoHMAZ65J3N9jhTHVk5ATA@mail.gmail.com>
In-Reply-To: <CAHk-=wh7vRkvFTFFQ_TQioLmoK-HWoHMAZ65J3N9jhTHVk5ATA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 14 Jun 2020 10:50:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASpHO0SiaciFMJ46yZsix7yPn=E5+k8fqBaXHpayR=wxg@mail.gmail.com>
Message-ID: <CAK7LNASpHO0SiaciFMJ46yZsix7yPn=E5+k8fqBaXHpayR=wxg@mail.gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Jun 14, 2020 at 5:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jun 13, 2020 at 10:56 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> >  - fix build rules in binderfs sample
>
> .. oh, and now that this builds, it also made it obvious that the
> .gitignore file was missing.
>
>           Linus


Thank you for the fixes!


-- 
Best Regards
Masahiro Yamada
