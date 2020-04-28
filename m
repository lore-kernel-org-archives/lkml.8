Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24775C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03875206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+tarnSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgD1Ipi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgD1Ipi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:45:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43AC03C1A9;
        Tue, 28 Apr 2020 01:45:37 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b18so19490805ilf.2;
        Tue, 28 Apr 2020 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6kCsx7wAGrjx+68NCUXouJOmxNELyFgrhEYo7Fq+h8c=;
        b=C+tarnSyrkRFmLdjp00BVNxJrJ0ECb6qa8qLWQHwCmOTyQKvszlum4fa/JNc2wjjEQ
         +xod5yiVp1QO2KOfl2oB5irbr2SxB1lONwU9NFwP/GVoQK452rohz+Q27cDd51v5ESBr
         o5o0Pf89nKmNRXSF5FRg83HaXgylmKkDtxIE5JZBmF3ndhcgE2JUwhNuu4shMoirplEn
         th9NtWOdp9DrrexTI8ZYXwbrGtkpzqCV4p7DRs3dGB6awr7IqzUWq0bZzC76VzI+malR
         o2WLy2MsCHkCTERhB23oyWJRGOPYzFah7aFeoVR6Lefrng956pbiQ24iXrswaR1gJRvn
         xrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6kCsx7wAGrjx+68NCUXouJOmxNELyFgrhEYo7Fq+h8c=;
        b=Q7sQI8vKxLpp3slJo3uQZRYSC1PErSOgxrWYlZSjoYnL6gN6z4FEdp7iRebLiFfNpg
         KH6Jo/UfXWBZIGIVouA9ftBKWBPtEuGveBVLa3WBc53Yag2/wkkknuNO80dHZSWDtTua
         R2KhLJZkMBv1cQOMblS8bzYV6uAOklw16/41hJp5cQM1+lvl6pQ6Gsmxhmn8EQmpfxlH
         swu5Raww9li5RaEXE15kzu1RGeYS/Lq5LqUiCCyZ8bIxqiNBiiLeKmmiFT7PDStE4KU2
         DnZ/rhVqXRz/KQ3MIeSHWUgX3ZuDXAWTT1R7GBj5Qd6A2juv7Gx2L6SrwmGhnJzMlhBb
         VXRg==
X-Gm-Message-State: AGi0PuYi+hJLFylJGyZ4Oer2sP79iUP7iGgf10EfWpQTQRMTFPp3iTAC
        jwEwc8/LbYtPHEOi9CI8+J6JyI1NjWA459YCDWA=
X-Google-Smtp-Source: APiQypIkK7jh6sesRljWxwYK1L0SgBoutO7PcaD6mBLQhY4xPsDiYxUKbG/slHl1xbUFXGsowlIYhRXsrV13Ijtvcss=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr23744535ilm.59.1588063537068;
 Tue, 28 Apr 2020 01:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200426121709.1216-1-peron.clem@gmail.com> <20200428075156.65okklrupingiza6@gilmour.lan>
In-Reply-To: <20200428075156.65okklrupingiza6@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 10:45:26 +0200
Message-ID: <CAJiuCcdnGW+jC8NQPWaE_fSEaNfrCcLhkmy3-L-ZXQmgQdsEKw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Use dedicated CPU OPP table
 for Tanix TX6
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 28 Apr 2020 at 09:52, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 26, 2020 at 02:17:09PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> > voltage to meet OPP table. The DVFS is not working as expected.
> >
> > Introduce a dedicated OPP Table where voltage are equals to
> > the fixed regulator.
> >
> > Reported-by: Piotr Oniszczuk <warpme@o2.pl>
> > Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables =
for Tanix TX6")
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> I'm not really a big fan of duplicating the OPPs, since that would make a=
n
> update of those very likely to be overlooked for that particular board (a=
nd
> since it's a board that not a lot of people have, it would be harder to n=
otice
> too).
>
> IIRC, removing the cpu-supply property should work as well?
Yes it would works also the OPP will provide a dummy regulator.

But as it has been introduced and there is a cpu regulator in the real life=
.
I thought it was a bit a hack to just remove it but as you wish.

Regards,
Clement



>
> Maxime
