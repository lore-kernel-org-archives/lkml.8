Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D74206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp/YUIpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGHRln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGHRlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:41:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE2DC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:41:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so6483524ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syXiCiWQa2sdVvRcXjSBref0DJZkM7sUmvl19hyA1qk=;
        b=Vp/YUIpWYHS9flQcnaE/dZkic3isoiKZ/gFaGhfFGHYuB/U+6Amt5UTZWbGJv22VCZ
         49t7gU6N28vhz7Eu9rNXUOR8zMQ9xeUUziCFU1QfwqCrOb+CDhbRQViT+rWEY1hOehwz
         TwsfzM7pW72HC1+B9ibAmwSuu0q3z42nDCIfp7btvN1y6rrybe/QrTZfPmWj19C440PC
         6ngmfQfrCfDUk/OEygarVhyp+b7PO3ZRdPCnPKI6Swvy3kxc/nh0snV5ddGEFPQ/AnlK
         oLXgnzOFUJVt2LSy4AVKyF2jqouzfyiflukqQWFBtqQJhGmN+zZHDRkd6KflveoppJeP
         N2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syXiCiWQa2sdVvRcXjSBref0DJZkM7sUmvl19hyA1qk=;
        b=tmPkk/Jz6ZM0CGJQO4K10UQvyUCFHjDmVIztkrr3v5im/gq4DSDiOCSNPeOP5YY82M
         mVmVuydk5MCg1oZAXmqEjxaRNsUqE3tSybHhqfFJajdN+3EsqliWl3WxbvVzZOGQoYnU
         41BMTB4cuwg7cmFZHWEgVPDzm66TCVZdUwiTiHlMmbmAuCIDFfXp04IEZpZ2KzGFn0M0
         6lQ9U3X6k6mzh27KtKHBW5tZ/VaP90TJ+yWReXiOG5VAypS8+SDsCJjEXMepTcGtm4JV
         nOk7VpvFVvJZGkTveP6QlXbNjvYeIQ/DQq+KduXAE6dcHIviXi+anrTjNDFX6EhKpTvS
         6Bgw==
X-Gm-Message-State: AOAM532UQOKVJ4/5g/emsLLgD+N9AgPod0MjF8J6k/1yowQW+DFAZvw/
        /c4N4y5kmb2OXa016aRQ76y4f0TWsqQn26N+nfs=
X-Google-Smtp-Source: ABdhPJwLrY9WGA/PF+ajgJGK2d5iaouZbqiREdwwJ2fuGuF+sfuPpzWj6A7gtqQqR3dunUpHeLMKsP3gnBHsuyNzXqQ=
X-Received: by 2002:a2e:a168:: with SMTP id u8mr5462228ljl.178.1594230100990;
 Wed, 08 Jul 2020 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1593764337-8267-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1593764337-8267-1-git-send-email-hongxing.zhu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Jul 2020 14:41:29 -0300
Message-ID: <CAOMZO5AHkBCnd54OZd688gbBnHs1stNAPOfKzpX0KEUUcVRxYg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable sata on imx6qp
 sabreauto board
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

In the Subject the board name appears twice, which is redundant.

It could be made simpler like this:

ARM: dts: imx6qp-sabreauto: enable sata


On Fri, Jul 3, 2020 at 5:23 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Enable SATA on iMX6QP SABREAUTO board.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
