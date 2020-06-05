Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0609206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591389901;
	bh=TYl5YgK/h2Cs8+s/i7jiLlIpC2Dm/i+JEoKC+kV/IKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=urAcVhQaLPKpmRlfGL/AtBTNTWrvoeSeCOOHpSX1Ptr1szPLjjuVZLt3Vry3pTS67
	 mRPzZZAcJU42bnml9XaJpuIt9aWiI5xteGEWAUMBHCsRCPA8yIsJIZ9y27aFpgLHl+
	 i/iCnDZgIbpKVZYu4sAudkygKo9m56dB0gCjXu8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgFEUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgFEUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:44:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17ABC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:44:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x93so8440488ede.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qMV9KxwdmsZX+Eg7b8uIKpKh+L6ERIeG0MgUjSlWGY=;
        b=dADgwH7HLX3Ef50nfWyXB0qJfBAkA4toklDET3r14dvzwUvOOHWJPSPxqvIAj8Hnqz
         uAo/tEBpNiuHuvb7vCyFfELFzlsPN7GC2kh35ivVAaWd4qFpAcUGYcwhiMkU/id7MW/n
         UEzobQLweBKm1LElBmSjOoiSVbWI/e7jjz2WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qMV9KxwdmsZX+Eg7b8uIKpKh+L6ERIeG0MgUjSlWGY=;
        b=Upi9UHS6BCEZ8F5K0TtUzu/K3aEpYg9QjJ5Wfw5HIXvFMDcFdQ1rN8ylxqZxx3Zw7E
         D4meRKAtHDwIdAQbFCeHOJEq2DFFDDw3XZ7HLjhMApGHECqpLchUmu4AZi8Z1kVGR6kN
         6/ycdf1wVF02K35XuvgDkEaTojXcoQ6fw76T5Wlk9mgwqAUqHkUZlAuu41p+Bf8R34OT
         8WEWj8p2iuhKsZTXpT+d4/mVSzou46ZqqlrpgoHNNlNps5bZaDdJf5uLHstsleHaK6y2
         Lwvv4HpivyDiGnXUAH8SRzvm6bt0nKjCP5K3E2iUXxQaYnSsan0yKGwkdjDEYrw+WUwy
         TTkQ==
X-Gm-Message-State: AOAM531qIEx8KgfdbkH197uquHjn/XuH/NnfWlhCprlq0+wL9z5LuQIa
        HxdMvkKkPiBIPP3Do04hHJmQ6NkRl7s=
X-Google-Smtp-Source: ABdhPJwS7/rMESqds8jR02udPjc5kLZEuLwMKQPIyiYyOPxZZ8PFWNtiW48PAJG1Ly3mpKZjbGDnww==
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr10722152edb.310.1591389895108;
        Fri, 05 Jun 2020 13:44:55 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id bg21sm5228591ejb.90.2020.06.05.13.44.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:44:54 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id l11so11046431wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:44:54 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr5213330ljn.70.1591389567802;
 Fri, 05 Jun 2020 13:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <87eeqth3hi.fsf@mpe.ellerman.id.au> <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
In-Reply-To: <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 13:39:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg33hLZHjqcMhvWzmgNrE6Gv+xpEcFXUx7iUHS2t5QtdQ@mail.gmail.com>
Message-ID: <CAHk-=wg33hLZHjqcMhvWzmgNrE6Gv+xpEcFXUx7iUHS2t5QtdQ@mail.gmail.com>
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

On Fri, Jun 5, 2020 at 12:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ..and then when I actually compared whether I otherwise got the same
> result as you, I realized that this all depends on the module tree.
>
> I'll go merge that first, and then re-do this all. Oh well.

Ok, redone and pushed out. Can you check that the end result makes sense?

              Linus
