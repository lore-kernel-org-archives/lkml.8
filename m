Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F595C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA4C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y8IOIIbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgE2Tjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:39:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43606 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2Tjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:39:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04TJdP6B037266;
        Fri, 29 May 2020 14:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590781165;
        bh=wQ582Jun/nwakMpVHCTGC+XK6lct9XsIpF/gTKCzB4E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y8IOIIbgm87LrsXCKCcUbTGdAcKHRwAu8QJEeHzVJRcjRZ/e7U8Hh8xCeF08Tsyp1
         NsIfBDRAbDXOZIXycPjJWkWr63uGpgIkutvuZU/LiPTM7gbbSePlsCZS7b3vmjcTYb
         6QMjwKrczyzOuEgiZDYA2k5QEjJKpKnLUjEdwkHA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04TJdPXe124917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 14:39:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 29
 May 2020 14:39:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 29 May 2020 14:39:24 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04TJdMYP008147;
        Fri, 29 May 2020 14:39:22 -0500
Subject: Re: [PATCH v4 0/2] soc: ti: add k3 platforms chipid module driver
To:     <santosh.shilimkar@oracle.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <20200512123449.16517-1-grygorii.strashko@ti.com>
 <a132765e-f4e4-a1e8-fb43-239188fecf1b@ti.com>
 <CAK8P3a31DYOn1TyjxCYM7ebc9nL5EFKsNpSHkq55bG54Bns+MA@mail.gmail.com>
 <cb980673-d3ad-53b8-9351-196ff3f47c45@oracle.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f06a6285-aa9f-918b-044c-c0ba1f0ad1fc@ti.com>
Date:   Fri, 29 May 2020 22:39:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cb980673-d3ad-53b8-9351-196ff3f47c45@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2020 22:19, santosh.shilimkar@oracle.com wrote:
> On 5/29/20 11:34 AM, Arnd Bergmann wrote:
>> On Fri, May 29, 2020 at 8:22 PM Grygorii Strashko
>> <grygorii.strashko@ti.com> wrote:
>>> On 12/05/2020 15:34, Grygorii Strashko wrote:
>>
>>>>    .../bindings/soc/ti/k3-socinfo.yaml           |  40 +++++
>>>>    drivers/soc/ti/Kconfig                        |  10 ++
>>>>    drivers/soc/ti/Makefile                       |   1 +
>>>>    drivers/soc/ti/k3-socinfo.c                   | 152 ++++++++++++++++++
>>>>    4 files changed, 203 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
>>>>    create mode 100644 drivers/soc/ti/k3-socinfo.c
>>>>
>>>
>>> Any chances you can pick this up?
>>
>> I merged a version of this driver from Santosh's pull request into the
>> arm/drviers tree yesterday.
>>
>> Is there something missing?
>>
> Nope. I was going to reply on the thread but missed it.

Oh. Thanks. I've missed that it was already picked up.

Thanks again.

-- 
Best regards,
grygorii
