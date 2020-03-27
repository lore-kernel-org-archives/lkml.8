Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FD1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4387820578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxN7gRGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0L3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:29:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36667 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0L3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:29:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so3353884plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qcf1rNOw05Dfij57btjIVq6nb9rSLDxT4zXKFbFD/Fs=;
        b=XxN7gRGD6bc53fQXcFgCxiesTztZx0yxgVvgYr4fj8ahRtsdeCpH42hxR/oncDUG2E
         zppmEVJAoGMIjPcpRXfjGvOA4zYUpQBbM6Njnd8APE9yuPv9/LkJu3MRx9q1tWOgyabH
         bSzPt2ve5y2Ermj3lIH5HZ62McrLIV3qxei9RwI5HagI/onBBUavweIe4lRx+dczwL8p
         87XINGrRWLyNuFKhjzru+HcyVxrCTlS+2AICL48fqV0DNEFtdT+mN1oU/H74Nytog1El
         UFyMY5WMbm/7ApqO+wKU3vcIFAAoVzRDrOAndCcNdV3jcdPx98iKcTMtLo4WsP80VbV9
         gvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qcf1rNOw05Dfij57btjIVq6nb9rSLDxT4zXKFbFD/Fs=;
        b=OZppTS/dSXJEOpqgCtu8qRvpI2EDIAHeoF9v9po46NpYUNS2bX2FXOQKnjccrCdEaC
         Jk4kc/l09QCSww89X9iMulHpvpvWzdM7Ez7MHldU6YtFOyq2nsY49QzsN4QECeZyygR7
         lkHAF29r9tkqFCiBUCXIFFbx3Ebzc73kZBLXY6C/C08mdtNuHPaAatr7Er4rNJIow/YH
         +MgQlF4QUcegtHTMD3+LmsC203Ccq0GlZrJTgd3BZEsmd55/3BuAxM7oP0yAf3h3gOZx
         e3y66uBohlnGkI1TNt/5pmTjGUXGd0WXPHnYPAByzew9f03pYNr9PEM3mmG0F4kr9if2
         NJow==
X-Gm-Message-State: ANhLgQ0plrJ7pi6l/KYFpNhbeoRA3CSfxBre/8fFPVdL21HYsmVYepj2
        xdeIN01m3sqLKUvPd8tcRaE=
X-Google-Smtp-Source: ADFU+vvSIQ1WaAe23bl2bGWcfsCpE/MOKlHN075cVB1FcEc48YZV4/DhsITy6mvXtP65NBJWZU/rYg==
X-Received: by 2002:a17:90b:3606:: with SMTP id ml6mr5353202pjb.172.1585308555602;
        Fri, 27 Mar 2020 04:29:15 -0700 (PDT)
Received: from localhost ([183.82.181.40])
        by smtp.gmail.com with ESMTPSA id h95sm3530804pjb.46.2020.03.27.04.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 04:29:15 -0700 (PDT)
Date:   Fri, 27 Mar 2020 16:59:13 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
Message-ID: <20200327112913.GA8711@afzalpc>
References: <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl>
 <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
 <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc>
 <20200325114332.GA6337@afzalpc>
 <20200327104635.GA7775@afzalpc>
 <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
 <20200327111012.GA8355@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327111012.GA8355@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Mar 27, 2020 at 04:40:12PM +0530, afzal mohammed wrote:
> On Fri, Mar 27, 2020 at 11:55:36AM +0100, Arnd Bergmann wrote:

> > To make sure I get the right ones, could you bounce all the patches that are
> > still missing to soc@kernel.org to let them show up in patchwork?
> 
> Done.

Sorry, i first forwarded, after that i bounced all, but not able to
see the bounced ones in patchwork, only the forwarded ones.

> If it helps, i can send the same patches w/ tags received as well.

Let me know if if anything more needs to be done from my side.

Regards
afzal
