Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF85C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DD320775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151609;
	bh=ZqJtrKKWgIPEOxc3s/QmD5Oj7Xm0HOa8VK5RRLpg1Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ut2OQZgUJyLAae8DFrgBLxp4D6ABpReeS6CxrSL/CcyBMI8tgB5H2KyRldEwfAtyi
	 e5UIeBNqg0NDO8JIOzmccfNpieviOEkUniUPeCgQpZAya25J77kCqHULbdCL8jSfHD
	 z/8M9yQBDAU31fiTWNq1hXIhakgMLB5syMTJBuAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgICQqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgICQqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:46:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF12520716;
        Thu,  3 Sep 2020 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599151607;
        bh=ZqJtrKKWgIPEOxc3s/QmD5Oj7Xm0HOa8VK5RRLpg1Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zgGbSRhKlIfvoOt4AmrOygHHWNmuzFxWkchzwtQLmMPDxevUocAdPOgw2umjSxCZ9
         VyVJUg0+D2SX1LSbNzXyX6vrnItG6pHjp2VdROBQUMYE2/5Vw2a5SPDD/+3CtenpuT
         dIUUUBj1lt6tiARqsRu3VLgthsWuORuuCZORWi3w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDsNo-008wl4-QI; Thu, 03 Sep 2020 17:46:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Sep 2020 17:46:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 0/2] add support for Hisilicon SD5203 vector interrupt
 controller
In-Reply-To: <20200903120504.2308-1-thunder.leizhen@huawei.com>
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <ac9458877cd414a8265d267569b0e8ea@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: thunder.leizhen@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 13:05, Zhen Lei wrote:
> The interrupt controller of SD5203 SoC is VIC(vector interrupt 
> controller), it's
> based on Synopsys DesignWare APB interrupt controller (dw_apb_ictl) IP, 
> but it
> can not directly use dw_apb_ictl driver. The main reason is that VIC is 
> used as
> primary interrupt controller and dw_apb_ictl driver worked for 
> secondary
> interrupt controller.

What prevents you from improving the existing driver so that it can act
as a primary interrupt controller? It shouldn't be rocket science, 
really.

There are some examples in the tree of drivers that can be used in
both situations (GIC, VIC

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
