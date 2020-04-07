Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFC20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586274024;
	bh=PoSRM/NhkeRJ7pWoOItOCa4dBTdhw1s+cVGl+zg5S9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1RgTJ6dJ+umZmlO2lk+yYPmXlplzpwYtlVZrTTH3uZgyuaqJPT8edORXwDqj6sVHt
	 gqWyRWbvrz+sIXKAjFV98kM2IoY9HpNw8/6NRDiP8fA+lScetkQoAdaRj8GD1/NvAq
	 QqI/2qNgdyx9GmEXbNM2DhrXOqGPwT2YvDmtVJxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgDGPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:40:23 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:23941 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:40:22 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 037FeBsd030256;
        Wed, 8 Apr 2020 00:40:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 037FeBsd030256
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586274011;
        bh=XWjmG9EhuXnHJLGvG7qDJWptwWxm9QG76mUZi49RDfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OmOhA7FAZ+LP41dQDnZjEPtaWM8GH9eUtyp/1zMLhDI6BHGrG1mvtVli1vb6CK6to
         AFd/0Kibr3MiIqyhdx7iRiqs0Wc8vWsURPrtd7Cy1RPG20AFO/PNJxFHm5uBGaQ0Jn
         CVfJFzItnwQYAhIP3EWSFPRcc2+3K3oRDejai6reLV2nRPv5KcUYoVOGUoRcuuTcW9
         kFwuSsgDchWHW5gON59lPr7o6P6+fDz03LvlEAR8B0FAISlZdhTzmqanB0Wdb1eEmU
         N0EyftTIbbH+SVPSpBXo3TPCALyeBB0WWegAUsSnBfsinDG1u0OHNsf115F69TIdSe
         WlYpYE+nzgNsQ==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id s10so2451772vsi.9;
        Tue, 07 Apr 2020 08:40:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuYWeXxOG14Sh/Ni6fLssa5b5Tv3cnbdz+b1aFr2R78B7LR/kotW
        BUZzzXh108ozrKceiUtWK4LCILrEGcC//iW0K1w=
X-Google-Smtp-Source: APiQypKKQfcetnSEY7d8Ni6kfJjTmtw1TOAqIWS1GFW0Ea7aW6xiARHqdFdzIcHMCeOSZ8pMfwTyotZF7dXLoLb/VTw=
X-Received: by 2002:a67:33cb:: with SMTP id z194mr2415038vsz.155.1586274010321;
 Tue, 07 Apr 2020 08:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200403090224.24045-1-masahiroy@kernel.org> <20200406180558.GA22412@dev.jcline.org>
In-Reply-To: <20200406180558.GA22412@dev.jcline.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 8 Apr 2020 00:39:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASn8z4SF9YeyidjYDmA+1MMV9VArem=Scui51LaB3Q1wg@mail.gmail.com>
Message-ID: <CAK7LNASn8z4SF9YeyidjYDmA+1MMV9VArem=Scui51LaB3Q1wg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add dummy toolchains to enable all cc-option etc.
 in Kconfig
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 3:06 AM Jeremy Cline <jcline@redhat.com> wrote:

> > diff --git a/scripts/dummy-tools/ld b/scripts/dummy-tools/ld
> > new file mode 100755
> > index 000000000000..3bc56ae4cc15
> > --- /dev/null
> > +++ b/scripts/dummy-tools/ld
> > @@ -0,0 +1,4 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +# Dummy script that always succeeds
>
> It looks like scripts/Kbuild.include expects "$(LD) --version" to return
> something. If it doesn't "ld-ifversion" stops working.


Actually, scripts/Kbuild.include is not used in the Kconfig stage.
So, scripts/dummy-tools/ld does not need to handle --version or -v,
but we may do that in the future.

I will support it in v2.


> Other than that it seems to work as advertised. Thanks!
>
> - Jeremy
>


-- 
Best Regards
Masahiro Yamada
