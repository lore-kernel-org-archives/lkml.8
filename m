Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E779C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9BC2068F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bPgamNSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbgIAQzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:55:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4936 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730554AbgIAQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:55:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081GqaHK026681;
        Tue, 1 Sep 2020 18:55:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=dOGKJLyQja/sG1HbGmIDAJSbIZyWV9DTJ1K3Lx5m4SA=;
 b=bPgamNSSeXKmE4tcLlGG2Amml1sMlm8aFYUHTEHf27LyJomBpm4AcvIQ/nHODz/EKSSd
 zfLzujbNjTDKlWbCmiwqgIhO3ligyBGW0vmMeLTv7AdqTmkwHYocwBVAc+izEJJn6/aW
 PpK4Ta3QEtUX3TfYk1uwrQNBy7GKzxZpcdLHp9ULpQa2NIKoNHGsKN6Ug2TLdPRp8XY5
 HJx08EUbr0S0OlaNpJ1hzJTojJ0jaaLoigxoWt/WaPZs9uJfzYShZuSYT1SnYI9eeM0f
 3Wp6rwSbTcPHJJt0vthTV2Wikug8vGVdB/CWe8n+KuoYgSix+tdeQvvdc9HtA2FrdM4t 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337c58gva4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 18:55:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C909A10002A;
        Tue,  1 Sep 2020 18:55:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4D4B2B427D;
        Tue,  1 Sep 2020 18:55:16 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 18:55:15 +0200
Subject: Re: [PATCH 00/13] remoteproc: Add support for detaching from rproc
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <cc10db90-92ca-41e1-110d-885ef8266191@st.com>
Date:   Tue, 1 Sep 2020 18:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_10:2020-09-01,2020-09-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 8/26/20 6:45 PM, Mathieu Poirier wrote:
> Following the work done here [1] this set provides support for the
> remoteproc core to release resources associated with a remote processor
> without having to switch it off. That way a platform driver can be removed
> or the applcation processor power cycled while the remote processor is
> still operating.
> 
> I have not tested the solution because of the work involved in getting
> a new firmware image to support the feature.  I will do so once it is
> determined that this is the right approach to follow.

I just started watching your series. I also think that we have first to
determine the approach that match meets the requirements of all companies.

Here is my feeling, waiting more feedback from community:

If I understand your approach correctly you propose that the application
determines the firmware live-cycle. Depending on request, the remoteproc core
performs a "shutdown" ( stop + unprepare) or a "detach".
The platform driver can(or have to?) implement the stop and/or the detach.
By default a preloaded firmware is detached and a "standard" firmware is stopped
on kernel shutdown (rproc_del).

As we have seen with the rproc cdev, it might not be simple to manage this
in case of crash.
For instance you can have a Firmware started by the boot-stages but
which must be gracefully stopped in case of crash.  

Another approach would be to let the platform driver decides what should
be done on the stop and prepare ops depending on the HW context.
So the platform driver would be in charge of detaching the firmware.
In this case the issue is to determine the state after stop. the information
would be in platform driver.

I would be more in flavor of the second one, because application would not
have to be aware of the co-processor firmware life-cycle, and the firmware
could expose its own constraints for shutdown.  

A third approach (or complementary approach): 
I don't know why i didn't think of it before... The attach/detach
feature is quite similar to the regulator management.

For regulator 2 DT properties exist[1]:
- regulator-always-on: boolean, regulator should never be disabled
- regulator-boot-on: bootloader/firmware enabled regulator

It is a static configuration but could be implemented for both the attach and
the detach in the core part.
Else if a more dynamic management could be managed by the platform driver
(depending on the loaded firmware).
  
[1]https://elixir.bootlin.com/linux/v4.0/source/Documentation/devicetree/bindings/regulator/regulator.txt

Thanks,
Arnaud

> 
> Applies cleanly on rproc-next (62b8f9e99329)
> 
> Thanks,
> Mathieu 
> 
> [1]. https://lkml.org/lkml/2020/7/14/1600
> 
> Mathieu Poirier (13):
>   remoteproc: Re-check state in rproc_shutdown()
>   remoteproc: Remove useless check in rproc_del()
>   remoteproc: Add new RPROC_ATTACHED state
>   remoteproc: Properly represent the attached state
>   remoteproc: Add new detach() remoteproc operation
>   remoteproc: Introduce function __rproc_detach()
>   remoteproc: Introduce function rproc_detach()
>   remoteproc: Rename function rproc_actuate()
>   remoteproc: Add return value to function rproc_shutdown()
>   remoteproc: Properly deal with a stop request when attached
>   remoteproc: Properly deal with detach request
>   remoteproc: Refactor rproc delete and cdev release path
>   remoteproc: Properly deal with a kernel panic when attached
> 
>  drivers/remoteproc/remoteproc_cdev.c  |  18 ++-
>  drivers/remoteproc/remoteproc_core.c  | 151 +++++++++++++++++++++-----
>  drivers/remoteproc/remoteproc_sysfs.c |  17 ++-
>  include/linux/remoteproc.h            |  14 ++-
>  4 files changed, 157 insertions(+), 43 deletions(-)
> 
