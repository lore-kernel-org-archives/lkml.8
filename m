Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88A1C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9672206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="K5pzuy/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgEMHM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:12:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2688C05BD09
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:12:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d21so8833851ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRFk30OEdsBaX3lNynkWDdT0LAUKPWkllb6vWrvUfFU=;
        b=K5pzuy/Q0DbKRQJhtwBbIhHrErl3UFCylyh40MxEmVKtgp7yEA96J6jzDlnp1Z9lX3
         L0095lu9fUxrCVlwBbN8u7k/YjU5gQNhOooEFNtUQuKet6vVAPI48KqdvwDDSoWxkmNw
         +PylWBmbq3ADzq9SmaUFmuSSxZT6qEFLq+V/2QzC90vcKfu7ZAw7q1+eCKk985st/+rD
         L0WnmVbg1Zay9q2IAo3SswAhLrVPrbQyjbJyS5GnZ/rQoLHTPXPjoZLTn/MHOb9BorNj
         TxoihN27LfVVuTTxxgi5ohtgAfasA7G6w5fuCLWotsAmKVh4quhdqPwl8wkOmMx30QtM
         4TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRFk30OEdsBaX3lNynkWDdT0LAUKPWkllb6vWrvUfFU=;
        b=QO2PnQxhV9d9INGnzUrskM/my2PzlHbdO+IA57ZQLnFayhS0TT4MNO2AwyX8Sskhg+
         zTzeo5260rnlivPj7U3YYIS+eR+wev5q1UFI+zBmnLUHgUHfXQ/s5xKqFqUeWCDehKag
         Qv5GzmqfZX3wAVlBE1xPhog0Pk/4VnPjyE36nD1TqlPH4hYXJyVTS8EZS5AO0QK8lrLV
         k8h1yfMnx6xsU87Wa4zTRx0k+0QNC2LwYd116BVZjWwkXTT3GPPvpTcoR6PwmcMEI4gJ
         moHrTgKWsVzd9e1kRkL7266VxXsALz/76QzOUODdFfrwqcMOtfjw4WVqPQvyLakoLPmN
         KSuQ==
X-Gm-Message-State: AOAM530DNPwiZVcC5jyR/IZmJD9HBiXjYJoVyapOBfEmbl1ivK7D7Xhd
        IfzbA0qKQxTtstQa/QQiDQEG/7HI62KSrMDxZ90P1A==
X-Google-Smtp-Source: ABdhPJxOVv0j3JItO5IlLO900Ue/XycQksnMkwQAPd8Io9f7MPELoXRwn0ku6xHMSL2Omjmun1aVBi7/j3xnmT3aaQ4=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr16710225ljk.134.1589353944120;
 Wed, 13 May 2020 00:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-4-git-send-email-yibin.gong@nxp.com> <20200513060525.GJ5877@pengutronix.de>
In-Reply-To: <20200513060525.GJ5877@pengutronix.de>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 13 May 2020 09:12:13 +0200
Message-ID: <CANh8QzxJg05nXasHfN2kC-G7TOKZ8trJkOP_v0KXvcy6S4df4Q@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 03/13] Revert "dmaengine: imx-sdma: fix context cache"
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 08:07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Tue, May 12, 2020 at 01:32:26AM +0800, Robin Gong wrote:
> > This reverts commit d288bddd8374e0a043ac9dde64a1ae6a09411d74, since
> > 'context_loaded' finally removed.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
>
> I think this can safely be folded into the next patch which makes it
> more clear what is happening.
>

Agreed,
not only that but having 2 separate patches also means that the bug
that was fixed by the commit being reverted could reappear during
bisection.

More generally I think reverts should be reserved for commits that
later turn out to be wrong or unneeded (ie should never really have
been applied).
If they were OK at the time but later become unnecessary due to other
code changes I think all the related modifications should be done in a
single normal non revert patch.

Martin
