Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C67C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A035206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKtt7Ce2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgFCWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFCWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:09:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C44C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 15:09:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so2311947lfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGmwYW9BzpYkE3b5BXMa4x8r+iWYDMrACAFEn5/TXJs=;
        b=HKtt7Ce2T/uv0uuk+ikmeaezZFR7KV+O78D0r/pRwJ/pvjEvYLfSpoVYCPmGMlXgAH
         vklJDoXat2X4tk+UWGiPrV1fAJzjDYjto173ALf43iPuLmlA7XTETrfM1n42QfDFYA6G
         lybqZRxRsnxahb0rFMHSsWDGaHfUwLYJcRCM3DQs1xpf/3lnHy6DC75yQNYuwQT7hyC7
         aI3VznFrKb81GMJMV34Mg5laOi3kTzCSe4MyP4nCHPbGBrMF/l/O5CUyDc96d9qfMTyw
         /u1HgOiHC0+TbH7IDV7ts5kgOQS0aTGs9WtayvOuKAcQsbrJtu+D4ZrcZ7BbOqgXazYA
         Sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGmwYW9BzpYkE3b5BXMa4x8r+iWYDMrACAFEn5/TXJs=;
        b=iLif/BiDZrjDR1OrWuXMTCRZ1n6V/z6O2inrFylhJahlNyJfEQPY8kIJjEvDk56EHm
         l0l86sbu21Sv1PBkSpdFkVvpnQJg2mtToPcnejmvXupA5ixohL8xoSZy8ZJLgc0hC59F
         /6OHWpq56bBr+XFSmQmNBnzxyzphLvd8KtM+KriK4rMyORt4Hlce2cFAbmuX0XTBbETF
         yg2+XaLsdjdjBcgGkTRL77hu4R20VZ7FFhoSGhV+L6oSEMd31q5n9qkhHVjowmhVbBkQ
         TwHZw7F9WioZz9s0ScHhfa2WrOOUJM71bXE5T4sgFG9J9ZvYhYOIxl9ONcv+Ym0PY40f
         lLUA==
X-Gm-Message-State: AOAM531dDnFvH77t5TxG5HZHGn8gmA3i0/ucqt/H50JhYWmlDD9+QpHF
        +Jknt+1Gv444wPSQpdtzSp6FbMZpzowwytd7SC+49w==
X-Google-Smtp-Source: ABdhPJyk+KPR2lsjSvLKNRHP6aN4z/UirZhICS+CEfRNQ+r3j4K/FSNVE284NtSnzx9V5dXUQyG8xe1LglaugjNvlLo=
X-Received: by 2002:a19:c8cb:: with SMTP id y194mr820722lff.89.1591222140898;
 Wed, 03 Jun 2020 15:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
 <87h7vvb1s3.fsf@belgarion.home> <a2e34c9a-676f-d83f-f395-7428af038c16@wanadoo.fr>
 <20200601183102.GS30374@kadam>
In-Reply-To: <20200601183102.GS30374@kadam>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jun 2020 00:08:49 +0200
Message-ID: <CACRpkdasbS-4_ZwC-Ucm8tkSUW5tAQdUrXjxHXQ3J0goVYfgHw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pxa: pxa2xx: Remove 'pxa2xx_pinctrl_exit()'
 which is unused and broken
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 8:31 PM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
> On Mon, Jun 01, 2020 at 01:31:23PM +0200, Christophe JAILLET wrote:
> > Le 01/06/2020 =C3=A0 10:58, Robert Jarzmik a =C3=A9crit :
> > > Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
> > >
> > > > Commit 6d33ee7a0534 ("pinctrl: pxa: Use devm_pinctrl_register() for=
 pinctrl registration")
> > > > has turned a 'pinctrl_register()' into 'devm_pinctrl_register()' in
> > > > 'pxa2xx_pinctrl_init()'.
> > > > However, the corresponding 'pinctrl_unregister()' call in
> > > > 'pxa2xx_pinctrl_exit()' has not been removed.
> > > >
> > > > This is not an issue, because 'pxa2xx_pinctrl_exit()' is unused.
> > > > Remove it now to avoid some wondering in the future and save a few =
LoC.
> > > >
> > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > >
> > > Would be even a better patch with a :
> > > Fixes: 6d33ee7a0534 ("pinctrl: pxa: Use devm_pinctrl_register() for p=
inctrl registration")
> >
> > I was wondering it was was needed in this case.
> > The patch does not really fix anything, as the function is unused. Or i=
t
> > fixes things on a theoretical point of view.
>
> There is no concensus...  We should call a vote on this at Kernel
> Summit.  :P

Fixes means it fixes something that was wrong in that commit.
That's all. Whether syntactic or semantic or regression or
serious or not does not matter. It is also not compulsory to
add it is just helpful.

If it is a regression or critical bug, we also add Cc: stable.

Yours,
Linus Walleij
