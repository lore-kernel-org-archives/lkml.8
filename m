Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1986C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AD520820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="qFLDfgvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgEJOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEJOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:51:30 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD2C061A0C;
        Sun, 10 May 2020 07:51:29 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AC0762271F;
        Sun, 10 May 2020 16:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589122287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1n2TgpWhqp0MLsGjFL957f5FejpNsO6QrJ/GBwzQH0=;
        b=qFLDfgvymc98Lhb28vCJWZhn5E2WRVjea0Y23Uz43hAq5yslqbx21tS9DH/OKwyiUwDXM5
        9lP9ldopmz3OHAemgDJSV2iUqSiECNRWJ0CyjsCmwA1dDoSj7Qvl4aU4mIYHGTeShXKLDB
        DUW+TbJ+Gka9NNghflkjQvS+90Ltin4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 10 May 2020 16:51:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/4] net: phy: broadcom: add cable test support
In-Reply-To: <20200510144410.GI362499@lunn.ch>
References: <20200509223714.30855-1-michael@walle.cc>
 <20200509223714.30855-4-michael@walle.cc> <20200510144410.GI362499@lunn.ch>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <51bddbc3bdd10c81aad0e79ee4552e68@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-05-10 16:44, schrieb Andrew Lunn:
> On Sun, May 10, 2020 at 12:37:13AM +0200, Michael Walle wrote:
>> Most modern broadcom PHYs support ECD (enhanced cable diagnostics). 
>> Add
>> support for it in the bcm-phy-lib so they can easily be used in the 
>> PHY
>> driver.
>> 
>> There are two access methods for ECD: legacy by expansion registers 
>> and
>> via the new RDB registers which are exclusive. Provide functions in 
>> two
>> variants where the PHY driver can from. To keep things simple for now,
> 
> can from ?

can choose from. Should I send a new patch? Will DaveM fix minor typos, 
if
he commits it?

> 
>> +static int bcm_phy_report_length(struct phy_device *phydev, int 
>> result,
>> +				 int pair)
>> +{
>> +	int val;
>> +
>> +	val = __bcm_phy_read_exp(phydev,
>> +				 BCM54XX_EXP_ECD_PAIR_A_LENGTH_RESULTS + pair);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	if (val == BCM54XX_ECD_LENGTH_RESULTS_INVALID)
>> +		return 0;
>> +
>> +	/* intra-pair shorts report twice the length */
>> +	if (result == BCM54XX_ECD_FAULT_TYPE_CROSS_SHORT)
>> +		val >>= 1;
> 
> You mentioned this before. This seems odd. The pulse travelled the
> same distance as for an open or shorted cable. The whole of time
> domain reflectrometry is based on some sort of echo and you always
> need to device by two. So why this special case?

Well, I don't know why this is special. But one thing which is
different is that you listen on all pairs for the pulse instead of
just the one where you've sent it (which seems to be a bit trickier
otherwise the cheapo AT8031 would support it, too). Maybe they
screwed that. In any case, I can try it with a 100m cable just
to be sure.

-michael
