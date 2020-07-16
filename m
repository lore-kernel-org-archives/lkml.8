Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDEC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02AC207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594931528;
	bh=Nqxulrodxo8eOevLZn2HwsAISOP60thSdFpkTzjHl1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r/9fio7TUbukcl5GpLoS0e15ixFRObSdACXyCwwGzGRtJG5iB5mTIVMdQy66eAtDy
	 z3HTNHK3ohZcUM+52Ll400S7sBp0e4zStMPzGUXJHaKShZRWpZKvmXUVpk7in0SYlq
	 dQ/tMlyV8xgxc5qQgPTbP5zb0p6I+OTUX1Z7+zrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGPUcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPUcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:32:06 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D23D207E8;
        Thu, 16 Jul 2020 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594931526;
        bh=Nqxulrodxo8eOevLZn2HwsAISOP60thSdFpkTzjHl1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cH1b0WZXXlqv/IqmIu/n/UBktooOBSfIG9m2vop4KbpespzV/W2T/ehiaxmj9JUg9
         VxNDMKimDmjtZle3uDOyH349zcEXT9hXK0vlRLqQ6ZM7lffxf175iWlO4jslFBYEzJ
         4PR5uaDaJLwyAUkGG3R+OUYtlQ67rXQPrFzrKj2I=
Date:   Thu, 16 Jul 2020 13:32:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net] net: dp83640: fix SIOCSHWTSTAMP to update the
 struct with actual configuration
Message-ID: <20200716133202.24b1b5d0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200716185650.GA1074@hoboy>
References: <20200715161000.14158-1-sorganov@gmail.com>
        <20200716185650.GA1074@hoboy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 11:56:50 -0700 Richard Cochran wrote:
> On Wed, Jul 15, 2020 at 07:10:00PM +0300, Sergey Organov wrote:
> > From Documentation/networking/timestamping.txt:
> > 
> >   A driver which supports hardware time stamping shall update the
> >   struct with the actual, possibly more permissive configuration.
> > 
> > Do update the struct passed when we upscale the requested time
> > stamping mode.
> > 
> > Fixes: cb646e2b02b2 ("ptp: Added a clock driver for the National Semiconductor PHYTER.")
> > Signed-off-by: Sergey Organov <sorganov@gmail.com>  
> 
> Acked-by: Richard Cochran <richardcochran@gmail.com>

Applied, thank you!
