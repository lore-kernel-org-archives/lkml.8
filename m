Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF56CC11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91605206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Zk+cdZTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgBTVPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:15:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38484 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBTVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:15:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id p23so35395719edr.5;
        Thu, 20 Feb 2020 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0r8UtKklC8vn0exQFm1xc2bM7Px85fwUILOFwxpfXc=;
        b=Zk+cdZTJrrQGLS4LPCXUuDR4TnwujssZT/tflyRWzR4m5EuB74oGIb4XNsW8ZpTcV6
         0bMOKocFAC5Aws/uPZuTdgEtDPOjoyukKgAGlNmDCD977jXJDA419hAYFYPI1NXVuJQo
         h430UdKqeKyZxLWCK4GO4NKiUkni6qDd7foBhauhsIrn9EgNs9smHTIWE+gilQ/16aAA
         qfn6Hasa8dA4DT4sDD1+nxpUPc7G2OPFgzjY066Dx0k/Rav91/e4+SBstXos/38maA95
         wnZg7wriDejBaAEUGOUJBhPWdWDn0GFAE47f0mBxFDKwa5X6dxLRje0PnLK0qSHVgZ26
         oMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0r8UtKklC8vn0exQFm1xc2bM7Px85fwUILOFwxpfXc=;
        b=HGnhpVFR1sxTmIAhQm6Ubn4AWXVyclQVIYWY3Vhhqbec7VeBiZRFyTinMhS5Op9LxF
         et1VtkbbO7+POH0h68Lr4mS/wdU5HjEBAmuw0BxNDAXSbkME9DDlYnJfe+zBsku5f8rV
         VrZI5+9Ed19GOC7NdSzf0+GklrP+jKr3Wj2ksEr8gwcW6j2GW1lfg4mwlKY0tH7GIN1v
         eFNPyboDYgWvLJ/esMPLHW4Lp/bstuODYFRbYD5DnTg/Zl7sfRy+wbcyry+vKzFr8FZs
         FjZZ5ogVLIzn27oFAeaaOsucMmmPlHXKLD4wa0FBb47+kCW5PGh/gYJr9NcOcv8zIwCt
         Iu1w==
X-Gm-Message-State: APjAAAVmqzhu/CNdRTlvFT+9Mo/PalwAFnP6hYizUvz1aF/D8EnHTTiJ
        qmj9E3U/mrM8sOguoPBjNPlFUq/kWmDZq+7K/jg=
X-Google-Smtp-Source: APXvYqwXYPTGE8gx5kvAp7lnVSFQVA+NMeL3QVC6+h/cuRK/8EgB3ahTv0Vbyn5nmgxN9HxsBKLSAoZv7ayNwuuXxTA=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr29262250edb.146.1582233317366;
 Thu, 20 Feb 2020 13:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com>
 <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com> <CANAwSgSaQgU=H3h0S9deT11HA8z9R=Fhy5Kawii9tSBxKf2Wgw@mail.gmail.com>
In-Reply-To: <CANAwSgSaQgU=H3h0S9deT11HA8z9R=Fhy5Kawii9tSBxKf2Wgw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 20 Feb 2020 22:15:06 +0100
Message-ID: <CAFBinCCSosE1XfwbKZOR9G+DVYg8zFcKShmTNWUhh1e8W0VoAQ@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Feb 17, 2020 at 2:30 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > @@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
> > >                       &g12a_sys_pll.hw
> > >               },
> > >               .num_parents = 2,
> > > -             .flags = CLK_SET_RATE_PARENT,
> > > +             .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> >
> > Why not. Neil what do you think of this ?
> > If nothing is claiming this clock and enabling it then I suppose it
> > could make sense.
> >
> I would like core developers to handle this.
> Sorry for the noise.
can you please resend this patch with only the change to g12b_cpub_clk?
I have no G12B board myself so it would be great if you could take care of this!


Martin
