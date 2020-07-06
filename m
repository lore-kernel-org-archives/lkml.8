Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D36C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BFE205CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgM0DpuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgGFXPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGFXPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:15:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2868C061755;
        Mon,  6 Jul 2020 16:15:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so44062921ljp.6;
        Mon, 06 Jul 2020 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKp7IUGhbEzy43SIfD7SweirhPl6i6zvn0OzLbI7glY=;
        b=vgM0DpuAkfl0GBtAWnLCoJ8STE1Rly8YT2Rp0pg+tcYGOL9SSExfdVLJk7WgPfZr1B
         +gOGcryMDg7Z5f9ha5U9UQEqRY/vJF2tbQ9EAr24jXZM6OpoFg8TlbQdM7+nGgs2qxRv
         gRhpogiWGczuoVD0pltHaxx3M83IAZsETaIn+HSnGBFt1M74Awgpvy1mTXSrlhcA7B++
         cAp/siUpb6EmBRIYdzGqEU0iGRtMNavdlTqZ9ZBRsKolO+vRVVos4ohW1LC8sDLHExCw
         ElrprKmwlbk7wq2rAHIC3EYuf0jTMaSz2+9X9D9vxT30lejQmS0SrcYoVLs00Av4LfOJ
         yCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKp7IUGhbEzy43SIfD7SweirhPl6i6zvn0OzLbI7glY=;
        b=ZroFFSkQ/hO4BZyQBSE/ACPvZYg2V/lPaMDJaubz7c1cpG9y+V4y+b1aI4W6NZ5Xxg
         CKJD3yngZPE4DoYy4zSo0luLYDrj9cph1pN+C0LPMCaRpwuh7V2xmN0y7XLVxeTI+oZm
         ZqrgieMjjVk0upMZS4YeXkqgSR73s0y0ly9Oejvvmboyr7Ce8uPHSZVs8IPRIQ3a35ac
         Kz4LyN/ZzXBsz4G4mK/WRkuk2JPvZLeuVF3ba1ZvO4/RToSbFjXdpbYdPoPi7+BBtosd
         YVVlHNZTi1ob6gmRDMX4cVu7MRDfWiaGdxIAL39U6fd07FLY92LiPnq+57RgyK1PvTaq
         gu9A==
X-Gm-Message-State: AOAM533b9N0voXOGOrlc6UF2llWWgXUAJeB9SdqBbdFJQPgGirubO9Aa
        mgCwf81RT83cuaopvvqm4iHWM1A97+fNS9rgXsQ=
X-Google-Smtp-Source: ABdhPJx066ihdUOPCioWC6D3HKleTnGp64KJIpGzQ36rj0u9yljYKEATDgAfdVWSA84Y63zfBrMkIgBz6R7G/gYgIS4=
X-Received: by 2002:a05:651c:200f:: with SMTP id s15mr16465014ljo.125.1594077313091;
 Mon, 06 Jul 2020 16:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZoovWBavRFaEWEFcSkVjNx26BkKOkhcutNfzL8MrHwMTw@mail.gmail.com>
In-Reply-To: <CAFXsbZoovWBavRFaEWEFcSkVjNx26BkKOkhcutNfzL8MrHwMTw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 6 Jul 2020 20:15:01 -0300
Message-ID: <CAOMZO5AMZoagB5JDxq-4_FbLXrJc-i112SW6NwxG5BdsogXm+A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-ssmb-dtu: Pass "no-sdio"/"no-sd" properties
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 12:16 AM Chris Healy <cphealy@gmail.com> wrote:
>
> esdhc0 is connected to an eMMC, so it is safe to pass the "no-sdio"/"no-sd"
> properties.
>
> esdhc1 is wired to a standard SD socket, so pass the "no-sdio" property.
>
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
