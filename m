Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E51C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7352076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzoubfPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYLni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:43:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35060 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:43:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id g6so719556plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8iyeGw5w2tbRML8NAgJCo0IAIFK3QN8wW86R3syQN4I=;
        b=lzoubfPixbOKlHDqdSdOUeHr1qBYe2Uf6DriewATUvR/TLiH5XybPU9NWfbxxJ5mTk
         AAiw5T+zXp2R0vKl5X1oLe2LwTeDnTo43kw9SmsS5t0O5jcFjCNxF6or8fuIdKlia5Mj
         CyeLy8wRnTHwkDDZMuWRQbW5N8IfuqZfynPPnfbqKZlkp9kqxu1TftNWpajpCzzUS8Xw
         VmJNWzCf49CJ2SKdmITGMcL26Ze2bL8iIlDQmGAk3VQ955o7X78ycVnGD9Xeohuq9Scu
         NW2LzjlPu0ttRBdKjx0nsfK3wgyyB7eDS/gfeNzi0D5Fa0z9owSYbs9e0GyHxC8P3qbR
         RqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8iyeGw5w2tbRML8NAgJCo0IAIFK3QN8wW86R3syQN4I=;
        b=DpZ/vjF2ZFj1J8hP0C9aj1K9Sd2ewuo0PVpPji2s5ykKmo3FfvdoxoNIvT8VkyM/B0
         7VGW09KUObwG2exyKrUrMtPGouFgAs4l/g81omkbmJhjzc5rSV9UR2E60zpvenq9pv4T
         962JM+8nx6yu94uSb11m2VwMI1TqbBaQLl7zA7xTvoCmrTYwMhLF8CLYbYnbPiStF5k9
         m8CgBVODin6qCuedqdcoqsb59Y2PXL00XEC+9sEzyWxOVwYmbuFZU2Q/Z1vGnmP+8+Pm
         6uCMcG0paqI/mFsjimywrVB1ycXeuMjqLaaoUvIBBHqnOecXh32LFLIeXlbMdWqL6tgt
         4SFQ==
X-Gm-Message-State: ANhLgQ1wGxh+/yoWIfbMRjHRof1mIr4XzB7iLWXODP8viNmRWO5MoTBK
        1XSfuYPWv/U2WTBGA85Ai0Y=
X-Google-Smtp-Source: ADFU+vurlWVPRUWCZZfGTSANeiGP94Kbo5bzEsvfddLhBKgcIM5lu2yHILRBxfH2Y40aRzoOkvWA/g==
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr3022707pjb.186.1585136615154;
        Wed, 25 Mar 2020 04:43:35 -0700 (PDT)
Received: from localhost ([49.207.53.56])
        by smtp.gmail.com with ESMTPSA id d13sm4283141pjs.44.2020.03.25.04.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 04:43:34 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:13:32 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, arm@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
Message-ID: <20200325114332.GA6337@afzalpc>
References: <87mu8ppknv.fsf@FE-laptop>
 <20200302031736.5or4ww5a4l7zomfo@vireshk-i7>
 <20200308161903.GA156645@furthur.local>
 <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl>
 <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
 <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317043702.GA5852@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

On Tue, Mar 17, 2020 at 10:07:02AM +0530, afzal mohammed wrote:

> + soc@kernel.org, arm@kernel.org,
> in case it helps to reduce the chances of below mail getting slipped
> thr' the cracks.

> On Fri, Mar 13, 2020 at 09:15:20PM +0530, afzal mohammed wrote:

> > Hi Olof, Arnd,
> > 
> > This is regarding cleanup of setup_irq() usages & replacing it w/
> > request_irq(). Earlier it was sent as single series spanning all
> > architectures & drivers, later Thomas Gleixner suggested [1] to take it
> > thr' relevant maintainers. As for ARM, there is an additional layer of
> > sub-architecture maintainers, for ARM, patches were sent to relevant
> > subsystem maintainers & mailing list, all copied to LAKML as well.
:
:
> > Of this,
> > (1) OMAP, (2) ebsa110 & (3) rpc are already in linux-next.
> > (4) footbridge (Russell) - there was a build warning, so he dropped
> > after applying to his tree, i have submitted the newer fixed version in
> > his patch system.
> > (5) orion - Andrew has given Reviewed-by & Gregory mentioned that he will
> > take care of it.
> > So if things goes as expected 1 & 5 will be coming to you thr' sub-arch
> > maintainers, while 2-4 directly via Russell

footbridge & orion went into -next around a week back

> > Now we are left with five (6-10),
> > (6) ep93xx - Alexander has given Acked-by & mentioned to take thr' Arnd
> > (7) spear - Viresh has given Acked-by & mentioned to take it thr' Arnd
> > (8) cns3xxx - Krzysztof has given Acked-by (though not copied to lists,
> > he has been cc'ed here)
> > (9) mmp - Lubomir has given Acked-by & Tested-by & mentioned to get it
> > thr' Olof
> > (10) iop32xx - per get_mantainer, an orphan
> > 
> > Can you please include the patches 6-10 directly into the armsoc tree ?,
> > Let me know if anything needs to be done from my side.

Can you please consider for inclusion the above 5 patches.

Sorry for pestering, i understand that none of the ARM SoC pull requests
has been picked up as opposed to what happens normally by this time of
development cycle. Still asking as this is part of tree wide series &
it is safe to send core removal patch of setup_irq() to Thomas only
after all it's usages have been removed.

REgards
afzal

> > [1] https://lkml.kernel.org/r/87y2somido.fsf@nanos.tec.linutronix.de
