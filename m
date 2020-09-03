Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A52206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgICQyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:54:21 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:36252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgICQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:54:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7F2BB181D3025;
        Thu,  3 Sep 2020 16:54:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: match19_4c0df1f270ab
X-Filterd-Recvd-Size: 1959
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Sep 2020 16:54:15 +0000 (UTC)
Message-ID: <6e223efabb08b0203ac650caeffc05a48cd0b170.camel@perches.com>
Subject: Re: [PATCH net] net: phy: dp83867: Fix various styling and space
 issues
From:   Joe Perches <joe@perches.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        andrew@lunn.ch, hkallweit1@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Sep 2020 09:54:13 -0700
In-Reply-To: <4d38ac31-8646-2c4f-616c-1a1341721819@ti.com>
References: <20200903141510.20212-1-dmurphy@ti.com>
         <76046e32-a17d-b87c-26c7-6f48f4257916@gmail.com>
         <4d38ac31-8646-2c4f-616c-1a1341721819@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-03 at 11:41 -0500, Dan Murphy wrote:
> On 9/3/20 11:34 AM, Florian Fainelli wrote:
> > On 9/3/2020 7:15 AM, Dan Murphy wrote:
> > > Fix spacing issues reported for misaligned switch..case and extra new
> > > lines.
[]
> > > diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
[]
> > > @@ -35,7 +34,7 @@
> > >   #define DP83867_CFG4_SGMII_ANEG_MASK (BIT(5) | BIT(6))
> > >   #define DP83867_CFG4_SGMII_ANEG_TIMER_11MS   (3 << 5)
> > >   #define DP83867_CFG4_SGMII_ANEG_TIMER_800US  (2 << 5)
> > > -#define DP83867_CFG4_SGMII_ANEG_TIMER_2US    (1 << 5)
> > > +#define DP83867_CFG4_SGMII_ANEG_TIMER_2US    BIT(5)

> > Now the definitions are inconsistent, you would want to drop this one 
> > and stick to the existing style.
> 
> OK I was a little conflicted making that change due to the reasons you 
> mentioned.  But if that is an acceptable warning I am ok with it.

Maybe use GENMASK for DP83867_CFG4_SGMII_ANEG_MASK instead.


