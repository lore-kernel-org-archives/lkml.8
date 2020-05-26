Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2C7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F81320704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEk6l109"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbgEZRnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:43:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC99C03E96D;
        Tue, 26 May 2020 10:43:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so21332324wru.0;
        Tue, 26 May 2020 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcoTWLaWuLh6LbQ2E4pMtjfD0DV5c7lnlwMOorG+hjo=;
        b=MEk6l109ZsgDsgxPPHc7TMEvSssMisdoBSHkKQQrQCOthwHs0s8i/KdD8H/QGlhcPX
         /yGYKMeGirxAUN8WXz3fZkl9/hKY3tt4l1tRn+fZyPKq99LJBolmTaFNGAMQ03ss/2Jm
         9XKroGmMOL1ZNOX4hNQGMRG/gaAdgxTKfc0Y/djC+Np97sbgp5Z/8Un7pcc/1VhTnbdI
         NpqRHA/Dd2mdwkLR7VhJBcsAeEuKsj7MVeOG6JCDwZYuJENI9AeOwUDNUtxTIgC9ErRe
         d3ajk257n1qqjj1me2d+tbvAi353QZVF2X/zUfNGffg6dbomRH2vrF0e8jCi4C0TJZid
         qCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcoTWLaWuLh6LbQ2E4pMtjfD0DV5c7lnlwMOorG+hjo=;
        b=bXeUYpM9Yd8NuzwZUI3q4qy5CRXFsVMkWDWXDangnXho8RZCKrZZxbipXgTNFroWY/
         2a/4b2o0eLwGYeY2/27JYD268i8qoP8MGXC5KG4VNATtbPRrxYh9QlGTxu3MIYoxKgPf
         ng2g9TEKAs0VyYvGQkp0IfgtNQwl1doI+8GQ9a12tjLPacHCN837oGLqnusJ0CQYUK6d
         QOAuxuUEa7BlVT8xycjKe/d7s5iMBCo84U+xpPSjTdnY+wZDrgshhyQs7piSpscMgK5A
         ermdKafFPMFzVFjpLde/Dq1j7Sysi3vimNVS6G8KYCet7kT9CR0PYpLJvJIaopGt0oqo
         Xkkg==
X-Gm-Message-State: AOAM531ANjBgFoRGEro0ED7CxMGcQQixYHMPGk4VHBc+2rYYIkdqxfSq
        Akbt08IiXPAnfjJnqUdLI9KbIDjdSAHA9q1Q98s=
X-Google-Smtp-Source: ABdhPJyoDeW75oDbS4RgC+rrZAbEt3FUCMuJnat3rtA+g/1JeSCoyGgqVUMthL8CZAOusFW65TR9SHP2qXfztEoTg8k=
X-Received: by 2002:adf:eec3:: with SMTP id a3mr22471564wrp.164.1590515015370;
 Tue, 26 May 2020 10:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200526170939.104111-1-aford173@gmail.com>
In-Reply-To: <20200526170939.104111-1-aford173@gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 26 May 2020 20:43:24 +0300
Message-ID: <CAEnQRZCv0KbVkGUoVz-Sz3XwQyFY-5KZXfLoFw6u5amxGSCVgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Fix voltages on LDO1 and LDO2
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 8:11 PM Adam Ford <aford173@gmail.com> wrote:
>
> LDO1 and LDO2 settings are wrong and case the voltage to go above the
> maximum level of 2.15V permitted by the SoC to 3.0V.
>
> This patch is based on work done on the i.MX8M Mini-EVK which utilizes
> the same fix.
>
> Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
No need for a new line between fixes and signed-off-by.

With that:

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
