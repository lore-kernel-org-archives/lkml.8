Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85D022BF3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NrU7I/Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHDVj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:39:58 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39460 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHDVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:39:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 074Ldrf1122069;
        Tue, 4 Aug 2020 16:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596577193;
        bh=LImguDWeGSZHfnoAy6ty67PNB7Bs0ypFqLfjErMZBRM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NrU7I/SnO9Fyi5+7cqDG8h57eUeH1ACOYuQpUMDaxCOfOkUsayqFCsEYo3fBMIAhb
         A/t7YwQQdQ+Xtyspmtk7Sw5RNp3RIL6MBR9pOcs2fDplDKaxQ3zXWdfW+B5oZwoPlH
         i5Fus9yVY4k061pvLeWYqqhPkdnvO4n2ZbQZnSIo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 074LdrRM071410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Aug 2020 16:39:53 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 4 Aug
 2020 16:39:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 4 Aug 2020 16:39:52 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 074LdmCj100746;
        Tue, 4 Aug 2020 16:39:49 -0500
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J7200
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, <t-kristo@ti.com>
CC:     <nsekhar@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>
References: <20200803105359.16744-1-peter.ujfalusi@ti.com>
 <f13b8e17-308f-fdf2-885e-318710d4d836@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a3ea4e4f-1c7e-b7b1-798e-4fda0ce73cba@ti.com>
Date:   Wed, 5 Aug 2020 00:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f13b8e17-308f-fdf2-885e-318710d4d836@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On 03/08/2020 17:41, Lokesh Vutla wrote:
> 
> 
> On 03/08/20 4:23 pm, Peter Ujfalusi wrote:
>> Update K3 chipinfo driver to support new TI J7200 SoC.
>> It's JTAG PARTNO is 0xBB6D.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>



-- 
Best regards,
grygorii
