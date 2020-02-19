Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A6C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0928B208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBSTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:12:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBSTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:12:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C03A515ADF481;
        Wed, 19 Feb 2020 11:12:13 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:12:13 -0800 (PST)
Message-Id: <20200219.111213.2304689693183810621.davem@davemloft.net>
To:     olteanv@gmail.com
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next/devicetree 0/5] DT bindings for Felix DSA
 switch on LS1028A
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200219151259.14273-1-olteanv@gmail.com>
References: <20200219151259.14273-1-olteanv@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Feb 2020 11:12:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 19 Feb 2020 17:12:54 +0200

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This series officializes the device tree bindings for the embedded
> Ethernet switch on NXP LS1028A (and for the reference design board).
> The driver has been in the tree since v5.4-rc6.
> 
> As per feedback received in v1, I've changed the DT bindings for the
> internal ports from "gmii" to "internal". So I would like the entire
> series to be merged through a single tree, be it net-next or devicetree.
> If this happens, I would like the other maintainer to acknowledge this
> fact and the patches themselves. Thanks.

I'm fine with this going through the devicetree tree.

Acked-by: David S. Miller <davem@davemloft.net>
