Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 04:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147C720768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 04:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCREXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 00:23:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35600 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgCREXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 00:23:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA6031475D4D7;
        Tue, 17 Mar 2020 21:23:08 -0700 (PDT)
Date:   Tue, 17 Mar 2020 21:23:07 -0700 (PDT)
Message-Id: <20200317.212307.1874233849204792506.davem@davemloft.net>
To:     rayagonda.kokatanur@broadcom.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        arun.parameswaran@broadcom.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] net: phy: mdio-mux-bcm-iproc: check
 clk_prepare_enable() return value
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200317.212127.2045455292795972153.davem@davemloft.net>
References: <20200317045435.29975-1-rayagonda.kokatanur@broadcom.com>
        <20200317.212127.2045455292795972153.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Mar 2020 21:23:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 17 Mar 2020 21:21:27 -0700 (PDT)

> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Date: Tue, 17 Mar 2020 10:24:35 +0530
> 
>> Check clk_prepare_enable() return value.
>> 
>> Fixes: 2c7230446bc9 ("net: phy: Add pm support to Broadcom iProc mdio mux driver")
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Applied.

I also queued this up for -stable as well.
