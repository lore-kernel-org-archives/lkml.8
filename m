Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E226CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2792078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoPTTH/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgDTMtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729409AbgDTMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:25 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EBBC061A0C;
        Mon, 20 Apr 2020 05:49:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f19so10760336iog.5;
        Mon, 20 Apr 2020 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iDvRfbVf9THDBf1Pms1SmVEOSBofYzkdzChDMla8Sj4=;
        b=qoPTTH/C2gxv+dLqooKi0oP3etwgI2MpwMv7iq5bECuizrvtm90YtPVA/uQC0xtVsp
         RBdXZuvVgfFQOjVxyzj+l9GGJ1oADnVXGV+VpFtsPf7iGoWE8BgdqaQPp5oEr/sneSbI
         SXrIatCRCy7xtcqpy+b72+TLU22Vk8sD3R8hc41cXo2R1C6uCx4BAzOlh4lAcorO9hLL
         jW0R8stz9JxFsvWD5Bh1sYLoiL2u7OaVLwHVyFWmjr7Yfyzg8WkM+JBjruB5kzuEGX6H
         NKCuOyq+L2NH/9GtrF28S11HqxeIpVjPnC/CJT8ZUBNA6v0d6bxolTYo2J8PQWXHif81
         rUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iDvRfbVf9THDBf1Pms1SmVEOSBofYzkdzChDMla8Sj4=;
        b=OgTq5v8chblMjU42WM9RCHk9CNCKgwHDLSehUeSzTYI7ahJJk03xdDOIeZ/tBgu7SB
         oE8vozPwleNpt5r3cG1yUVRcyuzxEJRQsYXHwSDMwEfQKTgP6DAFBQKs4MU8F8eJkVM1
         2A4uelszI8X4Rt6FuRt/K/SYUjOEDAdX9OP5ttVjTUrI2Yn9FmZ6pqDs5r3y6mADJEtI
         8PxAkqQwDapc30wR/m8CgJqb+6bKCH+ltlyYv56W2RpnPFqCBr9MWr7WiUMTJJWqcPjZ
         vLMBjStcEaZBd6DPVXGJvlLzgr//D11wAoddwaVPPSIzk+lm7Q/BMpXcX+dNdsftuPHk
         A1Pw==
X-Gm-Message-State: AGi0PuZbRFOWUjdSjgxeWPRX1P19J4iOzRRejeVSKjromMAssB67FPT+
        uQ89qKQpah1c5N0EuYYYkqIbSI6d5bR1g+Q3w20=
X-Google-Smtp-Source: APiQypKaZSsBFHDRc6ZNUTLfTPUf2bTUloz2jpZ0tEKTf3jF6cmVOHfHfGCVReoOY4Y95r/EhQK2KpRAhO9PiADwFPw=
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr15266052ioc.178.1587386964385;
 Mon, 20 Apr 2020 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200419135011.18010-1-peron.clem@gmail.com> <20200420084547.q5xqlbnmug7l45p2@gilmour.lan>
 <20200420103927.uvzotrolz2inz6q2@core.my.home> <CAJiuCcdDge21pRmN8LzKv_tMqBoD9KHg96MUxDS9gp0+xbroJg@mail.gmail.com>
 <20200420124739.pxmtvktlyt7ppfjb@gilmour.lan>
In-Reply-To: <20200420124739.pxmtvktlyt7ppfjb@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 20 Apr 2020 14:49:13 +0200
Message-ID: <CAJiuCcdy-yKU61z30CxY7=aMedaRp928_FYffB9X=ergj9a2kw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Add support for Allwinner H6 DVFS
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Mon, 20 Apr 2020 at 14:47, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Apr 20, 2020 at 02:36:32PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Ondrej, Maxime,
> >
> > On Mon, 20 Apr 2020 at 12:39, Ond=C5=99ej Jirman <megous@megous.com> wr=
ote:
> > >
> > > Hi Maxime,
> > >
> > > On Mon, Apr 20, 2020 at 10:45:47AM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >
> > > > On Sun, Apr 19, 2020 at 03:50:04PM +0200, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > > > Now that required drivers are merged we can contibute on DVFS
> > > > > support for Allwinner H6.
> > > > >
> > > > > This serie is based on Yangtao Li serie[0] and Ond=C5=99ej Jirman=
 work[1].
> > > > >
> > > > > Most of the OPP tables are taken from original vendor kernel[2].
> > > > > Plus there are new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> > > > >
> > > > > I wrote a simple script to randomly set a frequency during
> > > > > a random time[3]. This script is quite stressfull and set some hi=
gh
> > > > > frequency without checking temperature. This can result on behavi=
or
> > > > > that whould not occurs with the real cpufreq framework.
> > > > > As Maxime point out I also tested with cpufreq-ljt-stress-test
> > > > > (found here https://github.com/ssvb/cpuburn-arm).
> > > > > This script doesn't trigger any issue.
> > > > > I also test that that offlining CPU0 and doing DVFS on other CPUs
> > > > > works. As CPU regulator is only set for CPU0.
> > > > >
> > > > > The GPU devfreq was drop as the regulator is still not properly
> > > > > drive by panfrost driver[4].
> > > > > I will re-introduce it later.
> > > > >
> > > > > Ond=C5=99ej Jirman has an Orange Pi 3, Jernej has a PineH64 and a=
 Tanix
> > > > > TX6 boards and I have a Beelink GS1 board so I have enable these
> > > > > boards. But CPU Devfreq is really touchy has it depends on:
> > > > > board design, SoC speed_grade and environement which can affect
> > > > > thermal cooling and have different behavior for different user.
> > > > >
> > > > > If people can test this serie and give feedback, I will try to
> > > > > introduce this in LibreElec tree, so LE community can test it.
> > > >
> > > > Applied all of them, thanks!
> > >
> > > Please also apply "[PATCH v2 1/7] arm64: dts: allwinner: h6: Add
> > > clock to CPU cores" from the v2 series, otherwise cpufreq will
> > > not work.
> > >
> > > I can also send a missing patch adding the trip points, and cpu
> > > as a cooling device, that I linked in my other reply to this patch
> > > series afterwards, if Cl=C3=A9ment wants.
> >
> > Indeed I have sent using the following cmd : "git send-email --to=3DXXX=
X HEAD~7"
> > from the previous version.
> >
> > I should had do Instead: "git send-email --to=3DXXXX next/master "
> >
> > Sorry for that :(
>
> I haven't pushed anything yet, can you resend the proper branch?

Yes, I will,

Thanks!
>
> Thanks!
> Maxime
