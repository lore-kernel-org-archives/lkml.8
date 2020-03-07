Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06ADC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C1A206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCGGHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:07:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGGHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:07:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::f0c])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C1ABA154F6F3B;
        Fri,  6 Mar 2020 22:07:45 -0800 (PST)
Date:   Fri, 06 Mar 2020 22:07:45 -0800 (PST)
Message-Id: <20200306.220745.905582309424057305.davem@davemloft.net>
To:     ansuelsmth@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] dt-bindings: net: Add ipq806x mdio bindings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200304213841.5745-2-ansuelsmth@gmail.com>
References: <robh@kernel.org>
        <20200304213841.5745-1-ansuelsmth@gmail.com>
        <20200304213841.5745-2-ansuelsmth@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Mar 2020 22:07:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>
Date: Wed,  4 Mar 2020 22:38:33 +0100

> Add documentations for ipq806x mdio driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Applied to net-next.
