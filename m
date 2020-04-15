Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C34C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CB520768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D5y+wDHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbgDOXuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:50:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40522 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733274AbgDOXtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KsfdEC8WsFMbxvp0Zy1Uk07H2XqVM3wcsM3uXIHuF0A=; b=D5y+wDHcAtzzBC8H0R38etpB+2
        0XYqjPkwZCYH3jGIIxCZBn9KgDHlXuX/9TY3vfdA/i05diAEgQmpwAruyNRMj4yQVR0PgEHdGK8ng
        C4Bxb+zy+mHsuREyIgehv7ZTiEErSJpa2ZIqQvZ99/ZgHCDi8xVJd1SyvMYgM1B99Lro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jOrmy-002yRv-16; Thu, 16 Apr 2020 01:49:52 +0200
Date:   Thu, 16 Apr 2020 01:49:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v3 2/3] dt-bindings: add Qualcomm IPQ4019 MDIO bindings
Message-ID: <20200415234952.GI611399@lunn.ch>
References: <20200415150244.2737206-1-robert.marko@sartura.hr>
 <20200415150244.2737206-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415150244.2737206-2-robert.marko@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:02:46PM +0200, Robert Marko wrote:
> This patch adds the binding document for the IPQ40xx MDIO driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

