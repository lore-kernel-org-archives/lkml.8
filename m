Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6F3C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B8920709
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgIBRHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:07:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgIBRHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:07:43 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7E02F3E6D6C22741041D;
        Wed,  2 Sep 2020 18:07:42 +0100 (IST)
Received: from [127.0.0.1] (10.47.4.206) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Sep 2020
 18:07:41 +0100
Subject: Re: [PATCH v7 2/5] perf/jevents: Add new structure to pass json
 fields.
To:     Kajol Jain <kjain@linux.ibm.com>, <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <pc@us.ibm.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <maddy@linux.ibm.com>, <ravi.bangoria@linux.ibm.com>
References: <20200902160439.335232-1-kjain@linux.ibm.com>
 <20200902160439.335232-3-kjain@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <34566244-88ba-562b-71cf-414a0ba307f4@huawei.com>
Date:   Wed, 2 Sep 2020 18:05:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200902160439.335232-3-kjain@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.206]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2020 17:04, Kajol Jain wrote:
> This patch adds new structure called 'json_event' inside jevents.h
> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> +static int json_events

Adding 'static' should have really been in the previous patch ...

