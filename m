Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367D9C3403B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D2E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JlE5Vakp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBRMpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:45:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35646 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgBRMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:45:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01ICjWYi016830;
        Tue, 18 Feb 2020 06:45:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582029932;
        bh=dnj//0zodylv9fY/4CtvgSGPpRwAJebJFvfHLzBPTps=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=JlE5VakpR0OdmB4shdFN3EWxwhlCOJoulkANYy7LEK5CJTHTiD69QQgKbQ2jUddYD
         +JN7iKis/erPEMvbJS/BW1yw5v0kmO4SFHcb+rHZA3/q1eF8CWNkHilyAOBY7GMZyO
         Vhts56Zja29C6c2repuXsHzPIz/M4eL+Kb/XXGZA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ICjWgK027105;
        Tue, 18 Feb 2020 06:45:32 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 06:45:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 06:45:31 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ICjVsd034966;
        Tue, 18 Feb 2020 06:45:31 -0600
Subject: Re: [PATCH 1/3] dt-bindings: Document shiji vendor-prefix
To:     Nicolas Belin <nbelin@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
References: <1582018657-5720-1-git-send-email-nbelin@baylibre.com>
 <1582018657-5720-2-git-send-email-nbelin@baylibre.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <455c5db0-7190-8874-bdbc-dc0985905162@ti.com>
Date:   Tue, 18 Feb 2020 06:40:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582018657-5720-2-git-send-email-nbelin@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas

On 2/18/20 3:37 AM, Nicolas Belin wrote:
> Shenzhen Shiji Lighting Co.,Ltd is a LED manufacturer.
>
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---

You need to add the devicetree mailing list and Rob Herring to this for 
their review of the dt bindings patches

Dan

