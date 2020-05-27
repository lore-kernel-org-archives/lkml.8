Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A23620870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s9DR8aBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgE0Ayt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 20:54:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50884 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgE0Ayt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JJBJ5tzKiUCrYev+GO1lw1Nyc1phyUoroBz7fe1zVqU=; b=s9DR8aBcvEWW7DbcJbZly/BMHw
        ycwkfbm8E8lSbW8ST8fHaMhmFGlFefu6WN8rT+Onm+YZFjmvnHAQkSGC1+JwFJKwOtCmc97wa55cN
        9MsT+cjRpc2cs1EWxV9mwdWPHWKSWJ7SVPmmFLuufw6BpyOk5Lzz3iNDnXmk8m1dmybo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jdkLF-003LEW-FC; Wed, 27 May 2020 02:54:45 +0200
Date:   Wed, 27 May 2020 02:54:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: dp83869: Add RGMII internal delay
 configuration
Message-ID: <20200527005445.GG782807@lunn.ch>
References: <20200526174716.14116-1-dmurphy@ti.com>
 <20200526174716.14116-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526174716.14116-5-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int dp83869_internal_delay[] = {250, 500, 750, 1000, 1250, 1500, 1750,
> +				       2000, 2250, 2500, 2750, 3000, 3250,
> +				       3500, 3750, 4000};
> +

You should make this const. Otherwise it takes up twice the space.

    Andrew
