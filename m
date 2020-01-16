Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF987C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73FB2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zt4hUFck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393323AbgAPSfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:35:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34863 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407150AbgAPSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:35:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so23782147lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3m47L5Z0xI8HYh0lKryrWYdR0UgzApvsO7nDstJ484=;
        b=zt4hUFckpv0JtJBTTBpPR0wmokiqIfW2lNyhGhC5whKAMLVPQ598lSopUqg40Dednt
         zZo0oen6Rj98R4s2jKVEEcBxfKT/0FB5KuR3J5vOvJn4EL6sX/EUaJVb0CARHJQRzqoW
         uKbC//iUkpteLGJZ6Dw876Fj0gC3FiXyI+hiL33ReAiBpqHjvoxIX3d8exyoXErn3ulF
         3M+pB9l/F2YBegxvYZqVrF14OhsMBCzdgU+DFXEVcGFHUJdwod8/UsTrdWlt1M1nYU1s
         VyiO8zEEtSJi0si67QGW4eRXclm6PYPI8n7GMfhxFHWwD8JYf5YlHLFCO3zVZZh7qZyF
         HZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3m47L5Z0xI8HYh0lKryrWYdR0UgzApvsO7nDstJ484=;
        b=iXFKu3jeLH1LXQLDWAHBae0aJnqEh/GcZ5gDz1GewSxdFxglgiOnDthEsh1O1tabse
         vg+bRs6W3/lCD7vQPmp0vBu1oOw4TR9H67wI4xdLQcYC+aVXsqXaysU2PELK9TqXa0vQ
         yF0Xbm1ykuGUupGUWr8WFJ6bpbOfBQ8DryqtKUgW+SiBPcHyZwDmFbPbO0wam8EOeKJo
         eKYMwQXqo96KKuwX/2X53WKP12PJW4DPE7QVESg/hqmeLZoug+e60H5aIYd3cAzn49P5
         c3pG1ZqCU7od8JuxGp9aDwBn/U9WE2tx7zpHISpNpcwTFM45HiY3SK1dZAc3GAEbmqoH
         gcxw==
X-Gm-Message-State: APjAAAURtaG/2YMR2J4R/WXogNcbhXjvGS9bs5Zxukei23XY9zgiFxDb
        683AVbSc3aBf2pjwqtMOqshc3QgZNug=
X-Google-Smtp-Source: APXvYqz/9p+Equ9yB2/f1ypHaf4+rn1iYRPCZicwrFKzWbSFxXdSqtv9R5Vc2x+rsOBhxB3KKZsmqg==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr3151068ljk.228.1579199742453;
        Thu, 16 Jan 2020 10:35:42 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x84sm11124259lfa.97.2020.01.16.10.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 10:35:41 -0800 (PST)
Date:   Thu, 16 Jan 2020 10:34:58 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: davinci: select CONFIG_RESET_CONTROLLER
Message-ID: <20200116183458.qsa6bk7wlfhpd4m4@localhost>
References: <20191210195202.622734-1-arnd@arndb.de>
 <ba94531d-1f16-b985-5638-c226bab28d5b@ti.com>
 <1513bfee-6623-47fa-1eef-6074ba9ab3b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513bfee-6623-47fa-1eef-6074ba9ab3b8@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:32:54PM +0530, Sekhar Nori wrote:
> Hi Arnd,
> 
> On 11/12/19 3:42 PM, Sekhar Nori wrote:
> > Hi Arnd,
> > 
> > On 11/12/19 1:21 AM, Arnd Bergmann wrote:
> >> Selecting RESET_CONTROLLER is actually required, otherwise we
> >> can get a link failure in the clock driver:
> >>
> >> drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
> >> psc.c:(.text+0x9a0): undefined reference to `devm_reset_controller_register'
> >> drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> >> psc-da850.c:(.text+0x24): undefined reference to `reset_controller_add_lookup'
> >>
> >> Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
> >> Cc: <stable@vger.kernel.org> # v5.4
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Assuming you are going to apply directly to ARM-SoC,
> > 
> > Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> This is not yet in Linus's master. Let me know if I should collect it
> and send a pull request.

It's sitting in our fixes branch and should show up in mainline in not too
long.


-Olof
