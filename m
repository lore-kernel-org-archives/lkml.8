Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57362C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C582208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599841435;
	bh=9LYqaWU05I+yGzP75Vgbuy+m+69FJjcCY3s2HbbX2wU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sbdvUgwNqwRvYCx+0843MJZ0NHV9wd49PiHV7OJhHsH73otuVn/kq0zBqA6ZhJr50
	 trc52VCwzyANVxmYpIyYoHeMzPC/RIKVF32NFiSCL6MJzke78Xe/3X/Ir1cgJWIwQi
	 tZTQ4rZlH6yrGvn51BS2LPPM8M61ELMEPwXYw4y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIKQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgIKQWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:22:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C600B208FE;
        Fri, 11 Sep 2020 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841363;
        bh=9LYqaWU05I+yGzP75Vgbuy+m+69FJjcCY3s2HbbX2wU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B+v3SQiZwyy4UpWmJFD5mb8pxB/dxPQPVLoAKoMGP9bLTuvI0ZKQsNEEvOdCSPH2W
         nblGV1FRmN5LkKMD1g7+RrDfHYBrZ8ZwR+ozYKUhY35e+Du4wuHAOsrm6nZqJUfUSn
         A6b+SpbdYrPCxhfmRC2jU8e1187mdrD2LkFcpgT0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kGlov-00B2LT-SV; Fri, 11 Sep 2020 17:22:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 17:22:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v6 2/3] irqchip: Add Actions Semi Owl SIRQ controller
In-Reply-To: <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
 <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <c5115d27739e1664f808ff5f1fc315e8@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cristian.ciocaltea@gmail.com, robh+dt@kernel.org, manivannan.sadhasivam@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, afaerber@suse.de, parthiban@linumiz.com, sravanhome@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, pn@denx.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-08 09:20, Cristian Ciocaltea wrote:
> This interrupt controller is found in the Actions Semi Owl SoCs (S500,
> S700 and S900) and provides support for handling up to 3 external
> interrupt lines.
> 
> Each line can be independently configured as interrupt and triggers on
> either of the edges or either of the levels. Additionally, each line
> can also be masked individually.
> 
> The patch is based on the work started by Parthiban Nallathambi:
> https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> [cristi: optimized DT, various fixes/cleanups/improvements]
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Who is the author of these patches? If this is a co-development, please
use the relevant tags. Otherwise, the author of the patch must come as
the first SoB.

The patch itself looks good.

         M.
-- 
Jazz is not dead. It just smells funny...
