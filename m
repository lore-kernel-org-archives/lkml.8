Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69A72070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jyzicPHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgEULqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgEULqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:46:18 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DBC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rsieF57gufe7ou9V7L0Dwppgjn2RE0LWW3aj4epHibE=; b=jyzicPHNA03f4JzG2fuRl4fCA
        YDU9nB+jas7c6+LLf0xryPU806VK8AaddWAoYgPjLoXhQNq4ZWX2vB5XDz4oabalOKFNLqCTEAhAT
        kp8U3++R/5dxFUqi1ocSGPR6KeeMTHY3pDJf5nPdVuKPC+RU3aFQOYJ/KUiI0wgZ/6ctl8KwNBE75
        M2Kp4JHyjF8PN5I53ibZSpB0gi5/Q6pPnzzqYi7W15PqyuzICvVlteXaHyib27cFhTnRbiQLmuiRb
        bbUN4HsWB69tKtUgBqd73iNdK/qr4SAdE1T0sSy7ulWGOKD/ZAuemESLH2HAeuHUUvPXGM8RMedY9
        cWnWtxUgQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:60832)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jbjeM-0002Ki-Dr; Thu, 21 May 2020 12:46:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jbjeJ-0000Ab-BN; Thu, 21 May 2020 12:46:07 +0100
Date:   Thu, 21 May 2020 12:46:07 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
Message-ID: <20200521114607.GP1551@shell.armlinux.org.uk>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck>
 <20200521081055.GD1131@bogus>
 <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
 <20200521101422.GO1551@shell.armlinux.org.uk>
 <CAK8P3a3cPPiprEpF_k-GWAgWSZiP3Qp3v++jvS_8W17Ns4_HGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3cPPiprEpF_k-GWAgWSZiP3Qp3v++jvS_8W17Ns4_HGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:31:32PM +0200, Arnd Bergmann wrote:
> On Thu, May 21, 2020 at 12:14 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, May 21, 2020 at 11:06:23AM +0200, Arnd Bergmann wrote:
> > > Note that the warning should come up for either W=1 or C=1, and I also
> > > think that
> > > new code should generally be written sparse-clean and have no warnings with
> > > 'make C=1' as a rule.
> >
> > No, absolutely not, that's a stupid idea, there are corner cases
> > where hiding a sparse warning is the wrong thing to do.  Look at
> > many of the cases in fs/ for example.
> >
> > See https://lkml.org/lkml/2004/9/12/249 which should make anyone
> > who sees a use of __force in some random code stop and question
> > why it is there, and whether it is actually correct, or just there
> > to hide a sparse warning.
> >
> > Remember, sparse is there to warn that something isn't quite right,
> > and the view taken is, if it isn't right, then we don't "cast the
> > warning away" with __force, even if we intend not to fix the code
> > immediately.
> >
> > So, going for "sparse-clean" is actually not correct. Going for
> > "no unnecessary warnings" is.
> >
> > And don't think what I've said above doesn't happen; I've rejected
> > patches from people who've gone around trying to fix every sparse
> > warning that they see by throwing __force incorrectly at it.
> >
> > The thing is, if you hide all the warnings, even for incorrect code,
> > then sparse becomes completely useless to identify where things in
> > the code are not quite correct.
> 
> Adding __force is almost always the wrong solution, and I explictly
> was not talking about existing code here where changing it would
> risk introducing bugs or require bad hacks.

I'm using existing code to illustrate the problem with your idea of
"sparse-clean" new code, trying to show you that it is not about
being sparse clean, but about being correct.

> However, when writing a new driver, sparse warnings usually
> indicate that you are doing something wrong that is better addressed
> by doing something different that does not involve adding __force.

Right, but if you lay down a rule that says "new submissions must be
sparse clean" you will get people using __force to shut sparse up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
