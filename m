Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74115C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62864221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g+2hVCdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHFW2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHFW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:28:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EBFC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ROL26wzrBi3BA4eoI4YIkoABUg6mXp3MZ30GChFull0=; b=g+2hVCddKbli5fq/v23yGI4l4
        y152Oi78OWzqSYJGVTI0s2Uh0Uc2BET8ObNRpqfiFLUH0Ba+Y+33cwPgMq1CLSNW5IthPAw0atRDi
        NEffDvexq+clGUN9DX9/8D0eGj1HVtiT3XzwwmoQGHnSvIaZhqX6D/kehyQ0tN1/QvjMz67M26LXL
        3JYupLPS1qUE57EKkRMYO7CPg28XUeTeGQTltOPIALictEHR5AiqvoQAP17hXK6GOQfa2UqpxgdmP
        vNLP81Xw4OjJtA9woPXFHJ0hNT24YGFwWHE+opuiwwmB62PhUKOpkzAAL0l5uHm9kZKoY4fBAZh6F
        BEakLZMkA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49236)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k3oNM-00059q-RH; Thu, 06 Aug 2020 23:28:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k3oNM-0006YP-22; Thu, 06 Aug 2020 23:28:40 +0100
Date:   Thu, 6 Aug 2020 23:28:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        Pavel Labath <labath@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
Message-ID: <20200806222839.GG1551@shell.armlinux.org.uk>
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck>
 <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
 <CAD=FV=WgoVN-scgT41R=6Toif2Zrskb3rNzZn_xbP_-ByZC1MA@mail.gmail.com>
 <20200806154144.GD1551@shell.armlinux.org.uk>
 <CAD=FV=XBinO0+uSt_sDTw_YFiZC4Gf8RMSC9ycDg+RWH=63Tog@mail.gmail.com>
 <CAD=FV=XAi6J1LZRZJacTVhX=PYCWs3-5MtS_bG2_ZTuQPfxstQ@mail.gmail.com>
 <20200806220241.GE1551@shell.armlinux.org.uk>
 <CAD=FV=UMc=YVpDRfWdtv_g5=zhCRg=y8JeszYQLUZbgtHC6dLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UMc=YVpDRfWdtv_g5=zhCRg=y8JeszYQLUZbgtHC6dLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:26:09PM -0700, Doug Anderson wrote:
> Hi,
> 
> Sigh.  OK, hopefully correct now:
> 
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8997/2

LGTM.  Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
