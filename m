Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABEF2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591384120;
	bh=GKgLU0QJgVb/nit0HFyZ0nJAXwQ7rg3k/4fnMy5jDLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ykuRP6G/B36PLcKReIEL+/VH+hHCesreLPLPhveMkcEoWHM2ZH/Hy7ilgXS031pgb
	 kpchIIdt35Ey2jgfdOk0rlozKquTVHV7ZIBfW/H4mNH3vMp/oU5U859Nem7KBYquf+
	 7eJAiGpK38GF1yPWc5ABir6g5qajsxYM0qFzG2t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgFETIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgFETIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:08:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97251C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 12:08:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so6410968lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcezGontWez8pNBdgQEac8VyYkNUk3H4r/f/qgUnO2g=;
        b=bVtxxK21u8dFZ9y31drF87QSfC9BKTKsr0QMyL11UqoPm2rvFF7BO1to+YkhbH9K8w
         FAPjZj+mG/ocCBLoRw2vDGFIpRTeL5h7SNors+NuUGyYuGvDUO6BWjXJVACFmpJqoK0t
         HOXqsiJN6v4QGn38rZPSZWveRUy/PbCeGcbzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcezGontWez8pNBdgQEac8VyYkNUk3H4r/f/qgUnO2g=;
        b=j7d2022jNjPP5qNCx+mfv2NKMmKYGo+rhWlzszK/ZXPiHWZ3RTC5IMRBV7eC9NplW3
         3rAwolFpGTXOwo8I/m6JGu7cnpo3MCOoJ+dT9r1NZdg2GrD5BlYJfAf+39+Sog3qDya0
         jK1P1iLiZOO+FdfVFdzOBk3y0c3/Qt7KgGsMc5H8CKHZT4WfBLQWZHj4fAE/bD0Tu1e+
         tI1FDcePnZ4TgBnXZIJiKa15mBU/RThbpi2Cedz/S9rsnjRpYtrrEMnBmXPpiSZ9JOTX
         +fs2ARBNup/tBOnwtZa1gMuV99sPmN1jzRhvYMauB7lDHxWBtrJL6rsrsC+8i3cpTCLb
         b8xg==
X-Gm-Message-State: AOAM531D0p9fuE7RxpG6r20rRL5MOFjOqyrOQ3H6ISkU3iFMRRKS9bkE
        c3veWv1u6p6+Ay0viM5YYSmLec6f6qs=
X-Google-Smtp-Source: ABdhPJyUnTzm359V12LBsSh8bVGmQyU8LnO+LtkMcsb1TngRcDZrSnkbTqx4L6IA53vTs2gehtZwMQ==
X-Received: by 2002:ac2:48a3:: with SMTP id u3mr6155299lfg.115.1591384116608;
        Fri, 05 Jun 2020 12:08:36 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 205sm1297825lfe.73.2020.06.05.12.08.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 12:08:36 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y11so11397498ljm.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:08:36 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr5235749ljo.371.1591383681430;
 Fri, 05 Jun 2020 12:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <87eeqth3hi.fsf@mpe.ellerman.id.au>
In-Reply-To: <87eeqth3hi.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 12:01:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
Message-ID: <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ajd@linux.ibm.com,
        alistair@popple.id.au,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        chenzhou10@huawei.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        christophe.leroy@csgroup.eu, clg@kaod.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        ego@linux.vnet.ibm.com,
        Markus Elfring <elfring@users.sourceforge.net>,
        emmanuel.nicolet@gmail.com, fbarrat@linux.ibm.com,
        geoff@infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        haren@linux.ibm.com, hbathini@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, huhai@tj.kylinos.cn,
        jniethe5@gmail.com, kernelfans@gmail.com, kjain@linux.ibm.com,
        leobras.c@gmail.com, leonardo@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linuxram@us.ibm.com, mahesh@linux.ibm.com, michal.simek@xilinx.com,
        mikey@neuling.org, Nathan Chancellor <natechancellor@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        rzinsly@linux.ibm.com, sbobroff@linux.ibm.com,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, st5pub@yandex.ru,
        Takashi Iwai <tiwai@suse.de>, wangxiongfeng2@huawei.com,
        wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 9:38 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> I've pushed the result of my resolution of the conflicts to the powerpc/merge
> branch, if you want to look at that, though I've also tried to describe it in
> full below.

I ended up doing the machine_check_exception() differently, because I
felt the code itself was done wrong and I wanted to add a note about
that.

Having the same function have completely different semantics depending
on a platform issue is just fundamentally wrong, and makes not just
for fragile code, but also means that you can't do single image
kernels.

It should be two different functions, possibly just

   non_nmi_fn() { ... }

   nmi_fn() { nmi_enter(); non_nmi_fn(); nmi_exit(); }

and now you don't have odd rules for the same function that depends on
how the platform happens to call it.

I didn't do the above. I did something that looked like the old code,
but had a comment. Oh well.

But thanks for describing the merge, I'd have missed the place where
there was a new use of pgd_oiffset().

..and then when I actually compared whether I otherwise got the same
result as you, I realized that this all depends on the module tree.

I'll go merge that first, and then re-do this all. Oh well.

               Linus
