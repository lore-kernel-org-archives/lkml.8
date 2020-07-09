Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFCB207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hqw4zfkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGIQde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:33:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13612 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbgGIQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:33:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069GSsaH001240;
        Thu, 9 Jul 2020 18:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=p3WUOE1BFwyOWMLXIbNJG7i4gfk1IMbX9+3yZTZGgc0=;
 b=hqw4zfkPmSiAVjOKbFFXR17hj+FvjIVnsf2E+u1VCnJYTA6OnmCdgZwKUfsheROFR2Hx
 qYcNAOeoZFM9+ZZDyZtQb1FPYscHfRkQPmvzWx4xGetXakawhMyG8Ur3AgycMA7cGmnA
 bv94kxjz4a7W3M9FngTcznB9i4t5WZzfa2qUfy2ZdtcobyTM9CHIT5GcompPoMDFXAAA
 6b7aBGykp3mw73mZOiJkv7s2Q5+jdYIPSD/j+T1KwvCVyUIZ8mBaNdhmga87SQHiDcKe
 XM6He93AZZ16Vfi+uibfAkV3IUmf1PIvPEjjkyoXUDSvts2dvtFaIUW9W0A/fYo96YHL FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k4cx04y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 18:33:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E3DE10002A;
        Thu,  9 Jul 2020 18:33:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51A5C2CA1F8;
        Thu,  9 Jul 2020 18:33:27 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.49) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 18:33:26 +0200
Subject: Re: [PATCH v5 00/11] remoteproc: stm32: Add support for attaching to
 M4
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <9d54383c-d653-cddf-7746-21f1001122ea@st.com>
Date:   Thu, 9 Jul 2020 18:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 11:31 PM, Mathieu Poirier wrote:
> This set applies on top of [1] and refactors the STM32 platform code in
> order to attach to the M4 remote processor when it has been started by the
> boot loader.
> 
> New to V5:
> 1) Added Bjorn's reviewed-by to patch 06.
> 2) Removed Loic's reviewed-by from patch 08, it has changed too much.
> 
> Patches that need to be reviewed: 7, 8, 9 and 10.
> 
> Tested on ST's mp157c development board.
> 
> Thanks,
> Mathieu
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=314523
> 
> Mathieu Poirier (11):
>   remoteproc: stm32: Decouple rproc from memory translation
>   remoteproc: stm32: Request IRQ with platform device
>   remoteproc: stm32: Decouple rproc from DT parsing
>   remoteproc: stm32: Remove memory translation from DT parsing
>   remoteproc: stm32: Parse syscon that will manage M4 synchronisation
>   remoteproc: stm32: Properly set co-processor state when attaching
>   remoteproc: Make function rproc_resource_cleanup() public
>   remoteproc: stm32: Split function stm32_rproc_parse_fw()
>   remoteproc: stm32: Properly handle the resource table when attaching
>   remoteproc: stm32: Introduce new attach() operation
>   remoteproc: stm32: Update M4 state in stm32_rproc_stop()
> 
>  drivers/remoteproc/remoteproc_core.c |   3 +-
>  drivers/remoteproc/stm32_rproc.c     | 214 ++++++++++++++++++++++++---
>  include/linux/remoteproc.h           |   1 +
>  3 files changed, 198 insertions(+), 20 deletions(-)
> 

I tested the series with the [1] 
Minor remarks on patch 6 & 8. After fixing them, for the series:

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thank you very much for your work on this feature.

Arnaud
