Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9CAC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F4720730
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUODPKUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJCzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:55:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44316 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJCzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:55:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so628133ljz.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 19:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0xzkMIDkyGduopP7KoTyproKxtGZnSVLA08rr6/YJvE=;
        b=GUODPKUI0ZdV2k3RdkQoIoWFHhrH90l1l+ZdhSzgFYhWSheBP7Kkw8a+X6mMiSCoLw
         ehwH/jSs/fZ/PxeQBT3fZgimeI548F13litdm/91m64Y9Fnf6FIz8EFH+FRQCwnENXQm
         CCySdt1tjC9jisab2u5YaieKg8Ufgdrf798r1Lq7r3s51ZsBFyFKsJIMXI/mP0cPnAGT
         Zss8ieGN8Zo8ev6viQJpkQsQtB73uz/kcTTEf5xsajwmnt68XNZHF96ZJnixkqz8IBuj
         t4BYP/c7SI3u8j+T6QMnytfx8u2RQuBqmymbmgSmh8PDJTr1REpmUfIIf7O4avW7GhUg
         bzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0xzkMIDkyGduopP7KoTyproKxtGZnSVLA08rr6/YJvE=;
        b=XqZ3mLv5qOVQfZkeQ/1pNRkVEE7NSNX0dtF3mqF06M/6SjYxw28T/KXP9/1m0IxHqt
         i55G+V99viYE6bFg9d/mcPqYB/wOCEnaJXfYNA2aT+v8iXzsHrSwiO6S2M9k/24nA4z1
         b4zA5QAP8xkRUPupiEA4VIi+h9qIuqS+2hkAcGcw2AaiwKJ3zCITpPilUTeskfLWcKr+
         ZC4z3uQO78ViOkDNJT7SYXjo0Hq19c7+SNv4L56YhXeYfWVSFA6mwL7u/++eHrOP93pB
         306ewu8uzdwpytCDoZi8O6bt+hGKpvMykqPcFvu1HuDk7R1LDQ+X92XJ8NtzUzmJhT8E
         zQ7Q==
X-Gm-Message-State: AGi0PuZJ2dRans2vMRDkAUxyzUxellJ4Adeh/+Np3fC0uCwpqvIQRmIK
        WgPHdet0FnYZJ1Exi7nbR9fpNKHbxgi+Zsbwif4=
X-Google-Smtp-Source: APiQypJ/vr1Dvbu37vXf7fafcIfjYfjYSEQkEKJNYRT6CFnCjcJDoVjeD/qH8ErTB0wWuTlz4Vsv5OfXUQQdF2tbGro=
X-Received: by 2002:a2e:99c1:: with SMTP id l1mr1662346ljj.196.1586487327692;
 Thu, 09 Apr 2020 19:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <f48d3b98debe5b2c1cc9a384874d6032b051a4c5.1586422035.git.baolin.wang7@gmail.com>
 <20200409104546.GA5399@sirena.org.uk> <CADBw62p0O6dfiMF_r0SaN3cvrmcUdmnLm55gv_c=pywwzpTjoQ@mail.gmail.com>
 <20200409142620.GE5399@sirena.org.uk>
In-Reply-To: <20200409142620.GE5399@sirena.org.uk>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 10 Apr 2020 10:55:16 +0800
Message-ID: <CADBw62oP-bJcjWaQiW1zAdix3c4=nfTkNTZZOti6bVtLJwp7+w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] regmap: Add reg_update_bits() support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:26 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 09, 2020 at 10:12:44PM +0800, Baolin Wang wrote:
> > On Thu, Apr 9, 2020 at 6:45 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > MMIO devices clearly don't physically have an update_bits() operation=
 so
> > > this should be implemented further up the stack where it applies to a=
ll
> > > buses without physical support.
>
> > I understood your concern. But the syscon driver need use the MMIO
> > devices' resources (such as address mapping, clock management and so
> > on), if move this to further up stack, I am afraid the update_bits()
> > can not use the resources in 'struct regmap_mmio_context'. Do you have
> > any good suggestion? Thanks.
>
> If the syscon driver needs to be peering into the regmap implementation
> that seems like there's a serious abstraction problem - users of the
> regmap shouldn't be looking at the implmentation at all.  Why do you
> think this is needed?

Sorry for confusing, that's not what I mean. My point is the syscon
driver will call the regmap_init_mmio() to use the MMIO regmap_bus,
but as you said, MMIO bus should not a physical bus, so I suppose the
syscon driver should create a new phycical regmap bus for our special
case, but the problem is the phycical regmap bus implementation will
be similar with the MMIO bus except adding a reg_update_bits()
callback, which will introduce more duplicated code. What do you
think=EF=BC=9F

--=20
Baolin Wang
