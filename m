Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50049206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="oO3KEZHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFARbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:31:31 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:42220 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFARbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:31:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49bMfS2W0LzLn;
        Mon,  1 Jun 2020 19:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591032689; bh=OcbJRSI9gSF9z5NgduN2oVxJ6vT/DUHo/GDJNy7Y0Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oO3KEZHmFcixsHiF3qnNmW6/EaRrzo5ZWLa8usHOmKZLeqcBlzOwyoIXVFZ5y2Bzy
         tYH2SgKLRYiMAXaI/xPqQBRZbuetTrK8vnZPUl6MkAwaFocrSHsyqpDoRXVk8L5dU6
         +L26ikeDTAIUDCRYAkfRPurU8uZZaA9GQk/26W0lNFaSPugQp9KJ1XW14ZEd+XO82Z
         +21ysbjhAD3kzwfDgnR3vEkubG4VA76j0epEm3xkR/NRKIgRLDjee+Nv/J0E4BqqBS
         RuMZNzijow8bL4OoAChoVn+m8AiEoJ9ltbgttpX/lfcIUxMiGZnsAqitqjYTUAzdgK
         YIJSeGX1Pe/qA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 1 Jun 2020 19:31:27 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] misc: atmel-ssc: lock with mutex instead of spinlock
Message-ID: <20200601173126.GA31822@qmqm.qmqm.pl>
References: <eb9b1cb3-5b3f-f387-da45-71427a4383ed@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9b1cb3-5b3f-f387-da45-71427a4383ed@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:18:48AM +0200, Markus Elfring wrote:
> > Uninterruptible context is not needed in the driver and causes lockdep
> > warning because of mutex taken in of_alias_get_id().
> 
> Was a spin lock taken?
> > Convert the lock to mutex to avoid the issue.
> Would you like to add the tag “Fixes” to the commit message?

I guess we can add:

Fixes: 099343c64e16 ("ARM: at91: atmel-ssc: add device tree support")

Best Regards
Michał Mirosław
