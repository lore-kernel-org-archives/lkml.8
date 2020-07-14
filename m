Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C634C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FFA2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594759178;
	bh=vsJoqLN3SowqXMSj14UqCf7GoNEyfVmFAh/NYPKXAZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vMlIs4QiyrM9miwuiEbH2s2OkVhBNPRNtovercnFtmJQfeA+4zdQVTDKrTVybCDrm
	 19OwKkDh05KiK73htMZodCYbiDmvw3d2dc5RVvUcg0I+ozn9Wwr8aWkLlzi5xAIWon
	 /lO2Rq8Xr7T/NUpcpxIbSA38ZEKWrv0N9d8Dyras=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGNUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNUjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:39:36 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB76720758;
        Tue, 14 Jul 2020 20:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594759176;
        bh=vsJoqLN3SowqXMSj14UqCf7GoNEyfVmFAh/NYPKXAZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fVoCKRwIV4K7Wqykziy83jgg8ZZqIGWNoAzVJrsWSJ9J3MATXaP/ZlMMq44nyCN0V
         UTy8QkOea86rNZsPfFMKiUS6W31rrvcGmhMLmcm77Dp7t+FR9G8tfjnvYxygM0XC19
         jCdziyY3J/aWpsbddB1xYA6aG5Iugkc+lfKnAgTo=
Received: by mail-io1-f49.google.com with SMTP id k23so18726053iom.10;
        Tue, 14 Jul 2020 13:39:35 -0700 (PDT)
X-Gm-Message-State: AOAM532258y8iMumvyfrbEvteIG/YuDklVd0mxVM+8b5iOqjORpyoUNR
        vRe/El4DmMgZZqpaDgwfJoLhcz4ucM9ykzRaJJg=
X-Google-Smtp-Source: ABdhPJzCMOZaBUcXd8oqTwkKwaQnQ2GH27rKGys1KnzCXRDOUXcH2ttDkAm5+RLVmZLkn0KwR0sY4hSHIuHuW0tQ1mk=
X-Received: by 2002:a5e:da06:: with SMTP id x6mr6817841ioj.196.1594759175401;
 Tue, 14 Jul 2020 13:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <1592480018-3340-1-git-send-email-hanks.chen@mediatek.com>
 <1592480018-3340-4-git-send-email-hanks.chen@mediatek.com>
 <CACRpkdavqjcma8A1y9Sh=WWLu-n0+mQOhyNw2dHenA8ZnQkvgg@mail.gmail.com> <CACRpkdb5TyictD3j_PE5JtBJmxX87Bk04YkxF1ErsbHwO4TSOg@mail.gmail.com>
In-Reply-To: <CACRpkdb5TyictD3j_PE5JtBJmxX87Bk04YkxF1ErsbHwO4TSOg@mail.gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 14 Jul 2020 13:39:24 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpbSjJ2f=rKMhfsrgXcVgiWzmyMvcXfrMmxBchezARNag@mail.gmail.com>
Message-ID: <CAGp9LzpbSjJ2f=rKMhfsrgXcVgiWzmyMvcXfrMmxBchezARNag@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] pinctrl: mediatek: avoid virtual gpio trying to
 set reg
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hanks Chen <hanks.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, wsd_upstream@mediatek.com,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sean if you're OK with this patch I can just apply it separately.
>
> Ah nevermind since the next patch has your ACK I just applied this
> too since it's a dependency. Yell if this is wrong.

The patch looks good to me too.
By the way, I didn't see those applied patches in for-next branch yet
I just think Hanks should send those patch based on the top if he has
the next version

>
> Yours,
> Linus Walleij
