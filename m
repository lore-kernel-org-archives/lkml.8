Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4554C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B294F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bSWNXg7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHTO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:58:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51218 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHTO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:58:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07KEvtA8067332;
        Thu, 20 Aug 2020 09:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597935475;
        bh=fwkjcqXjAEvoMKw7hysN2k2pYEvPoK7LylOknVO56H8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bSWNXg7BixCbnYUPuP2MzE8rW78OaND2YyN88iHDZlhTjXdFm2cvItfXDvRvw41tl
         ymwYkvHT/xVBg38dy9ftZULxF1s0HUiI/kof7WsuiUMqeJW8H2aQnQxp7vIf0BzL7u
         3KmTDV8JPtdEOyz55TXL0M1tKRApLluZ8Ho8xUdU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07KEvto1057736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 09:57:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 20
 Aug 2020 09:57:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 20 Aug 2020 09:57:55 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KEvrLK024724;
        Thu, 20 Aug 2020 09:57:53 -0500
Subject: Re: [PATCH v5] phy: omap-usb2-phy: disable PHY charger detect
To:     Roger Quadros <rogerq@ti.com>, <kishon@ti.com>
CC:     <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
References: <20200820133937.32504-1-rogerq@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a3b3e82c-983b-928c-156e-13d43636aa36@ti.com>
Date:   Thu, 20 Aug 2020 20:27:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200820133937.32504-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 7:09 PM, Roger Quadros wrote:
> AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
> could cause enumeration failure with some USB hubs.  Disabling the
> USB2_PHY Charger Detect function will put D+ into the normal state.
> 
> This addresses Silicon Errata:
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
> Presence"
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

+ Vinod as well
