Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0682B2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="elmIn/w9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbgFWQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:00:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40806 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733012AbgFWQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:00:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05NFxoNB045823;
        Tue, 23 Jun 2020 10:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592927990;
        bh=olC4l/jXzIroYJbEpRReyOUqgRg7I8gSJNp27yn9+/g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=elmIn/w9jpsWEuzqTTEYJMbNKlN3CikTLSag64yS0+7RWQhvsgkwgPuhSnidqaH3Y
         zLFp4scutmYLF7bf1PmT96FcQcJmQahn/lROVxVGJdOZOUR3UP4ucXrxsnrV9CA7tE
         hB02ImQxeZkTKLUtZglqNab7Oy6xEg00+9XjJCQE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05NFxotF083470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 10:59:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 10:59:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Jun 2020 10:59:50 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05NFxnjP128978;
        Tue, 23 Jun 2020 10:59:50 -0500
Subject: Re: [PATCH v4 2/2] ASoC: tas2562: Update shutdown GPIO property
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200612171412.25423-1-dmurphy@ti.com>
 <20200612171412.25423-2-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cfb043e3-77c5-2957-20b6-2814f1445cf0@ti.com>
Date:   Tue, 23 Jun 2020 10:59:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612171412.25423-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 6/12/20 12:14 PM, Dan Murphy wrote:
> Update the shutdown GPIO property to be shutdown from shut-down.

I have some other patches that go on top of this patchset I am wondering 
if I should re-submit with those patches on top or indicate in a cover 
letter the dependency

Dan

