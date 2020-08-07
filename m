Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF0BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807C6206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osmTCgse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHGBXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:23:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 18:23:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o21so463705oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGoiJwr7Yn7E8C81RuccqJ1OLqJy/5B2GmlLZzl97CY=;
        b=osmTCgsekWezaCWmBB9Fal9fGvS/B9ZLHEO/zNUnaIFHxPMRYcgjd8J32mw+CwJl/u
         t7LcYW/wgR4ddB0nPQminG/BGV8meoautGgE291F5yX/BB7hzW/sR3HtvdwwgLEylpJ6
         xZVqSoMvXPPAq5FqyM0q1LbzCD+g/vBFFo/yB10uFLsiqzKwNz2xbT+GIXiTopKtXGgT
         0Aa7+kvPGsakHXyCuSLBqYhT2UPIgDdmgQjPI+WvGzGHA8OihhXvuxt/minXpuA0mB4R
         IQuPoapIrW9o9m01ORxnrpPMiO+ZnDU6e9odE1eZrejTiMc4Tj6xl+vqu8idgUtDC9Ek
         /lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGoiJwr7Yn7E8C81RuccqJ1OLqJy/5B2GmlLZzl97CY=;
        b=KA+KBsw/IwN0o9M/vCFz/Bj72xfRc4B5BjF0Fi6Kz6QW3ElN9GhaGc5BAQRF2z8AH+
         7KzODPZu5qufPRGiJQnSaihUfzISdkONYCO2Bw3gHmPTbvQVrieG95HEq5oC9xJ/8slu
         MrBmOpU59viOPcw+ciW+1ihUuCxoGS2MWtvYc7XtmLWUXSV6+srH8ovW5PQYHsJGyvAP
         eJUrcK+Pluu1xZr+KQmmb955ZywnBGs+tULP+ORzWjMLvFxYxGxI3OXxa8CHCvsZM9sB
         kxPB2lGYZV8g39WOQu4eW8GMU202NsgbqVCwrvmxC2qN6OQ6K8Qf8c4EBTaQyQsrZURT
         SyyQ==
X-Gm-Message-State: AOAM532RkuBx4j0ILPiWxbFdR4OvbSNUgXcwwEfXnuVbJtxnXDsuZBv+
        n5XYXwLYYjzZgOmC8kjncKJYAHCjtueW2oA/+6oKvQ==
X-Google-Smtp-Source: ABdhPJwFk2nflHwOtTvVQHApMHk97eO1yiJZx+c9NT3sX6L2W+QUIqlBsciPxXNEYOGivlC0fJKcGnGDyWS8Vo0yGMg=
X-Received: by 2002:aca:f106:: with SMTP id p6mr8969952oih.169.1596763384888;
 Thu, 06 Aug 2020 18:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com> <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <f314b687-11a9-5a5e-e79e-c46dd2f16c6f@kali.org> <78ad0914-6173-f753-9eba-b7cbfbb51fd6@kali.org>
 <CALAqxLXPN9kThwF32YoWyApaWnfjthANXj3uk65Wc3ddaJQFFQ@mail.gmail.com> <20200807004001.GF20825@builder.lan>
In-Reply-To: <20200807004001.GF20825@builder.lan>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 6 Aug 2020 18:22:53 -0700
Message-ID: <CALAqxLWwY00PVUL7EM-tgbXeB5h8MsfPo7EFZTfDSzbb3P3eqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 5:43 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 05 Aug 14:57 PDT 2020, John Stultz wrote:
> > On Wed, Aug 5, 2020 at 2:47 PM Steev Klimaszewski <steev@kali.org> wrote:
> > > On 8/5/20 4:16 PM, Steev Klimaszewski wrote:
> > > > On 8/5/20 3:19 PM, Saravana Kannan wrote:
> > > >> On Wed, Aug 5, 2020 at 12:44 AM John Stultz <john.stultz@linaro.org> wrote:
> > > >>> <sigh>
> > > >>> So this is where I bashfully admit I didn't get a chance to try this
> > > >>> patch series out, as I had success with a much older version of
> > > >>> Saravana's macro magic.
> > > >>>
> > > >>> But unfortunately, now that this has landed in mainline, I'm seeing
> > > >>> boot regressions on db845c. :( This is in the non-modular case,
> > > >>> building the driver in.
> > > >> Does that mean the modular version is working? Or you haven't tried
> > > >> that yet? I'll wait for your reply before I try to fix it. I don't
> > > >> have the hardware, but it should be easy to guess this issue looking
> > > >> at the code delta.
> > > > For what it's worth, I saw this too on the Lenovo C630 (started on -next
> > > > around 20200727, but I didn't track it down as, well, there's less way
> > > > to get debug output on the C630.
> > > >
> > > > In my testing, module or built-in doesn't matter, but reverting does
> > > > allow me to boot again.
> > > >
> > > Actually - I spoke too soon - QCOM_PDC built-in with the commit reverted
> > > boots, however, module (on the c630 at least) doesn't boot whether it's
> > > a module or built-in.
> >
> > You may need to set deferred_probe_timeout=30 to give things a bit
> > more grace time to load.
>
> With the risk of me reading more into this than what you're saying,
> please don't upstream anything that depend this parameter to be
> increased.
>
> Compiling any of these drivers as module should not require the user to
> pass additional kernel command line parameters in order to get their
> device to boot.

So, ideally I agree, and Saravana's fw_devlink work should allow us to
avoid it. But the reality is that it is already required (at least in
configurations heavily using modules) to give more time for modules
loaded to resolve missing dependencies after init begins (due to
changes in the driver core to fail loading after init so that optional
dt links aren't eternally looked for). This was seen when trying to
enable the qualcom clk drivers to modules.

It doesn't seem necessary in this case, but I suggested it here as
I've got it enabled by default in my AOSP builds so that the
module-heavy configs for GKI boot properly (even if Saravana's
fw_devlink work is disabled).

thanks
-john
