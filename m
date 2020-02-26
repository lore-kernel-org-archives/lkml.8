Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17FC4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCD72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="slqioptl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgBZQQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:16:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55580 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:16:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QGG64N119983;
        Wed, 26 Feb 2020 10:16:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582733766;
        bh=0FcgBZD0FcGrWhEPucId1UBN/EwNU1wafv0wW/abf7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=slqioptlPCKXxQMJ4eKOpsW4TDjTw29mNub/CYcPvjVCJBA2W14fTEEsngMqu4hjE
         g2nM+VK2fpirqfJNdGpCwBvI/tUp1CIApBlQHNKmppiKIUGlB4tFYwU51UfZUJblak
         HoJ3BxWCgTMKQvDjW0325vj44EVeEBhvL90QE44s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QGG6XW000712;
        Wed, 26 Feb 2020 10:16:06 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 10:16:05 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 10:16:05 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01QGG5B7079209;
        Wed, 26 Feb 2020 10:16:05 -0600
Subject: Re: [PATCH for-next 3/3] ASoC: tas2562: Fix sample rate error message
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200226130305.12043-1-dmurphy@ti.com>
 <20200226130305.12043-3-dmurphy@ti.com> <20200226161204.GG4136@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <531e40a0-7433-66d9-7b77-fc4ccc3dabdb@ti.com>
Date:   Wed, 26 Feb 2020 10:10:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226161204.GG4136@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 2/26/20 10:12 AM, Mark Brown wrote:
> On Wed, Feb 26, 2020 at 07:03:05AM -0600, Dan Murphy wrote:
>> Fix error message for setting the sample rate.  It says bitwidth but
>> should say sample rate.
> Fixes should always go at the start of a series so they can be applied
> as such without any dependency on any new features or cleanups.
OK I will rebase and put the fixes first.


Dan

