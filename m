Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MENTIONS_GIT_HOSTING,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from gateway20.websitewelcome.com ([192.185.4.169]:44397 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730172AbgCKQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:12:57 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id BADF740DBE61B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:28:43 -0500 (CDT)
Subject: Re: [PATCH] mmc: Replace zero-length array with flexible-array member
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200226223125.GA20630@embeddedor>
 <CAPDyKFpCczkLfzbRHV5WEzuMOseMj19mV=j1w6=hNX9K8YN1JQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <7fe54f8f-52ed-c819-550c-a775c2afdde6@embeddedor.com>
Date: Wed, 11 Mar 2020 10:46:01 -0500
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpCczkLfzbRHV5WEzuMOseMj19mV=j1w6=hNX9K8YN1JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/11/20 10:34, Ulf Hansson wrote:

>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied for next, thanks!
> 

Thanks, Ulf.
--
Gustavo

> Kind regards
> Uffe
> 

