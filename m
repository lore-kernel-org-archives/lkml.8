Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903AAC3524E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6405F21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JnEKz4/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBSVSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:18:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46806 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:18:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01JLGphA114842;
        Wed, 19 Feb 2020 15:16:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582147011;
        bh=hELP/UVWF2wnG4khdI+ML3nj51J78zGR6XNDM5je6Hg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JnEKz4/DGmVnBOrxNaZHZuiGPeUqqqq/31MYe4eTb7lpWgkFhcm6pOU6VaKgC+UkK
         oWOPnZZO0Ykef9kve5EubrsJ+i1D0o7yPRdEgi4KFkXq2hYfGNWG77GEPb/ji4KIJL
         1sW3BQR4PQMMX1Z4y8hUTo5cgI4FDB2vIbWPDl5w=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01JLGp1U062825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 15:16:51 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 15:16:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 15:16:51 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01JLGp5o045264;
        Wed, 19 Feb 2020 15:16:51 -0600
Subject: [RFC] Volume control across multiple registers
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200219134622.22066-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <2f74b971-4a6a-016f-8121-4da941eeccef@ti.com>
Date:   Wed, 19 Feb 2020 15:11:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219134622.22066-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am trying to figure out how to control the volume of a speaker device 
with full volume control spread out across 4 8bit registers.

The standard TLV calls only allow a single register for volume control.  
But I have 4 I need to touch to get a full range of volume from 0dB to 
-110dB.

I was looking at using the DAPM calls and use PGA_E and define an event 
but there really is no good way to get the current volume setting.

I don't see any example of this in any current driver.

Any guidance is appreciated.

Dan

