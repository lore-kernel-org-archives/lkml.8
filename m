Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8836E2064C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PpRZ5bzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgFFApX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgFFApX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:45:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8EC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 17:45:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49f1566Qpzz9sSc;
        Sat,  6 Jun 2020 10:45:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591404320;
        bh=IaU5svNPQHhne20TEVlRZ0Kl72R9wx14Smw0PSgLfqw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PpRZ5bzYtwIKvGBjTsE7uAgTTrKf58mi2pjY4JzXmNwpk062tb0AdkqDy4/SvuLyM
         7pUvSDSiEw0bJQwnSXcKitUASlKYBKt9o0WseERFR8HMlCPyASqDOEzCvzczeqyjWw
         JpGj8nEf+7EG02SGd8auYupz7qxKQMGdhOgkSIRNsp7KGg2NpWN36py1I1geCAuxce
         ee3s3G5NfaHuMBqbrn48ApQism1lFWVgryRfFyOUSN2n4NYysIxZ/8QVKVwJaYe44S
         nj3oN2p7KiG9iJhxMW7zR2/LOvR3hu+Ywcfn8kzsHyfZdxrfArZH0EI0Gqcj/BAFyw
         QIHwQdTvjAkWw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Oliver O'Halloran <oohall@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        rzinsly@linux.ibm.com, sbobroff@linux.ibm.com,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, st5pub@yandex.ru,
        Takashi Iwai <tiwai@suse.de>, wangxiongfeng2@huawei.com,
        wsa@kernel.org
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-1 tag
In-Reply-To: <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
References: <87eeqth3hi.fsf@mpe.ellerman.id.au> <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
Date:   Sat, 06 Jun 2020 10:45:37 +1000
Message-ID: <87a71hggy6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Jun 5, 2020 at 9:38 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> I've pushed the result of my resolution of the conflicts to the powerpc/merge
>> branch, if you want to look at that, though I've also tried to describe it in
>> full below.
>
> I ended up doing the machine_check_exception() differently, because I
> felt the code itself was done wrong and I wanted to add a note about
> that.
>
> Having the same function have completely different semantics depending
> on a platform issue is just fundamentally wrong, and makes not just
> for fragile code, but also means that you can't do single image
> kernels.

Yeah I agree it's not that nicely structured.

In this case CONFIG_PPC_BOOK3S_64 is one of our top-level compile time
switches anyway, so the single image thing at least isn't a concern.

> It should be two different functions, possibly just
>
>    non_nmi_fn() { ... }
>
>    nmi_fn() { nmi_enter(); non_nmi_fn(); nmi_exit(); }
>
> and now you don't have odd rules for the same function that depends on
> how the platform happens to call it.

Agreed.

> I didn't do the above. I did something that looked like the old code,
> but had a comment. Oh well.

Thanks, we can restructure it later.

> But thanks for describing the merge, I'd have missed the place where
> there was a new use of pgd_oiffset().

Yeah I missed it to begin with :}

> ..and then when I actually compared whether I otherwise got the same
> result as you, I realized that this all depends on the module tree.
>
> I'll go merge that first, and then re-do this all. Oh well.

Darn it. I figured you'd have merged that by the time you saw my pull,
will mention anything similar in future.

cheers
