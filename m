Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B24C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DE820719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbgCPV6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:58:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48446 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:58:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 941D0156D1DB5;
        Mon, 16 Mar 2020 14:58:48 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:58:47 -0700 (PDT)
Message-Id: <20200316.145847.669961790477208036.davem@davemloft.net>
To:     madalin.bucur@oss.nxp.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] QorIQ DPAA ARM RDBs need internal delay on
 RGMII
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1584360358-8092-1-git-send-email-madalin.bucur@oss.nxp.com>
References: <1584360358-8092-1-git-send-email-madalin.bucur@oss.nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Mar 2020 14:58:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@oss.nxp.com>
Date: Mon, 16 Mar 2020 14:05:55 +0200

> v2: used phy_interface_mode_is_rgmii() to identify RGMII
> 
> The QorIQ DPAA 1 based RDB boards require internal delay on
> both Tx and Rx to be set. The patch set ensures all RGMII
> modes are treated correctly by the FMan driver and sets the
> phy-connection-type to "rgmii-id" to restore functionality.
> Previously Rx internal delay was set by board pull-ups and
> was left untouched by the PHY driver. Since commit
> 1b3047b5208a80 ("net: phy: realtek: add support for
> configuring the RX delay on RTL8211F") the Realtek 8211F PHY
> driver has control over the RGMII RX delay and it is
> disabling it for other modes than RGMII_RXID and RGMII_ID.
> 
> Please note that u-boot in particular performs a fix-up of
> the PHY connection type and will overwrite the values from
> the Linux device tree. Another patch set was sent for u-boot
> and one needs to apply that [1] to the boot loader, to ensure
> this fix is complete, unless a different bootloader is used.

Series applied, thanks.
