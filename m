Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F0BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B54324653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lqWja4lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAURFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:05:19 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54256 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAURFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HOkuQLxE1IM33Ws1DA0iCvA3nHSpKBt03fizcakeBVI=; b=lqWja4lTgiHFf7h/oDfSYwCdn
        ffE1FbqEvVVa0ZyuzTEB7L+9H9DVIFJoLjBxGAXw4ry7Xhq5p1/2yEQ8XD4RiFRYDjvygjcfhzVIx
        FytKHCkFcdu4WuDthrdhSBR8BbUTfCXExC/rH+yigGw/Rwr4gQ4cqWDmq1AnC+PHJsyDEMyRaBUpb
        K4M6JwWJ6rdSQGiCGVjD00NhBrp7mCIU66sDbHl0dwGSxPeJZGXQXFZv5MKwRbi7BROmZcoMbI+rd
        glFn2AvJ9ISNYvF2qD7Oghf3xAJHZdEE2ptzb/++AM9fOjRTiqpAGbpv6pXA6GYrQMNTkHeTOP1uU
        MECN0fQgw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37252)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1itwxk-00062b-CI; Tue, 21 Jan 2020 17:05:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1itwxj-0003zR-Nj; Tue, 21 Jan 2020 17:05:11 +0000
Date:   Tue, 21 Jan 2020 17:05:11 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] arm: arm64: Don't use disable_nonboot_cpus()
Message-ID: <20200121170511.GI25745@shell.armlinux.org.uk>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-4-qais.yousef@arm.com>
 <20200121165030.xksivf6mrhsaynq2@e107158-lin.cambridge.arm.com>
 <20200121165321.GH25745@shell.armlinux.org.uk>
 <20200121165809.3kk3xauky4vjp5ni@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121165809.3kk3xauky4vjp5ni@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:58:09PM +0000, Qais Yousef wrote:
> On 01/21/20 16:53, Russell King - ARM Linux admin wrote:
> > On Tue, Jan 21, 2020 at 04:50:31PM +0000, Qais Yousef wrote:
> > > On 11/25/19 11:27, Qais Yousef wrote:
> > > > disable_nonboot_cpus() is not safe to use when doing machine_down(),
> > > > because it relies on freeze_secondary_cpus() which in return is
> > > > a suspend/resume related freeze and could abort if the logic detects any
> > > > pending activities that can prevent finishing the offlining process.
> > > > 
> > > > Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> > > > is an othogonal config to rely on to ensure this function works
> > > > correctly.
> > > > 
> > > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > > CC: Russell King <linux@armlinux.org.uk>
> > > > CC: Catalin Marinas <catalin.marinas@arm.com>
> > > > CC: Will Deacon <will@kernel.org>
> > > > CC: linux-arm-kernel@lists.infradead.org
> > > > CC: linux-kernel@vger.kernel.org
> > > > ---
> > > 
> > > Ping :)
> > > 
> > > I'm missing ACKs on this patch and patch 4 for arm64. Hopefully none should be
> > > controversial.
> > 
> > ARM and ARM64 are maintained separately, so you can't submit a single
> > patch covering both.  Sorry.
> 
> Sure I'd be happy to split.
> 
> It was just a single line change and I expected Thomas to pick the whole series
> up, so I didn't think there'd be an issue in combining them up since they're
> identical.
> 
> Do I take it you have no objection to the code change itself and just would
> like to see this split up?

I do have an objection to the new function you're introducing in patch
1.  See my reply to that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
