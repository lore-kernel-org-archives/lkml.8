Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F409C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202EC20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw7yjM26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGGVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGGVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:51:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963CC061755;
        Tue,  7 Jul 2020 14:51:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so26910604ljn.8;
        Tue, 07 Jul 2020 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j1Ui06AKqMGBn5Gjz9KT3GhGugXM0xrPlLDctFf2fM=;
        b=dw7yjM26eD+SivZGQRsSZDI86YkEQwqjUt12OuUAE6YanGKEv//efPK8MbwCtGMxK2
         Ou/3KrvoV5egqoRVXl0ZMhc7zEG+Oc5OThr9rsr5Pmbxaacgr+Rju+tujny9dBUAHF4R
         x+/HgM0jgPC+wPSgQLeUNeGi2lSCY9wthNyQwpmUOW0SBMnpKys1XgXGRXTC/IUyJi5p
         lc29CMXgRNek4RhD3nEECJyf966d2FW6xU3pCXXPRPZxeJ7TXHfbM5twqhQTkQDaQMr1
         GS1mpzEQx2qk+hM0o1tAV2gvEvQgmYUwIsQ/QjXk7gx03csnqzzp8BSgm0sViAMPfE19
         Npyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j1Ui06AKqMGBn5Gjz9KT3GhGugXM0xrPlLDctFf2fM=;
        b=r3GsmxeQmgiut4kByvB1KIqNB1CjD86R//3LcU/kCcTqfO3KSbXdNjVqFvqM4e+kN5
         hJaGFR/6h287zqa/j8hXrA13zilbhEX7w1qNVrNSC+V7SsN9BaIVmQefYOh212DO9kVR
         vq3gWrN2TYieK+QebH38g7Sy58sYaB+odl6gnNG+inZeNxUP+nVILmNURW/9vEknh4of
         nFccUfgtVi5nkiThd8D4q9JKgm/MNfJLDV+F9udoadh/anHd0EUkmzT8DZUIwyVUlS4g
         62sJuxu0dHLZI8hZn7LowTBo+ul3eKUcVTQFiO7EG0ZmNYGLh/+x5wOEI0c82hmSNIts
         EeKQ==
X-Gm-Message-State: AOAM5327HgIixxBUsZLFoMrq75aa66o4LnUOTTPhLOS01JXbfih6jwP1
        +65mLK3LoJdJyxR+KPTZZtFAeDAYiKGJyyaw+MI=
X-Google-Smtp-Source: ABdhPJyIqM6oobh1dSUh7r7X71tuzYBiuigwuPWRQWYnubENwrIRTWrX9CzJ9+Ebw6KRfrWkbLadPtj7KITj1K0fIbo=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr20930708ljh.218.1594158671507;
 Tue, 07 Jul 2020 14:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200707211359.29906-1-cphealy@gmail.com>
In-Reply-To: <20200707211359.29906-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 Jul 2020 18:51:00 -0300
Message-ID: <CAOMZO5CWv7S4iWLWMxQwRs_8qfVRGVgMX3YTkr8H01=6L_V25g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vfxxx: Add node for CAAM
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Jul 7, 2020 at 6:15 PM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Add node for CAAM device in NXP Vybrid SoC.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Chris Healy <cphealy@gmail.com>
>
> v2:
> - fixup commit to show that this patch is from Andrey Smirnov.

We usually put this information below the --- line.

Maybe Shawn could fix it while applying it.

Other that that:
Reviewed-by: Fabio Estevam <festevam@gmail.com>
