Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F21C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C8C20578
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="chs8H5vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgH3UTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3UTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:19:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF87C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:19:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v69so3252194qkb.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfInBHJQiG3kU31X11IPmrYuhaRLEL6y5a0Bq4CRTCo=;
        b=chs8H5vM8IOeTJH9uHolWFUy5YtPMIklS49nEgRXsmf+5Xr2P0XCvaA8gz029qu3Rr
         309MOnFth2JlbfQpS2TUwai1cumyoZ0eiOw61y4ygP1jggl5gr5gc6HHJXiFrz7rHGML
         JWqUe7LofqGHlexiWC1jdMo6d9F5ti4UoSzu70jMOZ49OZYDpXZ+E5DLagbfpa9rr36Y
         WxfpSkG9MYjV50n5AV3eiguh/GhxLay3bEX3iyvAorrlV8EFwUDVoWjufyoyX1EIxpXB
         3tMKK4oqG9yZu4bEpAG23Ku5/3B/E0ZkEvWDwtackyGNUlvimt0a7OGzb8w53O0zEl6Q
         dHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfInBHJQiG3kU31X11IPmrYuhaRLEL6y5a0Bq4CRTCo=;
        b=qiowB9BpffpTk35R4scgv9oIsYBD7AsfL2QQWtfWNK5WSPoiW15Ipp4oUCz3cS6+pX
         mhyQmB91KIZXsBErTC+hud18qaVWds/77iB246w7EZ51Ehjn6gb1QRMXE38XIHhuZCcB
         pAvI0XPr6Q8xcJYUCY8C35uYacrmC0Td7Jna3VC03jXV/Ev9sPPFnF9YH6jUA9JmVOWl
         RGiETIs5sAoYUxAsIYyy4f8cGicEsRjeN7btpOUEQD5rmYtUpCJ94z/TDfPyWP37ZxuJ
         JCn3ThGqdV0a3GlAQFx3Bl7y3VILcfAgQyalwWcWgo2sp93bSZNmX9USCPfbxb8JgyDW
         f6ug==
X-Gm-Message-State: AOAM533ncp/vvI1uf2YBKf8UAnWiKycE3d8shDyzpPu1m0dKTTAjgtx9
        LvuAGX2L3yX1HQXTrGbC/KZOQA==
X-Google-Smtp-Source: ABdhPJwQjl3e9PVqEpC0sLfc2gDkL4iobrdTOQ0tiNsVEJCyz6dLRTclDrHI4JECF5Vhnlz7uUfFUA==
X-Received: by 2002:a05:620a:16d9:: with SMTP id a25mr7782107qkn.155.1598818772164;
        Sun, 30 Aug 2020 13:19:32 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id q58sm7785283qtc.40.2020.08.30.13.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 13:19:32 -0700 (PDT)
Date:   Sun, 30 Aug 2020 16:19:29 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200830161929.49466c44@DUFFMAN>
In-Reply-To: <65d88bdd0888a69849327501a2aad186@kernel.org>
References: <20200829164920.7d28e01a@DUFFMAN>
        <65d88bdd0888a69849327501a2aad186@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 10:41:42 +0100
Marc Zyngier <maz@kernel.org> wrote:

Hi,

Thanks for the reply.

> Hi Samuel,
> 
> On 2020-08-29 21:54, Samuel Dionne-Riel wrote:
> > Hi,
> > 
> > The patch "of: address: Work around missing device_type property in
> > pcie nodes" by Marc Zyngier,
> > d1ac0002dd297069bb8448c2764c9c31c4668441, causes the "DUMO" variant
> > of the gru-scarlet-inx, at the very least, to not boot. A gru-kevin
> > reportedly had no issues booting (further), though it most likely
> > had a different kernel configuration.  
> 
> Do you have a pointer to the device-tree for this system? I couldn't
> spot anything amiss in the scarlet-inx DT, but I'm not sure the
> system you have is that exact one. Even a DTB would help.

Is "arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts" what you
wanted? The FDT in use is the one that's present in the kernel tree for
the same revision. The one with the `compatible` property with a bunch
of `google,scarlet-rev*-sku6`. The build process for the kernel
partition (booting using depthcharge) ensures they are in sync always.

In any cases, from previous discussions with people involved with the
scarlet development, the only difference between all scarlets are the
display on some (innolux vs. kingdisplay). I would expect (and hope)
the issue would be the same on all.

> The fact that Kevin still boots is a good indication that the issue
> could be with with the board-specific changes layered on top of the
> GRU base. My own rk3399 systems are running with this patch.
> 
> > Using a SuzyQ cable, there is absolutely no serial output at boot,
> > while reverting the commit (and this commit alone) on top of
> > v5.9-rc2 works just as it did with v5.9-rc1.  
> 
> Do you have "earlycon" on the kernel command-line?

I did not, I thought earlyprintk was earlycon... I had:

  console=ttyS2,115200n8 earlyprintk=ttyS2,115200n8

Now with wither "earlycon" or "earlycon=uart8250,mmio32,0xff1a0000" I
somehow can't get any output, and it's not booting. That is with and
without the problematic patch, and also verified on v5.8. Odd.

So I would say that I don't have earlycon, and maybe can't? I'm open to
suggestions.

> > From this point on, I don't know what's the usual process, so bear
> > with me if I forgot to provide relevant information, or made a
> > faux-pas by CC-ing too many people or not enough.  
> 
> No need to worry, and thank you for reporting the issue.
> 
> Could you try replacing the problematic patch with [1], and let me
> know whether this changes anything on your end? This patch probably
> isn't the right approach, but it would certainly help pointing me
> in the right direction.
> 
> [1]
> https://lore.kernel.org/lkml/20200815125112.462652-2-maz@kernel.org/

On top of v5.9-rc2 + revert d1ac0002dd297069bb8448c2764c9c31c4668441

  $ curl https://lore.kernel.org/lkml/[...]/raw | git am

With the patch, with and without (the probably bad) earlycon, I get
the same result, hang at boot, no serial output.

Again, knowing that the hardware is not necessarily in the hands of
everyone, I'll be glad to try patches and configurations proposed to
further the understanding of the issues.
