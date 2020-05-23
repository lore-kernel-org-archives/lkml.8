Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E0207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Up30C1YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgEWNOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbgEWNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:14:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC2C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:14:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c16so14468861iol.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qqk95wVsZmzmcuIGFt4zOLnbm5tsZjHScQ5kWL0ptlo=;
        b=Up30C1YRhvWB57ye1T2UrlkPecgpMbEt23MMyafxVtj4AWCFG/FP7d50A6YnKzg9yp
         G2totyxkDwGSHGb7MyOfkpg+yi5yX1RK12jEKRrBkpHP6ZfWVKTJC9sYB2brG+MairoD
         nVu7qav8lKDiem0EWG8cq+eNzX0PIUp92pXJJ05sgDL2eFgGXNL7w4o15p6olun3W+Xq
         AWP/WTLrrm5Q2J98rGCkDUk465WESwOxdkOm+R3HSYg8UezUHHjE5f7UmhvYqSJEI9jC
         dDMgCm+myuFjb6RIyGffd1PFIclibonFoPKs1bF6NUkiv9nFwsu5JVO3a0xShNsc/Nwh
         1GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qqk95wVsZmzmcuIGFt4zOLnbm5tsZjHScQ5kWL0ptlo=;
        b=c9AIlrH41aEROG1RJtxCs0P4TYGNRN8WafVuPUWLerBIvRSSw5gaxXAWtIuyD1mOBk
         Ambh/2k/LWpKZD7Tm3Yy41gW05ACG0xyBCVI+Ewaek+a2OqgUow+P+XaJslRNXA3eUIB
         aeJ+z3SCkYzdtuRhsRtLL13WjDEWKJrbrwWXc+1zG8OzrBFfleQquZbJXzVnGt3NI74g
         N84fxxgcsCwDcEJtDZtw5mV9jiCsvjuTERF9U+AMQBZk7E2b0YNlInncFzCEHmUGhJXJ
         xg0zAPp7LgYx0c8c04iSKlUWxZf/1o6zpGD1pqrSUhqBvFdhLHRh9N4MQNcs7UXcPp/H
         OE3A==
X-Gm-Message-State: AOAM530Nco675cabL1p03lloAWiAskf2OjLDXje/v/9w+uSqGsVRUVZ3
        WAzcsLNMD2pOoVcV1KLEYVrEudW6kTB5EyFs8j1Vrw==
X-Google-Smtp-Source: ABdhPJy3r7ROG2Dd7iXkJwzhgssNgb6WC0TdCHVJoxGhMF/mvblnvGscUx3CvN8/kuZuYuZPjaHAQSC9J4+TMor5GdA=
X-Received: by 2002:a05:6638:b:: with SMTP id z11mr1909060jao.114.1590239680686;
 Sat, 23 May 2020 06:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200520114415.13041-1-brgl@bgdev.pl> <20200522.153653.998395486877096103.davem@davemloft.net>
In-Reply-To: <20200522.153653.998395486877096103.davem@davemloft.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 23 May 2020 15:14:29 +0200
Message-ID: <CAMRc=MdQo1faFjUzS0z5VmihZ3dfiuHiXozxQUkOhAi1n5tkcQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] net: provide a devres variant of register_netdev()
To:     David Miller <davem@davemloft.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 23 maj 2020 o 00:36 David Miller <davem@davemloft.net> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <brgl@bgdev.pl>
> Date: Wed, 20 May 2020 13:44:10 +0200
>
> >   net: ethernet: mtk_eth_mac: use devm_register_netdev()
>
> This patch doesn't apply to net-next.
>
> Neither the source file drivers/net/ethernet/mediatek/mtk_eth_mac.c,
> nor the function mtk_mac_probe() even exist in the net-next GIT
> tree.

Indeed. The driver got renamed in v5. I didn't resend a new version of
this series because I thought there would be a discussion about its
usefulness. I'll send a rebased version then.

Bartosz
