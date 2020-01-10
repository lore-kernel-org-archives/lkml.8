Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA05C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771BA20848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0Q0k1JGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgAJTZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:25:30 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60530 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgAJTZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VeAF7kIPHmz5D92LYg39J7zZehUDxqe+O04AMdHzzQg=; b=0Q0k1JGHSvl1WRisv/SaIZ6779
        6/escUAYK8/hDLyen/evY4/3aKF+ZsQEuvpKw3yUQkntu0L7HEXZNLVd29O+tyecgOr3mnsLw801A
        gbdWRTjI3bufMC+pQWVxGlt6ldXOAHyTpmAed5wLNV0Os9Br7kcKUCu7cXUnAQjv+Kns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ipzuO-0003jt-PO; Fri, 10 Jan 2020 20:25:24 +0100
Date:   Fri, 10 Jan 2020 20:25:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] TI DP8382x Phy support update
Message-ID: <20200110192524.GO19739@lunn.ch>
References: <20200110184702.14330-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110184702.14330-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:46:58PM -0600, Dan Murphy wrote:
> Hello
> 
> These patches update and fix some issue found in the TI ethernet PHY drivers.

Hi Dan

Please could you separate fixes from new functionality. Have the fixes
based on net, and new functionality on net-next.

      Thanks
		Andrew
