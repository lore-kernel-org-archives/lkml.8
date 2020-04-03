Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79546206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbgDCJWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:22:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50495 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:22:51 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7C44824000D;
        Fri,  3 Apr 2020 09:22:45 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:22:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Colin King <colin.king@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] rtc: ds1307: check for failed memory
 allocation on wdt
Message-ID: <20200403092245.GR3683@piout.net>
References: <20200402135201.548313-1-colin.king@canonical.com>
 <c6fe9db8-3e27-b6fc-fff7-131cecad3f88@roeck-us.net>
 <20200402145312.GN3683@piout.net>
 <20200403084504.GZ2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403084504.GZ2001@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2020 11:45:04+0300, Dan Carpenter wrote:
> On Thu, Apr 02, 2020 at 04:53:12PM +0200, Alexandre Belloni wrote:
> > 
> > As stated, I also prefer keeping the watchdog optional and ignore the
> > error.
> 
> Hopefully you aren't running out of memory on start up.  In current
> kernels small memory allocations like this never fail so it doesn't
> really affect runtime.  It only silences the NULL dereference static
> checker warning.
> 

Yes, so the

if (!wdt)
 return;

would be enough instead of introducing unnecessary error handling.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
