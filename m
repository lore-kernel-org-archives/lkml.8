Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AACE20707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tQiZiMoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405346AbgFYON3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:13:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59130 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405286AbgFYON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:13:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05PED89d080994;
        Thu, 25 Jun 2020 09:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593094389;
        bh=c6PIE6h1Ufcsj4xy/cCCsvdAlZ7BD5W5ZeCScWioTrw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tQiZiMozPUWwnxGVHJ/sGU1dx9qJ6xHUp906daw8ywtnshytoODlNyDnDplGDsuki
         zIm4SK60ONHWazNWRRgbwJ/XrVUcc69FlzzdCRLT0297+GzkvC2+H5WI9YmPdVWg+b
         hnxJFnjGcEC7GWsVq6EG5S3zB6AnE72CI+PhkW6Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05PED3Nn073800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 09:13:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 25
 Jun 2020 09:13:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 25 Jun 2020 09:13:04 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05PED3Te095056;
        Thu, 25 Jun 2020 09:13:03 -0500
Subject: Re: [PATCH BUGFIX] can: m_can: make m_can driver work with sleep
 state pinconfig
To:     =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
CC:     Sriram Dash <sriram.dash@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200625142435.50371e2f@ipc1.ka-ro>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9416850b-73c3-9b1c-6dd0-c49665ab3ec1@ti.com>
Date:   Thu, 25 Jun 2020 09:13:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625142435.50371e2f@ipc1.ka-ro>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lothar

On 6/25/20 7:24 AM, Lothar Waßmann wrote:
> Hi,
>
> When trying to use the m_can driver on an stm32mp15 based system, I
> found that I could not send or receive any data.
> Analyzing the pinctrl registers revealed, that the pins were
> configured for sleep state even when the can interfaces were in use.
>
> Looking at the m_can_platform.c driver I found that:
>
> commit f524f829b75a ("can: m_can: Create a m_can platform framework")
>
> introduced a call to m_can_class_suspend() in the m_can_runtime_suspend()
> function which wasn't there in the original code and which causes the
> pins used by the controller to be configured for sleep state.
>
> commit 0704c5743694 ("can: m_can_platform: remove unnecessary m_can_class_resume() call")
> already removed a bogus call to m_can_class_resume() from the
> m_can_runtime_resume() function, but failed to remove the matching
> call to m_can_class_suspend() from the m_can_runtime_suspend() function.
>
> Removing the bogus call to m_can_class_suspend() in the
> m_can_runtime_suspend() function fixes this.

Thank you for the patch Richard G has already submitted a similar patch

https://lore.kernel.org/patchwork/patch/1253401/

Dan


