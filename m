Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D1C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3049B24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oLMDacTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgB0Tz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:55:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40302 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgB0Tz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:55:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RJtrjj016486;
        Thu, 27 Feb 2020 13:55:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582833354;
        bh=j14A4KDiPV7+5CyFfQyJF/I3tzUDMgNnvsW6fd74nag=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oLMDacTs2oqKcIK1HyhmDXvyTagq7IDbnNVynon3UuwO6GmCLRxz40fHc2y/Bw721
         4GQyKqr09qMC7Fy1SnSs1cmiT8Tk0OMnYEFE0UAaMrk3ENT7gdqAF40c+hjMswjhKp
         0DUnt0yR/XM1qrWJk6ADqc/KSI2ahfnB/56zHyhI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RJtrEv125288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 13:55:53 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 13:55:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 13:55:53 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RJtrLW110458;
        Thu, 27 Feb 2020 13:55:53 -0600
Subject: Re: [RFC PATCH] leds: add sgm3140 driver
To:     Luca Weiss <luca@z3ntu.xyz>, <linux-leds@vger.kernel.org>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
References: <20200227185015.212479-1-luca@z3ntu.xyz>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7742f98c-fd96-7f0e-c33c-fbac61a4881c@ti.com>
Date:   Thu, 27 Feb 2020 13:50:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227185015.212479-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luca

On 2/27/20 12:50 PM, Luca Weiss wrote:
> Add a driver for the SGMICRO SGM3140 Buck/Boost Charge Pump LED driver.
>
> This device is controller by two GPIO lines, one for enabling the LED
> and the second one for switching between torch and flash mode.
>
> The device will automatically switch to torch mode after being in flash
> mode for about 250-300ms, so after that time the driver will turn the
> LED off again automatically.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

You seem to be missing the devictree bindings doc for the GPIOs.

Dan


