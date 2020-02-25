Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2479C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC1E20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F4DThKHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgBYT3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:29:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33984 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgBYT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:29:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PHovn2044086;
        Tue, 25 Feb 2020 11:50:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582653057;
        bh=oUfgz4jpNu++9i18Bck0PQmtMSSoE4RnFSLpUGi+yRc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F4DThKHvDUq/YhNYRfTUL6Z0MBQFb9KraV2xGrx/mr+bB3tXdsB7ZgmYTswdDCeZw
         C1lSvfr/ZeE189rlQRqdvlDCmqJ8n7A17RR/IZCyzev73hsAYrWj6MRjkTYYpsrs6e
         EuvgmfpJaOCQeVcpdzJkPyY6WpLVkCAQqgSmhkxU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PHov0M049083;
        Tue, 25 Feb 2020 11:50:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 11:50:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 11:50:56 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PHouID046652;
        Tue, 25 Feb 2020 11:50:56 -0600
Subject: Re: [PATCH linux-master 1/3] can: tcan4x5x: Move clock init to TCAN
 driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <wg@grandegger.com>, <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>
References: <20200131183433.11041-1-dmurphy@ti.com>
 <20200131183433.11041-2-dmurphy@ti.com>
 <06af6e1d-aec4-189c-378a-77af4073a1a6@ti.com>
 <fed1d801-e284-eada-d5b3-ae78089b3ead@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e420c667-23d8-9739-1905-4a89570ddb72@ti.com>
Date:   Tue, 25 Feb 2020 11:45:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fed1d801-e284-eada-d5b3-ae78089b3ead@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc

On 2/21/20 8:43 AM, Marc Kleine-Budde wrote:
> On 2/21/20 3:25 PM, Dan Murphy wrote:
>> Hello
>>
>> On 1/31/20 12:34 PM, Dan Murphy wrote:
>>> Move the clock discovery and initialization from the m_can framework to
>>> the registrar.  This allows for registrars to have unique clock
>>> initialization.  The TCAN device only needs the CAN clock reference.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>> I would like to have these 3 patches reviewed and integrated (post
>> review) so I can work on other issues identified.
> Applied to linux-can-next/testing.

I am not seeing these patches applied

I am looking here 
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing

But they could be in a different repo

Dan

>
> tnx,
> Marc
>
