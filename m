Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529E0206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Spi4GdlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgFEIP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFEIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:15:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71335C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tN8XUxtYk30HXZcIQB+wfT1DrsEeJ+YsQN2XKtbbX7E=; b=Spi4GdlUJQb6TaE0aqEr/Xm5o
        JDPFwS9x4w7vkbQyG3Kvn7x8cQSLkFYO8BGUNqDl+WuGcYd3wu29ipFZJ/wKtf+phCqfcFonqFBtr
        K4nr+HYXkzyL9zoSI1vf3kVOlVIAtyYejdo9C7p+6lZX7o9Yo772Ph6CFqB68rtPmGiCPydGveqFR
        qb2d/kTW0dt8zY+0vo8yUYi+Jn074qxUTzSz6k4+lhGb66eOmADH2u8VceTBpXe2sJOzju7FARBDu
        W3DYi+s+2fVIcOC2xksLsRi2Ch57FJY492FtcQ5uiI37Fl5pJXKcqjQ0J6a8Jh0qoezOf1Mie2cg+
        yN2mM+XhQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:39104)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jh7VY-0001bp-UW; Fri, 05 Jun 2020 09:15:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jh7VW-0007IZ-CN; Fri, 05 Jun 2020 09:15:18 +0100
Date:   Fri, 5 Jun 2020 09:15:18 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
Message-ID: <20200605081518.GG1551@shell.armlinux.org.uk>
References: <20200603184500.GC1551@shell.armlinux.org.uk>
 <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
 <20200603195853.GD1551@shell.armlinux.org.uk>
 <jhjftbbj3qi.mognet@arm.com>
 <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org>
 <jhjeeqvi3m1.mognet@arm.com>
 <20200604092901.GE1551@shell.armlinux.org.uk>
 <jhjbllzhzg9.mognet@arm.com>
 <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com>
 <jhja71ij0xr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhja71ij0xr.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:38:40PM +0100, Valentin Schneider wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 74a5ac65644f..ba846f6e805b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -439,8 +439,11 @@ config HAVE_SCHED_AVG_IRQ
>         depends on SMP
> 
>  config SCHED_THERMAL_PRESSURE
> -	bool "Enable periodic averaging of thermal pressure"
> +	def_bool n

You don't need to specify this default, as the default default is "n".
"bool" will do.

You should never need to use "def_bool n" or "default n" for anything
this simple. There are more complex cases where there may be multiple
conditional "default" lines where it may be necessary, but the majority
of cases where people use these are completely unnecessary.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
