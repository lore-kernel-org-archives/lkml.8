Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196EFC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9D2206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nITANJhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgGOHtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:49:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:49:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so941278qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2hxAhRHGznvP3x0GH9I5kLA83LtI5MGzkZDrric2C8=;
        b=nITANJhZ+S1Je3d/kQHYlr/LhsqXxPv8kVQpvEzlVF1g56h8F0f/RvZXCzQvtvjsGl
         EoTaUTmG8wAKzp/pe0KWE3QAahWqmfXk8TpROJZAJF/AolCKVTXcAxtRbRCjBdL9SUOd
         c7QaU5hwk5yXHGrOZKnlJ8y8mMrfwFkA1AN26YV5kLnLIt4Yg57lLga+Qhyv8X/D9fax
         2GLQGm0V0zWP6YTmz3NGmSh+wlgasLHEK8WgjpyF7ga2kvDRbxkckWUgGwH0wmDqo3KP
         jdQ4aegz6v1stNglcJEI38a9P5ZPtyNvz9Wu/07JQXpy9IG145PT5OVcJDJtz2kKywoC
         MrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2hxAhRHGznvP3x0GH9I5kLA83LtI5MGzkZDrric2C8=;
        b=AyAE3aL1VPzDJeG2OGpKSZj/1Zeyco+Ju+j3DEeoOyH9CRiyHfcipOM6RHVbySIoYG
         3K7TiGc1ipluO08FZeCLw9zfD5fmHhj4q/7+FGhIzFDIDDK5rZpX4/TPzlBsDx1ykEiB
         JkeQdUpRP2L067ofPPvtJCrvzKaYvW+pv5dWcRoNZovgVZnlMmgmXfr7/S0LZL+zqLhl
         cKJscMEj7OisNjt1cj0TRQVOl97LgsFSnJghHc467s2+SYQd2AeQYIqjICw+SWJ3B86p
         JizaVuRbcJTHatC9i+YFRoIpblNH1MNFoybDYei4xFFk/kWFcCPO9v21e6wNaAQtkTJy
         Mryg==
X-Gm-Message-State: AOAM530xrqdmq7/no3Bxfekyb3nnTIC1VWaTSNLVUeBOSjB/wOQ8tlJ5
        pCslxYa2h57mZCAEO8ip+zdeODtUJGNwu8LvBAO9uw==
X-Google-Smtp-Source: ABdhPJxRU1suOXictpKMhpKdY5n5UFCCvMV8M/HIMI2KDxMKdYWvKym3V4XUrQboYUtv/X0P+Ssv4DNWAqpKu3Vj1N8=
X-Received: by 2002:a37:9147:: with SMTP id t68mr8274659qkd.34.1594799385291;
 Wed, 15 Jul 2020 00:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200619090635.58548-1-lizhe67@huawei.com> <e0d04d70ce674584a71af1a5a00984dd26729891.camel@infinera.com>
 <dadc539df01b17aa5dc85e7c0f1dbc83591667cc.camel@infinera.com>
 <CAFLxGvzP3AuZBJ3RugZiRTobxv3Z-kxYKnBUi0rfshwf7GuuCA@mail.gmail.com> <a42981ab23f75dcf5feddf6c8b50d3b44f749899.camel@infinera.com>
In-Reply-To: <a42981ab23f75dcf5feddf6c8b50d3b44f749899.camel@infinera.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 15 Jul 2020 09:49:34 +0200
Message-ID: <CAFLxGvwNuN_OqGdA8oMom1uG=QAnmJDJkQ-BHEMA915-Kz19cA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: fix UAF problem
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "zhongjubin@huawei.com" <zhongjubin@huawei.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "qiuxi1@huawei.com" <qiuxi1@huawei.com>,
        "richard@nod.at" <richard@nod.at>,
        "wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "chenjie6@huawei.com" <chenjie6@huawei.com>,
        "lizhe67@huawei.com" <lizhe67@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:51 PM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
> Did you queue for stable too?
> This bug has been there since day one for jffs2

It will. I just had no chance to re-create my setup after the
infradead.org meltdown. :-)

-- 
Thanks,
//richard
