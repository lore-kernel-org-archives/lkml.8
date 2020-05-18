Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42624C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E32B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DRn/c/Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgERMOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:14:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44144 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:14:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ICEcv7003007;
        Mon, 18 May 2020 07:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589804078;
        bh=19wKfYL2K+Jv8klgnAl+ycEXDoL29eF4u3UVJLxwajc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DRn/c/Y/a5UvpW+C8iJcNoBRH38lPa97/NOrDirQk/qywerat2dBqNHe0HEQ/ebd5
         cw1Ofb3nt+aObN0aZm6Rxpx7QdnzGUp+R2Y/OuVp3vRVnqDZDo/0Tq0gfJPAKtm/9+
         N4kyJ2GFzoHebz3HyT+0kqUd+6sv/upZ43fKIfJQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ICEc2W125821;
        Mon, 18 May 2020 07:14:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 07:14:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 07:14:38 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ICEaDi089857;
        Mon, 18 May 2020 07:14:36 -0500
Subject: Re: [PATCH 0/3] phy: broadcom: Constify structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, <vkoul@kernel.org>,
        <alcooperx@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
References: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e14a36fc-c37a-203c-2312-c2798ffbe00b@ti.com>
Date:   Mon, 18 May 2020 17:44:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2020 5:34 PM, Rikard Falkeborn wrote:
> A small series adding const to a few static structs. Each patch can be
> applied separately.

merged, thanks!

-Kishon
> 
> Rikard Falkeborn (3):
>   phy: phy-bcm-ns2-usbdrd: Constify phy_ops
>   phy: sr-usb: Constify phy_ops
>   phy: phy-brcm-usb: Constify static structs
> 
>  drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c |  2 +-
>  drivers/phy/broadcom/phy-bcm-sr-usb.c     |  2 +-
>  drivers/phy/broadcom/phy-brcm-usb.c       | 16 ++++++++--------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
