Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CECC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FA52070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C10XJss4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCTNHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:07:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60966 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UruEh+QPWdIyoj6UKAjvgmG3F1nB4TGGozNiE2Ak4pc=; b=C10XJss4RLdfq+4z3wT/a+fgR
        tObaHD6QoI3lh7aLZROqwKhC1Sqv97jd+JrGbdu3hcTcd+VgxgM2Iw+yCyyKnY+GSUy8G4UrkQhLE
        TV8fYLln/wpBktD5R+BWmmH7epdgvg4qrOeKps6QyAhmflVmx/9s5iNflLUnNgUiIdgRC3vMcediF
        QfLm0zI7iVFx0DXiV6pdfmkrJUtb7CYJkf8Q+/XJ3ADVQI9O6ffdbKQ0MqSGUrot7qyQJDB1qeyiR
        ijaOXbXNBH2f67DwMeVtqSP26LdG+lii9zV5J7b/ncmKurxaVcnUOAKHfb62xCrIpYHTwK3XhJgda
        9yCQuLFHw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:34882)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jFHMc-0008Pq-U1; Fri, 20 Mar 2020 13:07:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jFHMb-0005ni-1d; Fri, 20 Mar 2020 13:07:01 +0000
Date:   Fri, 20 Mar 2020 13:07:01 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 04/15] arm: Don't use disable_nonboot_cpus()
Message-ID: <20200320130700.GR25745@shell.armlinux.org.uk>
References: <20200223192942.18420-1-qais.yousef@arm.com>
 <20200223192942.18420-5-qais.yousef@arm.com>
 <20200320110430.jozfyrqqx272266u@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320110430.jozfyrqqx272266u@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:04:31AM +0000, Qais Yousef wrote:
> On 02/23/20 19:29, Qais Yousef wrote:
> > disable_nonboot_cpus() is not safe to use when doing machine_down(),
> > because it relies on freeze_secondary_cpus() which in turn is
> > a suspend/resume related freeze and could abort if the logic detects any
> > pending activities that can prevent finishing the offlining process.
> > 
> > Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> > is an othogonal config to rely on to ensure this function works
> > correctly.
> > 
> > Use `reboot_cpu` variable instead of hardcoding 0 as the reboot cpu.

I think that should be a separate change - you have two separate
changes in this patch:

1. to switch to using the new helper.
2. to change the CPU that we potentially use for the final steps of
   shutdown

These should be two seperate changes, so if (2) causes a regression
it can be reverted independently of (1).

> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > CC: Russell King <linux@armlinux.org.uk>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> 
> Hi Russel
> 
> Does the updated version look good to you now?
> 
> Thanks
> 
> --
> Qais Yousef
> 
> >  arch/arm/kernel/reboot.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
> > index bb18ed0539f4..0ce388f15422 100644
> > --- a/arch/arm/kernel/reboot.c
> > +++ b/arch/arm/kernel/reboot.c
> > @@ -88,11 +88,11 @@ void soft_restart(unsigned long addr)
> >   * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
> >   * kexec'd kernel to use any and all RAM as it sees fit, without having to
> >   * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
> > - * functionality embodied in disable_nonboot_cpus() to achieve this.
> > + * functionality embodied in smp_shutdown_nonboot_cpus() to achieve this.
> >   */
> >  void machine_shutdown(void)
> >  {
> > -	disable_nonboot_cpus();
> > +	smp_shutdown_nonboot_cpus(reboot_cpu);
> >  }
> >  
> >  /*
> > -- 
> > 2.17.1
> > 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
