Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983ABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6F207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RfoMZQjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgFDOYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:24:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1655 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728881AbgFDOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:24:09 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054EMikq009578;
        Thu, 4 Jun 2020 16:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=UkmPnCEcRQC0JdajD5qa7MyPL9pxMsvhxlH+GUvo0sI=;
 b=RfoMZQjO+7nbuCmeQSa9AcEnmj0FlV23lpGsOqXivY/l3qr7tkbSTK12JEbhxvlLooou
 XqjfFXRzdSwxcjS9rIlqiN7D/WYTa6UtjTVez6YpOZxoYit9jqz620rEw2+i3HeN+H7H
 9PbbEnvtZ8j6EKZ8ch/zPh1nNCEERepsLaO36iNMnIbnvLlLdtMrPtFwfbEJcRY5D/IE
 Ist1jftqdzJnHy/ULC+8CyDxCd27iWRq8i097ywDIVjQiSdeLHiCO0WqLj/CnFXalRwN
 NY9YPxEqrIypwqDPjkTDbL+yoOJMydLPyZ4YG59Nqp03FiSIiUWnU2acoMvTqH745f4m nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31ejxavamu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 16:24:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C9F6100038;
        Thu,  4 Jun 2020 16:24:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F051B2C50C8;
        Thu,  4 Jun 2020 16:24:03 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 16:24:03 +0200
Subject: Re: [PATCH v4 0/9] remoteproc: Add support for attaching with rproc
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <0780724c-4fc0-9f98-023e-aa1245b01888@st.com>
Date:   Thu, 4 Jun 2020 16:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200601175139.22097-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_10:2020-06-02,2020-06-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 6/1/20 7:51 PM, Mathieu Poirier wrote:
> This fourth iteration implements a solution that is fairly different from
> what was proposed in V3 and earlier versions.  Three aspects have been 
> revisited:
> 
> 1) Only the scenario where the remoteproc core is attaching to the remote
>    processor is implemented.  Other scenarios where actions need to be 
>    taken when the remote processor is stopped or crashes will be
>    considered in subsequent versions.
> 
> 2) The introduction of a new RPROC_DETACHED state to be set by platform
>    drivers when needing to attach to an already running remote processor.
> 
> 3) New functions are introduced to replicate the functionality provided by
>    rproc_fw_boot() and rproc_start(), minus operations related to firmware
>    management. 
> 
> Enhancement to the documentation has been left out intentionally until it
> is agreed to move forward with this implementation.

Look good to me, i have only a minor concerns about the code duplication
introduced by the point 3)

If you are agree with that, I plan to do a new review on the stm32 series
when you will start the documentation :-)

Regards,
Arnaud

> 
> Applies cleanly on rproc-next(7dcef3988eed) and will be rebased on v5.8-rc1
> when it comes out in two weeks.
> 
> Thanks,
> Mathieu
> 
> Mathieu Poirier (9):
>   remoteproc: Add new RPROC_DETACHED state
>   remoteproc: Add new attach() remoteproc operation
>   remoteproc: Introducing function rproc_attach()
>   remoteproc: Introducing function rproc_actuate()
>   remoteproc: Introducing function rproc_validate()
>   remoteproc: Refactor function rproc_boot()
>   remoteproc: Refactor function rproc_trigger_auto_boot()
>   remoteproc: Refactor function rproc_free_vring()
>   remoteproc: Properly handle firmware name when attaching
> 
>  drivers/remoteproc/remoteproc_core.c     | 226 +++++++++++++++++++++--
>  drivers/remoteproc/remoteproc_internal.h |   8 +
>  drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
>  include/linux/remoteproc.h               |   9 +-
>  4 files changed, 243 insertions(+), 17 deletions(-)
> 
