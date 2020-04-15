Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C44C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33BE206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo1kcmGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406703AbgDOT1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404592AbgDOT1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:27:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7FC061A0F;
        Wed, 15 Apr 2020 12:27:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so4958783ljk.12;
        Wed, 15 Apr 2020 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47rQ3+FA2D3LJs/1g842b1siYUlXkXN6VqdcwjogJq4=;
        b=Wo1kcmGuq3Ni6b11dpMKa6BWqZWI7iFPQlOO6XuZ3kg2OCLqLnmtNfu/sPcqyQWleQ
         4kwKK+VMgYzFYdxJ4QOKV1lSoP5aiyMIxTt1Z4+BHUQSigz2EvLFOQ236TFdusZts2ds
         q5Lvj/WIu4fTVBFN9XqTbFE7NFuT0ZH8UFj+g2N4AqQpg7WE2r2PubGJJgFxnTUFSmID
         WXmSW3k0PfGfoHcO8D2QISDIfsCoPmKaCbNaWwQf4vfqmqkPHofAM85BoL8eQcsSqdAc
         npOQPuniuxgTHrChKAuUdhvgl3qrCt1b6ukw5j2mIEa3myXxAd7/+N7aeHKUn7xr2pI3
         1BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47rQ3+FA2D3LJs/1g842b1siYUlXkXN6VqdcwjogJq4=;
        b=XmY56cq8oIEkirdIyvGRnrYMwabfdcGYRWh5IiDB0w7EvCiel8pHV/02OVAE2IHSs4
         Gq4drUeBmI3LSBw/Uni+qHbWSVMAMFRFrsWdVR4AC64l2lp3p4ABZK5NKYKSvV6gMMS1
         CLtXl9Bm8s/awL9iL/IRedTWMwtKkojMIUcb0/5hKuySenewKJopaol20nfe3kyNtari
         ijSAe/nsaOTf/vsyPe47lLg1UhRthW9rmWstr+YS8WYsM5JSA7qm4b990pLQkFvRqMHJ
         ma3L+plt4dC2c/HqbwTtlsg/ilIsGzUYgPM06ETAD+rPhpDEmcztkacd3KM02CcSNnQP
         KQ3w==
X-Gm-Message-State: AGi0PuYjFp/OIvhpnnwov5T9MuL5srvJcvKJ7jEOEkUJZB0nTd3kOfU1
        Ng+AhoEDa/kHoCOni0JJySYgY1uv8X4lfbkK/tU=
X-Google-Smtp-Source: APiQypJfKLCHWzDvZAs+sC93xTgAqt8ibneXwnMKrWfuDDNeT8PGQvOG6N7qZNWFRwp0sNft7o5NTBLjkEGHEpe+nNI=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr4114274ljj.117.1586978848666;
 Wed, 15 Apr 2020 12:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200415185941.13956-1-mporter@konsulko.com>
In-Reply-To: <20200415185941.13956-1-mporter@konsulko.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 15 Apr 2020 16:27:52 -0300
Message-ID: <CAOMZO5Ct+cpdvfTEvk1PtQpScJM4iyoMFyChbtGromvuAV291w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: specify #sound-dai-cells for SAI nodes
To:     Matt Porter <mporter@konsulko.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Wed, Apr 15, 2020 at 4:00 PM Matt Porter <mporter@konsulko.com> wrote:
>
> Add #sound-dai-cells properties to SAI nodes.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
