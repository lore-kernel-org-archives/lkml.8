Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268E021744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJqh6yLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHGF6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGF6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:58:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543CC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 22:58:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so545666pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vcDjP1C6ckosb0QbIDQlKL+iptwbO/UQeOPmtnLI2s=;
        b=VJqh6yLUqRlU/8vDadsdticX2DRzG+Kxq9lYot76dh5LRzksBbdtgsE3LFXf3v+2rX
         0w1da7TVRlRUQze0/fbyx6j37IUSCawzGMShbULjPYcZzlvUhW+taqbIj0V2sbMgpomX
         +pVtD5tCIfwsuLkphI/IsToOBMYpnesLaC8TlxbjDeb0P1mdH7eEJf8C2AilREK5/XiJ
         k0Xp9fQemDBhFQ7xdklsZg/x+MrMUI9mqx8gjGMOcA6mXzaWdt53UnYxN1LmvzItuC6S
         UYJqOfGhypQxZX2w2thtGMwodaOTbnGtrhMzQ/iQE8OVbdBdNI4R5tmFkQ7BFso/6b3b
         yEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vcDjP1C6ckosb0QbIDQlKL+iptwbO/UQeOPmtnLI2s=;
        b=tkyMKRe/KjnBCDP+XDksoYg0FqC88zmvg92bLlP3e3YKPOVmlPWBC0mZp4a2so1Qc1
         qm2xMjwIuOnTK2Ckh6lL5ASEfIPdGZyrIK6KY+E2ysy4gHxUs8ryy876lF6h6tdm0gzM
         gXNH3GvRwLqsa+o150qp+3P/9eHok/xGtg1+btihxSqLNHI8EDdixCODKfhBDSgkv065
         Pt+qwjUBRmR2JrE80OUBXiSHCq/2475QJcsD7qWphfrvjx/C8YNAozM6QhwjODaDcpgY
         VVn5BBTJPlVG63Me2mjdm8ionlNgN15xjSgx87xA2IMOeIZtrFEf2nAhsJn0CZETu+Dt
         pVUg==
X-Gm-Message-State: AOAM531JVo+4VqTSl4tObsKNX/ay2j1GHvQ+czCeoQ/i1wbskLeKezQC
        dLx4cYvBpISZMJPmB6oUP4vubw==
X-Google-Smtp-Source: ABdhPJwHM2B8c7EJm4dXQWTDr++7oOCRLBImV+xCcdlfTN8ALIrmwPvx4ZQtiTFHGhEypTdApi+ULw==
X-Received: by 2002:a17:902:a610:: with SMTP id u16mr11166058plq.197.1596779926484;
        Thu, 06 Aug 2020 22:58:46 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f63sm8575773pjk.53.2020.08.06.22.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 22:58:45 -0700 (PDT)
Date:   Thu, 6 Aug 2020 22:58:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
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
        Loda Chou <loda.chou@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
Message-ID: <20200807055842.GP61202@yoga>
References: <20200718000637.3632841-3-saravanak@google.com>
 <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <f314b687-11a9-5a5e-e79e-c46dd2f16c6f@kali.org>
 <78ad0914-6173-f753-9eba-b7cbfbb51fd6@kali.org>
 <CALAqxLXPN9kThwF32YoWyApaWnfjthANXj3uk65Wc3ddaJQFFQ@mail.gmail.com>
 <20200807004001.GF20825@builder.lan>
 <CALAqxLWwY00PVUL7EM-tgbXeB5h8MsfPo7EFZTfDSzbb3P3eqQ@mail.gmail.com>
 <20200807013903.GG20825@builder.lan>
 <CALAqxLWmJisTA9836Rvb8f9m4hsTL7iZ=HQtz39anu2Bbgv44g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWmJisTA9836Rvb8f9m4hsTL7iZ=HQtz39anu2Bbgv44g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Aug 19:48 PDT 2020, John Stultz wrote:

> On Thu, Aug 6, 2020 at 6:42 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Thu 06 Aug 18:22 PDT 2020, John Stultz wrote:
> > > On Thu, Aug 6, 2020 at 5:43 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > > On Wed 05 Aug 14:57 PDT 2020, John Stultz wrote:
> > > > > On Wed, Aug 5, 2020 at 2:47 PM Steev Klimaszewski <steev@kali.org> wrote:
> > > > > > On 8/5/20 4:16 PM, Steev Klimaszewski wrote:
> > > > > > > On 8/5/20 3:19 PM, Saravana Kannan wrote:
> > > > > > >> On Wed, Aug 5, 2020 at 12:44 AM John Stultz <john.stultz@linaro.org> wrote:
> > > > > > >>> <sigh>
> > > > > > >>> So this is where I bashfully admit I didn't get a chance to try this
> > > > > > >>> patch series out, as I had success with a much older version of
> > > > > > >>> Saravana's macro magic.
> > > > > > >>>
> > > > > > >>> But unfortunately, now that this has landed in mainline, I'm seeing
> > > > > > >>> boot regressions on db845c. :( This is in the non-modular case,
> > > > > > >>> building the driver in.
> > > > > > >> Does that mean the modular version is working? Or you haven't tried
> > > > > > >> that yet? I'll wait for your reply before I try to fix it. I don't
> > > > > > >> have the hardware, but it should be easy to guess this issue looking
> > > > > > >> at the code delta.
> > > > > > > For what it's worth, I saw this too on the Lenovo C630 (started on -next
> > > > > > > around 20200727, but I didn't track it down as, well, there's less way
> > > > > > > to get debug output on the C630.
> > > > > > >
> > > > > > > In my testing, module or built-in doesn't matter, but reverting does
> > > > > > > allow me to boot again.
> > > > > > >
> > > > > > Actually - I spoke too soon - QCOM_PDC built-in with the commit reverted
> > > > > > boots, however, module (on the c630 at least) doesn't boot whether it's
> > > > > > a module or built-in.
> > > > >
> > > > > You may need to set deferred_probe_timeout=30 to give things a bit
> > > > > more grace time to load.
> > > >
> > > > With the risk of me reading more into this than what you're saying,
> > > > please don't upstream anything that depend this parameter to be
> > > > increased.
> > > >
> > > > Compiling any of these drivers as module should not require the user to
> > > > pass additional kernel command line parameters in order to get their
> > > > device to boot.
> > >
> > > So, ideally I agree, and Saravana's fw_devlink work should allow us to
> > > avoid it. But the reality is that it is already required (at least in
> > > configurations heavily using modules) to give more time for modules
> > > loaded to resolve missing dependencies after init begins (due to
> > > changes in the driver core to fail loading after init so that optional
> > > dt links aren't eternally looked for). This was seen when trying to
> > > enable the qualcom clk drivers to modules.
> > >
> >
> > So to clarify what you're saying, any system that boots successfully
> > with the default options is a sign of pure luck - regardless of being
> > builtin or modules.
> >
> >
> > And there you have my exact argument against the deferred timeout magic
> > going on in the driver core. But as you know people insist that it's
> > more important to be able to boot some defunct system from NFS than a
> > properly configured one reliably.
> 
> I'd agree, but the NFS case was in use before, and when the original
> deferred timeout/optional link handling stuff landed no one complained
> they were broken by it (at least at the point where it landed).

I did object when this was proposed and I've objected for the last two
years, because we keep adding more and more subsystems to follow this
broken behavior.

> Only later when we started enabling more lower-level core drivers as
> modules did the shortened dependency resolution time start to bite
> folks.  My attempt to set the default to be 30 seconds helped there,
> but caused trouble and delays for the NFS case, and "don't break
> existing users" seemed to rule, so I set the default timeout back to
> 0.
> 

I can't argue with that and I'm at loss on how to turn this around.

> > > It doesn't seem necessary in this case, but I suggested it here as
> > > I've got it enabled by default in my AOSP builds so that the
> > > module-heavy configs for GKI boot properly (even if Saravana's
> > > fw_devlink work is disabled).
> > >
> >
> > With all due respect, that's your downstream kernel, the upstream kernel
> > should not rely on luck, out-of-tree patches or kernel parameters.
> 
> I agree that would be preferred. But kernel parameters are often there
> for these sorts of cases where we can't always do the right thing.
> As for out-of-tree patches, broken things don't get fixed until
> out-of-tree patches are developed and upstreamed, and I know Saravana
> is doing exactly that, and I hope his fw_devlink work helps fix it so
> the module loading is not just a matter of luck.
> 

I don't agree with this, upstream should be functional in its default
configuration. Out-of-tree patches might be necessary to enable features
or get the most out of the hardware, but what we have upstream should
work.  And no, this is not always the case, but we should at least aim
for this.

> Also I think Thierry's comments in the other thread today are also
> good ideas for ways to better handle the optional dt link handling
> (rather than using a timeout).
> 

I'll take a look at that, but to repeat what I've said many times
before, for Qualcomm platforms there's pretty much no such thing as
optional links.

Regards,
Bjorn
