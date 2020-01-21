Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34ECC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944AA21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ACwFHEaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAUQxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:53:34 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54046 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAUQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n3rbXd3EXmHx24tk+JhwjQAO26KwOs96OGEPn8Jzqa4=; b=ACwFHEaFEVDZNK6Opob5Vb9EW
        +iVvIIc2yxNoP3Rt5yTv6cuxRex+zJO36N1LGVHXhOLyU5wKOV9zTGXAPEo1jLulLFLjmAYuBnnkt
        c36zLea+khHwypaKCC9+8PDFntsBpmoU/Yu5cIZGOEl2+w4Ket/Mw4p4432Rx1IM05wQ2ZoLZFblW
        3BqfXv62pHan8Lzm9TizjHtPzSXBMXMkkv3iAdcjYrEbTih6igpxNIddAhfX/bB5g62vI/wXBNDCb
        6UayHwKyWwzco5XUgggeJcKC5Utf06Mvo9XRy2/nzU9OwHx9/4IPyaxvXl+bEQNOufL/lePiTRZZj
        vOTF71/XQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41388)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1itwmJ-0005xc-Bw; Tue, 21 Jan 2020 16:53:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1itwmH-0003zA-94; Tue, 21 Jan 2020 16:53:21 +0000
Date:   Tue, 21 Jan 2020 16:53:21 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] arm: arm64: Don't use disable_nonboot_cpus()
Message-ID: <20200121165321.GH25745@shell.armlinux.org.uk>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-4-qais.yousef@arm.com>
 <20200121165030.xksivf6mrhsaynq2@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121165030.xksivf6mrhsaynq2@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:50:31PM +0000, Qais Yousef wrote:
> On 11/25/19 11:27, Qais Yousef wrote:
> > disable_nonboot_cpus() is not safe to use when doing machine_down(),
> > because it relies on freeze_secondary_cpus() which in return is
> > a suspend/resume related freeze and could abort if the logic detects any
> > pending activities that can prevent finishing the offlining process.
> > 
> > Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> > is an othogonal config to rely on to ensure this function works
> > correctly.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > CC: Russell King <linux@armlinux.org.uk>
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > CC: Will Deacon <will@kernel.org>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> 
> Ping :)
> 
> I'm missing ACKs on this patch and patch 4 for arm64. Hopefully none should be
> controversial.

ARM and ARM64 are maintained separately, so you can't submit a single
patch covering both.  Sorry.

> 
> Thanks!
> 
> --
> Qais Yousef
> 
> >  arch/arm/kernel/reboot.c    | 4 ++--
> >  arch/arm64/kernel/process.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
> > index bb18ed0539f4..58ad1a70f770 100644
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
> > +	smp_shutdown_nonboot_cpus(0);
> >  }
> >  
> >  /*
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 71f788cd2b18..3bcc9bfc581e 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -141,11 +141,11 @@ void arch_cpu_idle_dead(void)
> >   * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
> >   * kexec'd kernel to use any and all RAM as it sees fit, without having to
> >   * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
> > - * functionality embodied in disable_nonboot_cpus() to achieve this.
> > + * functionality embodied in smpt_shutdown_nonboot_cpus() to achieve this.
> >   */
> >  void machine_shutdown(void)
> >  {
> > -	disable_nonboot_cpus();
> > +	smp_shutdown_nonboot_cpus(0);
> >  }
> >  
> >  /*
> > -- 
> > 2.17.1
> > 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
