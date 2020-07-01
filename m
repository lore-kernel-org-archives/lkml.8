Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF47C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA58206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VAAuneYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGAV3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:29:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57776 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAV3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:29:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061LSvOO051725;
        Wed, 1 Jul 2020 16:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593638937;
        bh=CTJQzourXPxe5H+I635s6IAoGRQlIR/1ckLKfy6e0+w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VAAuneYht7VTnMRSQMaDPznjpmJMF7q1mBvT84BWa/wqle7oJNoEFgSy+gQ8kN5t6
         wZ/rUyiGjpu0axMARi5++OxuXyBie0JI10jWz8oBfHqtez78q8Mg5fkSCt155AhWtr
         wI2hKYkgl7OGU21iDb9kANX3jPXM1aX8A68W4RUo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061LSqjm006926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 16:28:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 16:28:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 16:28:51 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061LSplW012741;
        Wed, 1 Jul 2020 16:28:51 -0500
Subject: Re: [PATCH 0/2] remoteproc: Address runtime PM issues
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <paul@crapouillou.net>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <8d3d479a-2b41-bf5f-4ada-ad2fbd46da3d@ti.com>
Date:   Wed, 1 Jul 2020 16:28:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 6/30/20 11:31 AM, Mathieu Poirier wrote:
> This set follows the conversation that took place here[1] and provides
> the "two small patches" I alluded to at the end of the thread.
> 
> Paul Cercueil: patch 1/2 is compile tested only - please see that it does what
> you want.
> Suman Anna: Please test on your side and confirm that it addresses the Omap
> regression.

Tested the behavior with 5.8-rc3 + these patches, all looks good. Also 
provided by review tags on the individual patches.

regards
Suman

> 
> Applies on top of rproc-next (7dcef3988eed)
> 
> Thanks,
> Mathieu
> 
> [1]. https://lore.kernel.org/linux-remoteproc/20200515104340.10473-1-paul@crapouillou.net/T/#t
> 
> Mathieu Poirier (2):
>    remoteproc: ingenic: Move clock handling to prepare/unprepare
>      callbacks
>    Revert "remoteproc: Add support for runtime PM"
> 
>   drivers/remoteproc/ingenic_rproc.c   | 84 +++++++++-------------------
>   drivers/remoteproc/remoteproc_core.c | 17 +-----
>   2 files changed, 27 insertions(+), 74 deletions(-)
> 

