Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE69FC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8521420773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S9Eq1c0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIBOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:21:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53174 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgIBOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:08:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082E8ZBv004104;
        Wed, 2 Sep 2020 09:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599055715;
        bh=YNjauqsvYcJTZcBL24cWGDogJK4+fiqf2K9zoPEdmdo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=S9Eq1c0qJHzDHmcUdlZSOUsRNEXr/PqVa6tiFf2QfQjtL7squaXqjpsEkYiMUTNmy
         nO2ZjOxumnCuljeNuYAM+3mDPQTHCtTk5k/xAmrfVWhaFjXpvErdA7D7q5dEJXrFLh
         mf9gWVg9ohje0m45PDEAK+sxBIJ/C+EmDg8VXhc0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082E8ZD4108666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 09:08:35 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 09:08:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 09:08:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082E8Ygc025835;
        Wed, 2 Sep 2020 09:08:34 -0500
Date:   Wed, 2 Sep 2020 09:08:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <santosh.shilimkar@oracle.com>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
Message-ID: <20200902140834.5fficxrxy6t572um@kahuna>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
 <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:34-20200831, santosh.shilimkar@oracle.com wrote:
> On 8/29/20 11:41 AM, Grygorii Strashko wrote:
> > Hi Santosh,
> > 
> > I've rebased on top of  linux-next and identified merge conflict of patch 3
> > with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM resource types")
> > in -next.
> > 
> > ---
> > This series adds support for the TI AM65x SR2.0 SoC Ringacc which has fixed
> > errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State Interoperability
> > Issue after Channel Teardown". This errata also fixed for J271E SoC.
> > The SOC bus chipinfo data is used to identify the SoC and configure
> > i2023 errata W/A.
> > 
> > This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's removed.
> > 
> > Changes in v2:
> >   - no functional changes
> >   - rebased on top of linux-next
> >   - added ask from Rob Herring
> > 
> Thanks. Can you please followup DT acks for PRUSS series so that I can
> apply PRUSS + $subject series.


Santosh, in this series, may i suggest that the dtsi changes[1] be hosted
on my tree? else we are going to create a mix of rc1 and rc3 branches
which is going to be irritating, to say the least.

I will pick [1] the day after I see the patches 1 and 2 in linux-next tag.

[1] https://lore.kernel.org/lkml/20200829184139.15547-4-grygorii.strashko@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
