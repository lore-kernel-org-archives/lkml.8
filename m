Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5927DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C75206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ab0R0dfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFGPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:31:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38658 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgFGPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oGjdbZkTfG2shZbhkVg+O0cltlsoKRjKsMT0FxY6qS0=; b=ab0R0dfEkIhxgsHfHtOTFaaxIQ
        96+8r5pe9piLn8nb3wMxysCpWNXfL1ar3ebbJd4HnhxmFlb8AkWd8bv9pENn6oydGIedu65Vc8DYe
        k0mqMyiyQtc//EYv42hBbhasPnei+3tGOPh6AxcEdtxF4YNDfqNxrUrbRTnBuUJv/frU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jhxFq-004LP3-A3; Sun, 07 Jun 2020 17:30:34 +0200
Date:   Sun, 7 Jun 2020 17:30:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Amit Cohen <amitc@mellanox.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        corbet@lwn.net, jiri@mellanox.com, idosch@mellanox.com,
        shuah@kernel.org, mkubecek@suse.cz, gustavo@embeddedor.com,
        cforno12@linux.vnet.ibm.com, f.fainelli@gmail.com,
        linux@rempel-privat.de, alexandru.ardelean@analog.com,
        ayal@mellanox.com, petrm@mellanox.com, mlxsw@mellanox.com,
        liuhangbin@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH net-next 04/10] ethtool: Add link extended state
Message-ID: <20200607153034.GC1022955@lunn.ch>
References: <20200607145945.30559-1-amitc@mellanox.com>
 <20200607145945.30559-5-amitc@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607145945.30559-5-amitc@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * enum ethtool_ext_substate_cable_issue - more information in
> + * addition to ETHTOOL_EXT_STATE_CABLE_ISSUE.
> + */
> +enum ethtool_ext_substate_cable_issue {
> +	ETHTOOL_EXT_SUBSTATE_UNSUPPORTED_CABLE = 1,
> +	ETHTOOL_EXT_SUBSTATE_SHORTED_CABLE,
> +};

I'm not too happy about shorted cable. I can see this getting extended
to open cable, shorted to another pair, etc. It then becomes a
duplicate of the PHY cable testing infrastructure. A more generic

> +	ETHTOOL_EXT_SUBSTATE_CABLE_TEST_FAILURE,

would be better, and then the user can use then use the cable testing
infrastructure to get the full details.

	Andrew
