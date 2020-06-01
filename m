Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5D0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE6D207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qIcfCZZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgFAPiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:38:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38398 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgFAPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:38:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 051Fc0Ft087726;
        Mon, 1 Jun 2020 10:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591025880;
        bh=FMpU1xx24EePgAl2kXzZ81j+MBqD4TefOkKVPf0sNbU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qIcfCZZ6Hk9VT5G0kTW95lEhS9Zbwoqq+Ru06Mx6xfdhGN1ofKp6Pjhrj4fdAOrKZ
         RwodBkLORFAEZMKnl9DB93me7UAe7K+KagnN6T4lzRaJViMu4s2MHdjN4ZiqMwnuVB
         4fatF2YgWATTeTyAfp7gcsos9bfqLA12MJtLaBok=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 051Fc05b104663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jun 2020 10:38:00 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Jun
 2020 10:37:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Jun 2020 10:37:59 -0500
Received: from [10.250.232.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 051Fbu0P021566;
        Mon, 1 Jun 2020 10:37:57 -0500
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am654-main: Update otap-del-sel
 values
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <t-kristo@ti.com>, <nm@ti.com>
References: <20200519082027.5726-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <2157ce88-89bc-1c0f-fcd4-8206e5e17bfe@ti.com>
Date:   Mon, 1 Jun 2020 21:07:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519082027.5726-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/05/20 1:50 pm, Faiz Abbas wrote:
> According to the latest AM65x Data Manual[1], a different output tap
> delay value is optimum for a given speed mode. Update these values.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> 
> v3: Updated values to the latest data manual revision
> 
> v2: Updated to the latest mainline kernel
> 

Can this patch be picked up?

Thanks,
Faiz
