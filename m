Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B22C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C473F20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq79pYLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEHLaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:30:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56169C05BD43;
        Fri,  8 May 2020 04:30:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so10185852wmc.5;
        Fri, 08 May 2020 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbNfoJNiKx6/ZU7iMTxz20yTQG61ErCidoEOq/ZHMgQ=;
        b=Iq79pYLOaG814TxQFsVfG0swVgtIyNmjyQcAmb1wFin2WdwFHw7CPmD6oV3Ffcq2nN
         91g1RIqGAKAz9e5ibJ9LzSHo1M8+TCZErM0lCnvdW43nF+sbDUmm7cT2S9CRlBwpyHTf
         m1QQOayoUJQ9DjFKgXRnvbFnThSY5Art1dr5iF+za5CyvpxRywTHkaJiT+3NqYhSdM7K
         5wOk8dV4taW1TYlF2tnY9bsQAiZwWSYQ9cSYryQDKDqxV2cWBB3r6xqXX2WxWZhzZgwy
         JZOxjJTHbMWoI6GUHi1UKUzIrWC11fYaUiZRN9PUyQvGr4Ng2pIZydw+11oudJNVua5b
         t/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbNfoJNiKx6/ZU7iMTxz20yTQG61ErCidoEOq/ZHMgQ=;
        b=p5u0nrlf3S4yFvJlN2/5rCHwKGygCDpTjrnP9xlUv0ZPwo0ShOU9wIXPcloJuu3bhP
         fvQAxEeK3e7Y9ub/B0ZunccHTUDkiRTQm0kuHi/t5Ll3tN3M+q8UazbUxNa3zrAzapd8
         PZeTzOsTh5i1gRKmPWWYrv9PREGVJO6pcEnf3p8Q+mijHuPAR3lzUFXCiLYXAo7qoyPv
         H4qjo4chSwZtBU7qp/YUtsF5F9h5efQKPYwdEHJQmMupqbY2mzLFj0wsVZIwHgRwtnUN
         3x5HKkOlwU1poO/pZS0iJ0bxzSPc+2LIlPN8nLfXwgIXelJtQLbImc2S9woHlCjPTKyI
         0qPw==
X-Gm-Message-State: AGi0PuYzjhsshc8qHnLWbD/4L7nETCC7BByia2JEQoauPXYXemot5Fiv
        DvGNYKqJlzAw9vf3HR3RxGVQqhu+
X-Google-Smtp-Source: APiQypLXLkhGhaDGu+eU2mZ3PNYyDz2ozJLRYPy44YsFJf1RWf0VM+/qAeXRczlR20iKKsh97h5I4Q==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr16804525wmc.83.1588937419069;
        Fri, 08 May 2020 04:30:19 -0700 (PDT)
Received: from localhost ([185.67.209.71])
        by smtp.gmail.com with ESMTPSA id y3sm2433391wrt.87.2020.05.08.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:30:18 -0700 (PDT)
Date:   Fri, 8 May 2020 13:30:12 +0200
From:   Jorge Amoros-Argos <joramar76@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-kernel@vger.kernel.org, john@phrozen.org,
        martin.blumenstingl@googlemail.com, rahul.tanwar@intel.com,
        linux-clk@vger.kernel.org
Subject: Re: clk: Lantiq/Intel: XWAY CGU support
Message-ID: <20200508133012.000000f2@gmail.com>
In-Reply-To: <743865de-c69c-836c-a74f-f50ccaaed9b3@hauke-m.de>
References: <20200404105309.0000745d@gmail.com>
        <743865de-c69c-836c-a74f-f50ccaaed9b3@hauke-m.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 15 Apr 2020 00:00:20 +0200
Hauke Mehrtens <hauke@hauke-m.de> escribi=F3:
> On 4/4/20 10:53 AM, Jorge Amoros-Argos wrote:
> > Dear community,
> >=20
> > This is addresed to the Lantiq/Intel developers for the SoC's
> > VRX200 and XWAY in general.
> >=20
> > I'm trying to port the current sources to the common clock
> > framework for Openwrt. =20
>=20
> Thanks for looking into this. this SoC should really be converted to
> the common clock framework.
>=20
>=20
> > For this purpose, I'd need to have a good knowledge of both clock
> > providers and consumers in order to update the device tree and also
> > the drivers. This means hardware (how devices are connected) and
> > software (what registers do what?)
> >=20
> > There's no such low level detail after all my investigations, which
> > are shown here:
> >=20
> >      https://github.com/Mandrake-Lee/Lantiq_XWAY_CGU
> >=20
> > For instance, the full structure of PLL2 register remains a mistery
> > and also its output; OCP selector, is a kind of divider?; PCIe
> > generator is located where? PMU, is just a gate controller or a
> > provider itself?
> >=20
> > I'd really appreciate if you could share some details in order to
> > start the job. =20
>=20
> A common clock framework driver for the Lightning Mountain(LGM) SoC is
> currently being reviewed on the upstream mailling list:
> https://lkml.org/lkml/2020/3/24/4
> there could still be some similarities between the VRX200 and the LGM,
> but there are some generations in between and with the xrx500 many
> registers in the CGU block changed.
>=20
> Martin started to write a driver some years ago:
> https://github.com/xdarklight/linux/commits/lantiq-clk-20160620
> But this does not really models the clock tree.
>=20
> Be aware that the clock tree is not so simple, it has a lot of
> dividers.
>=20
> Hauke
>=20
>=20

Dear Hauke and friends,

Based on some forsaken sources for linux and uboot, I have managed to
re-create most of the clock layout of the Lantiq VR9.

With this information I've been able to modify the device tree
structure and create a minor set of drivers in order migrate to CCF.

The code is now available at:
	https://github.com/Mandrake-Lee/openwrt/tree/LTQ_PORTING_CLK_FRAMEWORK

Also, I've tried to gather all relevant information with references
here:
	https://github.com/Mandrake-Lee/Lantiq_XWAY_CGU

There's also a fancy schematic:
	https://github.com/Mandrake-Lee/Lantiq_XWAY_CGU/blob/master/VR9_CGU_v0_202=
00503.pdf

Unfortunately the status so far is UNSTABLE although I have the feeling
that we must be very close to the end.

The boot-up logging is mostly standard but right after kernel modules
are loaded and eth driver detects a link, the system hangs-up and
reboots after 30s roughly. There's no log message at all.

There're still some seconds where a terminal is operative though, so I
guess there's a module loading that crashes without trace.

So any help and comments are really appreciated.

In parallel, the only big "black box" that remains is the PCIe PLL
register meaning. I would appreciate if someone from Lantiq (now Intel)
could give a hand.

Best regards,
Jorge Amor=F3s-Argos
