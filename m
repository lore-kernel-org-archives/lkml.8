Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E738420829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txe/8vd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgETDcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgETDcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:32:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:32:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o13so1382979otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2vK9F/eA14thO30W50mK/uC9vmImhp6JcvtaBfalus=;
        b=Txe/8vd30AxuY9Cp9qMRIiPjVlgPWo9BHR/CL3Wgqy6AE7SyYWidotTjxY0/jDStqh
         Ixc+8EiaFrLUnoBWEHJctLDH3m2qq2KwDbsdtadTMfx8EJueY6SL2X56MtvhsbDsQygO
         6q1W7v95tPKwj9Eev816CGRFvjir6CPE2KBugcO5cOJW04maMQuakYqFLoZFLY1LmDF/
         FoPvJZTz23UQT8nTIKEIoQ+iA5H5ibQx15P4TJmxhdMn20D6ir8WmVscb8VWNl/4z1WK
         YreGTJSkEOkBfXnxGJ3pH4P4WBre0cPzeQ+MoI2jsi8a/LX7Ie/gSCRdY8R2gadala6/
         i+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2vK9F/eA14thO30W50mK/uC9vmImhp6JcvtaBfalus=;
        b=pZo9L0AfYnAhrbYPsSvCHem2FpwlgZTkNq/gA5xVp2EXmZGseH8/yzIKh12H6Sm1Rb
         42yRDfSEhT95SI4sSAh1LoeuHb/BlcY9pBDDumJzIDP1Hmr05Q9RZ7YAQ+yCzhmJTgY3
         RUuYKoiL4uzVPf6LmavvKgnAl4vwDt37c46r10r9k1HdBxz/Rh4cn+KSQ3fM4dgRLcZ5
         4Pqubl1O3u/hxJ2EWlOMH8fxThODas082mcoT6kG9lLIJKJboxqS5kHkILqBrdAvtjFK
         NUby4PS4tt77RU48udWKyjXWCDGwW/Mdir571+mMO2Mau6HXwVY+ftN9xxIqJMxZI106
         JWGg==
X-Gm-Message-State: AOAM530Ps+Sjtp8jCo9/zJzo1qN9upPDqXyxLN2jhbKKb0ZJd7wG3JLb
        yk1jcPCPn/zokGeVSUqoES4GDXy9N9GVrj2bjTaYjP+4
X-Google-Smtp-Source: ABdhPJywljdbI8qKbuGjHOrWr51yAQbdJYFS68Iblc4CXacS9JbRL4urQsSQ7MZdskoTOc7xW/bRxIc2g+gIQ9jUNu8=
X-Received: by 2002:a9d:32b4:: with SMTP id u49mr1768191otb.304.1589945521027;
 Tue, 19 May 2020 20:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <1588151843-2133-1-git-send-email-peng.fan@nxp.com> <20200520005638.GA11739@dragon>
In-Reply-To: <20200520005638.GA11739@dragon>
From:   Shawn Guo <shawn.gsc@gmail.com>
Date:   Wed, 20 May 2020 11:31:50 +0800
Message-ID: <CAJBJ56J-q7BreW9L4B7QbCkmxPEkpY6YMrBbzG3HWk3FL+wJwg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] ARM: imx: move cpu code to drivers/soc/imx
To:     peng.fan@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, abel.vesa@nxp.com,
        Anson Huang <Anson.Huang@nxp.com>, ard.biesheuvel@linaro.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, git@andred.net,
        leonard.crestez@nxp.com, info@metux.net, allison@lohutok.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 8:57 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Apr 29, 2020 at 05:17:20PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V2:
> >  Keep i.MX1/2/3/5 cpu type for completness
> >  Correct return value in patch 1/3
> >  use CONFIG_ARM to guard compile soc-imx.c in patch 3/3
> >
> > V1:
> > https://patchwork.kernel.org/cover/11433689/
> > RFC version :
> > https://patchwork.kernel.org/cover/11336433/
> >
> > Nothing changed in v1, just rename to formal patches
> >
> > Shawn,
> >  The original concern has been eliminated in RFC discussion,
> >  so this patchset is ready to be in next.
> > Thanks.
> >
> > Follow i.MX8, move the soc device register code to drivers/soc/imx
> > to simplify arch/arm/mach-imx/cpu.c
> >
> > I planned to use similar logic as soc-imx8m.c to restructure soc-imx.c
> > and merged the two files into one. But not sure, so still keep
> > the logic in cpu.c.
> >
> > There is one change is the platform devices are not under
> > /sys/devices/soc0 after patch 1/4. Actually ARM64 platform
> > devices are not under /sys/devices/soc0, such as i.MX8/8M.
> > So it should not hurt to let the platform devices under platform dir.
> >
> > Peng Fan (3):
> >   ARM: imx: use device_initcall for imx_soc_device_init
> >   ARM: imx: move cpu definitions into a header
> >   soc: imx: move cpu code to drivers/soc/imx
>
> Applied all, thanks.

Unfortunately, I have to drop this, as it turns out the series needs a
rebase onto for-next.  The series conflicts with 'ARM: vf610: report
soc info via soc device' there.

Shawn
