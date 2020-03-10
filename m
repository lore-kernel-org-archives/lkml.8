Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F80208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d34cIJ40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgCJNYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:24:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55132 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730327AbgCJNYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IzQlYHGoa46ajr1EZTuJDABnxTaARMHlWCMFWC3lKAQ=; b=d34cIJ4053bHz7eMwjO57QAjDa
        FKaLM/VRz2WjXv6n57jzGvtkzqK7Tvp9SRJBRAPwDY0ul3xcVH9C3g3kzZQcbIwqzw7Ev2NXV67zs
        JcH9onBFBiXFMbEK/HvOIEjzb2DklOJ1VYQ1u1sR+iZeqoiAI4bz9MK8J2iIuth8pXeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jBera-0001oF-JW; Tue, 10 Mar 2020 14:24:02 +0100
Date:   Tue, 10 Mar 2020 14:24:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phy: mscc: split the driver into
 separate files
Message-ID: <20200310132402.GF5932@lunn.ch>
References: <20200310090720.521745-1-antoine.tenart@bootlin.com>
 <20200310090720.521745-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310090720.521745-3-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:07:19AM +0100, Antoine Tenart wrote:
> +++ b/drivers/net/phy/mscc/mscc.h
> @@ -0,0 +1,451 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Driver for Microsemi VSC85xx PHYs
> + *
> + * Copyright (c) 2016 Microsemi Corporation
> + */
> +
> +#ifndef _MSCC_PHY_H_
> +#define _MSCC_PHY_H_
> +
> +#if IS_ENABLED(CONFIG_MACSEC)
> +#include <net/macsec.h>
> +#include "mscc_macsec.h"
> +#endif

> +#if IS_ENABLED(CONFIG_MACSEC)
> +struct macsec_flow {
> +	struct list_head list;
> +	enum mscc_macsec_destination_ports port;
> +	enum macsec_bank bank;
> +	u32 index;
> +	int assoc_num;
> +	bool has_transformation;
> +
> +	/* Highest takes precedence [0..15] */
> +	u8 priority;
> +
> +	u8 key[MACSEC_KEYID_LEN];
> +
> +	union {
> +		struct macsec_rx_sa *rx_sa;
> +		struct macsec_tx_sa *tx_sa;
> +	};
> +
> +	/* Matching */
> +	struct {
> +		u8 sci:1;
> +		u8 tagged:1;
> +		u8 untagged:1;
> +		u8 etype:1;
> +	} match;
> +
> +	u16 etype;
> +
> +	/* Action */
> +	struct {
> +		u8 bypass:1;
> +		u8 drop:1;
> +	} action;
> +
> +};
> +#endif

Could some of this be moved into mscc_macsec.h? It would reduce the
number of #ifdefs.

       Andrew
