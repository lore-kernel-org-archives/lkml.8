Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13836C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F2420575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aVHNXMlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgDNNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:30:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45458 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbgDNN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:28:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03EDSpA4083332;
        Tue, 14 Apr 2020 08:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586870931;
        bh=u4MC3vP7IuttKDx8Z8LBQeVWaGt1BmFWT4OrNlLtjYI=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=aVHNXMlcX5EKbH3LTgr3Tjpgm5hRS8r743YqZgixAsfjpDuD99BXSG3fbAkolkifj
         LfrAHM2RmtlIjxjlub0aFxAwvLfT9LElbnz/OEqQ/DNCTaRwXI7AeIzu47zDT1BhKC
         oFvgU0YY19CZ6YWqQEVK+zqOy8TpEttwAsYm9U3s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03EDSpq1003225;
        Tue, 14 Apr 2020 08:28:51 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Apr 2020 08:28:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Apr 2020 08:28:51 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03EDSpnA008906;
        Tue, 14 Apr 2020 08:28:51 -0500
Subject: Re: [PATCH v19 04/18] leds: multicolor: Introduce a multicolor class
 definition
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200402204311.14998-1-dmurphy@ti.com>
 <20200402204311.14998-5-dmurphy@ti.com>
 <e5a789d5-b622-df23-d540-99816851d5f1@ti.com>
Message-ID: <aa642c7e-c3b5-d326-17e8-73f80babf7c0@ti.com>
Date:   Tue, 14 Apr 2020 08:23:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e5a789d5-b622-df23-d540-99816851d5f1@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 4/8/20 11:35 AM, Dan Murphy wrote:
> Pavel
>
> On 4/2/20 3:42 PM, Dan Murphy wrote:
>> Introduce a multicolor class that groups colored LEDs
>> within a LED node.
>>
>> The multi color class groups monochrome LEDs and allows controlling two
>> aspects of the final combined color: hue and lightness. The former is
>> controlled via <color>_intensity files and the latter is controlled
>> via brightness file.
>
> When you get a chance I would like to get your review on this patch as 
> well before I submit v20
>
Have you had a chance to review the code?  I want to be able to post the 
next version but want to make sure there are currently no other major 
changes.

Dan

> Dan
>
