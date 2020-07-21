Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48614C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D09F21702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pAoMEIdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgGUMRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:17:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38966 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGUMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:17:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LCGtFC067912;
        Tue, 21 Jul 2020 07:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595333815;
        bh=gFm3GQJD6iGfxn3i2RyDU92dAWg7cMKkvcOz7EYvjjE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pAoMEIdw6mPN7Ym2CU2zbGryEo4eeD7nkTnb8KZSUlf3NNF5SJkm0uo3CHjIlVHet
         UMOcbNCsyYGMXWRAwdP3WHV+Ij0eKn5KFK/1utcElgu7dY/cqoI83u/Hh2xhzFYWol
         17pok/O6sxhIffgU1E/pzBalGXqulTVMYQoe6hA4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LCGts4043901;
        Tue, 21 Jul 2020 07:16:55 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 07:16:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 07:16:55 -0500
Received: from [10.250.32.229] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LCGsZE096585;
        Tue, 21 Jul 2020 07:16:54 -0500
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2770: Convert tas2770 binding to
 yaml
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
References: <20200720181202.31000-1-dmurphy@ti.com>
 <20200721093358.GA4845@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6cf0b470-f064-7d25-0509-252d6f845d62@ti.com>
Date:   Tue, 21 Jul 2020 07:16:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721093358.GA4845@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 7/21/20 4:33 AM, Mark Brown wrote:
> On Mon, Jul 20, 2020 at 01:12:01PM -0500, Dan Murphy wrote:
>> Convert the tas2770 binding to yaml format.
>> Add in the reset-gpio to the binding as it is in the code but not
>> documented in the binding.
> What's new about this version?

The licensing was updated and added reviewed-by from Rob from v1 of the 
patchset.

https://lore.kernel.org/patchwork/patch/1255425/

