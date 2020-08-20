Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D63D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PpsG3KQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHTOqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:46:53 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33354 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgHTOqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:46:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07KEkkuC083442;
        Thu, 20 Aug 2020 09:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597934806;
        bh=tHb/5HfXympUc0nojFY4SJjhN1VEMkOshbOP4AxCRpA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PpsG3KQybr0w9qyFlUsa0N1/Hwze5zavB3LcKFVDhuFjnfaFPKvYMMpob2osLUwBa
         aE5g66rnmdEQgriu6Q1IapHjUQdVfvAMbCgC6vPFH1E6vfm01Ensqb5H2ffwQQfdEW
         0IlO8r2aWvEixs4jJA3L+IAff63lXTKR54vS0+S0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KEkkvf087345;
        Thu, 20 Aug 2020 09:46:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 20
 Aug 2020 09:46:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 20 Aug 2020 09:46:44 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KEkgGr084901;
        Thu, 20 Aug 2020 09:46:43 -0500
Subject: Re: [PATCH v4 1/3] dt-binding: phy: convert ti,omap-usb2 to YAML
To:     Roger Quadros <rogerq@ti.com>, <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20200716082252.21266-1-rogerq@ti.com>
 <20200716082252.21266-2-rogerq@ti.com>
 <4032ac86-5f2e-98ca-180b-73a483bae6b6@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <693250c2-58e1-2cd6-c0b1-9ed6dce65ee9@ti.com>
Date:   Thu, 20 Aug 2020 20:16:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4032ac86-5f2e-98ca-180b-73a483bae6b6@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 7:10 PM, Roger Quadros wrote:
> Kishon,
> 
> On 16/07/2020 11:22, Roger Quadros wrote:
>> Move ti,omap-usb2 to its own YAML schema.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Can you please pick just this one patch from this series for -next? Thanks.

+ Vinod as well.

Thanks,
Sekhar
