Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DFAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5EE2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587285;
	bh=glA9FZnn82XVZ9DXudG/wsLp0gHmy5avRzTSbihAlg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cpCiK7PcOZ0Dtxv3FML7J8m0OacxbZ6VQ4JcO0t4GjNcwQr1Bbo6hUGK9wZ2EfDFn
	 9ieGZQUXSCmx+0+6QpW+lauVPn7M+GCrmoUr9SlqQh4+mTmTpXUVpsHHosyTz5xsIU
	 2uZ09OsDWSAEMxAIohzDqlYC0fMZn3C0KYgVBEDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgIHRsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731740AbgIHRrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:47:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE262064B;
        Tue,  8 Sep 2020 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599587241;
        bh=glA9FZnn82XVZ9DXudG/wsLp0gHmy5avRzTSbihAlg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rznVXhRHlPwT1egW4rJJysN5YoyX4RCP5gHuw5wqGyBV8xlBMU920/EpP0fuYis7B
         TlfknDjUz3xOK7QFSeRES/pfRu8LsKfgnw8zyVYsZBxBiP6GAFqlFkwe5G7y1u9Mqq
         i9OE2wysrk5BLHHaPPHENvBZdltBy7ZBQ0iQZ64I=
Date:   Tue, 8 Sep 2020 10:47:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] net: dp83869: Add speed optimization
 feature
Message-ID: <20200908104719.0b8aced3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <9848c3ee-51c2-2e06-a51b-3aacc1384557@ti.com>
References: <20200903114259.14013-1-dmurphy@ti.com>
        <20200903114259.14013-4-dmurphy@ti.com>
        <20200905113818.7962b6d4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <9848c3ee-51c2-2e06-a51b-3aacc1384557@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 09:07:22 -0500 Dan Murphy wrote:
> On 9/5/20 1:38 PM, Jakub Kicinski wrote:
> > On Thu, 3 Sep 2020 06:42:59 -0500 Dan Murphy wrote:  
> >> +static int dp83869_set_downshift(struct phy_device *phydev, u8 cnt)
> >> +{
> >> +	int val, count;
> >> +
> >> +	if (cnt > DP83869_DOWNSHIFT_8_COUNT)
> >> +		return -E2BIG;  
> > ERANGE  
> 
> This is not checking a range but making sure it is not bigger then 8.
> 
> IMO I would use ERANGE if the check was a boundary check for upper and 
> lower bounds.

Yeah, ERANGE is not perfect, but the strerror for E2BIG is
"Argument list too long" - IDK if users seeing that will know that it
means the value is too large. Perhaps we should stick to EINVAL?
