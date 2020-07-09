Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6784C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85347207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LnZQWvll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGIQXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:23:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15084 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgGIQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:23:14 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069GISBs026751;
        Thu, 9 Jul 2020 18:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=d2jcEAbPdJZRxx/7VM0LT3kmywQuHL6czVlRFoMpPmw=;
 b=LnZQWvllaO+te3tA8RkO5kTtXQpBJIUgDAz0JeDi+1TTNRm/EDI9BhS/n/UF8Mk7Lvel
 BF1J3p2pSNSTPJLUip6DhIc6QpSvu/UNKkkffQ24uqZLDbG2xSRJjP0XbMaAxHzpnkCe
 LBUWYVLei/G/WIOTYaLhPt4ensMuIxJkzVSTQeDGO6Y4J19tlcnte+lR5dqDg/OzgVoo
 qABeW8Mj+ZH/vrAjHxcNj9GtXtYerPWQ4SEuEGBi4OrzDZo2Ob3OuK2Lw/gkXwjsR6Sj
 jHWbKa1dJKUX86ydq7rsvQS9o31tSkC7njsqPreEUaajyujMaTVBOYD2bgwJwVd/i/ld 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k405vsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 18:23:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0691710002A;
        Thu,  9 Jul 2020 18:23:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1B2B2C38AB;
        Thu,  9 Jul 2020 18:23:11 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.49) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 18:23:11 +0200
Subject: Re: [PATCH v5 0/9] remoteproc: Add support for attaching with rproc
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <ae8e64ed-09e4-986e-096e-a3c5fb2243aa@st.com>
Date:   Thu, 9 Jul 2020 18:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 7/7/20 11:00 PM, Mathieu Poirier wrote:
> This set provides functionality allowing the remoteproc core to attach to 
> a remote processor that was started by another entity.
> 
> New in V5:
> 1) Added Bjorn's reviewed-by.
> 2) Removed PM runtime call from patch 04.
> 3) Used a 'case' statement in patch 05.
> 
> Patches that need to be reviewed: 4, 5 and 9.
> 
> Applies cleanly on rproc-next (49cff1256879)

I tested the series in different modes, no issue observed.
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks for your work!

Arnaud

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
>  drivers/remoteproc/remoteproc_core.c     | 213 +++++++++++++++++++++--
>  drivers/remoteproc/remoteproc_internal.h |   8 +
>  drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
>  include/linux/remoteproc.h               |   9 +-
>  4 files changed, 230 insertions(+), 17 deletions(-)
> 
