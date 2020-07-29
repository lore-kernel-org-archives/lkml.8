Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0768C20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="PlHqBHQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgG2MeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:34:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:34:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so21503014wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIO25dsj9y1sacwjOVQU2qxiT1NxKYb20Ra0eQDCssQ=;
        b=PlHqBHQ7oPTLAJXglbhBvrn0PuYZROIprcr6B/QbHZeFjyu7qu6UMil8qyc9i1KFRX
         4Sn9y/qO05dOHTSuiEl4Kng8D/B7ichVSg+xyl9FvseMe6+FOeD+am00t9LREIG8DJZ4
         g6rXerPW2bSYqNJdz/IRkaFLmlYQlJOZ+MjIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIO25dsj9y1sacwjOVQU2qxiT1NxKYb20Ra0eQDCssQ=;
        b=Wx2utGLvf8aW2PrAcM1jivAHDeoKmI1cPo1DQ0xpE2h5k5QOJNyPsB0FL5EPNvHmSM
         P5JfdB5BxizJlFalJCR2nPF21chYzpv+pIvz5GbCVE128EZCDQjIVWsP7FcVokyiMPFM
         lZ1tYXDcwFkkiLHHYRpb6MktkzURMNnmwAEEFrjLxwsl8G8X/3mMTChbUo4c3d86o5JX
         F6y/6PrGdYebkLGMlPCyVYDRnAhhq3l9peH7/pGYl5RRfkhlw/9Rf5ZKwA2LHNoXPX77
         rkV7to1ruVKtSc7aUXUI20RwPszJBFuMs3pbkHjXhBpsFJPc/tewKRpvdbU9QeVPB1Vv
         2oPw==
X-Gm-Message-State: AOAM531w2hZR1wc86uOSjzRH6J9szpPE7HG31CeaSQLXGUTYKbacTvEo
        RnGZJC+6ban3qDfIT+GUXOiPv3mPmuI60wbpMdF3NB7P
X-Google-Smtp-Source: ABdhPJyQMzNtPjGIIXmXxDEeBBrskdO6q0ASFwn9TWVeoCeE/LyRiv4udOWG4lbzVXrsNEOujM1yAvCF/TlRit9CwN4=
X-Received: by 2002:adf:f186:: with SMTP id h6mr30102581wro.144.1596026060446;
 Wed, 29 Jul 2020 05:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200728100321.1691745-1-daniel@0x0f.com> <20200728100321.1691745-2-daniel@0x0f.com>
 <20200728191842.GB2778962@bogus> <CAFr9PXkwpNAhQvOJFqLUm-uWoaH=nsNiq_y+OgTf8Z60i4RhRw@mail.gmail.com>
 <CAK8P3a0-rZq_aJxWY2+009C91igzC4nHG7XJFwXkbB8bJBertA@mail.gmail.com>
In-Reply-To: <CAK8P3a0-rZq_aJxWY2+009C91igzC4nHG7XJFwXkbB8bJBertA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 29 Jul 2020 21:34:24 +0900
Message-ID: <CAFr9PXnuMCjhzYQWGBiw3ayDD36qrUc433DsSphyF5+tqetnNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mstar: Add binding details for mstar,pmsleep
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 29 Jul 2020 at 21:14, Arnd Bergmann <arnd@arndb.de> wrote:
> > Does calling it "mstar,pmsleepv7" make more sense? I'm not sure what
> > to call it really.
>
> Use the name of the oldest chip you know that supports it in there,
> such as "mstar,msc313-pmsleep" if this one is specific to msc313.

That makes sense. I think the original patch got merged to soc/arm/newsoc.
Should I recreate the series or create a new patch to do the corrections?

Slightly off topic but I'm working on the series for the interrupt controller
and I've just renamed it from mstar,msc313e-intc to mstar,v7intc.
I originally called it msc313e because I only knew of that chip but the
same controller is present at the same place in all of the chips so far.
I guess I should probably rename it to mstar,msc313-intc to keep with
the first chip it appeared in pattern?

Thanks,

Daniel
