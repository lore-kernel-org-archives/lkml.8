Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BCFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24BC206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D1Q6EoCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgHFRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgHFQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:30:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF464C002176
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SfddbmLFlUQ0+2CTU0mFNxT8HQmZBOw2XCU66BDvkhs=; b=D1Q6EoCdlM8ll41mrAcZKGhTm
        pVW2jMOhfFTnt2JXtVqIaZ+mZQW6opyRTrizzkANylnv5MBDdHdW045799Oo0VejOaxfXeh0s2vNd
        63Vdl8ja/0pFIHKfux22Yh2UgYpCxDbjilE755ube/ntYMY9SPWjs2XxcanigYvmnY8fVxreZ/7+B
        tQqdbXuLK5y+BOvELwtrNI/s2rcrRf7b78FyRgbFYxHUYMAUZ5OI0N6rGSXClGfh5vRNciXOUhtCY
        1XaQo+LRdyfIT4nvvZoll6dJEWXe6yA3HnJzA5K1AIlxqsP5qlKEoAdMJs5BbgtPReWFVub/SwLGf
        kskdKohPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49130)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k3iZW-0004re-CI; Thu, 06 Aug 2020 17:16:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k3iZV-0006Jp-NZ; Thu, 06 Aug 2020 17:16:49 +0100
Date:   Thu, 6 Aug 2020 17:16:49 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        Pavel Labath <labath@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
Message-ID: <20200806161649.GB1605@shell.armlinux.org.uk>
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck>
 <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
 <CAD=FV=WgoVN-scgT41R=6Toif2Zrskb3rNzZn_xbP_-ByZC1MA@mail.gmail.com>
 <20200806154144.GD1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806154144.GD1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 04:41:44PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Aug 06, 2020 at 08:05:10AM -0700, Doug Anderson wrote:
> > Yet if I go check mainline the patch is not there.  This came to my
> > attention since we had my patch picked to the Chrome OS 4.19 tree and
> > suddenly recently got a stable merge conflict with "ARM: 8986/1:
> > hw_breakpoint: Don't invoke overflow handler on uaccess watchpoints".
> > 
> > Anyone know what happened here?
> 
> Yes.  Stephen Rothwell raised a complaint against it, which you were
> copied with:
> 
> > Hi all,
> > 
> > Commit
> > 
> >   116375be0461 ("ARM: 8944/1: hw_breakpoint: Handle inexact watchpoint addresses")
> > 
> > is missing a Signed-off-by from its author.
> 
> My reply to Stephen's email was:
> 
> > Thanks Stephen, patch dropped.
> > 
> > It looks like Doug used his "m.disordat.com" address to submit the
> > patch through the web interface, and there was no From: in the patch
> > itself, so that was used as the patch author.  However, as you spotted,
> > it was signed off using Doug's "chromium.org" address.
> > 
> > I think it's time to make the patch system a bit more strict, checking
> > that the submission address is mentioned in a signed-off-by tag
> > somewhere in the commit message.
> > 
> > Doug, the patch system does have your "chromium.org" address, if that's
> > the one you want to use as the author, please submit using that instead.
> > Thanks.
> > 
> > Russell.
> 
> Neither email got a response from you, so the patch was dropped and
> nothing further happened.

I should've also said, there's two ways to avoid that problem:

1. Provide a From: line in the standard way to tell the patch system
   who the author of the patch is (the author defaults to the known
   login email address.)

2. Update your login email address in the system to the one you
   normally author patches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
