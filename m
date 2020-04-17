Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E4EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EA12076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kpLScCnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgDQNea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:34:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54140 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbgDQNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:34:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HDYSuR067778;
        Fri, 17 Apr 2020 08:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587130468;
        bh=vwxmXlpsjVVKlW88yhJVrdo6L2S7yEoxX6tXMWse8zE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kpLScCnEjfjyF98cIS7ZVvC0dM3cXZTKhaE4bGJLo7sw+WoJGQE1Q1Rv06HhS1tMZ
         o9B3ck9h2oEEbriaZcVwETQqaOklBFQwjEFXE3zP9cz4mWFvFJy62LA5xDc7P24/rV
         tnwqirJX4k317JQiAfCb+K0DsFo5sZad+Vd+wsF4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HDYSbN104088;
        Fri, 17 Apr 2020 08:34:28 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 08:34:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 08:34:28 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HDYRcR034794;
        Fri, 17 Apr 2020 08:34:27 -0500
Subject: Re: [PATCH v2 0/7] remoteproc: Refactor function rproc_alloc()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <elder@linaro.org>, <Markus.Elfring@web.de>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b1a1d496-5ffa-95c1-0f06-7ea9f6b7e401@ti.com>
Date:   Fri, 17 Apr 2020 08:34:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,
On 4/15/20 3:48 PM, Mathieu Poirier wrote:
> Good afternoon,
> 
> This is the second installment in this series, the first one can be
> found here[1].  The goal of the work is to consolidate modifications to
> function rproc_alloc() that were made over the last weeks[2][3][4] to
> provide a common foundation to work from and avoid merge conflicts.
> 
> Applies cleanly on v5.7-rc1

Thanks for the patches. Overall looks good. I have couple of minor 
comments, will post them in the respective patches.

> 
> Thanks,
> Mathieu
> 
> New for V2:
> - Reworked title for patch 01.
> - Added "Fixes" tag to patch 01.
> - Using kasprintf() instead of complex memory allocation.
> - Using kstrdup_const() instead of kstrdup().
> - Reworked rproc_alloc_firmware() to use non-negative form.
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=270239
> [2]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=261069
> [3]. https://patchwork.kernel.org/patch/11456385/

I have since reworked this and posted the next version on top of this 
series.
https://patchwork.kernel.org/patch/11493941/

regards
Suman

> [4]. https://patchwork.kernel.org/patch/11473241/
> 
> Alex Elder (1):
>    remoteproc: Fix IDR initialisation in rproc_alloc()
> 
> Mathieu Poirier (6):
>    remoteproc: Split firmware name allocation from rproc_alloc()
>    remoteproc: Simplify default name allocation
>    remoteproc: Use kstrdup_const() rather than kstrup()
>    remoteproc: Restructure firmware name allocation
>    remoteproc: Split rproc_ops allocation from rproc_alloc()
>    remoteproc: Get rid of tedious error path
> 
>   drivers/remoteproc/remoteproc_core.c | 96 +++++++++++++++-------------
>   include/linux/remoteproc.h           |  2 +-
>   2 files changed, 54 insertions(+), 44 deletions(-)
> 

