Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3152C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63A920772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591290627;
	bh=M/AuFpehGusNMSeUle1JrJaPhNJMg0l6uzzIe1fZvf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hpP67p/EUxqMWyzX0UN+w8MQW8VM2Wa3qI0dFAbUmig+tbyFjrhW0WqA0nzZByYBV
	 2S074W41J47cZCHppZN4Ys5cPFi231V4rgqzwRtZpdlH5lltS9fi6F1+sdf3RpnDpQ
	 0D77zYkVGGQ294iQBEUAYARCSia9VEKLf3dpDyDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgFDRK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbgFDRK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D38206DC;
        Thu,  4 Jun 2020 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591290626;
        bh=M/AuFpehGusNMSeUle1JrJaPhNJMg0l6uzzIe1fZvf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfHy09iha5d2FDQtM8Dmu3HCYtV8wZdBvaIZ38Ay4pFyvLsmz5hG40mq2P8pU/gBG
         q+l+cKQJFDh5UcjfmgX5sOcB4H0GJ5+Ya8yTe7kZOsWNC2fGUeKqJEERK/4LJ+/Czl
         rPTjU+PPOhvYWFhW/MTP422CNGV63zyYHMWe4JuY=
Date:   Thu, 4 Jun 2020 19:10:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Small devm helper for devm implementations
Message-ID: <20200604171024.GA1073292@kroah.com>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
 <217b892d-678f-8c32-b9ab-a3dd238c197a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217b892d-678f-8c32-b9ab-a3dd238c197a@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 06:13:21PM +0200, Marc Gonzalez wrote:
> Looks like this series has fallen through the cracks :(
> Greg, you would be taking the drivers/base/devres.c changes?
> As mentioned in patch 2, "This patch needs testing on a platform with many clocks."
> (I've only tested using a trivial kernel module)

I can't do anything during the merge window, sorry.  Please feel free to
resend it after 5.8-rc1 is out and I will be glad to review it then.

thanks,

greg k-h
